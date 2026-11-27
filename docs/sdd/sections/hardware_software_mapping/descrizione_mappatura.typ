#import "../../../templates/common.typ": palette-primary, readable-text, table-style


= Mappatura Hardware/Software <mappatura_hw_sw>
La presente sezione descrive la mappatura tra i sottosistemi software di Pharos (definiti in @decomposizione_sottosistemi) e le risorse hardware e infrastrutturali deputate alla loro esecuzione. L'obiettivo è concretizzare la topologia di distribuzione del sistema per la realizzazione dell'MVP su infrastruttura cloud gestita in area UE (basata su Vue.js e servizi cloud gestiti), specificando l'allocazione dei sottosistemi sui rispettivi nodi, i protocolli di comunicazione e la tracciabilità rispetto ai flussi architetturali `[F1]–[F4]`.

In coerenza con il diagramma architetturale, la mappatura introduce due raffinamenti progettuali:
- il nodo logico *Persistenza e Sicurezza* viene allocato su due nodi infrastrutturali distinti e amministrativamente separati (`:PersistenceServer` e `:AuditBackupStorage`), al fine di garantire la _Separation of Duties_ sull'*Audit Log Immodificabile* e la custodia _off-site_ dei backup;
- per il *Modulo IA di Triage*, la configurazione MVP concretizza l'opzione di inferenza tramite container _stateless_ isolato e *Adattatore Provider IA* verso un *Provider IA esterno* in area SEE vincolato da DPA e policy _Zero-Retention_, preservando la possibilità di passare a un deployment _on-premise_ senza modificare *Triage Guidato* né gli altri sottosistemi.

#pagebreak()

== Descrizione generale e relazioni tra i nodi
La topologia di distribuzione di Pharos adotta un'architettura multi-livello organizzata per domini di fiducia e ospitata su servizi cloud gestiti in regione UE (GDPR-compliant), evitando dipendenze da infrastrutture _on-premise_ di Ateneo nella fase MVP pur mantenendo interfacce standard verso i servizi istituzionali. Tutte le comunicazioni avvengono su canali cifrati (HTTPS/TLS 1.3, SAML 2.0/OIDC), mentre la de-identificazione e le operazioni crittografiche End-to-End restano confinate sui dispositivi client. Di seguito sono descritti ruolo e interazioni di ciascun nodo:

- *Dispositivo Utente (`:UserDevice`):* Risorsa hardware mobile o desktop dell'Utente che esegue nel browser l'*Applicazione Web Utente (PWA)* realizzata utilizzando il framework Vue.js, comprensiva di _Panic Button_, Diario delle evidenze cifrato _offline-first_, mappa e rubrica offline dei Servizi Territoriali, accesso al supporto di Counseling psicologico, motore di de-identificazione _on-device_ e cifratura/decifratura E2EE locale. Partecipa al flusso `[F1]` (autenticazione SSO via redirect browser verso `:UniversityIdP`) e comunica su HTTPS (TLS 1.3) con `:ApplicationServer` esclusivamente tramite il punto di ingresso unico *Controllo Accessi e Sicurezza* (`[F1–F3]`).

- *Postazione CDF (`:CDFWorkstation`):* Risorsa hardware desktop del CDF che esegue nel browser l'*Applicazione Web CDF* (Vue.js conforme a WCAG 2.1 AA) e il modulo client di decifratura E2EE. Partecipa al flusso `[F1]` (SSO + MFA verso `:UniversityIdP`), dialoga su canale cifrato dedicato con `:HSM_KMS` per l'utilizzo protetto della chiave privata del CDF (`[F3]`) e comunica su HTTPS (TLS 1.3) con `:ApplicationServer` esclusivamente tramite *Controllo Accessi e Sicurezza* (`[F1, F3, F4]`).

