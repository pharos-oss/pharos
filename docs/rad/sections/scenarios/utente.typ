
#import "../../../templates/common.typ":callout-box

// da questa sezione si inseriscono gli scenari utente da 1-4
Gli identificativi degli scenari riportano la gestione di appartenenza: Scenario gestione utente (SC_U) e Scenario gestione consigliere di fiducia (SC_CDF)

#callout-box(title:"SC_U_01 Invio di una segnalazione al Consigliere di Fiducia")[

  #v(0.3em)

  *Partecipanti*: Giulia (Utente), Elena (Consigliere di Fiducia)

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

  *Flusso di eventi*:

  + Giulia, studentessa del terzo anno, ha vissuto un episodio spiacevole con un collega di laboratorio e vuole tenerne traccia, senza aver ancora deciso se segnalarlo. Accede a Pharos e apre il proprio diario delle evidenze.
  + Il sistema mostra gli eventi già annotati in ordine cronologico e la possibilità di aggiungerne uno nuovo.
  + Giulia aggiunge un nuovo evento: indica data, ora e luogo (laboratorio dell’edificio F3) e descrive brevemente l’accaduto.
  + Giulia allega lo screenshot di un messaggio ricevuto in chat.
  + Il sistema verifica che i campi obbligatori siano compilati e che l’allegato rispetti formato e dimensione consentiti.
  + Il sistema salva l’evento in forma cifrata, registra la data e l’ora di inserimento e lo mostra nel diario.
  + Il sistema chiede a Giulia se desidera segnalare l’evento al Consigliere di Fiducia. Giulia sceglie di non farlo per il momento: l’evento resta salvato nel diario e il sistema la riporta alla Home.
]
// da questa sezione si inseriscono gli scenari utente da 5-8