#import "../../../templates/common.typ": table-style, palette-primary

= Decomposizione in sottosistemi <decomposizione_sottosistemi>

Il sistema Pharos è scomposto in sottosistemi secondo due criteri combinati: la *stratificazione* in tre livelli (Presentazione, Applicativo, Persistenza e Sicurezza) e il *partizionamento* in sottosistemi coesi, ciascuno con una responsabilità precisa. Il Provider di Identità di Ateneo, il Servizio di Notifiche, l'HSM/KMS istituzionale (che custodisce la chiave privata del CDF) e l'eventuale Provider IA esterno sono sistemi esterni a Pharos. Il Modulo IA di Triage è un componente interno a Pharos, logicamente isolato e privo di persistenza: il suo deployment (on-premise o servizio gestito vincolato da DPA) è demandato alla progettazione di dettaglio, e l'eventuale ricorso a un Provider IA esterno avviene esclusivamente tramite un adattatore esplicito, rappresentato nei diagrammi dal componente Adattatore Provider IA. I sottosistemi Gestione Utente (MO\_GU) e Gestione CDF (MO\_GCDF) corrispondono ai due moduli funzionali definiti nel RAD.

== Riepilogo dei sottosistemi e tracciabilità 

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #set table.cell(breakable: false)
  #figure(
    caption: [Sottosistemi di Pharos, responsabilità e requisiti del RAD coperti.],
    table(
      columns: (1.3fr, 0.9fr, 2fr, 1.2fr),
      inset: 8pt,
      align: horizon,
      ..table-style(palette-primary),
      table.header([*Sottosistema*], [*Livello*], [*Responsabilità*], [*Requisiti*]),

      [Applicazione Web Utente (PWA)], [Presentazione],
      [Interfaccia dell'Utente, Panic Button (Chiusura rapida), Diario delle evidenze cifrato in locale e disponibile offline (service worker e archiviazione locale cifrata del browser), de-identificazione on-device, cifratura End-to-End lato client e decifratura locale dei propri contenuti, consultazione offline della mappa dei Servizi Territoriali e della rubrica, accesso al supporto di Counseling psicologico.],
      [RF\_GU\_01–03, RF\_GU\_11, RNF\_U\_01–04, RNF\_A\_01, RNF\_A\_03, RNF\_P\_01],

      [Applicazione Web CDF], [Presentazione],
      [Interfaccia del CDF conforme a WCAG 2.1 AA: consultazione, ricerca e filtro delle Pratiche, presa in carico, avanzamento con Note CDF, richiesta di Integrazioni, chiusura, gestione del Periodo di Assenza, Report Statistici ed esportazione; decifratura End-to-End con chiave privata del CDF custodita in HSM/KMS istituzionale.],
      [RF\_GCDF\_01–09, RNF\_U\_03, RNF\_A\_01, RNF\_P\_02],

      [Controllo Accessi e Sicurezza], [Applicativo],
      [Autenticazione tramite SSO, autorizzazione per ruolo sulla base dei ruoli forniti dal Provider di Identità di Ateneo, instradamento di ogni richiesta verso il sottosistema competente (punto di ingresso unico), verifica che i dati sensibili transitino solo cifrati E2E, registrazione centralizzata dei log applicativi e della telemetria senza dati riservati.],
      [RNF\_IF\_01, RNF\_A\_01, RNF\_S\_01],

      [Gestione Utente (MO\_GU)], [Applicativo],
      [Sincronizzazione cifrata degli eventi del Diario (salvataggio, modifica, eliminazione), gestione di Segnalazioni, Bozze, consultazione dello stato, Integrazioni, interruzione dell'iter, consultazione dei Servizi Territoriali e supporto di Counseling psicologico.],
      [RF\_GU\_01–06, RF\_GU\_08, RF\_GU\_09, RF\_GU\_11, RNF\_A\_01],

      [Gestione CDF (MO\_GCDF)], [Applicativo],
      [Gestione di Pratiche, Stati Pratica, Note CDF, richieste di Integrazione, Esiti Pratica e Periodi di Assenza; sola lettura sulle Pratiche chiuse; scrittura nell'Audit Log di ogni accesso e operazione sui dati sensibili.],
      [RF\_GCDF\_01–07, RNF\_A\_02, RNF\_L\_02],

      [Triage Guidato], [Applicativo],
      [Inoltro al Modulo IA del testo già depurato dai dati identificativi e restituzione della Valutazione IA.],
      [RF\_GU\_10, RNF\_P\_01],

      [Reportistica CUG], [Applicativo],
      [Aggregazione dei soli metadati statistici non identificativi, produzione ed esportazione dei Report Statistici.],
      [RF\_GCDF\_08, RF\_GCDF\_09],

      [Gestione Notifiche], [Applicativo],
      [Invio all'Utente, tramite il Servizio di Notifiche, di notifiche in-app ed e-mail sugli aggiornamenti di Stato Pratica, prive di dettagli riservati; lettura dei soli dati di contatto dalla Persistenza Dati.],
      [RF\_GU\_07],

      [Persistenza Dati], [Persistenza e Sicurezza],
      [Archiviazione separata di anagrafica, contenuti cifrati e metadati statistici; archivio dei Servizi Territoriali consultabili anche offline; la copia sincronizzata del Diario resta cifrata e inaccessibile sia al server sia al CDF; sola lettura sulle Pratiche chiuse o archiviate; backup cifrati.],
      [RNF\_A\_02, RNF\_O\_01],

      [Audit Log Immodificabile], [Persistenza e Sicurezza],
      [Registrazione immodificabile (WORM) di ogni accesso e operazione del CDF sui dati sensibili, solo metadati. Canale di consultazione separato, in sola lettura e anch'esso tracciato, riservato a DPO, responsabile sicurezza di Ateneo o autorità competenti, non al CDF.],
      [RNF\_L\_02],

      [Modulo IA di Triage], [Componente isolato (interno a Pharos)],
      [Valutazione IA stateless e Zero-Retention; eventuale collegamento a un Provider IA esterno tramite adattatore esplicito; modalità di deployment demandata alla progettazione di dettaglio.],
      [RNF\_IM\_02, RNF\_L\_01],
    ),
  ) 
]

#v(3em)

I requisiti RNF\_IM\_01, RNF\_PK\_01 e RNF\_PK\_02 sono trasversali a tutti i sottosistemi e non sono assegnati a uno in particolare.

#pagebreak()

== Diagramma dei sottosistemi 

#figure(
  image("../../assets/diagramma_sottosistemi.png", width: 77%, height: 95%),
  caption: [Diagramma dei sottosistemi di Pharos.],
) <fig-sottosistemi>

#[
  #set text(size: 8pt)
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 4.5pt,
    align: horizon,
    ..table-style(palette-primary),
    table.header([*Notazione*], [*Significato*], [*Notazione*], [*Significato*]),

    table.cell(fill: rgb("#EAE8FA"))[*Livello Presentazione*], [Interfacce PWA Utente e Web CDF],
    table.cell(fill: rgb("#D5E8F7"))[*Livello Applicativo*], [Sottosistemi del Server Applicativo],

    table.cell(fill: rgb("#D5ECD9"))[*Livello Persistenza*], [Persistenza Dati e Audit Log WORM],
    table.cell(fill: rgb("#FCE8CC"))[*Componente isolato*], [Modulo IA (stateless) e Adattatore],

    table.cell(fill: rgb("#ECEEEF"))[*Sistemi esterni*], [Servizi istituzionali e provider esterni],
    table.cell(fill: rgb("#F7F7F9"))[*Riquadro esterno*], [Confine del Sistema Pharos],

    table.cell(fill: rgb("#ECECFF"))[*Componente*], [Sottosistema o sistema esterno],
    [*Cilindro*], [Archivio di dati],

    [*Freccia continua*], [Interazione interna a Pharos],
    [*Freccia tratteggiata*], [Dipendenza d'uso (`A → B`: A utilizza B)],
    [*Attore* / *\[F1\]–\[F4\]*], [DPO, sicurezza o autorità (sola lettura); flussi operativi],
  )
]

Il diagramma (@fig-sottosistemi) evidenzia quattro proprietà strutturali:

- *Punto di ingresso unico*: le due applicazioni di Presentazione accedono ai servizi solo tramite il sottosistema Controllo Accessi e Sicurezza.

- *Separazione dei dati*: l'anagrafica, i contenuti cifrati e i metadati statistici sono archiviati separatamente, e il Server Applicativo non accede in chiaro ai contenuti sensibili.

- *Isolamento del Modulo IA*: interno al confine di Pharos, riceve solo testo già depurato dai dati identificativi, non conserva alcuno stato ed è raggiunto solo attraverso il Triage Guidato; il collegamento a un Provider IA esterno passa solo dall'Adattatore Provider IA.

- *Controllo indipendente*: l'Audit Log è scritto dalla Gestione CDF e consultato in sola lettura, su canale separato, da DPO, responsabile sicurezza e autorità.

== Diagramma architetturale 

#figure(
  image("../../assets/diagramma_architetturale.png", width: 78%, height: 95%),
  caption: [Diagramma architetturale di Pharos con i flussi principali.],
) <fig-architettura>

