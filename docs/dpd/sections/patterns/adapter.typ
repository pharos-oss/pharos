#import "../../../templates/common.typ": table-style, palette-primary

== Adapter - Disaccoppiamento del Modulo IA di Triage <pattern_adapter>

Nel flusso `[F2]` dell'SDD, l'Applicazione Web Utente (PWA) esegue la rimozione dei dati identificativi _on-device_ e invia al sottosistema Triage Guidato il solo testo depurato per ottenere una Valutazione IA (gravità, tipologia di violenza e passi dell'iter di segnalazione, `RF_GU_10`). Come definito nell'SDD, il Modulo IA di Triage (_stateless_ e _Zero-Retention_) può operare _on-premise_ oppure collegarsi a un Provider IA esterno vincolato da DPA, trattamento in area SEE e conformità a GDPR e AI Act (`RNF_IM_02`, `RNF_L_01`). Poiché i fornitori esterni espongono API e formati di risposta eterogenei, invocare direttamente un servizio esterno da Triage Guidato introdurrebbe un forte accoppiamento tecnologico.

== Soluzione e ruoli

Si adotta il pattern *Adapter* (mediante composizione), realizzando il componente Adattatore Provider IA già previsto nell'SDD all'interno del Modulo IA di Triage. Triage Guidato interagisce esclusivamente con l'interfaccia esposta dal Modulo IA di Triage. In caso di ricorso a un servizio gestito esterno, Adattatore Provider IA traduce richieste e risposte del Provider IA esterno, applica i parametri di disattivazione della ritenzione e gestisce i _timeout_ a supporto della soglia massima di $5$ s (`RNF_P_01`). In caso di esecuzione _on-premise_, il Modulo IA di Triage soddisfa direttamente il medesimo contratto senza ricorrere all'adattatore esterno.

#pagebreak()

#[
  #set par(justify: false)
  #set table.cell(breakable: false)
  #table(
    columns: (1fr, 1.45fr, 2.05fr),
    ..table-style(palette-primary),
    inset: 7pt,
    align: horizon,
    table.header([*Ruolo GoF*], [*Componente in Pharos*], [*Responsabilità*]),
    [Client], [Triage Guidato], [Inoltra il testo già depurato al Modulo IA di Triage e restituisce la Valutazione IA all'Utente.],
    [Target], [Modulo IA di Triage (interfaccia interna)], [Definisce il contratto di valutazione _stateless_ del testo depurato, indipendente dalla modalità di esecuzione.],
    [Adapter], [Adattatore Provider IA (interno al Modulo IA di Triage)], [Traduce richieste e risposte del fornitore esterno, impone i vincoli _Zero-Retention_ e gestisce errori e _timeout_.],
    [Adaptee], [Provider IA esterno], [Servizio IA gestito opzionale, operante in area SEE sotto DPA con interfaccia proprietaria.],
  )
]

== Conseguenze progettuali

- *Benefici:* consente di sostituire il fornitore esterno o passare all'esecuzione _on-premise_ senza modificare Triage Guidato; confina in un unico punto la traduzione dei formati e la gestione dei _timeout_.

- *Limiti:* introduce un lieve livello di intermediazione e richiede l'aggiornamento dell'*Adattatore Provider IA* in caso di variazioni dell'interfaccia del fornitore esterno.