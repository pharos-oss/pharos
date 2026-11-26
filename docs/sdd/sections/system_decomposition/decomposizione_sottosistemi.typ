#import "../../../templates/common.typ": table-style, palette-primary

= Decomposizione in sottosistemi <decomposizione_sottosistemi>

Per soddisfare i _design goal_ di sicurezza, separazione logica dei dati, tracciabilità e manutenibilità definiti in @introduzione, l'architettura _client-server multi-tier_ di Pharos adotta uno stile combinato di stratificazione (_layering_) e partizionamento (_partitioning_).

Il sistema è organizzato in tre livelli logici principali con accesso controllato (architettura a livelli chiusa rispetto ai client, che non accedono mai direttamente al livello di persistenza):

- *Livello di Presentazione:* partizionato per ruolo applicativo nei due client web (Applicazione Web Utente (PWA) e Applicazione Web Consigliere di Fiducia), responsabili dell'interazione, della cifratura e decifratura _End-to-End_ lato client e, lato utente, dell'operatività _offline_ e della rimozione dei dati identificativi direttamente sul dispositivo.
- *Livello Applicativo (Server Applicativo):* partizionato in sottosistemi coesi e debolmente accoppiati che incapsulano il controllo degli accessi, i due domini funzionali del RAD (Gestione Utente e Gestione Consigliere di Fiducia), l'adattatore _stateless_ per il Triage Guidato, l'elaborazione dei Report Statistici per il CUG e la Gestione Notifiche.
- *Livello di Persistenza e Sicurezza:* suddiviso tra la Persistenza Dati, che mantiene logicamente separati Dati Anagrafici, Pratiche, Metadati Statistici e Contenuti Cifrati, e l'Audit Log Immodificabile per il tracciamento delle operazioni del Consigliere di Fiducia.

A margine del nucleo applicativo opera il Modulo IA di Triage, mantenuto come componente isolato e _stateless_ (con modalità di _deployment_ _on-premise_ oppure servizio esterno conforme ai vincoli di non conservazione dei dati e divieto di riaddestramento). Esternamente al confine di Pharos si collocano invece i due sistemi esterni integrati, ovvero il Provider di Identità di Ateneo e il Servizio di Notifiche.

#pagebreak()

== Riepilogo dei sottosistemi e tracciabilità

La tabella seguente sintetizza i sottosistemi individuati, il livello architetturale di appartenenza, le responsabilità principali e la tracciabilità rispetto ai requisiti del RAD.

#v(0.8em)