#[
  #set text(size: 8pt)
  #set par(justify: false)
  #table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 4.5pt,
    align: horizon,
    ..table-style(palette-primary),
    table.header([*Notazione*], [*Significato*], [*Notazione*], [*Significato*]),

    table.cell(fill: rgb("#EAE8FA"))[*Nodi Client*], [Dispositivo Utente e Postazione CDF],
    table.cell(fill: rgb("#D5E8F7"))[*Nodo Server*], [Server Applicativo],

    table.cell(fill: rgb("#D5ECD9"))[*Nodo Persistenza*], [Persistenza Dati e Audit Log WORM],
    table.cell(fill: rgb("#FCE8CC"))[*Nodo Modulo IA*], [Componente isolato (stateless) e Adattatore],

    table.cell(fill: rgb("#ECEEEF"))[*Sistemi esterni*], [Servizi istituzionali e provider esterni],
    table.cell(fill: rgb("#F7F7F9"))[*Riquadro esterno*], [Confine del Sistema Pharos],

    [*Riquadro "Nodo: …"*], [Nodo di esecuzione],
    table.cell(fill: rgb("#ECECFF"))[*Componente* / *Cilindro*], [Sottosistema / Archivio di dati],

    [*Freccia continua*], [Flusso operativo interno a Pharos],
    [*Freccia tratteggiata*], [Dipendenza d'uso (`A → B`: A utilizza B)],
    [*Attore* / *\[F1\]–\[F4\]*], [Utente, CDF, DPO, sicurezza o autorità; flussi principali],
  )
]

