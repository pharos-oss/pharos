#import "../../../templates/common.typ": palette-primary, readable-text, table-style

= Class Diagram Ristrutturato <class_diagram_ristrutturato>

La presente sezione illustra il Class Diagram ristrutturato di Pharos, ottenuto evolvendo il modello statico di analisi per riflettere la decomposizione in sottosistemi (@decomposizione_sottosistemi), l'adozione dei _design pattern_ definiti nel DPD e gli obiettivi progettuali di sicurezza, privacy e manutenibilità. Rispetto al modello concettuale del RAD, le classi sono state partizionate nei livelli *Presentazione*, *Applicativo* e *Persistenza Dati*, affiancati dal nodo isolato *Audit Log Immodificabile (WORM)*, dal componente *Modulo IA di Triage* (_stateless_ e _Zero-Retention_) e dalle interfacce verso i servizi esterni (`IServizioSSO`, `IServizioHSM`, `IServizioNotifiche`, `ProviderIAEsterno`).

L'accesso ai servizi applicativi avviene attraverso un punto di ingresso unico (`GestoreAccessiSicurezza`) dotato di autenticazione SAML 2.0, controllo RBAC e telemetria pseudonimizzata (`LoggerApplicativo`), attraverso il quale transita anche la sincronizzazione _offline-first_ (`ArchivioOfflineLocale`), mentre cifratura E2EE (`GestoreCifraturaClient`, `ClientDecifraturaCDF`) e redazione preventiva del testo (`RedattoreOnDevice`) restano confinate sui client. A livello applicativo sono integrati il pattern *Adapter* sul Modulo IA (`IModuloIATriage`, `ModuloIAOnPremise`, `AdattatoreProviderIA`) e il pattern *Observer* (`ISoggettoEventi`, `IOsservatoreEventi`, `EventoPratica`) per disaccoppiare la gestione delle pratiche dall'invio di notifiche prive di dettagli riservati (`GestoreNotifiche`) e dalla registrazione sincrona su storage WORM (`GestoreAuditLog`), che traccia anche le esportazioni dei report CUG prodotte da `GestoreReport`.

A livello di persistenza, le utenze istituzionali (`Utente`, `Cdf`) specializzano `AccountIstituzionale` e i dati sono separati logicamente nei domini Anagrafica, Contenuti Cifrati e Metadati (`MetadatoStatistico`). Lo stato `BOZZA` è confinato alla sola `Segnalazione`, mentre il ciclo di vita della `Pratica` adotta il pattern *State* tramite la classe astratta `StatoPratica` e le sei sottoclassi concrete (`Inviata`, `PresaInCarico`, `InLavorazione`, `InAttesaIntegrazioni`, `Chiusa`, `Archiviata`), imponendo il blocco in sola lettura sugli stati terminali. Infine, la consultazione dell'Audit Log con _hash-chaining_ avviene esclusivamente tramite il canale separato in sola lettura (`InterfacciaAudit`), riservato a DPO, responsabile sicurezza di Ateneo e autorità competenti, con tracciamento autonomo degli accessi.

La tabella seguente sintetizza la tracciabilità tra sottosistemi architetturali, classi principali, vincoli chiave e requisiti:

