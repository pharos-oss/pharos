#import "../../../templates/common.typ": palette-primary, readable-text, table-style

Di seguito sono elencati i requisiti funzionali del sistema, suddivisi per gestione di appartenenza: *Gestione Utente (GU)* e *Gestione Consigliere di Fiducia (GCDF)*.

#v(1.5em)

=== Gestione Utente 

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset:(x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Attori*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RF_GU_01*], [Registrazione evento nel diario], [#block(breakable: false)[Il sistema deve consentire all'utente di annotare privatamente un evento nel proprio diario indicando data, ora, luogo, descrizione, e inserendo eventuali allegati multimediali.]], [Utente], [Elevata], [SC_U_02, SC_U_07, UC_03],
    
    [*RF_GU_02*], [Cifratura del diario], [#block(breakable: false)[Il sistema deve salvare tutti gli eventi e gli allegati del diario in forma cifrata, rendendoli inaccessibili finché non viene inviata una segnalazione.]], [Sistema], [Elevata], [SC_U_02, UC_03],
    
    [*RF_GU_03*], [Modifica ed eliminazione eventi], [#block(breakable: false)[Il sistema deve consentire all'utente di modificare o eliminare eventi dal diario personale prima che siano inclusi in una segnalazione formale.]], [Utente], [Media], [Generale],
    
    [*RF_GU_04*], [Salvataggio in bozza], [#block(breakable: false)[Il sistema deve consentire all'utente di salvare una segnalazione come bozza, così da completarla in un momento successivo.]], [Utente], [Media], [SC_U_06, UC_03],
    
    [*RF_GU_05*], [Invio segnalazione formale], [#block(breakable: false)[Il sistema deve permettere all'utente di inviare una segnalazione al CDF, compilando l'apposito modulo e allegando eventi già registrati.]], [Utente], [Elevata], [SC_U_01, SC_U_06, UC_03],

    [*RF_GU_06*], [Consultazione stato segnalazione], [#block(breakable: false)[Il sistema deve permettere all'utente di visualizzare la cronologia, lo stato di avanzamento e le note visibili della propria segnalazione.]], [Utente], [Elevata], [SC_U_05, UC_04],
    
    [*RF_GU_07*], [Ricezione notifiche di stato], [#block(breakable: false)[Il sistema deve inviare una notifica (email o in-app) all'utente ad ogni aggiornamento di stato della propria segnalazione da parte del CDF.]], [Sistema], [Media], [SC_U_01, SC_U_03, UC_01],
    
    [*RF_GU_08*], [Invio integrazioni], [#block(breakable: false)[Il sistema deve consentire all'utente di rispondere a una richiesta del CDF aggiungendo allegati, nuovi eventi o note esplicative alla pratica in corso.]], [Utente], [Elevata], [SC_U_03, UC_01],
    
    [*RF_GU_09*], [Interruzione dell'iter], [#block(breakable: false)[Il sistema deve permettere all'utente di ritirare una segnalazione in corso, causando l'archiviazione della pratica in sola lettura.]], [Utente], [Elevata], [SC_U_08, UC_04],
    
    [*RF_GU_10*], [Triage guidato IA], [#block(breakable: false)[Il sistema deve permettere all'utente di inviare eventi del diario a un modulo IA per una valutazione indicativa di gravità e tipologia di molestia.]], [Utente], [Media], [SC_U_04, UC_02],
    
    [*RF_GU_11*], [Anonimizzazione dati IA], [#block(breakable: false)[Il sistema deve rimuovere automaticamente tutti i dati identificativi dal testo prima di inviarlo al modulo IA per il triage.]], [Sistema], [Elevata], [SC_U_04, UC_02]
  )
]

#v(1.5em)

#pagebreak()

=== Gestione Consigliere di Fiducia

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto, auto),
    inset:(x: 5pt, y: 8pt),
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*ID*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Attori*],
    text(fill: readable-text(palette-primary))[*Priorità*],
    text(fill: readable-text(palette-primary))[*Scenari / UC*],

    [*RF_GCDF_01*], [Visualizzazione segnalazioni], [#block(breakable: false)[Il sistema deve mostrare al CDF l'elenco delle segnalazioni ricevute, evidenziando chiaramente le nuove richieste che devono essere prese in carico.]], [CDF], [Elevata], [SC_CDF_01, UC_CDF_1],
    
    [*RF_GCDF_02*], [Ricerca e filtri avanzati], [#block(breakable: false)[Il sistema deve permettere al CDF di filtrare le segnalazioni per stato, data, ID pratica e tipologia di violenza.]], [CDF], [Media], [Generale],
    
    [*RF_GCDF_03*], [Presa in carico], [#block(breakable: false)[Il sistema deve permettere al CDF di visionare i dettagli e gli allegati di una nuova segnalazione e di modificarne lo stato in "Presa in carico".]], [CDF], [Elevata], [SC_CDF_02, UC_CDF_1],
    
    [*RF_GCDF_04*], [Avanzamento iter e note], [#block(breakable: false)[Il sistema deve permettere al CDF di aggiornare lo stato di una pratica e inserire note e appuntamenti che diverranno visibili all'utente.]], [CDF], [Elevata], [SC_CDF_01, UC_CDF_1],
    
    [*RF_GCDF_05*], [Richiesta integrazioni], [#block(breakable: false)[Il sistema deve consentire al CDF di impostare lo stato su "In attesa di integrazioni" specificando le informazioni o i documenti mancanti all'utente.]], [CDF], [Media], [SC_U_03],

    [*RF_GCDF_06*], [Chiusura e archiviazione], [#block(breakable: false)[Il sistema deve permettere al CDF di chiudere formalmente una pratica, indicandone l'esito finale e bloccando ulteriori modifiche bilaterali.]], [CDF], [Elevata], [SC_CDF_03, UC_CDF_2],
    
    [*RF_GCDF_07*], [Gestione assenza temporanea], [#block(breakable: false)[Il sistema deve permettere al CDF di impostare un periodo di indisponibilità, attivando un avviso automatico per gli utenti riguardo all'allungamento dei tempi di risposta.]], [CDF], [Bassa], [Aggiuntivo],
    
    [*RF_GCDF_08*], [Generazione report aggregati], [#block(breakable: false)[Il sistema deve permettere di generare report statistici anonimi indicando periodo di riferimento, tipologia di violenza e componente accademica.]], [CDF], [Media], [SC_CDF_04, UC_CDF_2],
    
    [*RF_GCDF_09*], [Esportazione report], [#block(breakable: false)[Il sistema deve permettere al CDF di esportare i report statistici e i grafici generati in formato PDF e CSV.]], [CDF], [Media], [SC_CDF_04]
  )
]