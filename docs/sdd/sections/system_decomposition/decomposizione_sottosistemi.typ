#import "../../../templates/common.typ": table-style, palette-primary

= Decomposizione in sottosistemi <decomposizione_sottosistemi>

Il sistema Pharos è scomposto in sottosistemi secondo due criteri combinati: la *stratificazione* in tre livelli (Presentazione, Applicativo, Persistenza e Sicurezza) e il *partizionamento* in sottosistemi coesi, ciascuno con una responsabilità precisa. Il Provider di Identità di Ateneo e il Servizio di Notifiche sono sistemi esterni a Pharos. Il Modulo IA di Triage è invece un componente di Pharos logicamente isolato e privo di persistenza: poiché il suo deployment (on-premise o servizio gestito vincolato da DPA) è demandato alla progettazione di dettaglio, è rappresentato fuori dal confine applicativo. I sottosistemi Gestione Utente (MO\_GU) e Gestione CDF (MO\_GCDF) corrispondono ai due moduli funzionali definiti nel RAD.

== Riepilogo dei sottosistemi e tracciabilità <riepilogo_sottosistemi>

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #figure(
    caption: [Sottosistemi di Pharos, responsabilità e requisiti del RAD coperti.],
    table(
      columns: (1.3fr, 0.9fr, 2fr, 1.2fr),
      inset: 8pt,
      align: horizon,
      ..table-style(palette-primary),
      table.header([*Sottosistema*], [*Livello*], [*Responsabilità*], [*Requisiti*]),

      [Applicazione Web Utente (PWA)], [Presentazione],
      [Interfaccia dell'Utente, Panic Button (Chiusura rapida), Diario delle evidenze cifrato in locale, de-identificazione on-device, cifratura End-to-End lato client e decifratura locale dei propri contenuti.],
      [RF\_GU\_01–03, RF\_GU\_11, RNF\_U\_01–04, RNF\_A\_01, RNF\_A\_03, RNF\_P\_01],

      [Applicazione Web CDF], [Presentazione],
      [Interfaccia del CDF, consultazione delle Pratiche e decifratura End-to-End con chiave privata del CDF custodita in HSM/KMS.],
      [RF\_GCDF\_01–03, RNF\_A\_01, RNF\_P\_02],

      [Controllo Accessi e Sicurezza], [Applicativo],
      [Autenticazione tramite SSO, autorizzazione per ruolo sulla base dei ruoli forniti dal Provider di Identità di Ateneo e punto di ingresso unico verso gli altri sottosistemi.],
      [RNF\_IF\_01],

      [Gestione Utente (MO\_GU)], [Applicativo],
      [Gestione di Segnalazioni, Bozze, consultazione dello stato, Integrazioni e interruzione dell'iter.],
      [RF\_GU\_04–06, RF\_GU\_08, RF\_GU\_09],

      [Gestione CDF (MO\_GCDF)], [Applicativo],
      [Gestione di Pratiche, Stati Pratica, Note CDF, richieste di Integrazione, Esiti Pratica e Periodi di Assenza.],
      [RF\_GCDF\_01–07],

      [Triage Guidato], [Applicativo],
      [Inoltro al Modulo IA del testo già depurato dai dati identificativi e restituzione della Valutazione IA.],
      [RF\_GU\_10, RNF\_P\_01],

      [Reportistica CUG], [Applicativo],
      [Aggregazione dei soli metadati statistici non identificativi, produzione ed esportazione dei Report Statistici.],
      [RF\_GCDF\_08, RF\_GCDF\_09],

      [Gestione Notifiche], [Applicativo],
      [Invio all'Utente, tramite il Servizio di Notifiche, di notifiche in-app ed e-mail sugli aggiornamenti di Stato Pratica, prive di dettagli riservati.],
      [RF\_GU\_07],

      [Persistenza Dati], [Persistenza e Sicurezza],
      [Archiviazione separata di anagrafica, contenuti cifrati e metadati statistici; la copia sincronizzata del Diario resta cifrata e inaccessibile sia al server sia al CDF; sola lettura sulle Pratiche chiuse o archiviate; backup cifrati.],
      [RNF\_A\_02, RNF\_O\_01],

      [Audit Log Immodificabile], [Persistenza e Sicurezza],
      [Registrazione immodificabile (WORM) di ogni accesso e operazione del CDF sui dati sensibili, solo metadati. Consultazione in sola lettura, anch'essa tracciata, riservata a DPO, responsabile sicurezza di Ateneo o autorità competenti, non al CDF.],
      [RNF\_L\_02],

      [Modulo IA di Triage], [Componente isolato],
      [Valutazione IA stateless e Zero-Retention; modalità di deployment demandata alla progettazione di dettaglio.],
      [RNF\_IM\_02, RNF\_L\_01],
    ),
  ) <tab-sottosistemi>
]

I requisiti RNF\_IM\_01, RNF\_S\_01, RNF\_PK\_01 e RNF\_PK\_02 sono trasversali a tutti i sottosistemi e non sono assegnati a uno in particolare.

== Diagramma dei sottosistemi <diagramma_sottosistemi>

#figure(
  image("../../assets/diagramma_sottosistemi.png", width: 97%),
  caption: [Diagramma dei sottosistemi di Pharos.],
) <fig-sottosistemi>

#[
  #set text(size: 8pt)
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 4pt,
    stroke: 0.4pt + gray,
    [*Componente*], [Sottosistema o sistema esterno], [*Cilindro*], [Archivio di dati],
    [*Rettangolo*], [Livello o confine], [*Freccia tratteggiata*], [Dipendenza d'uso],
    [*Sfondo arancione*], [Componente isolato (stateless)], [*Sfondo grigio*], [Sistema esterno a Pharos],
  )
]

