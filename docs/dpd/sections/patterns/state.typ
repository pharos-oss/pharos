#import "../../../templates/common.typ": table-style, palette-primary

== 2.2 State - Ciclo di vita della Pratica <pattern_state>

Nel flusso `[F3]` dell'SDD, ogni segnalazione inviata tramite Gestione Utente (`MO_GU`) dà origine a una Pratica in Gestione CDF (`MO_GCDF`) che attraversa i sei stati definiti nel RAD: `Inviata`, `Presa in carico`, `In lavorazione`, `In attesa di integrazioni`, `Chiusa` e `Archiviata`. Le operazioni consentite (consultazione di stato e cronologia, presa in carico, inserimento di Note CDF, richiesta o invio di Integrazioni, chiusura con Esito Pratica, interruzione dell'iter con archiviazione; `RF_GU_05`–`06`, `RF_GU_08`–`09`, `RF_GCDF_03`–`06`) variano in base allo Stato Pratica attivo. Inoltre, sulle pratiche `Chiusa` e `Archiviata` vige il vincolo di sola lettura (`RNF_A_02`). Gestire tali regole con istruzioni condizionali distribuite nei sottosistemi applicativi renderebbe il ciclo di vita fragile ed esposto a transizioni non valide.

Il pattern *State* incapsula le operazioni lecite e le transizioni di ciascuno stato nelle sottoclassi concrete di Stato Pratica. L'entità Pratica (Context) mantiene il riferimento allo Stato Pratica corrente e delega a esso ogni operazione sul ciclo di vita, coordinandosi con Persistenza Dati per la storicizzazione delle transizioni. La classe astratta Stato Pratica rifiuta in modo predefinito tutte le operazioni di modifica; ciascuno stato concreto abilita esclusivamente le azioni consentite nello Stato Pratica corrente, rendendo strutturale il blocco applicativo in sola lettura per `Chiusa` e `Archiviata`. Persistenza Dati applica inoltre separatamente il vincolo di sola lettura a livello di database richiesto da `RNF_A_02`. A ogni transizione valida viene attivata la notifica verso i componenti descritti in @pattern_observer.

#pagebreak()

#[
  #set par(justify: false)
  #show figure: set block(breakable: true)
  #set table.cell(breakable: false)
  #figure(
    caption: [Ruoli GoF nel pattern State.],
    table(
      columns: (1.05fr, 1.35fr, 2.6fr),
      ..table-style(palette-primary),
      inset: 8pt,
      align: left + horizon,
      table.header([*Ruolo GoF*], [*Componente in Pharos*], [*Responsabilità*]),
      [*Context*], [Pratica (`MO_GCDF`)], [Mantiene lo Stato Pratica corrente e delega le operazioni del ciclo di vita allo stato attivo.],
      [*State*], [Stato Pratica (classe astratta)], [Definisce le operazioni sul ciclo di vita e rifiuta in modo predefinito ogni modifica non consentita.],
      [*ConcreteState* (stati attivi)], [Stati `Inviata`, `Presa in carico`, `In lavorazione`, `In attesa di integrazioni`], [Abilitano esclusivamente le azioni e le transizioni valide nel rispettivo Stato Pratica.],
      [*ConcreteState* (stati terminali)], [Stati `Chiusa`, `Archiviata`], [Consentono la sola consultazione e bloccano qualsiasi operazione di modifica a livello applicativo (`RNF_A_02`).],
    ),
  )
]

- *Benefici:* elimina le catene condizionali duplicate, rende il vincolo applicativo di sola lettura sugli stati terminali un invariante strutturale e isola eventuali evoluzioni future del ciclo di vita.

- *Limiti:* aumenta il numero di classi di dominio (una per ciascuno dei sei stati) e richiede alla Persistenza Dati di ricostruire lo Stato Pratica concreto corrispondente al caricamento della Pratica.