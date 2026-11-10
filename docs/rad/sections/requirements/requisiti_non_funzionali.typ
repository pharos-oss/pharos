#import "../../../templates/common.typ": palette-primary, readable-text, table-style

Di seguito sono elencati i requisiti non funzionali del sistema, suddivisi per categorie di qualità: *Usabilità*, *Affidabilità*, *Prestazioni*, *Supportabilità*, *Implementazione*, *Interfacce*, *Operatività*, *Rilascio* e *Legali*.

#v(1.5em)

=== Usabilità

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_U_01*], [Interfaccia Triage Esplicita], [#block(breakable: false)[L'interfaccia deve chiarire in ogni passaggio che la valutazione IA è solo orientativa e non sostituisce in alcun modo l'inoltro formale della pratica al CDF.]], [Elevata], [Facile], [SC_U_04],
    
    [*RNF_U_02*], [Feedback sui file], [#block(breakable: false)[In caso di caricamento di allegati non conformi, il sistema deve comunicare istantaneamente il limite violato (dimensione/formato) mantenendo i campi testuali già compilati.]], [Elevata], [Media], [SC_U_07],
    
    [*RNF_U_03*], [Accessibilità WCAG 2.1], [#block(breakable: false)[L'interfaccia utente web/mobile deve rispettare i criteri di accessibilità WCAG 2.1 livello AA per garantire la corretta fruizione anche a utenti con disabilità.]], [Elevata], [Media], [Tutti],

    [*RNF_U_04*], [Chiusura rapida (Panic Button)], [#block(breakable: false)[L'app mobile deve fornire una funzionalità di oscuramento o uscita immediata per proteggere la privacy dell'utente qualora venga interrotto durante la scrittura nel diario o la consultazione della pratica.]], [Elevata], [Media], [Generale, UC_03, UC_04]
  )
]

#v(1.5em)

=== Affidabilità

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_A_01*], [Cifratura End-to-End], [#block(breakable: false)[Il sistema deve garantire la cifratura in locale dei dati del diario personale, assicurando che l'infrastruttura di base non acceda mai ai contenuti in chiaro.]], [Elevata], [Difficile], [SC_U_02, SC_U_07],
    
    [*RNF_A_02*], [Segregazione dei dati], [#block(breakable: false)[I dati anagrafici dell'utente devono rimanere architetturalmente e logicamente separati dai testi della segnalazione per limitare l'esposizione in caso di data breach.]], [Elevata], [Media], [SC_U_01],
    
    [*RNF_A_03*], [Integrità dello storico], [#block(breakable: false)[Le pratiche passate in stato "Chiusa" o "Archiviata" devono divenire tecnicamente di sola lettura a livello di database per garantirne la validità legale nel tempo.]], [Elevata], [Media], [SC_U_08, SC_CDF_03],

    [*RNF_A_04*], [Funzionamento Offline del Diario], [#block(breakable: false)[L'applicazione mobile deve consentire all'utente di registrare e cifrare localmente gli eventi nel diario anche in assenza di connettività, sincronizzandoli col server alla successiva riconnessione.]], [Media], [Difficile], [SC_U_02, UC_03]
  )
]

#v(1.5em)

=== Prestazioni

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_P_01*], [Tempi di risposta Modulo IA], [#block(breakable: false)[L'interrogazione del modulo IA per il Triage Guidato deve restituire l'esito e la tipologia di violenza all'utente entro un tempo massimo di 5 secondi.]], [Media], [Media], [SC_U_04],
    
    [*RNF_P_02*], [Supporto alla concorrenza], [#block(breakable: false)[Il sistema deve essere in grado di gestire picchi di traffico fino a 2.000 utenti concorrenti senza degradare i tempi di caricamento delle pagine oltre i 2 secondi.]], [Elevata], [Media], [Tutti]
  )
]

#v(1.5em)

=== Supportabilità

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_S_01*], [Log Centralizzato], [#block(breakable: false)[Il sistema deve tracciare errori e malfunzionamenti tramite un sistema di logging centralizzato per agevolare il debugging da parte degli amministratori.]], [Elevata], [Media], [Tutti]
  )
]

#v(1.5em)

#pagebreak()

=== Implementazione 

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_IM_01*], [Piattaforma ibrida divisa per ruoli], [#block(breakable: false)[Il sistema deve essere fruibile tramite applicazione web per il Consigliere di Fiducia e gli Admin, e tramite app mobile per gli utenti. Le funzionalità devono essere equiparate e supportate su entrambe le piattaforme.]], [Elevata], [Media], [Tutti],

    [*RNF_IM_02*], [Implementazione Modulo IA Zero-Retention], [#block(breakable: false)[Il modulo IA per il triage deve essere implementato tramite modelli ospitati in locale (on-premise) o API enterprise configurate in modalità "stateless", per garantire tecnicamente il blocco della conservazione dati e del riaddestramento.]], [Elevata], [Difficile], [SC_U_04, UC_02]
  )
]

#v(1.5em)

=== Interfacce

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_IF_01*], [Integrazione Single Sign-On], [#block(breakable: false)[Il sistema deve integrarsi con il provider di identità di Ateneo (basato su protocollo SAML 2.0 / Shibboleth, compatibile con la federazione IDEM-GARR) per consentire l'accesso con le credenziali universitarie istituzionali.]], [Elevata], [Difficile], [Tutti]
  )
]

#v(1.5em)

=== Operatività

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_O_01*], [Backup Automatico e Disaster Recovery], [#block(breakable: false)[L'infrastruttura deve eseguire backup completi cifrati del database ogni 24 ore, garantendo un RPO (Recovery Point Objective) massimo di 1 giorno.]], [Elevata], [Media], [Tutti]
  )
]

#v(1.5em)

=== Rilascio

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_PK_01*], [Containerizzazione Docker], [#block(breakable: false)[L'intera applicazione deve essere pacchettizzata all'interno di container Docker per standardizzare i processi di rilascio, test e deploy in produzione.]], [Media], [Facile], [Tutti],

    [*RNF_PK_02*], [Automazione CI/CD], [#block(breakable: false)[Il processo di build, test delle API e preparazione degli artefatti (immagini Docker, pacchetti web e app mobile) deve essere gestito tramite pipeline automatizzate di Continuous Integration/Continuous Deployment.]], [Media], [Media], [Tutti]
  )
]

#v(1.5em)

=== Legali 

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset: (x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Difficoltà*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RNF_L_01*], [Conformità IA (AI Act / GDPR)], [#block(breakable: false)[Il provider LLM del modulo di intelligenza artificiale non deve in alcun modo memorizzare i prompt in input né utilizzarli per il riaddestramento del modello.]], [Elevata], [Difficile], [SC_U_04],
    
    [*RNF_L_02*], [Audit Log inalterabile], [#block(breakable: false)[Il sistema deve registrare in un log immodificabile (WORM) ogni singolo accesso e operazione effettuata dal CDF sui dati sensibili degli utenti.]], [Elevata], [Media], [SC_CDF_01, SC_CDF_02, UC_CDF_1, UC_CDF_2]
  )
]