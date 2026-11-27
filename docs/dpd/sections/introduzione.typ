#import "../../templates/common.typ": table-style, palette-primary

= Introduzione <introduzione>

== Scopo e campo di applicazione
Il presente *Design Pattern Document (DPD)* descrive i _design pattern_ orientati agli oggetti adottati nella progettazione dettagliata di Pharos, collegando la decomposizione in sottosistemi del System Design Document (SDD) all'implementazione, nel rispetto dei requisiti del Requirements Analysis Document (RAD). Il documento si concentra esclusivamente sui pattern selezionati per l'utilizzo nel sistema, illustrandone il problema affrontato, il ruolo svolto e l'integrazione nella soluzione progettuale. Per le definizioni e gli acronimi di dominio si rimanda al RAD e all'SDD; si utilizza inoltre la sigla *GoF* (_Gang of Four_).

La tabella seguente riepiloga i tre pattern adottati, i sottosistemi dell'SDD coinvolti e i requisiti del RAD coperti.

#[
  #set par(justify: false)
  #set table.cell(breakable: false)
  #table(
    columns: (0.85fr, 1fr, 1.85fr, 1.45fr),
    ..table-style(palette-primary),
    inset: 7pt,
    align: horizon,
    table.header(
      [*Pattern*],
      [*Categoria GoF*],
      [*Scopo nel sistema*],
      [*Sottosistemi SDD e Requisiti RAD*],
    ),
    [Adapter (@pattern_adapter)],
    [Strutturale],
    [Disaccoppia Triage Guidato dal Modulo IA di Triage e dall'eventuale Provider IA esterno conforme a GDPR e AI Act.],
    [Triage Guidato, Modulo IA di Triage (`RF_GU_10`, `RNF_IM_02`, `RNF_L_01`, `RNF_P_01`)],
    [State (@pattern_state)],
    [Comportamentale],
    [Incapsula regole di transizione e operazioni consentite nei sei stati della Pratica, garantendo la sola lettura su `Chiusa` e `Archiviata`.],
    [Gestione Utente (`MO_GU`), Gestione CDF (`MO_GCDF`), Persistenza Dati (`RF_GU_05`–`06`, `RF_GU_08`–`09`, `RF_GCDF_03`–`06`, `RNF_A_02`)],
    [Observer (@pattern_observer)],
    [Comportamentale],
    [Disaccoppia la gestione delle pratiche dall'invio di notifiche prive di dettagli riservati e dalla registrazione in sola aggiunta sull'Audit Log Immodificabile (WORM).],
    [Gestione Utente (`MO_GU`), Gestione CDF (`MO_GCDF`), Gestione Notifiche, Audit Log Immodificabile (`RF_GU_07`, `RNF_L_02`)],
  )
]

#pagebreak(weak: true)

== Riferimenti
- *RAD\_Pharos (V1.0, 23/11/2026):* requisiti funzionali (`RF`), requisiti non funzionali (`RNF`), casi d'uso, modello degli oggetti e diagrammi di stato.

- *SDD\_Pharos (V0.5, 27/11/2026):* obiettivi di design, compromessi architetturali e decomposizione in sottosistemi, mapping hardware/software.

- *Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (1994):* _Design Patterns: Elements of Reusable Object-Oriented Software_, Addison-Wesley.

- *Bruegge, B., & Dutoit, A. H. (2013):* _Object-Oriented Software Engineering: Using UML, Patterns, and Java_ (3ª ed.), Pearson.

- *Regolamento (UE) 2016/679 (GDPR)* e *Regolamento (UE) 2024/1689 (AI Act):* vincoli di riservatezza, minimizzazione dei dati, _Zero-Retention_ e tracciabilità.