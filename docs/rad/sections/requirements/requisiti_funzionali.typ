#import "../../../templates/common.typ": palette-primary, readable-text, table-style

Di seguito sono elencati i requisiti funzionali del sistema, suddivisi per gestione di appartenenza: *Gestione Utente (GU)* e *Gestione Consigliere di Fiducia (GCDF)*.

#v(1em)

=== Gestione Utente 

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*Identificativo*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Attori*],
    text(fill: readable-text(palette-primary))[*Priorità*],

    [*RF_GU_01*], [Registrazione evento nel diario], [Il sistema deve permettere all'Utente di annotare privatamente un evento nel proprio diario (data, ora, luogo, descrizione, allegati multimediali).], [Utente], [Elevata],
    
    [*RF_GU_02*], [Cifratura del diario], [Il sistema deve salvare in forma cifrata tutti gli eventi e gli allegati inseriti nel diario, rendendoli inaccessibili fino all'inoltro di una segnalazione.], [Sistema], [Elevata],
    
    [*RF_GU_03*], [Modifica ed eliminazione eventi], [Il sistema deve consentire all'Utente di modificare o eliminare eventi dal diario personale prima che vengano allegati a una segnalazione formale.], [Utente], [Media],
    
    [*RF_GU_04*], [Salvataggio in bozza], [Il sistema deve permettere all'Utente di salvare una segnalazione in formato bozza per completarne la compilazione in un secondo momento.], [Utente], [Media],
    
    [*RF_GU_05*], [Invio segnalazione formale], [Il sistema deve permettere all'Utente di inviare una segnalazione al CDF, compilando l'apposito modulo e allegando eventi pre-registrati.], [Utente], [Elevata],

    [*RF_GU_06*], [Consultazione stato segnalazione], [Il sistema deve permettere all'Utente di visualizzare la cronologia, lo stato di avanzamento e le note visibili della propria segnalazione.], [Utente], [Elevata],
    
    [*RF_GU_07*], [Ricezione notifiche di stato], [#block(breakable: false)[Il sistema deve inviare una notifica (email o in-app) all'Utente ad ogni aggiornamento di stato della propria segnalazione da parte del CDF.]], [Sistema], [Media],
    
    [*RF_GU_08*], [Invio integrazioni], [Il sistema deve permettere all'Utente di rispondere a una richiesta del CDF aggiungendo allegati, nuovi eventi o note esplicative alla pratica in corso.], [Utente], [Elevata],
    
    [*RF_GU_09*], [Interruzione dell'iter], [Il sistema deve permettere all'Utente di ritirare una propria segnalazione in corso, causando l'archiviazione della pratica in sola lettura.], [Utente], [Elevata],
    
    [*RF_GU_10*], [Triage guidato IA], [Il sistema deve permettere di sottoporre eventi del diario a un modulo IA per una valutazione orientativa su gravità e tipologia di molestia.], [Utente], [Media],
    
    [*RF_GU_11*], [Anonimizzazione dati IA], [Il sistema deve rimuovere automaticamente tutti i dati identificativi dal testo prima di trasmetterlo al modulo AI per il triage.], [Sistema], [Elevata]
 )
]

#v(1.5em)
=== Gestione Consigliere di Fiducia

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, auto, auto, auto),
    inset: 8pt,
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[*Identificativo*],
    text(fill: readable-text(palette-primary))[*Nome*],
    text(fill: readable-text(palette-primary))[*Descrizione*],
    text(fill: readable-text(palette-primary))[*Attori*],
    text(fill: readable-text(palette-primary))[*Priorità*],

    [*RF_GCDF_01*], [Visualizzazione segnalazioni], [Il sistema deve mostrare al CDF l'elenco delle segnalazioni ricevute, evidenziando in modo chiaro le nuove richieste da prendere in carico.], [CDF], [Elevata],
    
    [*RF_GCDF_02*], [Ricerca e filtri avanzati], [Il sistema deve permettere al CDF di filtrare le segnalazioni per stato, data, ID pratica e tipologia di violenza.], [CDF], [Media],
    
    [*RF_GCDF_03*], [Presa in carico], [Il sistema deve permettere al CDF di visionare i dettagli e gli allegati di una nuova segnalazione e di modificarne lo stato in "Presa in carico".], [CDF], [Elevata],
    
    [*RF_GCDF_04*], [Avanzamento iter e note], [Il sistema deve permettere al CDF di aggiornare lo stato di una pratica e inserire note e appuntamenti che diverranno visibili all'Utente.], [CDF], [Elevata],
    
    [*RF_GCDF_05*], [Richiesta integrazioni], [Il sistema deve consentire al CDF di impostare lo stato su "In attesa di integrazioni" specificando le informazioni o i documenti mancanti all'Utente.], [CDF], [Media],

    [*RF_GCDF_06*], [Chiusura e archiviazione], [Il sistema deve permettere al CDF di chiudere formalmente una pratica, indicandone l'esito finale e bloccando ulteriori modifiche bilaterali.], [CDF], [Elevata],
    
    [*RF_GCDF_07*], [Delega temporanea], [Il sistema deve permettere al CDF di delegare temporaneamente l'accesso e la gestione delle pratiche a un sostituto autorizzato (es. per ferie/malattia).], [CDF], [Bassa],
    
    [*RF_GCDF_08*], [Generazione report aggregati], [Il sistema deve permettere di generare report statistici anonimi indicando periodo di riferimento, tipologia di violenza e componente accademica.], [CDF], [Media],
    
    [*RF_GCDF_09*], [Esportazione report], [Il sistema deve permettere al CDF di esportare i report statistici e i grafici generati in formato PDF e CSV.], [CDF], [Media]
)
]