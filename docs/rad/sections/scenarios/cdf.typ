#import "../../../templates/common.typ": palette-primary

#let scenario-box = block.with(
  width: 100%,
  inset: 12pt,
  radius: 4pt,
  fill: palette-primary.lighten(93%),
  stroke: (left: 3pt + palette-primary),
)

#scenario-box[
  === SC_CDF_01 Presa in carico di una nuova segnalazione

  #v(0.3em)

  Partecipanti: Elena: Consigliere di Fiducia, Giulia: Utente

  Obiettivo: prendere in carico una nuova segnalazione consultando in un unico punto la descrizione e le evidenze in ordine cronologico.

  Flusso di eventi:

  + La dott.ssa Elena Bianchi riceve la notifica di una nuova segnalazione e accede alla propria area riservata.
  + Il sistema mostra l'elenco delle segnalazioni ricevute, evidenziando quelle nuove.
  + La dott.ssa Bianchi apre la segnalazione di Giulia.
  + Il sistema mostra tipologia, descrizione ed eventi del diario allegati, in ordine cronologico e con la data di inserimento di ciascuno.
  + La dott.ssa Bianchi esamina il contenuto e prende in carico la segnalazione.
  + Il sistema imposta lo stato "Presa in carico" e notifica Giulia.

]

#v(1.5em)

#scenario-box[
  === SC_CDF_02 Aggiornamento dello stato della pratica

  #v(0.3em)

  Partecipanti: Elena: Consigliere di Fiducia, Giulia: Utente

  Obiettivo: tenere informata la vittima sull'avanzamento della pratica, garantendo la trasparenza dell'iter.

  Flusso di eventi:

  + La dott.ssa Elena Bianchi decide di fissare un colloquio conoscitivo con Giulia per concordare la gestione dell'iter e apre la relativa pratica.
  + Il sistema mostra lo stato attuale ("Presa in carico") e gli stati successivi ammessi.
  + La dott.ssa Bianchi seleziona lo stato "In lavorazione" e aggiunge una nota visibile a Giulia: "Colloquio conoscitivo fissato per il 20/11 alle ore 10:00".
  + Il sistema registra il nuovo stato nella cronologia della pratica e notifica Giulia.

  Flusso alternativo (passo 2): se nel frattempo Giulia ha rinunciato al proseguimento dell'iter, il sistema mostra la pratica nello stato "Archiviata" e non ne consente la modifica.
]
