#import "../../../templates/common.typ": table-style, palette-primary

== Observer - Notifiche di stato e Audit Log Immodificabile <pattern_observer>

Nel flusso `[F3]` dell'SDD, le operazioni eseguite su una Pratica — sia gli aggiornamenti di Stato Pratica regolati tramite @pattern_state sia gli accessi in consultazione e decifratura da parte del Consigliere di Fiducia (CDF) — devono attivare due meccanismi indipendenti:

1. L'invio all'Utente, tramite Gestione Notifiche, di notifiche in-app ed e-mail prive di dettagli riservati a ogni aggiornamento di Stato Pratica (`RF_GU_07`);

2. La registrazione in sola aggiunta (_append-only_) dei metadati di ogni accesso e operazione del CDF sull'Audit Log Immodificabile su storage WORM con _hash-chaining_ (`RNF_L_02`).

Richiamare direttamente Gestione Notifiche e Audit Log Immodificabile all'interno di ogni singola operazione di Gestione Utente (`MO_GU`) e Gestione CDF (`MO_GCDF`) creerebbe una dipendenza rigida tra la gestione delle pratiche, il canale di notifica e l'archivio di audit.

== Soluzione e ruoli

Con il pattern *Observer*, i sottosistemi che eseguono le operazioni sulla Pratica non invocano direttamente i servizi di notifica e di audit, ma pubblicano un evento verso gli osservatori registrati. In particolare, Gestione Utente (`MO_GU`) e Gestione CDF (`MO_GCDF`) svolgono il ruolo di *ConcreteSubject* e trasmettono eventi composti esclusivamente da metadati operativi (identificativo della pratica, azione eseguita o nuovo Stato Pratica, identificativo dell'Utente o del CDF, _timestamp_ ed esito), senza mai includere contenuti sensibili in chiaro.

#pagebreak()

Nell'ambito della gestione delle pratiche, gli osservatori implementano l'interfaccia comune *Observer* e reagiscono secondo il rispettivo vincolo di affidabilità:

- *Gestione Notifiche* riceve gli aggiornamenti di Stato Pratica provenienti da `MO_GU` e `MO_GCDF`, legge i soli dati di contatto dalla Persistenza Dati e attiva il Servizio di Notifiche (`RF_GU_07`);

- *Audit Log Immodificabile* riceve gli eventi operativi generati da `MO_GCDF` (accessi, apertura e decifratura di pratiche e allegati, cambi di stato, Note CDF, richieste di Integrazioni, chiusura, gestione del Periodo Assenza ed esportazione dei Report Statistici per il CUG) e li registra su storage WORM (`RNF_L_02`). Il canale separato di consultazione in sola lettura dell'Audit Log Immodificabile riservato a DPO, responsabile sicurezza di Ateneo e autorità competenti registra autonomamente i propri accessi secondo quanto stabilito nell'SDD.

Per garantire `RNF_L_02` senza lacune in caso di guasto, la notifica verso *Audit Log Immodificabile* viene eseguita in modo sincrono all'interno della medesima transazione dell'operazione del CDF, annullando l'operazione qualora la scrittura su storage WORM fallisca; l'invio tramite *Gestione Notifiche* avviene invece in modo disaccoppiato al completamento della transazione.

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
    [ConcreteSubject], [Gestione Utente (`MO_GU`), Gestione CDF (`MO_GCDF`)], [Notificano agli osservatori eventi composti esclusivamente da metadati operativi in corrispondenza di ogni aggiornamento di Stato Pratica e, per `MO_GCDF`, di ogni accesso o operazione del CDF.],
    [Observer], [Interfaccia di ricezione eventi], [Definisce il contratto di aggiornamento invocato alla ricezione di un evento di Pratica.],
    [ConcreteObserver 1], [Gestione Notifiche], [Reagisce agli aggiornamenti di Stato Pratica, legge i soli dati di contatto dalla Persistenza Dati e invia la notifica tramite il Servizio di Notifiche senza dettagli riservati (`RF_GU_07`).],
    [ConcreteObserver 2], [Audit Log Immodificabile], [Reagisce in modo sincrono e atomico agli eventi di `MO_GCDF` registrando in sola aggiunta i metadati su storage WORM con _hash-chaining_ (`RNF_L_02`).],
  )
]

== Conseguenze progettuali

- *Benefici:* disaccoppia `MO_GU` e `MO_GCDF` da Gestione Notifiche e Audit Log Immodificabile; impedisce strutturalmente la diffusione di dati riservati trasmettendo eventi composti esclusivamente da metadati operativi e assicura l'atomicità della registrazione di audit.

- *Limiti:* l'esecuzione sincrona dell'osservatore di audit all'interno della transazione introduce un lieve sovraccarico sulle operazioni del CDF e ne blocca il completamento in caso di indisponibilità dello storage WORM, mentre eventuali errori temporanei del Servizio di Notifiche restano isolati rispetto all'operazione principale.