Il diagramma (@fig-sottosistemi) evidenzia tre proprietà strutturali:

- *Punto di ingresso unico*: le due applicazioni di Presentazione accedono ai servizi solo tramite il sottosistema Controllo Accessi e Sicurezza.
- *Separazione dei dati*: l'anagrafica, i contenuti cifrati e i metadati statistici sono archiviati separatamente, e il Server Applicativo non accede in chiaro ai contenuti sensibili.
- *Isolamento del Modulo IA*: riceve solo testo già depurato dai dati identificativi, non conserva alcuno stato ed è raggiunto solo attraverso il Triage Guidato.

== Diagramma architetturale <diagramma_architetturale>

#figure(
  image("../../assets/diagramma_architetturale.png", width: 100%),
  caption: [Diagramma architetturale di Pharos con i flussi principali.],
) <fig-architettura>

#[
  #set text(size: 8pt)
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 4pt,
    stroke: 0.4pt + gray,
    [*Rettangolo*], [Confine del sistema o gruppo], [*Nodo*], [Ambiente di esecuzione],
    [*Componente*], [Sottosistema], [*Cilindro*], [Archivio di dati],
    [*Freccia continua*], [Interazione interna], [*Freccia tratteggiata*], [Interazione con sistema esterno],
    [*\[F1\]–\[F4\]*], [Flussi descritti di seguito], [*Sfondo arancione/grigio*], [Componente isolato / sistema esterno],
  )
]

#pagebreak()

La @fig-architettura mostra i nodi di esecuzione e i flussi, descritti nell'architettura del sistema proposto (@architettura_proposta):

