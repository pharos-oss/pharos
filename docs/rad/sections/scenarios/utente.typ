// da questa sezione si inseriscono gli scenari utente da 1-4

// da questa sezione si inseriscono gli scenari utente da 5-8
#scenario-box[
  === SC_U_05 Consultazione dello stato di una segnalazione

  #v(0.3em)

  Partecipanti: Giulia (Utente)

  Flusso di eventi:

  + Una settimana dopo l’invio, Giulia vuole sapere a che punto è la propria segnalazione. Accede a Pharos e apre l’elenco delle proprie segnalazioni.
  + Il sistema mostra le segnalazioni di Giulia con il relativo stato attuale.
  + Giulia apre la segnalazione inviata.
  + Il sistema mostra la cronologia degli stati con le relative date («Inviata», «Presa in carico», «In lavorazione») e la nota del Consigliere di Fiducia: «Colloquio conoscitivo fissato per il 20/11 alle ore 10:00».
]

#v(1.5em)

#scenario-box[
  === SC_U_06 Segnalazione salvata in bozza e ripresa

  #v(0.3em)

  Partecipanti: Marco (Utente), Elena (Consigliere di Fiducia)

  Flusso di eventi:

  + Marco inizia a compilare una segnalazione per mobbing ma, durante la stesura, viene interrotto e deve allontanarsi.
  + Marco sceglie di salvare la segnalazione come bozza.
  + Il sistema salva la bozza in forma cifrata, visibile solo a Marco e non inviata al Consigliere di Fiducia.
  + Il giorno successivo Marco accede a Pharos e apre la sezione delle proprie segnalazioni.
  + Il sistema mostra la bozza con la data dell’ultimo salvataggio.
  + Marco riapre la bozza, completa la descrizione, allega dal diario due eventi e conferma l’invio.
  + Il sistema registra la segnalazione nello stato «Inviata», notifica la dott.ssa Elena Bianchi ed elimina la bozza.
]

#v(1.5em)