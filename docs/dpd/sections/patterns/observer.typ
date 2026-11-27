#import "../../../templates/common.typ": table-style, palette-primary

== Observer - Notifiche di stato e Audit Log Immodificabile <pattern_observer>

Nel flusso `[F3]` dell'SDD, le operazioni eseguite su una Pratica, ovvero sia gli aggiornamenti di Stato Pratica regolati tramite @pattern_state sia gli accessi in consultazione e decifratura da parte del Consigliere di Fiducia (CDF), devono attivare due meccanismi indipendenti:

1. L'invio all'Utente, tramite Gestione Notifiche, di notifiche in-app ed e-mail prive di dettagli riservati a ogni aggiornamento di Stato Pratica (`RF_GU_07`);

2. La registrazione in sola aggiunta (_append-only_) dei soli metadati di ogni accesso e operazione del CDF sull'Audit Log Immodificabile su storage WORM con _hash-chaining_ (`RNF_L_02`).

Richiamare direttamente Gestione Notifiche e Audit Log Immodificabile all'interno di ogni singola operazione di Gestione Utente (`MO_GU`) e Gestione CDF (`MO_GCDF`) creerebbe una dipendenza rigida tra la gestione delle pratiche, il canale di notifica e l'archivio di audit.

== Soluzione e ruoli

Con il pattern *Observer*, i sottosistemi che eseguono le operazioni sulla Pratica non invocano direttamente i servizi di notifica e di audit, ma pubblicano un evento verso gli osservatori registrati al termine di ogni azione rilevante. In particolare, Gestione Utente (`MO_GU`) e Gestione CDF (`MO_GCDF`) svolgono il ruolo di *ConcreteSubject* e trasmettono esclusivamente metadati operativi (identificativo della pratica, azione eseguita o nuovo Stato Pratica, identificativo dell'Utente o del CDF, _timestamp_ ed esito), senza mai includere contenuti sensibili in chiaro.

#pagebreak()

I sottosistemi osservatori implementano l'interfaccia comune *Observer* e reagiscono autonomamente agli eventi di propria competenza, ovvero:

- *Gestione Notifiche* riceve gli aggiornamenti di Stato Pratica provenienti da `MO_GU` e `MO_GCDF`, legge i soli dati di contatto dalla Persistenza Dati e attiva il Servizio di Notifiche (`RF_GU_07`);

- *Audit Log Immodificabile* riceve esclusivamente gli eventi generati da `MO_GCDF` (accessi, apertura e decifratura di pratiche e allegati, cambi di stato, Note CDF, richieste di Integrazioni, chiusura e gestione del Periodo Assenza) e li registra su storage WORM (`RNF_L_02`).

#[
  #set par(justify: false)
  #set table.cell(breakable: false)
  #table(
    columns: (1fr, 1.45fr, 2.05fr),
    ..table-style(palette-primary),
    inset: 7pt,
    align: horizon,
    table.header([*Ruolo GoF*], [*Componente in Pharos*], [*Responsabilità*]),
    [Subject], [Interfaccia di notifica eventi (`MO_GU`, `MO_GCDF`)], [Consente di registrare e rimuovere gli osservatori e di notificare loro gli eventi relativi alla Pratica.],
    [ConcreteSubject], [*Gestione Utente (`MO_GU`)*, *Gestione CDF (`MO_GCDF`)*], [Notificano agli osservatori i soli metadati operativi al completamento di ogni aggiornamento di Stato Pratica e, per `MO_GCDF`, a ogni accesso o operazione del CDF.],
    [Observer], [Interfaccia di ricezione eventi], [Definisce il metodo di aggiornamento invocato alla ricezione di un evento di *Pratica*.],
    [ConcreteObserver 1], [*Gestione Notifiche*], [Reagisce agli aggiornamenti di Stato Pratica, legge i soli dati di contatto dalla Persistenza Dati e invia la notifica tramite il Servizio di Notifiche senza dettagli riservati (`RF_GU_07`).],
    [ConcreteObserver 2], [*Audit Log Immodificabile*], [Reagisce agli eventi di `MO_GCDF` registrando in sola aggiunta i metadati su storage WORM con _hash-chaining_ (`RNF_L_02`).],
  )
]

== Conseguenze progettuali

- *Benefici:* disaccoppia `MO_GU` e `MO_GCDF` da Gestione Notifiche e Audit Log Immodificabile; impedisce strutturalmente la diffusione di dati riservati trasmettendo solo metadati operativi.

- *Limiti:* richiede una gestione differenziata degli errori tra i due osservatori, poiché la registrazione sull'Audit Log Immodificabile deve essere garantita prima di completare l'operazione del CDF, mentre l'invio tramite il Servizio di Notifiche può avvenire in modo asincrono.