- *\[F1\] Autenticazione SSO*: Utente e CDF accedono tramite il Provider di Identità di Ateneo e ottengono una sessione vincolata al proprio ruolo.
- *\[F2\] Gestione del Diario e Triage Guidato*: la copia sincronizzata del Diario sul server resta cifrata e inaccessibile sia al server sia al CDF. All'avvio del Triage Guidato il client decifra localmente solo gli eventi selezionati e rimuove i dati identificativi on-device. Il testo depurato raggiunge il Server Applicativo, che lo inoltra al Modulo IA tramite il Triage Guidato.
- *\[F3\] Inoltro e lavorazione della Pratica*: il contenuto cifrato E2E e i soli metadati statistici non identificativi vengono archiviati separatamente nella Persistenza Dati. Il CDF lavora la Pratica con registrazione di ogni accesso nell'Audit Log, e la Gestione Notifiche attiva il Servizio di Notifiche per avvisare l'Utente degli aggiornamenti di stato.
- *\[F4\] Generazione di Report Statistici*: la Reportistica CUG aggrega solo i metadati non identificativi, senza accedere al contenuto cifrato.

== Descrizione dei sottosistemi e dei servizi esposti <servizi_sottosistemi>

La tabella seguente descrive, per ciascun sottosistema del livello applicativo e di persistenza, i servizi che espone e quali sottosistemi li utilizzano. I sottosistemi di Presentazione non espongono servizi: sono i soli fruitori dell'interfaccia del Controllo Accessi e Sicurezza.

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #figure(
    caption: [Servizi esposti dai sottosistemi e relativi fruitori.],
    table(
      columns: (1.2fr, 2.6fr, 1.2fr),
      inset: 8pt,
      align: horizon,
      ..table-style(palette-primary),
      table.header([*Sottosistema*], [*Servizi esposti*], [*Utilizzato da*]),

      [Controllo Accessi e Sicurezza],
      [Autenticazione tramite SSO e apertura della sessione; verifica del ruolo (Utente o CDF) sulla base dei ruoli forniti dal Provider di Identità di Ateneo; autorizzazione e instradamento di ogni richiesta verso il sottosistema competente.],
      [Applicazione Web Utente, Applicazione Web CDF],

      [Gestione Utente (MO\_GU)],
      [Sincronizzazione cifrata degli eventi del Diario; salvataggio, modifica ed eliminazione degli eventi; salvataggio in Bozza e invio della Segnalazione; consultazione di stato e cronologia della Pratica; invio di Integrazioni; interruzione dell'iter; consultazione dei Servizi Territoriali.],
      [Controllo Accessi e Sicurezza],

      [Gestione CDF (MO\_GCDF)],
      [Elenco, ricerca e filtro delle Pratiche; presa in carico; aggiornamento dello Stato Pratica e inserimento di Note CDF; richiesta di Integrazioni; chiusura con Esito Pratica; gestione dei Periodi di Assenza.],
      [Controllo Accessi e Sicurezza],

      [Triage Guidato],
      [Avvio del percorso di Triage Guidato con il testo già depurato; restituzione della Valutazione IA all'Utente.],
      [Controllo Accessi e Sicurezza],

      [Reportistica CUG],
      [Generazione del Report Statistico per periodo di riferimento a partire dai soli metadati non identificativi; esportazione del report.],
      [Controllo Accessi e Sicurezza],

      [Gestione Notifiche],
      [Invio all'Utente di notifiche in-app ed e-mail sugli aggiornamenti di Stato Pratica, senza dettagli riservati.],
      [Gestione Utente, Gestione CDF],

      [Persistenza Dati],
      [Salvataggio e lettura separati di anagrafica, contenuti cifrati e metadati statistici; conservazione della copia sincronizzata del Diario, cifrata e inaccessibile a server e CDF; applicazione della sola lettura alle Pratiche chiuse o archiviate; esecuzione dei backup cifrati.],
      [Gestione Utente, Gestione CDF, Reportistica CUG, Gestione Notifiche],

      [Audit Log Immodificabile],
      [Registrazione in sola aggiunta (append-only) di accessi e operazioni del CDF; consultazione in sola lettura, anch'essa tracciata, per DPO, responsabile sicurezza di Ateneo e autorità competenti.],
      [Gestione CDF],

      [Modulo IA di Triage],
      [Valutazione stateless del testo depurato, con restituzione di gravità, tipologia di violenza e passi dell'iter di segnalazione.],
      [Triage Guidato],
    ),
  ) <tab-servizi>
]