- *Server Applicativo (`:ApplicationServer`):* Nodo server cloud gestito che ospita il livello applicativo. Espone *Controllo Accessi e Sicurezza* come punto di ingresso unico — responsabile di autenticazione SSO, autorizzazione RBAC, verifica che i dati sensibili transitino solo cifrati E2E, instradamento delle richieste e registrazione centralizzata di log applicativi e telemetria privi di dati riservati — e i sottosistemi *Gestione Utente (MO\_GU)*, *Gestione CDF (MO\_GCDF)*, *Triage Guidato*, *Reportistica CUG* e *Gestione Notifiche*. Al proprio interno, *Controllo Accessi e Sicurezza* instrada le richieste verso `MO_GU`, `MO_GCDF`, *Triage Guidato* e *Reportistica CUG*, mentre `MO_GU` e `MO_GCDF` invocano *Gestione Notifiche* (`[F3]`). Il nodo non accede mai in chiaro ai contenuti cifrati E2EE.

- *Server di Persistenza (`:PersistenceServer`):* Nodo gestito di persistenza, accessibile esclusivamente dai sottosistemi di `:ApplicationServer` su canale cifrato. Ospita *Persistenza Dati*, mantenendo la separazione logica tra anagrafica, contenuti cifrati (Segnalazioni, Bozze, Pratiche, Note CDF, allegati e copia sincronizzata del Diario cifrata e inaccessibile sia al server sia al CDF), metadati statistici non identificativi e archivio dei Servizi Territoriali (`[F2–F4]`). In particolare, *Reportistica CUG* accede ai soli metadati statistici (`[F4]`) e *Gestione Notifiche* legge i soli dati di contatto (`[F3]`). Il nodo applica il vincolo di sola lettura alle Pratiche chiuse o archiviate e alimenta i backup giornalieri cifrati verso `:AuditBackupStorage`.

- *Storage Audit e Backup (`:AuditBackupStorage`):* Servizio di object storage cloud WORM in regione UE (con _Object Lock_ in modalità _Compliance_), allocato su account/IAM isolato rispetto a `:PersistenceServer` (_Separation of Duties_). Ospita l'*Audit Log Immodificabile* (soli metadati di accessi e operazioni del CDF), scritto in modalità _append-only_ da *Gestione CDF (MO\_GCDF)* (`[F3]`) e consultabile in sola lettura — su canale separato, anch'esso tracciato — esclusivamente da DPO, responsabile sicurezza di Ateneo e autorità competenti (fuori dai flussi `[F1]–[F4]`). Conserva inoltre i backup giornalieri cifrati _off-site_.

- *Nodo Modulo IA (`:AIInferenceNode`):* Container serverless _stateless_ in regione UE, privo di persistenza locale e invocato in modalità sincrona con timeout da *Triage Guidato* (`:ApplicationServer`) su HTTPS (TLS 1.3) nel flusso `[F2]`. Ospita il *Modulo IA di Triage* (componente isolato interno a Pharos) e l'*Adattatore Provider IA*, elaborando esclusivamente testo già depurato _on-device_ e restituendo gravità, tipologia di violenza e passi dell'iter di segnalazione.

#pagebreak()

- *Provider di Identità di Ateneo (`:UniversityIdP`) \[Esterno\]:* Servizio esterno che gestisce l'autenticazione SSO (+ MFA per il CDF) e il rilascio degli attributi di ruolo (Utente / CDF) nel flusso `[F1]`, interagendo su HTTPS (TLS 1.3) con `:UserDevice`, `:CDFWorkstation` e *Controllo Accessi e Sicurezza* (`:ApplicationServer`). Basato sullo standard SAML 2.0 (Shibboleth / IDEM-GARR in esercizio; IdP federato cloud SAML 2.0/OIDC compatibile nella fase MVP).

- *HSM/KMS istituzionale (`:HSM_KMS`) \[Esterno\]:* Servizio esterno deputato alla custodia e all'utilizzo protetto della chiave privata del CDF per la decifratura E2EE nel flusso `[F3]` (Cloud KMS hardware-backed in regione UE nell'MVP, sostituibile in esercizio con l'HSM/KMS istituzionale di Ateneo). Dialoga su canale cifrato dedicato esclusivamente con `:CDFWorkstation`, previa verifica della sessione SSO + MFA, senza esporre la chiave al livello applicativo.

