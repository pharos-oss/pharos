#import "../../../templates/common.typ": callout-box

#callout-box(title: "SC_CDF_01 Presa in carico di una nuova segnalazione")[

  #v(0.3em)

  *Partecipanti:* Elena (Consigliere di Fiducia), Giulia (Utente)

  *Obiettivo:* prendere in carico una nuova segnalazione consultando in un unico punto la descrizione e le evidenze in ordine cronologico.

  *Flusso di eventi:*

  + La dott.ssa Elena Bianchi riceve la notifica di una nuova segnalazione e accede alla propria area riservata.
  + Il sistema mostra l'elenco delle segnalazioni ricevute, evidenziando quelle nuove.
  + La dott.ssa Bianchi apre la segnalazione di Giulia.
  + Il sistema mostra tipologia, descrizione ed eventi del diario allegati, in ordine cronologico e con la data di inserimento di ciascuno.
  + La dott.ssa Bianchi esamina il contenuto e prende in carico la segnalazione.
  + Il sistema imposta lo stato "Presa in carico" e notifica Giulia.

]

#v(1.5em)

#callout-box(title: "SC_CDF_02 Aggiornamento dello stato della pratica")[

  #v(0.3em)

  *Partecipanti:* Elena (Consigliere di Fiducia), Giulia (Utente)

  *Obiettivo:* tenere informata la vittima sull'avanzamento della pratica, garantendo la trasparenza dell'iter.

  *Flusso di eventi:*

  + La dott.ssa Elena Bianchi decide di fissare un colloquio conoscitivo con Giulia per concordare la gestione dell'iter e apre la relativa pratica.
  + Il sistema mostra lo stato attuale ("Presa in carico") e gli stati successivi ammessi.
  + La dott.ssa Bianchi seleziona lo stato "In lavorazione" e aggiunge una nota visibile a Giulia: "Colloquio conoscitivo fissato per il 20/11 alle ore 10:00".
  + Il sistema registra il nuovo stato nella cronologia della pratica e notifica Giulia.

  *Flusso alternativo (passo 2):* se nel frattempo Giulia ha rinunciato al proseguimento dell'iter, il sistema mostra la pratica nello stato "Archiviata" e non ne consente la modifica.
]

#v(1.5em)

#callout-box(title: "SC_CDF_03 Chiusura e archiviazione della pratica")[

  #v(0.3em)

  *Partecipanti:* Elena (Consigliere di Fiducia), Marco (Utente)

  *Obiettivo:* concludere formalmente la pratica, registrandone l'esito e conservandone traccia.

  *Flusso di eventi:*

  + Concluso il percorso con Marco, la dott.ssa Elena Bianchi apre la pratica e sceglie di chiuderla.
  + Il sistema chiede l'esito della pratica ("Risolta con procedura informale", "Avviata procedura formale", "Non procedibile") e una nota conclusiva.
  + La dott.ssa Bianchi seleziona "Risolta con procedura informale" e scrive la nota conclusiva.
  + Il sistema imposta lo stato "Chiusa", archivia la pratica in sola lettura e notifica Marco.

  *Flusso alternativo (passo 3):* se la segnalazione non è procedibile, la dott.ssa Bianchi seleziona "Non procedibile" e ne motiva la decisione nella nota conclusiva; il sistema chiude la pratica e notifica Marco.
]

#v(1.5em)

#callout-box(title: "SC_CDF_04 Generazione di un report statistico")[

  #v(0.3em)

  *Partecipanti:* Elena (Consigliere di Fiducia)

  *Obiettivo:* fornire al CUG dati aggregati sul fenomeno senza compromettere la riservatezza delle vittime.

  *Flusso di eventi:*

  + Come ogni anno a febbraio, la dott.ssa Elena Bianchi deve presentare al CUG il riepilogo delle segnalazioni ricevute nell'anno precedente. Accede all'area riservata e apre la sezione di analisi dei dati.
  + Il sistema chiede il periodo di riferimento e i criteri di aggregazione.
  + La dott.ssa Bianchi seleziona il periodo dal 1° gennaio al 31 dicembre 2026 e l'aggregazione per tipologia di violenza e per componente accademica (studenti, personale).
  + Il sistema genera il report con dati aggregati e anonimi, accompagnato da grafici, e lo mostra.
  + La dott.ssa Bianchi esporta il report in PDF.

  *Flusso alternativo (passo 4):* se nel periodo selezionato non risultano segnalazioni, il sistema lo comunica e non genera il report.
]
