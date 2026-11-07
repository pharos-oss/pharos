#import "../../../templates/common.typ": callout-box

// da questa sezione si inseriscono gli scenari utente da 1-4

// da questa sezione si inseriscono gli scenari utente da 5-8
#callout-box(title: "SC_U_05 Consultazione dello stato di una segnalazione")[

  #v(0.3em)

  *Partecipanti:* Giulia (Utente)

  *Obiettivo:* verificare lo stato di avanzamento e la cronologia degli aggiornamenti della propria segnalazione.

  *Flusso di eventi:*

  + Una settimana dopo l’invio, Giulia vuole sapere a che punto è la propria segnalazione. Accede a Pharos e apre l’elenco delle proprie segnalazioni.
  + Il sistema mostra le segnalazioni di Giulia con il relativo stato attuale.
  + Giulia apre la segnalazione inviata.
  + Il sistema mostra la cronologia degli stati con le relative date («Inviata», «Presa in carico», «In lavorazione») e la nota del Consigliere di Fiducia: «Colloquio conoscitivo fissato per il 20/11 alle ore 10:00».
]

#v(5em)

#callout-box(title: "SC_U_06 Segnalazione salvata in bozza e ripresa")[

  #v(0.3em)

  *Partecipanti:* Marco (Utente), Elena (Consigliere di Fiducia)

  *Obiettivo:* salvare temporaneamente una segnalazione in bozza per poterla completare ed inviare in un secondo momento.

  *Flusso di eventi:*

  + Marco inizia a compilare una segnalazione per mobbing ma, durante la stesura, viene interrotto e deve allontanarsi.
  + Marco sceglie di salvare la segnalazione come bozza.
  + Il sistema salva la bozza, visibile solo a Marco e non inviata al Consigliere di Fiducia.
  + Il giorno successivo Marco accede a Pharos e apre la sezione delle proprie segnalazioni.
  + Il sistema mostra la bozza con la data dell’ultimo salvataggio.
  + Marco riapre la bozza, completa la descrizione, allega dal diario due eventi e conferma l’invio.
  + Il sistema registra la segnalazione nello stato «Inviata», notifica la dott.ssa Elena Bianchi ed elimina la bozza.
]

#v(1.5em)

#callout-box(title: "SC_U_07 Annotazione di un evento con allegato non conforme")[

  #v(0.3em)

  *Partecipanti:* Marco (Utente)

  *Obiettivo:* registrare un nuovo evento nel diario personale allegando un file, gestendo la correzione in caso di errore per superamento della dimensione massima consentita.

  *Flusso di eventi:*

  + Marco, dipendente tecnico amministrativo, vuole conservare nel diario la registrazione audio di una riunione in cui il proprio responsabile si è rivolto a lui in modo umiliante. Accede a Pharos e aggiunge un nuovo evento.
  + Il sistema mostra il modulo per l’inserimento dell’evento.
  + Marco compila data, luogo e descrizione e allega il file audio, ma non è conforme.
  + Il sistema rileva che il file supera la dimensione massima consentita e lo rifiuta, indicando il limite e i formati ammessi. I dati già inseriti restano nel modulo.
  + Marco allega una versione compressa della registrazione conforme.
  + Il sistema verifica il nuovo allegato, salva l’evento e lo mostra nel diario.
]

#v(1.3em)

#callout-box(title: "SC_U_08 Rinuncia al proseguimento dell’iter")[

  #v(0.3em)

  *Partecipanti:* Giulia (Utente), Elena (Consigliere di Fiducia)

  *Obiettivo:* rinunciare al proseguimento della gestione della segnalazione, richiedendone l'archiviazione e l'interruzione dell'iter.

  *Flusso di eventi:*

  + La segnalazione di Giulia è stata presa in carico ed esaminata dal Consigliere di Fiducia. Giulia decide di non proseguire con l’iter, quindi accede a Pharos, apre la segnalazione e sceglie di non continuare.
  + Il sistema avvisa Giulia che la segnalazione verrà archiviata e l’iter interrotto, e le chiede conferma.
  + Giulia conferma.
  + Il sistema imposta lo stato «Archiviata», rende la segnalazione consultabile in sola lettura e notifica la dott.ssa Elena Bianchi.
]