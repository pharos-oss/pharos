#import "../../../templates/common.typ": callout-box

// da questa sezione si inseriscono gli scenari utente da 1-4
Gli identificativi degli scenari riportano la gestione di appartenenza: Scenario gestione utente (SC_U) e Scenario gestione consigliere di fiducia (SC_CDF)

#callout-box(title:"SC_U_01 Invio di una segnalazione al Consigliere di Fiducia")[

  #v(0.3em)

  *Partecipanti*: Giulia (Utente), Elena (Consigliere di Fiducia)

  *Obiettivo*:Inviare una segnalazione formale al Consigliere di Fiducia tramite la compilazione del modulo standardizzato, includendo eventuali eventi precedentemente annotati.

  *Flusso di eventi*:

  + Giulia decide di segnalare gli episodi annotati nel diario e avvia la compilazione del modulo standardizzato di segnalazione.
  + Il sistema mostra il modulo: tipologia, descrizione ed eventi del diario da allegare.
  + Giulia seleziona la tipologia «molestia morale», scrive una breve descrizione e allega dal diario i tre eventi annotati, con i relativi allegati.
  + Il sistema mostra un riepilogo e informa Giulia che i suoi dati anagrafici restano separati dal contenuto e che la segnalazione sarà leggibile solo dal Consigliere di Fiducia.
  + Giulia conferma l’invio.
  + Il sistema registra la segnalazione nello stato «Inviata», le assegna un codice e notifica la dott.ssa Elena Bianchi.
  + Il sistema mostra a Giulia il codice della segnalazione e le comunica che potrà seguirne lo stato dalla piattaforma.
]

#v(1.5em)

#callout-box(title:"SC_U_02 Annotazione di un evento nel diario")[

  #v(0.3em)

  *Partecipanti*: Giulia (Utente)

  *Obiettivo*:tenere traccia di un evento nel proprio diario delle evidenze in modo privato, senza avviare una segnalazione.

  *Flusso di eventi*:

  + Giulia, studentessa del terzo anno, ha vissuto un episodio spiacevole con un collega di laboratorio e vuole tenerne traccia, senza aver ancora deciso se segnalarlo. Accede a Pharos e apre il proprio diario delle evidenze.
  + Il sistema mostra gli eventi già annotati in ordine cronologico e la possibilità di aggiungerne uno nuovo.
  + Giulia aggiunge un nuovo evento: indica data, ora e luogo (laboratorio dell’edificio F3) e descrive brevemente l’accaduto.
  + Giulia allega lo screenshot di un messaggio ricevuto in chat.
  + Il sistema verifica che i campi obbligatori siano compilati e che l’allegato rispetti formato e dimensione consentiti.
  + Il sistema salva l’evento in forma cifrata, registra la data e l’ora di inserimento e lo mostra nel diario.
  + Il sistema chiede a Giulia se desidera segnalare l’evento al Consigliere di Fiducia. Giulia sceglie di non farlo per il momento: l’evento resta salvato nel diario e il sistema la riporta alla Home.
]



  #v(0.3em)
#callout-box(title:"SC_U_03 Risposta a una richiesta di integrazioni")[
  *Partecipanti*: Marco (Utente), Elena (Consigliere di Fiducia)

  *Obiettivo*:fornire le informazioni e i documenti aggiuntivi richiesti dal Consigliere di Fiducia per proseguire la lavorazione di una segnalazione.

  *Flusso di eventi*:

  + Marco riceve una notifica: la sua segnalazione è passata allo stato «In attesa di integrazioni». Accede a Pharos e apre la segnalazione.
  + Il sistema mostra la richiesta della dott.ssa Elena Bianchi: le email ricevute dal responsabile nel mese di settembre.
  + Marco seleziona dal diario due eventi con le email allegate, aggiunge una breve nota e invia le integrazioni.
  + Il sistema allega il materiale alla segnalazione, la riporta nello stato «In lavorazione» e notifica la dott.ssa Elena Bianchi.
  + Il sistema conferma a Marco l’avvenuto invio.
]

#v(1.5em)

#callout-box(title:"SC_U_04 Triage guidato tramite il modulo AI")[

  #v(0.3em)

  *Partecipanti*: Giulia (Utente)

  *Obiettivi*: ottenere una valutazione orientativa tramite intelligenza artificiale sugli episodi annotati nel diario per comprendere la situazione e decidere se avviare una segnalazione formale.

  *Flusso di eventi*:

  + Giulia ha annotato nel diario tre episodi che coinvolgono la stessa persona e non sa se possano essere considerati molestia. Seleziona gli eventi e avvia il triage guidato.
  + Il sistema informa Giulia che il triage è solo orientativo, che viene svolto da un sistema di intelligenza artificiale, non sostituisce il Consigliere di Fiducia e non comporta alcun invio, e le chiede conferma.
  + Giulia conferma.
  + Il sistema trasmette al modulo AI il testo degli eventi selezionati, privato dei dati identificativi.
  + Il sistema mostra a Giulia la valutazione della gravità, la tipologia di violenza più probabile («molestia morale») e i passi dell’iter di segnalazione.
  + Il sistema chiede a Giulia se desidera inviare una segnalazione al Consigliere di Fiducia. Giulia sceglie di procedere.
]
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