La @fig-architettura mostra i nodi di esecuzione e i flussi, descritti nell'architettura del sistema proposto (@architettura_proposta):

- *\[F1\] Autenticazione SSO*: Utente e CDF accedono tramite il Provider di Identità di Ateneo e ottengono una sessione vincolata al proprio ruolo.

- *\[F2\] Gestione del Diario e Triage Guidato*: la Gestione Utente sincronizza sulla Persistenza Dati la copia cifrata del Diario, inaccessibile sia al server sia al CDF, e rende disponibili i Servizi Territoriali, consultabili offline dalla PWA. All'avvio del Triage Guidato il client decifra localmente solo gli eventi selezionati e rimuove i dati identificativi on-device. Il testo depurato raggiunge il Server Applicativo, che lo inoltra al Modulo IA tramite il Triage Guidato; il Modulo IA può usare un Provider IA esterno solo tramite il proprio adattatore.

- *\[F3\] Inoltro e lavorazione della Pratica*: il contenuto cifrato E2E e i soli metadati statistici non identificativi vengono archiviati separatamente nella Persistenza Dati. Il CDF decifra con la chiave privata custodita nell'HSM/KMS istituzionale e lavora la Pratica (inclusa la gestione del Periodo di Assenza) con registrazione di ogni accesso nell'Audit Log; la Gestione Notifiche legge i dati di contatto dalla Persistenza Dati e attiva il Servizio di Notifiche per avvisare l'Utente degli aggiornamenti di stato.

- *\[F4\] Generazione di Report Statistici*: la Reportistica CUG aggrega solo i metadati non identificativi, senza accedere al contenuto cifrato.

