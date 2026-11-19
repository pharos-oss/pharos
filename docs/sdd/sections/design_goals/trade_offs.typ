

Nella definizione dell'architettura, poiché raramente è possibile ottimizzare simultaneamente tutti gli obiettivi senza generare conflitti, sono stati valutati e risolti i seguenti compromessi (trade-offs):

- *Sicurezza (Crittografia) vs. Prestazioni (Tempo di Risposta)*
  
  - *Conflitto:* L'implementazione di algoritmi di crittografia avanzati per proteggere il "Diario delle evidenze" e le segnalazioni richiede potenza di calcolo e tempo, impattando potenzialmente sulla reattività della piattaforma.
  - *Risoluzione:* Si assegna priorità alla sicurezza. Un lieve incremento dei tempi di latenza durante il salvataggio dei dati è considerato del tutto accettabile a fronte della garanzia di inviolabilità e della conformità al GDPR, considerando la natura estremamente sensibile dei dati trattati nel safeguarding accademico.

#v(1.5em)

- *Usabilità vs. Autenticazione Forte (Controllo Accessi)*

  - *Conflitto:* Meccanismi di sicurezza stringenti (es. Multi-Factor Authentication frequente, timeout di sessione molto brevi) prevengono l'accesso non autorizzato ai dispositivi lasciati incustoditi, ma generano attrito per l'utente, che si trova già in uno stato di vulnerabilità psicologica e necessita di immediatezza (obiettivo: attenuare l'esitazione).
  - *Risoluzione:* Si bilanciano i due aspetti attraverso l'implementazione di un login sicuro ma "frictionless" per le operazioni di base e la consultazione del modulo AI, richiedendo verifiche di identità più rigorose esclusivamente al momento dell'inoltro formale della segnalazione o dell'accesso al Diario delle evidenze.

#v(1.5em)

- *Tracciabilità Trasparente vs. Anonimato della Segnalazione*
  
  - *Conflitto:* Da un lato, il sistema deve permettere alla vittima di tracciare in trasparenza l'iter della pratica; dall'altro, deve preservare la confidenzialità e proteggere contro eventuali ritorsioni, un timore che dissuade il 12% delle vittime.
  - *Risoluzione:* L'architettura implementerà un disaccoppiamento dei dati. All'utente verrà fornito un identificativo di tracciamento univoco (ticket id) slegato dai propri dati anagrafici esposti, permettendo al Consigliere di Fiducia di gestire il caso nel sistema mantenendo la separazione logica garantita dalla progettazione.

#v(1.5em)

- *Sviluppo del Modulo AI (Tempi/Costi) vs. Accuratezza del Triage*
  
  - *Conflitto:* Sviluppare un modello di Intelligenza Artificiale personalizzato ex-novo per classificare semanticamente le segnalazioni con estrema accuratezza richiederebbe costi elevati e allungherebbe i tempi di rilascio, ritardando la disponibilità dello strumento per la comunità.
  - *Risoluzione:* Per ottimizzare i tempi e rispettare le scadenze (time-to-market), si opterà per l'integrazione di LLM/modelli AI pre-addestrati e forniti tramite API sicure, fine-tuned specificamente sul dominio normativo di Ateneo (Linee Guida del CUG), accettando un livello di affidabilità supervisionata dal Consigliere di Fiducia prima di qualsiasi azione ufficiale.