#table(
  columns: (1.3fr, 0.85fr, 1.9fr, 1.0fr),
  ..table-style(palette-primary),
  inset: 7pt,
  align: left + horizon,
  table.header(
    [*Sottosistema*],
    [*Livello*],
    [*Responsabilità principali*],
    [*Requisiti RAD*],
  ),
  [*Applicazione Web Utente (PWA)*],
  [Presentazione],
  [Incapsula `InterfacciaUtente` (WCAG 2.1 livello AA), _Panic Button_, gestione _offline_ del Diario delle evidenze (cifratura locale) e dei Servizi Territoriali, rimozione dei dati identificativi sul dispositivo per il Triage Guidato, cifratura _End-to-End_ di Segnalazioni e Integrazioni.],
  [RF\_GU\_01..11, RNF\_U\_01..04, RNF\_A\_01, RNF\_A\_03, RNF\_IM\_01],
  [*Applicazione Web Consigliere di Fiducia*],
  [Presentazione],
  [Incapsula `InterfacciaCDF` (WCAG 2.1 livello AA) per la consultazione e presa in carico delle Pratiche, decifratura _End-to-End_ di Segnalazioni e Allegati riservata al CDF, gestione di Stato Pratica, Nota CDF, Esito Pratica e Periodo Assenza, richiesta ed esportazione dei Report Statistici per il CUG.],
  [RF\_GCDF\_01..09, RNF\_U\_03, RNF\_P\_02, RNF\_IM\_01],
  [*Controllo Accessi e Sicurezza*],
  [Applicativo],
  [Punto di ingresso su canale cifrato HTTPS per entrambi i client, verifica delle asserzioni SSO (SAML 2.0 / Shibboleth, IDEM-GARR) con il Provider di Identità di Ateneo, controllo degli accessi basato sui ruoli e logging tecnico pseudonimizzato.],
  [RNF\_IF\_01, RNF\_S\_01, RNF\_L\_01],
  [*Gestione Utente (`MO_GU`)*],
  [Applicativo],
  [Realizza i servizi di `GestoreDiario` e `GestoreSegnalazione`: sincronizzazione cifrata del Diario delle evidenze, gestione Bozze, inoltro separato di Segnalazione cifrata _End-to-End_ e metadati statistici non identificativi, Integrazioni, interruzione dell'iter, consultazione Stato Pratica, Nota CDF e Servizi Territoriali.],
  [RF\_GU\_01..09, RF\_GU\_11, RNF\_L\_01],
  [*Gestione Consigliere di Fiducia (`MO_GCDF`)*],
  [Applicativo],
  [Realizza i servizi di `GestorePratiche`: elenco filtrato, presa in carico, aggiornamento Stato Pratica, inserimento Nota CDF, richiesta Integrazioni, chiusura formale con Esito Pratica (blocco in sola lettura per Pratiche «Chiuse» o «Archiviate») e gestione Periodo Assenza.],
  [RF\_GCDF\_01..07, RNF\_A\_02, RNF\_L\_02, RNF\_P\_02],
  [#block(breakable: false)[*Triage Guidato*]],
  [#block(breakable: false)[Applicativo]],
  [#block(breakable: false)[Disaccoppia il server dal Modulo IA di Triage, quindi riceve il testo già privato dei dati identificativi sul dispositivo, lo inoltra in modalità _stateless_ con gestione _timeout_ e restituisce la Valutazione IA (gravità, tipologia di violenza e passi dell'iter) senza persistenza.]],
  [#block(breakable: false)[RF\_GU\_10, RNF\_IM\_02, RNF\_P\_01]],
  [*Reportistica CUG*],
  [Applicativo],
  [Realizza i servizi di `GestoreReport`: elabora ed esporta (PDF e CSV) i Report Statistici anonimizzati per il CUG interrogando esclusivamente i metadati statistici non identificativi, senza accesso ai Dati Anagrafici né ai contenuti cifrati.],
  [RF\_GCDF\_08, RF\_GCDF\_09, RNF\_L\_01, RNF\_L\_02],
  [*Gestione Notifiche*],
  [Applicativo],
  [Gestisce le Notifiche _in-app_ e coordina l'invio tramite il Servizio di Notifiche esterno per cambi di Stato Pratica, nuove Segnalazioni, richieste di Integrazione, ritiri e Periodi Assenza, garantendo l'assenza di dettagli riservati.],
  [RF\_GU\_05, RF\_GU\_07..09, RF\_GCDF\_03..07, RNF\_L\_01],
  [*Persistenza Dati*],
  [Persistenza e Sicurezza],
  [Mantiene la separazione logica tra Dati Anagrafici, Pratiche e Metadati Statistici (con vincoli di sola lettura per Pratiche «Chiuse» o «Archiviate») e Contenuti Cifrati (Segnalazioni cifrate _End-to-End_, Allegati, Bozze e copia sincronizzata del Diario delle evidenze); supporta backup giornalieri cifrati.],
  [RNF\_A\_01, RNF\_A\_02, RNF\_L\_01, RNF\_O\_01],
  [*Audit Log Immodificabile*],
  [Persistenza e Sicurezza],
  [Registra in modalità di sola aggiunta i metadati delle operazioni e degli accessi del CDF sui dati sensibili, risultando consultabile in sola lettura esclusivamente da DPO e Responsabile Sicurezza di Ateneo per separazione dei ruoli.],
  [RNF\_A\_02, RNF\_L\_02],
  [*Modulo IA di Triage*],
  [Isolato (_stateless_)],
  [Analizza il testo depurato dai dati identificativi producendo la Valutazione IA orientativa (gravità, tipologia di violenza e passi suggeriti) in modalità _stateless_ e _Zero-Retention_.],
  [RF\_GU\_10, RNF\_IM\_02, RNF\_P\_01],
)

#pagebreak()

== Descrizione dei sottosistemi e dei servizi esposti

- *Applicazione Web Utente (PWA):* incapsula `InterfacciaUtente`, la validazione asincrona degli Allegati con mantenimento dei campi già compilati e i presidi di sicurezza locale (_Panic Button_, cifratura locale del Diario delle evidenze _offline_, rimozione dei dati identificativi sul dispositivo prima del Triage Guidato, cifratura _End-to-End_ di Segnalazioni e Integrazioni). Interagisce con il Provider di Identità di Ateneo per l'autenticazione SSO e invoca esclusivamente le interfacce protette di Controllo Accessi e Sicurezza.

- *Applicazione Web Consigliere di Fiducia:* incapsula `InterfacciaCDF` per la consultazione filtrata e la presa in carico delle Pratiche, la gestione di Stato Pratica, Nota CDF, Esito Pratica e Periodo Assenza, nonché la generazione ed esportazione dei Report Statistici per il CUG. Esegue lato client la decifratura _End-to-End_ delle Segnalazioni e degli Allegati riservata al CDF e interagisce con il backend esclusivamente tramite Controllo Accessi e Sicurezza.

- *Controllo Accessi e Sicurezza:* funge da punto di ingresso unico su canale cifrato HTTPS. Verifica le asserzioni SAML 2.0 ricevute dal Provider di Identità di Ateneo, risolve il ruolo applicativo consultando i Dati Anagrafici nella Persistenza Dati, applica il controllo degli accessi basato sui ruoli verso i sottosistemi applicativi e produce logging tecnico pseudonimizzato.

- *Gestione Utente (`MO_GU`):* implementa la logica applicativa di `GestoreDiario` e `GestoreSegnalazione` (sincronizzazione cifrata del Diario delle evidenze, salvataggio e ripresa di Bozze, inoltro della Segnalazione cifrata _End-to-End_ con separazione logica dai metadati statistici non identificativi, invio di Integrazioni, interruzione dell'iter con passaggio a «Archiviata», consultazione di Stato Pratica e Nota CDF, consultazione della rubrica dei Servizi Territoriali).

- *Gestione Consigliere di Fiducia (`MO_GCDF`):* implementa la logica applicativa di `GestorePratiche` (ricerca e filtri, presa in carico, avanzamento di Stato Pratica, inserimento di Nota CDF, richiesta di Integrazioni, chiusura formale con Esito Pratica e blocco in sola lettura, gestione del Periodo Assenza con attivazione dell'avviso automatico agli Utenti). Ogni operazione sui dati sensibili invoca l'Audit Log Immodificabile per il tracciamento e Gestione Notifiche per l'aggiornamento all'Utente.

- *Triage Guidato:* funge da adattatore disaccoppiato tra il Server Applicativo e il Modulo IA di Triage. Riceve dall'Applicazione Web Utente il solo testo già depurato dai dati identificativi sul dispositivo, gestisce _timeout_ e invoca il Modulo IA di Triage in modalità _stateless_ per ottenere la Valutazione IA, isolando il resto del sistema dalla scelta di _deployment_ (_on-premise_ o servizio esterno conforme).

- *Reportistica CUG:* implementa `GestoreReport` per l'aggregazione statistica per periodo di riferimento, tipologia di violenza e componente accademica e l'esportazione dei Report Statistici in formato PDF e CSV. Dispone di permessi di lettura ristretti ai soli metadati statistici non identificativi e registra ogni esportazione nell'Audit Log Immodificabile.

- *Gestione Notifiche:* crea le Notifiche _in-app_ (salvate nella Persistenza Dati) e coordina l'inoltro al Servizio di Notifiche esterno per gli aggiornamenti di Stato Pratica, le nuove Segnalazioni, le richieste di Integrazione, i ritiri e i Periodi Assenza, omettendo qualsiasi dettaglio riservato.

- *Persistenza Dati:* garantisce la segregazione logica tra Dati Anagrafici (identità istituzionali e ruoli), Pratiche e Metadati Statistici (Stato Pratica, Nota CDF, Esito Pratica, Periodo Assenza, Servizi Territoriali, Notifiche e metadati non identificativi, con vincoli di sola lettura per Pratiche «Chiuse» o «Archiviate») e Contenuti Cifrati (Segnalazioni cifrate _End-to-End_, Allegati, Bozze e copia sincronizzata del Diario delle evidenze).

- *Audit Log Immodificabile:* registra in modalità di sola aggiunta i metadati delle operazioni e degli accessi del CDF sui dati sensibili, risultando accessibile in sola lettura esclusivamente a DPO e Responsabile Sicurezza di Ateneo per separazione dei ruoli.

#pagebreak(weak: true)

== Diagramma dei sottosistemi

Il diagramma seguente (@fig-sottosistemi) rappresenta la suddivisione del sistema Pharos nei sottosistemi individuati e le relative dipendenze (`«use»`), distinguendo con confini dedicati il sistema Pharos, i tre livelli architetturali, il Modulo IA di Triage isolato e i sistemi esterni integrati.

#figure(
  image("../../assets/diagramma_sottosistemi.png", width: 100%),
  caption: [Diagramma dei sottosistemi e delle dipendenze della piattaforma Pharos.],
) <fig-sottosistemi>

#pagebreak()

Le dipendenze evidenziate in @fig-sottosistemi riflettono tre proprietà strutturali dell'architettura:

1. *Assenza di dipendenze circolari:* le relazioni procedono gerarchicamente dal Livello di Presentazione verso il Livello Applicativo e da quest'ultimo verso il Livello di Persistenza e Sicurezza, agevolando la verifica e l'evoluzione incrementale dei componenti.

2. *Isolamento dei domini e dei servizi critici:* Reportistica CUG accede esclusivamente ai metadati statistici non identificativi senza dipendere da Gestione Utente (`MO_GU`) né dai Contenuti Cifrati, mentre Triage Guidato disaccoppia il nucleo applicativo dal Modulo IA di Triage.

3. *Contenimento dei confini esterni:* l'integrazione con il Provider di Identità di Ateneo (autenticazione federata SSO) e con il Servizio di Notifiche è confinata rispettivamente ai client / Controllo Accessi e Sicurezza e a Gestione Notifiche.

#pagebreak(weak: true)

== Diagramma architetturale

Il diagramma architetturale (@fig-architettura) illustra gli elementi operativi della piattaforma Pharos, le componenti interne dedicate alla sicurezza e alla persistenza segregata, i confini di esecuzione e le interazioni principali organizzate lungo i quattro flussi architetturali descritti nella panoramica (`[F1]`–`[F4]`), oltre al flusso di controllo indipendente riservato a DPO e Responsabile Sicurezza di Ateneo sull'Audit Log Immodificabile.

#figure(
  image("../../assets/diagramma_architetturale.png", width: 95%),
  caption: [Diagramma architetturale della piattaforma Pharos con componenti principali, confini e flussi di interazione.],
) <fig-architettura>

#pagebreak()

Le interazioni rappresentate in @fig-architettura corrispondono ai flussi definiti in @architettura_proposta:

- *Flusso `[F1]` - Autenticazione SSO:* entrambi i client eseguono l'accesso federato SAML 2.0 tramite il Provider di Identità di Ateneo; Controllo Accessi e Sicurezza verifica le asserzioni e risolve il ruolo applicativo (Utente o Consigliere di Fiducia).

- *Flusso `[F2]` - Diario delle evidenze e Triage Guidato:* l'Applicazione Web Utente (PWA) cifra localmente e sincronizza il Diario delle evidenze; all'avvio del Triage Guidato, esegue sul dispositivo la rimozione dei dati identificativi (redazione automatica e revisione assistita) prima di trasmettere il solo testo depurato tramite HTTPS all'adattatore applicativo, che interroga il Modulo IA di Triage in modalità _stateless_ per ottenere la Valutazione IA.

- *Flusso `[F3]` - Inoltro e lavorazione della Pratica:* all'invio di una Segnalazione (o di un'Integrazione), l'Applicazione Web Utente (PWA) cifra _End-to-End_ il contenuto sensibile e trasmette separatamente i metadati statistici non identificativi. Il Server Applicativo archivia in modo logicamente separato Dati Anagrafici, Pratiche e Metadati Statistici e Contenuti Cifrati senza poter leggere in chiaro i fatti narrati. Il CDF consulta e decifra _End-to-End_ la Pratica tramite l'Applicazione Web Consigliere di Fiducia, con registrazione obbligatoria nell'Audit Log Immodificabile e invio di Notifiche prive di dettagli riservati.

- *Flusso `[F4]` - Generazione di Report Statistici:* su richiesta del CDF, il sottosistema Reportistica CUG aggrega esclusivamente i metadati statistici non identificativi per produrre ed esportare i Report Statistici destinati al CUG, tracciando l'esportazione nell'Audit Log Immodificabile.

- *Flusso `[Audit]` - Verifica indipendente (Separazione dei ruoli):* DPO e Responsabile Sicurezza di Ateneo consultano in sola lettura (con tracciamento) l'Audit Log Immodificabile, inaccessibile in lettura e modifica sia agli Utenti sia al CDF.