- *Servizio di Notifiche (`:NotificationService`) \[Esterno\]:* Servizio esterno invocato in modo asincrono da *Gestione Notifiche* (`:ApplicationServer`) su HTTPS o SMTPS/TLS nel flusso `[F3]` per il recapito di notifiche e-mail e Web Push prive di dettagli riservati sugli aggiornamenti di Stato Pratica.

- *Provider IA esterno (`:ExternalAIProvider`) \[Esterno, opzionale\]:* Endpoint LLM gestito in area SEE vincolato da DPA art. 28 GDPR e policy _Zero-Retention_, invocato su HTTPS (TLS 1.3) nel flusso `[F2]` esclusivamente dall'*Adattatore Provider IA* (`:AIInferenceNode`) qualora il deployment del Modulo IA non sia _on-premise_.

#v(0.5em)

== Tabella dei nodi
La tabella seguente riassume la mappatura tra i nodi hardware e infrastrutturali di Pharos nella configurazione MVP cloud gestita, la piattaforma software di esecuzione, i sottosistemi allocati, le responsabilità e le principali connessioni di rete.

#v(0.5em)

#[
  #set text(lang: "it", hyphenate: true)
  #set par(justify: true)
  #show table.cell.where(y: 0): set par(justify: false)
  #show table.cell.where(x: 0): set par(justify: false)

  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.05fr, 1.15fr, 1.55fr, 1.45fr),
      inset: (x: 8pt, y: 8pt),
      align: (x, y) => if y == 0 or x == 0 { center + horizon } else { left },

      table.header(
        text(fill: readable-text(palette-primary))[*Nodo Hardware / Infrastrutturale*],
        text(fill: readable-text(palette-primary))[*Piattaforma / Ambiente di Esecuzione*],
        text(fill: readable-text(palette-primary))[*Sottosistemi e Componenti Allocati*],
        text(fill: readable-text(palette-primary))[*Responsabilità e Connessioni*],
      ),

      [*Dispositivo Utente* \ (`:UserDevice`)],
      [#block(breakable: false)[OS Mobile/Desktop; Browser moderno con _Service Worker_, IndexedDB, Web Crypto API e WebAssembly. Artefatti Vue.js erogati via CDN HTTPS.]],
      [#block(breakable: false)[*Applicazione Web Utente (PWA)*: UI accessibile (HTML semantico e WAI-ARIA), _Panic Button_, Diario delle evidenze cifrato _offline-first_, mappa/rubrica offline dei Servizi Territoriali, accesso al Counseling, de-identificazione _on-device_, cifratura/decifratura E2EE locale.]],
      [#block(breakable: false)[Erogazione UI (WCAG 2.1 AA), operatività offline, decifratura locale degli eventi selezionati per il Triage e crittografia client-side. Connessione Wi-Fi o 4G/5G: SSO SAML 2.0/OIDC verso `:UniversityIdP` (`[F1]`); HTTPS (TLS 1.3) verso `:ApplicationServer` solo tramite *Controllo Accessi e Sicurezza* (`[F1–F3]`).]],

      [*Postazione CDF* \ (`:CDFWorkstation`)],
      [#block(breakable: false)[OS Desktop; Browser moderno conforme WCAG 2.1 AA con Web Crypto API. Artefatti Vue.js erogati via CDN HTTPS.]],
      [#block(breakable: false)[*Applicazione Web CDF*: consultazione, ricerca e filtro Pratiche, presa in carico, Note CDF, Integrazioni, chiusura, Periodi di Assenza, Report Statistici ed esportazione; modulo client di decifratura E2EE.]],
      [#block(breakable: false)[Lavorazione delle Pratiche e generazione report CUG. Connessione HTTPS (TLS 1.3): SSO + MFA verso `:UniversityIdP` (`[F1]`); canale cifrato dedicato verso `:HSM_KMS` per decifratura E2EE (`[F3]`); HTTPS verso `:ApplicationServer` solo tramite *Controllo Accessi e Sicurezza* (`[F1, F3, F4]`).]],

      [*Server Applicativo* \ (`:ApplicationServer`)],
      [#block(breakable: false)[Server Cloud gestito (regione UE): API Gateway (TLS 1.3), runtime applicativo e servizio Realtime.]],
      [#block(breakable: false)[*Controllo Accessi e Sicurezza* (punto di ingresso unico); *Gestione Utente (MO\_GU)*; *Gestione CDF (MO\_GCDF)*; *Triage Guidato*; *Reportistica CUG*; *Gestione Notifiche*.]],
      [#block(breakable: false)[SSO/RBAC, verifica transito dati sensibili solo cifrati E2E, log applicativi/telemetria senza dati riservati, logica applicativa, notifiche in-app e orchestrazione (con `MO_GU` e `MO_GCDF` che invocano *Gestione Notifiche*). HTTPS/TLS 1.3 verso client, `:UniversityIdP` (`[F1]`), \ `:AIInferenceNode` (`[F2]`), \ `:NotificationService` (`[F3]`) e `:AuditBackupStorage` (`[F3]`); canale cifrato verso `:PersistenceServer` (`[F2–F4]`).]],

      [*Server di Persistenza* \ (`:PersistenceServer`)],
      [#block(breakable: false)[Server Cloud gestito (regione UE): Managed Database e Object Storage cifrato.]],
      [#block(breakable: false)[*Persistenza Dati*: archiviazione separata di anagrafica, contenuti cifrati (Segnalazioni, Bozze, Pratiche, Note CDF, allegati, copia sincronizzata del Diario), metadati statistici e archivio Servizi Territoriali.]],
      [#block(breakable: false)[Persistenza transazionale sicura, paginazione indicizzata ($<$ 2 s p95), Diario cifrato inaccessibile a server e CDF, sola lettura su Pratiche chiuse/archiviate e snapshot cifrati. Accessibile solo da `:ApplicationServer` (`MO_GU`, `MO_GCDF`, *Reportistica CUG* per soli metadati, *Gestione Notifiche* per soli dati di contatto); replica backup cifrati verso `:AuditBackupStorage`.]],

      [*Storage Audit e Backup* \ (`:AuditBackupStorage`)],
      [#block(breakable: false)[Cloud Object Storage WORM in regione UE (_Object Lock_ in modalità _Compliance_ e _hash-chaining_) su account/IAM isolato.]],
      [#block(breakable: false)[*Audit Log Immodificabile* (soli metadati di accessi e operazioni del CDF); archivio backup giornalieri cifrati _off-site_. ]],
      [#block(breakable: false)[Immutabilità WORM e non ripudio dei log del CDF (retention 5 anni, _Separation of Duties_) e continuità operativa (RPO $<=$ 24 h, RTO $<=$ 4 h). Scrittura _append-only_ da `MO_GCDF` (`:ApplicationServer`, `[F3]`), replica cifrata da `:PersistenceServer` e sola lettura tracciata su canale separato per DPO, responsabile sicurezza e autorità.]],

      [*Nodo Modulo IA* \ (`:AIInferenceNode`)],
      [#block(breakable: false)[Container serverless _stateless_ in regione UE (runtime applicativo senza storage persistente).]],
      [#block(breakable: false)[*Modulo IA di Triage* (componente isolato interno a Pharos) e *Adattatore Provider IA* (interfaccia standard compatibile).]],
      [#block(breakable: false)[Valutazione IA _stateless_ e _Zero-Retention_ (gravità, tipologia di violenza, passi dell'iter) su testo già depurato _on-device_. Invocazione sincrona con timeout ($<$ 5 s p95) da *Triage Guidato* (`:ApplicationServer`) su HTTPS/TLS 1.3 (`[F2]`); inoltro cifrato verso `:ExternalAIProvider` tramite adattatore.]],

      [*Provider di Identità di Ateneo* \ (`:UniversityIdP`) \ _\[Esterno\]_],
      [#block(breakable: false)[Standard SAML 2.0 (Shibboleth / IDEM-GARR in esercizio; IdP federato cloud SAML 2.0/OIDC con MFA nell'MVP).]],
      [#block(breakable: false)[Servizio federato di autenticazione Single Sign-On (SSO + MFA) e fornitura dei ruoli (Utente / CDF).]],
      [#block(breakable: false)[Identificazione istituzionale senza duplicazione delle credenziali (`[F1]`). Scambio asserzioni/token su HTTPS (TLS 1.3) con `:UserDevice`, \ `:CDFWorkstation` e *Controllo Accessi e Sicurezza* (`:ApplicationServer`).]],

      [*HSM/KMS istituzionale* \ (`:HSM_KMS`) \ _\[Esterno\]_],
      [#block(breakable: false)[Cloud KMS hardware-backed in regione UE nell'MVP; HSM/KMS istituzionale di Ateneo in esercizio.]],
      [#block(breakable: false)[Servizio di custodia, utilizzo protetto ed _escrow_ della chiave privata del CDF.]],
      [#block(breakable: false)[Custodia della chiave privata del CDF per la decifratura E2EE (`[F3]`) e continuità operativa in caso di avvicendamento. Invocazione su HTTPS (TLS 1.3) esclusivamente da `:CDFWorkstation`, vincolata a sessione SSO + MFA.]],

      [*Servizio di Notifiche* \ (`:NotificationService`) \ _\[Esterno\]_],
      [#block(breakable: false)[Gateway e-mail transazionale in area UE e servizi Push dei browser tramite Web Push API (VAPID).]],
      [#block(breakable: false)[Servizio esterno di recapito asincrono di notifiche e-mail e push.]],
      [#block(breakable: false)[Recapito all'Utente di notifiche sugli aggiornamenti di Stato Pratica prive di dettagli riservati (`[F3]`). Invocazione asincrona su HTTPS/SMTPS (TLS 1.3) esclusivamente da *Gestione Notifiche* (`:ApplicationServer`).]],

      [*Provider IA esterno* \ (`:ExternalAIProvider`) \ _\[Esterno, opzionale\]_],
      [#block(breakable: false)[Endpoint LLM gestito in area SEE con DPA art. 28 GDPR e policy _Zero-Retention_. ]],
      [#block(breakable: false)[Modello LLM gestito per l'elaborazione della Valutazione IA.]],
      [#block(breakable: false)[Utilizzato nell'MVP cloud in alternativa al deployment _on-premise_ (`[F2]`). Invocato su HTTPS (TLS 1.3) unicamente dall'*Adattatore Provider IA* (`:AIInferenceNode`) su testi già depurati _on-device_.]],
    )
  ]
]

== Diagramma di deployment

#figure(
  image("../../assets/diagramma_deployment.png", width: 120%),
  caption: [Diagramma di deployment di Pharos (configurazione MVP su cloud gestito UE).],
) <fig-deployment>

#pagebreak()

#[
  #set text(size: 8pt)
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 4.5pt,
    align: horizon,
    ..table-style(palette-primary),
    table.header([*Notazione*], [*Significato*], [*Notazione*], [*Significato*]),

    table.cell(fill: rgb("#E8E4F5"))[*Nodi Client*], [`:UserDevice` e `:CDFWorkstation` (Vue.js)],
    table.cell(fill: rgb("#DCE6F5"))[*Nodo Applicativo*], [`:ApplicationServer` (Server Cloud gestito UE)],

    table.cell(fill: rgb("#E3F1E6"))[*Nodi Persistenza/Audit*], [`:PersistenceServer` e `:AuditBackupStorage` (WORM)],
    table.cell(fill: rgb("#FDEFD9"))[*Nodo Modulo IA*], [`:AIInferenceNode` (Container serverless UE, stateless)],

    table.cell(fill: rgb("#EFEFEF"))[*Sistemi esterni*], [IdP, HSM/KMS, Servizio Notifiche, Provider IA],
    table.cell(fill: rgb("#F7F5FC"))[*Riquadro esterno*], [Confine del Sistema Pharos],

    table.cell(fill: rgb("#ECECFF"))[*Componente* / *Cilindro*], [Sottosistema allocato / Archivio dati],
    [*«stereotipo»*], [Tipologia del nodo infrastrutturale],

    [*Freccia continua*], [Canale di comunicazione interno a Pharos (con protocollo)],
    [*Freccia tratteggiata*], [Interazione verso sistema esterno o canale separato DPO],
  )
]