#[
  #set par(justify: false)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (auto, auto, auto, auto),
      inset: 8pt,
      align: horizon,

      table.header(
        [*Sottosistema*],
        [*Classi / Interfacce principali*],
        [*Relazioni e vincoli chiave*],
        [*Riferimenti*],
      ),

      [Applicazione Web Utente (PWA)],
      [InterfacciaUtente, GestoreCifraturaClient, RedattoreOnDevice, ArchivioOfflineLocale],
      [Cifratura AES-256 locale ed E2EE _client-side_; redazione _on-device_ prima del Triage; cache offline sincronizzata esclusivamente tramite `GestoreAccessiSicurezza`; Panic Button.],
      [RF\_GU\_01–03, RF\_GU\_11, RNF\_U\_01–04, RNF\_A\_01, RNF\_A\_03],

      [Applicazione Web CDF],
      [InterfacciaCDF, ClientDecifraturaCDF],
      [Decifratura E2EE tramite `IServizioHSM` senza esporre la chiave privata; nessuna dipendenza in lettura sull'Audit Log.],
      [RF\_GCDF\_01–09, RNF\_U\_03, RNF\_A\_01, RNF\_P\_02],

      [Controllo Accessi e Sicurezza],
      [GestoreAccessiSicurezza, Sessione, LoggerApplicativo, IServizioSSO],
      [Punto di ingresso unico per tutte le richieste provenienti dalla Presentazione; autenticazione SAML 2.0 e RBAC (`RuoloSistema`); logging tecnico pseudonimizzato.],
      [RNF\_IF\_01, RNF\_A\_01, RNF\_S\_01],

      [Gestione Utente (MO\_GU)],
      [GestoreDiario, GestoreSegnalazione],
      [Sincronizzazione cifrata di `Diario`/`EventoDiario`, validazione `Allegato`, bozze (`StatoSegnalazione`) e inoltro `Segnalazione`, integrazioni, interruzione iter e consultazione `ServizioTerritoriale`; `ConcreteSubject` nel pattern *Observer*.],
      [RF\_GU\_01–06, RF\_GU\_08, RF\_GU\_09, RF\_GU\_11],

      [Gestione CDF (MO\_GCDF)],
      [GestorePratiche],
      [Presa in carico, gestione ciclo di vita tramite pattern *State* su `Pratica`, `NotaCDF`, richiesta integrazioni, chiusura con `EsitoPratica`, gestione `PeriodoAssenza`; `ConcreteSubject` nel pattern *Observer*.],
      [RF\_GCDF\_01–07, RNF\_A\_02, RNF\_L\_02],

      [Triage Guidato],
      [GestoreTriage],
      [Riceve il solo testo depurato dalla PWA e delega la valutazione all'interfaccia target `IModuloIATriage`, restituendo `ValutazioneIA` senza accedere alla Persistenza Dati.],
      [RF\_GU\_10, RNF\_P\_01],

      [Modulo IA di Triage],
      [IModuloIATriage, ModuloIAOnPremise, AdattatoreProviderIA, ValutazioneIA, ProviderIAEsterno],
      [Componente isolato _stateless_ e _Zero-Retention_; disaccoppiamento del fornitore esterno tramite pattern *Adapter* (`IModuloIATriage` come Target, `AdattatoreProviderIA` come Adapter) con soglia di risposta #sym.lt.eq 5 s.],
      [RF\_GU\_10, RNF\_P\_01, RNF\_IM\_02, RNF\_L\_01],

      [Reportistica CUG],
      [GestoreReport, MetadatoStatistico, ReportStatistico],
      [Aggregazione dei soli metadati non identificativi senza accesso ai contenuti cifrati; `ConcreteSubject` per il tracciamento delle esportazioni sull'Audit Log WORM.],
      [RF\_GCDF\_08, RF\_GCDF\_09, RNF\_L\_02],

      [Gestione Notifiche],
      [GestoreNotifiche, Notifica, IServizioNotifiche],
      [`ConcreteObserver` asincrono su `EventoPratica`; invio notifiche generiche in-app ed e-mail senza dettagli riservati leggendo i soli contatti da `AccountIstituzionale`.],
      [RF\_GU\_07],

      [Persistenza Dati],
      [AccountIstituzionale, Utente, Cdf, Diario, EventoDiario, Allegato, Segnalazione, Pratica, StatoPratica (+ 6 stati concreti), StoricoTransizione, NotaCDF, EsitoPratica, PeriodoAssenza, ServizioTerritoriale],
      [Separazione logica in tre domini (Anagrafica, Contenuti Cifrati, Metadati); pattern *State* sui sei stati di `Pratica` con blocco applicativo e DB in sola lettura su `Chiusa` e `Archiviata`.],
      [RNF\_A\_01, RNF\_A\_02, RNF\_O\_01],

      [Audit Log Immodificabile (WORM)],
      [GestoreAuditLog, VoceAudit, InterfacciaAudit],
      [`ConcreteObserver` sincrono e atomico su storage WORM con _hash-chaining_; consultazione in sola lettura su canale separato (`InterfacciaAudit`) riservata a DPO, responsabile sicurezza di Ateneo e autorità competenti.],
      [RNF\_L\_02, RNF\_A\_01],
    )
  ]
]

#figure(
  image("../../assets/CD_02_Piattaforma_Ristrutturato.svg", width: 81%, height: 100%),
  caption: [Class Diagram ristrutturato di Pharos.],
)