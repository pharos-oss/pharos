
#import "../../../templates/common.typ":callout-box

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

  *Obiettivo*: ottenere una valutazione orientativa tramite intelligenza artificiale sugli episodi annotati nel diario per comprendere la situazione e decidere se avviare una segnalazione formale.

  *Flusso di eventi*:

  + Giulia ha annotato nel diario tre episodi che coinvolgono la stessa persona e non sa se possano essere considerati molestia. Seleziona gli eventi e avvia il triage guidato.
  + Il sistema informa Giulia che il triage è solo orientativo, che viene svolto da un sistema di intelligenza artificiale, non sostituisce il Consigliere di Fiducia e non comporta alcun invio, e le chiede conferma.
  + Giulia conferma.
  + Il sistema trasmette al modulo AI il testo degli eventi selezionati, privato dei dati identificativi.
  + Il sistema mostra a Giulia la valutazione della gravità, la tipologia di violenza più probabile («molestia morale») e i passi dell’iter di segnalazione.
  + Il sistema chiede a Giulia se desidera inviare una segnalazione al Consigliere di Fiducia. Giulia sceglie di procedere.
]
// da questa sezione si inseriscono gli scenari utente da 5-8