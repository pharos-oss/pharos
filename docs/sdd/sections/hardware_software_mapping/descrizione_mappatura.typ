#import "../../../templates/common.typ": palette-primary, readable-text, table-style

La presente sezione descrive la mappatura tra i sottosistemi software che compongono la piattaforma Pharos e le risorse hardware e infrastrutturali deputate alla loro esecuzione. L'obiettivo è definire la topologia di distribuzione del sistema, specificando l'allocazione degli artefatti software sui rispettivi nodi di elaborazione e i protocolli di comunicazione adottati per l'interazione tra di essi, garantendo il soddisfacimento dei requisiti non funzionali e dei design goals stabiliti in termini di prestazioni, affidabilità, scalabilità e costi.

#v(0.5em)

=== Descrizione generale e relazioni tra i nodi
La topologia di distribuzione di Pharos adotta un'architettura multi-livello strutturata per domini di fiducia, in cui il server applicativo centrale coordina le comunicazioni tra client, persistenza e servizi esterni su canali cifrati (HTTPS/TLS 1.3, SAML 2.0), mantenendo le operazioni crittografiche e di de-identificazione lato client. Di seguito sono riassunti il ruolo e le interazioni di ciascun nodo:

- *Dispositivo Utente (`:UserDevice`):* Ospita InterfacciaUtente, la logica locale di GestoreDiario, il modulo crittografico e il motore di de-identificazione on-device. Interagisce con :UniversityIdP tramite SAML 2.0 per l'autenticazione SSO e con :ApplicationServer su HTTPS (TLS 1.3) per l'invio delle segnalazioni cifrate, il triage guidato tramite modulo IA e la sincronizzazione della coda offline.
- *Postazione CDF (`:CDFWorkstation`):* Esegue InterfacciaCDF e il modulo client per la decifratura E2EE. Comunica con :UniversityIdP per l'accesso SSO + MFA, con :HSM_KMS per l'utilizzo protetto della chiave privata istituzionale e con :ApplicationServer su HTTPS (TLS 1.3) per la gestione delle pratiche e la generazione dei report.
- *Server Applicativo (`:ApplicationServer`):* Funge da nodo centrale di orchestrazione, ospitando i servizi di business (GestoreSegnalazione, GestorePratiche, GestoreReport) e gli adattatori di integrazione (SSOAdapter, TriageAIProxy, NotificationGateway, AuditLogClient). Media tutte le comunicazioni tra i nodi client, il livello di persistenza, i nodi di sicurezza e i servizi esterni, senza mai accedere in chiaro ai contenuti cifrati E2EE.
- *Server di Persistenza (`:PersistenceServer`):* Comunica esclusivamente con :ApplicationServer su rete privata cifrata per la memorizzazione separata di anagrafiche, pratiche cifrate, metadati statistici e allegati. Alimenta inoltre i processi di replica cifrata verso :AuditBackupStorage.
- *Storage Audit e Backup (`:AuditBackupStorage`):* Riceve in scrittura append-only i log di accesso inviati da AuditLogClient (:ApplicationServer) su storage WORM e conserva i backup giornalieri cifrati provenienti da :PersistenceServer, rimanendo isolato per garantire la separazione dei ruoli (Separation of Duties).
- *Modulo HSM/KMS (`:HSM_KMS`):* custodisce la chiave privata istituzionale del CDF e dialoga su canale cifrato dedicato con ⁠ :CDFWorkstation ⁠ (previa verifica della sessione SSO + MFA) per abilitare la decifratura delle pratiche senza esporre la chiave al livello applicativo.
- *Nodo Inferenza IA (`:AIInferenceNode`):* invocato in modalità sincrona e stateless da ⁠ TriageAIProxy ⁠ (⁠ :ApplicationServer ⁠) su HTTPS (TLS 1.3), riceve testi già redatti on-device e restituisce la valutazione orientativa (⁠ ValutazioneIA ⁠) senza persistenza dei dati
- *idP di Ateneo (`:UniversityIdP`):* nodo esterno che interagisce via SAML 2.0 con i client (⁠ :UserDevice ⁠, ⁠ :CDFWorkstation ⁠) e con ⁠ SSOAdapter ⁠ (⁠ :ApplicationServer ⁠) per verificare le identità istituzionali e fornire gli attributi di ruolo (RBAC).
- *Servizio Notifiche (`:NotificationService`):* nodo esterno invocato in modo asincrono da ⁠ NotificationGateway ⁠ (⁠ :ApplicationServer ⁠) su TLS/SMTPS o HTTPS per recapitare agli utenti gli avvisi di aggiornamento stato privi di contenuti sensibili.

