#import "../../../templates/common.typ": table-style, palette-primary

== State - Ciclo di vita della Pratica <pattern_state>

Nel flusso `[F3]` dell'SDD, ogni segnalazione inviata tramite Gestione Utente (`MO_GU`) dà origine a una Pratica in Gestione CDF (`MO_GCDF`) che attraversa i sei stati definiti nel RAD: `Inviata`, `Presa in carico`, `In lavorazione`, `In attesa di integrazioni`, `Chiusa` e `Archiviata`. Le operazioni consentite (consultazione di stato e cronologia, presa in carico, inserimento di Note CDF, richiesta o invio di Integrazioni, chiusura con Esito Pratica, interruzione dell'iter con archiviazione; `RF_GU_04`–`06`, `RF_GU_08`–`09`, `RF_GCDF_03`–`06`) variano in base allo stato attivo. Inoltre, sulle pratiche `Chiusa` e `Archiviata` vige il vincolo di sola lettura (`RNF_A_02`). Gestire tali regole con istruzioni condizionali distribuite nei sottosistemi applicativi renderebbe il ciclo di vita fragile ed esposto a transizioni non valide.

== Soluzione e ruoli

Il pattern *State* incapsula le operazioni lecite e le transizioni di ciascuna fase nelle sottoclassi concrete di Stato Pratica. L'entità Pratica (Context) mantiene il riferimento allo stato corrente e delega a esso ogni operazione sul ciclo di vita, coordinandosi con Persistenza Dati per la storicizzazione delle transizioni. La classe astratta Stato Pratica rifiuta in modo predefinito tutte le operazioni di modifica; ciascuno stato concreto abilita esclusivamente le azioni consentite nella propria fase, rendendo strutturale il blocco in sola lettura per `Chiusa` e `Archiviata`. A ogni transizione valida viene attivata la notifica verso i componenti descritti in @pattern_observer.

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
    [Context], [*Pratica* (`MO_GCDF`)], [Mantiene lo stato corrente e delega le operazioni del ciclo di vita allo stato attivo.],
    [State], [*Stato Pratica* (classe astratta)], [Definisce le operazioni sul ciclo di vita e rifiuta in modo predefinito ogni modifica non consentita.],
    [ConcreteState (stati attivi)], [Stati `Inviata`, `Presa in carico`, `In lavorazione`, `In attesa di integrazioni`], [Abilitano esclusivamente le azioni e le transizioni valide nella rispettiva fase di lavorazione.],
    [ConcreteState (stati terminali)], [Stati `Chiusa`, `Archiviata`], [Consentono la sola consultazione e bloccano qualsiasi operazione di modifica (`RNF_A_02`).],
  )
]

== Conseguenze progettuali

- *Benefici:* elimina le catene condizionali duplicate, rende il vincolo di sola lettura sugli stati terminali un invariante applicativo e isola eventuali evoluzioni future del ciclo di vita.

- *Limiti:* aumenta il numero di classi di dominio (una per ciascuno dei sei stati) e richiede alla Persistenza Dati di ricostruire lo stato concreto corrispondente al caricamento della Pratica.