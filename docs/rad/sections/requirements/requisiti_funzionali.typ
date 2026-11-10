#import "../../../templates/common.typ": palette-primary, readable-text, table-style

Di seguito sono elencati i requisiti funzionali del sistema, suddivisi per gestione di appartenenza: *Gestione Utente (GU)* e *Gestione Consigliere di Fiducia (GCDF)*.

#v(1em)

==== Gestione Utente (Pharos)

#align(center)[
  #table(
    ..table-style(palette-primary),
    columns: (auto, auto, 1fr, auto, auto),
    inset: 8pt,
    align: (x, y) => if x == 2 { left } else { center + horizon },

    text(fill: readable-text(palette-primary))[Identificativo],
    text(fill: readable-text(palette-primary))[Nome],
    text(fill: readable-text(palette-primary))[Descrizione],
    text(fill: readable-text(palette-primary))[Attori],
    text(fill: readable-text(palette-primary))[Priorità],

    [RF_GU_01], [Registrazione evento nel diario], [Il sistema deve permettere all'Utente di annotare privatamente un evento nel proprio diario (data, ora, luogo, descrizione, allegati multimediali).], [Utente], [Elevata],
    
    [RF_GU_02], [Cifratura del diario], [Il sistema deve salvare in forma cifrata tutti gli eventi e gli allegati inseriti nel diario, rendendoli inaccessibili fino all'inoltro di una segnalazione.], [Sistema], [Elevata],
    
    [RF_GU_03], [Modifica ed eliminazione eventi], [Il sistema deve consentire all'Utente di modificare o eliminare eventi dal diario personale prima che vengano allegati a una segnalazione formale.], [Utente], [Media],
    
    [RF_GU_04], [Salvataggio in bozza], [Il sistema deve permettere all'Utente di salvare una segnalazione in formato bozza per completarne la compilazione in un secondo momento.], [Utente], [Media],
    
    [RF_GU_05], [Invio segnalazione formale], [Il sistema deve permettere all'Utente di inviare una segnalazione al CDF, compilando l'apposito modulo e allegando eventi pre-registrati.], [Utente], [Elevata],
)
]