#pagebreak()

=== Tabella dei nodi

La tabella seguente riassume la mappatura tra i nodi hardware (o infrastrutturali) del sistema Pharos, la relativa piattaforma software di esecuzione (macchina virtuale), i componenti allocati e le principali connessioni di rete.

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

      text(fill: readable-text(palette-primary))[*Nodo Hardware / Infrastrutturale*],
      text(fill: readable-text(palette-primary))[*Piattaforma / Macchina Virtuale*],
      text(fill: readable-text(palette-primary))[*Componenti Software Allocati*],
      text(fill: readable-text(palette-primary))[*Responsabilità e Connessioni*],

      /* TODO: Da rivedere post revisione per la scelta finale della piattaforma utente (PWA/Nativa); in seguito riscrivere e riallineare i nomi delle componenti post approvazione scomposizione in sottosistemi, da rivedere le connessioni e le responsabilità */

      [*Dispositivo Utente* \ (`:UserDevice`)],
      [#block(breakable: false)[OS Mobile/Desktop; Browser con _Service Worker_ e storage locale (PWA) _oppure_ runtime mobile con Android Keystore / iOS Keychain.]],
      [#block(breakable: false)[Applicazione Utente (InterfacciaUtente, _Panic Button_, logica locale di GestoreDiario); modulo crittografico locale (AES-256 / E2EE); motore di de-identificazione _on-device_; cache locale cifrata (Diario, EventoDiario, ServizioTerritoriale) e coda di sincronizzazione _offline_.]],
      [#block(breakable: false)[Erogazione UI accessibile (WCAG 2.1 AA), operatività _offline-first_, redazione testi e cifratura lato client. Connessione Wi-Fi o 4G/5G su HTTPS (TLS 1.3) verso `:ApplicationServer` e SAML 2.0 verso `:UniversityIdP`.]],
      // guarda nota in cima alla tabella
      [*Postazione CDF* \ (`:CDFWorkstation`)],
      [#block(breakable: false)[OS Desktop; Web Browser moderno conforme WCAG 2.1 AA.]],
      [#block(breakable: false)[Applicazione Web Consigliere di Fiducia (InterfacciaCDF); modulo client per la decifratura E2EE dei contenuti delle pratiche e visualizzazione dashboard/report.]],
      [#block(breakable: false)[Presa in carico, avanzamento stato, inserimento note, gestione assenze e richiesta report CUG. Connessione Ethernet / rete di Ateneo su HTTPS (TLS 1.3) verso `:ApplicationServer` e SSO + MFA verso `:UniversityIdP` / \ `:HSM_KMS`.]],
      // da rivedere quando si decide la tecnologia backend
      [*Server Applicativo* \ (`:ApplicationServer`)],
      [#block(breakable: false)[Linux Server; Docker Engine; Reverse Proxy e Runtime applicativo backend.]],
      [#block(breakable: false)[Servizi applicativi dei domini `MO_GU` e `MO_GCDF` (GestoreSegnalazione, GestorePratiche, GestoreReport); adattatori di integrazione (SSOAdapter, TriageAIProxy, NotificationGateway, AuditLogClient).]],
      [#block(breakable: false)[Coordinamento della logica di business, controllo accessi RBAC, aggregazione statistica e instradamento senza accesso ai testi in chiaro. Connessioni HTTPS/TLS 1.3 verso client, IA e servizi esterni; rete interna cifrata verso persistenza e sicurezza.]],
      // da scegliere il database di persistenza (relazionale)
      [*Server di Persistenza* \ (`:PersistenceServer`)],
      [#block(breakable: false)[Linux Server; Docker Engine; DBMS Relazionale + Object Storage cifrato.]],
      [#block(breakable: false)[Database con separazione logica tra anagrafica (Utente, Cdf), contenuti cifrati (Segnalazione, Pratica, StatoPratica, NotaCDF, EsitoPratica), metadati statistici (ReportStatistico), ServizioTerritoriale e PeriodoAssenza; storage cifrato per Allegato e sync cifrato del Diario.]],
      [#block(breakable: false)[Persistenza transazionale sicura, paginazione indicizzata ($<$ 2 s p95) e blocco applicativo/DB in sola lettura (_read-only_) per pratiche «Chiuse» o «Archiviate». Accessibile esclusivamente da `:ApplicationServer` su rete privata cifrata.]],
      // questo componente va bene
      [*Storage Audit e Backup* \ (`:AuditBackupStorage`)],
      [#block(breakable: false)[Storage WORM con _hash-chaining_; repository remoto cifrato _off-site_.]],
      [#block(breakable: false)[`Audit Log` immodificabile (soli metadati operativi, accesso riservato a DPO/Sicurezza per _Separation of Duties_); archivio backup giornalieri cifrati.]],
      [#block(breakable: false)[Garanzia di integrità dei log di accesso del CDF (retention 5 anni) e continuità operativa con RPO $<=$ 24 h (ripristino containerizzato con RTO $<=$ 4 h). Scrittura append-only da `:ApplicationServer` e replica cifrata automatizzata.]],
      // questo componente va bene ma in revisione finale rivedrei le responsabilità della gestione della chiave CDF
      [*Modulo HSM / KMS* \ (`:HSM_KMS`)],
      [#block(breakable: false)[Hardware Security Module / Key Management Service istituzionale.]],
      [#block(breakable: false)[Servizio di custodia, utilizzo protetto ed _escrow_ istituzionale della chiave privata del CDF.]],
      [#block(breakable: false)[Protezione della chiave di decifratura E2EE del CDF e continuità in caso di avvicendamento del titolare. Accesso vincolato a sessione autenticata SSO + MFA su canale cifrato dedicato.]],
      // da decidere la soluzione per l'implementazione del modello
      [*Nodo Inferenza IA* \ (`:AIInferenceNode`)],
      [#block(breakable: false)[Server _on-premise_ (Docker/GPU) _oppure_ endpoint IA gestito in area SEE (DPA art. 28 GDPR, _Zero-Retention_).]],
      [#block(breakable: false)[Modulo IA di Triage _stateless_ (elaborazione semantica e generazione di ValutazioneIA).]],
      [#block(breakable: false)[Classificazione orientativa su testi già redatti _on-device_, senza persistenza né riaddestramento. Invocazione sincrona con timeout ($<$ 5 s p95) da `:ApplicationServer` su HTTPS (TLS 1.3).]],
      // questo componente va bene
      [*IdP di Ateneo* \ (`:UniversityIdP`) \ _\[Esterno\]_],
      [#block(breakable: false)[Shibboleth / SAML 2.0 (federazione IDEM-GARR).]],
      [#block(breakable: false)[Servizio federato di autenticazione Single Sign-On e rilascio attributi di ruolo.]],
      [#block(breakable: false)[Identificazione istituzionale degli utenti e del CDF senza duplicazione delle credenziali. Scambio asserzioni SAML 2.0 su HTTPS con i client e `:ApplicationServer`.]],

      [*Servizio Notifiche* \ (`:NotifyService`) \ _\[Esterno\]_],
      [#block(breakable: false)[Server SMTP istituzionale / Gateway di notifica push.]],
      [#block(breakable: false)[Servizio di inoltro asincrono per gli avvisi in-app ed e-mail (Notifica).]],
      [#block(breakable: false)[Recapito notifiche di aggiornamento stato o richieste di integrazione prive di dati sensibili. Invocazione asincrona su TLS/SMTPS o HTTPS da `:ApplicationServer`.]],
    )
  ]
]