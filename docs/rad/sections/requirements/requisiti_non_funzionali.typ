#import "../../../templates/common.typ": palette-primary, readable-text, table-style

Di seguito sono elencati i requisiti non funzionali del sistema, suddivisi per categorie di qualità: *Usabilità*, *Affidabilità*, *Prestazioni* e *Legali*.

#v(1em)

=== Usabilità

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*Identificativo*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],

    [*RNF_U_01*], [Interfaccia Triage Esplicita], [L'interfaccia deve chiarire in ogni passaggio che la valutazione IA è solo orientativa e non sostituisce in alcun modo l'inoltro formale della pratica al CDF.], [Elevata], [Facile],
    
    [*RNF_U_02*], [Feedback sui file], [In caso di caricamento di allegati non conformi, il sistema deve comunicare istantaneamente il limite violato (dimensione/formato) mantenendo i campi testuali già compilati.], [Elevata], [Media],
    
    [*RNF_U_03*], [Accessibilità WCAG 2.1], [L'interfaccia utente web/mobile deve rispettare i criteri di accessibilità WCAG 2.1 livello AA per garantire la corretta fruizione anche a utenti con disabilità.], [Elevata], [Media]
  )
]

#v(1.5em)

=== Affidabilità

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*Identificativo*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],

    [*RNF_A_01*], [Cifratura End-to-End], [Il sistema deve garantire la cifratura in locale dei dati del diario personale, assicurando che l'infrastruttura di base non acceda mai ai contenuti in chiaro.], [Elevata], [Difficile],
    
    [*RNF_A_02*], [Segregazione dei dati], [I dati anagrafici dell'utente devono rimanere architetturalmente e logicamente separati dai testi della segnalazione per limitare l'esposizione in caso di data breach.], [Elevata], [Media],
    
    [*RNF_A_03*], [Integrità dello storico], [Le pratiche passate in stato "Chiusa" o "Archiviata" devono divenire tecnicamente di sola lettura a livello di database per garantirne la validità legale nel tempo.], [Elevata], [Media]
  )
]