DPO, responsabile sicurezza e autorità consultano l'Audit Log in sola lettura attraverso un canale separato, anch'esso tracciato; tale accesso non appartiene ai flussi F1–F4.

#pagebreak()

== Descrizione dei sottosistemi e dei servizi esposti 

La tabella seguente descrive, per ciascun sottosistema del livello applicativo e di persistenza, i servizi che espone e quali sottosistemi li utilizzano; in coda sono riportati i sistemi esterni con cui Pharos interagisce. I sottosistemi di Presentazione non espongono servizi: sono i soli fruitori dell'interfaccia del Controllo Accessi e Sicurezza.

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #set table.cell(breakable: false)
  #figure(
    caption: [Servizi esposti dai sottosistemi e relativi fruitori.],
    table(
      columns: (1.2fr, 2.6fr, 1.2fr),
      inset: 8pt,
      align: horizon,
      ..table-style(palette-primary),
      table.header([*Sottosistema*], [*Servizi esposti*], [*Utilizzato da*]),

      [Controllo Accessi e Sicurezza],
      [Autenticazione tramite SSO e apertura della sessione; verifica del ruolo (Utente o CDF) sulla base dei ruoli forniti dal Provider di Identità di Ateneo; autorizzazione e instradamento di ogni richiesta verso il sottosistema competente; registrazione centralizzata di log e telemetria.],
      [Applicazione Web Utente (PWA), Applicazione Web CDF],

      [Gestione Utente (MO\_GU)],
      [Sincronizzazione cifrata degli eventi del Diario; salvataggio, modifica ed eliminazione degli eventi; salvataggio in Bozza e invio della Segnalazione; consultazione di stato e cronologia della Pratica; invio di Integrazioni; interruzione dell'iter; consultazione della mappa e della rubrica dei Servizi Territoriali (anche offline tramite la PWA); supporto di Counseling psicologico.],
      [Controllo Accessi e Sicurezza],

      [Gestione CDF (MO\_GCDF)],
      [Elenco, ricerca e filtro delle Pratiche; presa in carico; aggiornamento dello Stato Pratica e inserimento di Note CDF; richiesta di Integrazioni; chiusura con Esito Pratica; gestione dei Periodi di Assenza; sola lettura sulle Pratiche chiuse; scrittura nell'Audit Log.],
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
      [Salvataggio e lettura separati di anagrafica, contenuti cifrati e metadati statistici; archivio della mappa e della rubrica dei Servizi Territoriali (consultabili anche offline tramite la PWA); conservazione della copia sincronizzata del Diario, cifrata e inaccessibile a server e CDF; applicazione della sola lettura alle Pratiche chiuse o archiviate; esecuzione dei backup cifrati.],
      [Gestione Utente, Gestione CDF, Reportistica CUG, Gestione Notifiche],

      [Audit Log Immodificabile],
      [Registrazione in sola aggiunta (append-only) di accessi e operazioni del CDF; consultazione in sola lettura, anch'essa tracciata, tramite canale separato.],
      [Gestione CDF (scrittura); DPO, responsabile sicurezza di Ateneo e autorità competenti (sola lettura)],

      [Modulo IA di Triage],
      [Valutazione stateless del testo depurato, con restituzione di gravità, tipologia di violenza e passi dell'iter di segnalazione; collegamento opzionale a un Provider IA esterno tramite adattatore.],
      [Triage Guidato],

      [Provider di Identità di Ateneo (sistema esterno)],
      [Autenticazione SSO e fornitura dei ruoli.],
      [Applicazione Web Utente (PWA), Applicazione Web CDF, Controllo Accessi e Sicurezza],

      [Servizio di Notifiche (sistema esterno)],
      [Recapito di notifiche in-app ed e-mail.],
      [Gestione Notifiche],

      [HSM/KMS istituzionale (sistema esterno)],
      [Custodia della chiave privata del CDF per la decifratura End-to-End.],
      [Applicazione Web CDF],

      [Provider IA esterno (sistema esterno, opzionale)],
      [Elaborazione della Valutazione IA, se il deployment non è on-premise.],
      [Modulo IA di Triage (tramite adattatore)],
    ),
  ) 
]