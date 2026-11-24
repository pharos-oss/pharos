Nella definizione dell'architettura, poiché raramente è possibile ottimizzare simultaneamente tutti gli obiettivi senza generare conflitti, sono stati valutati e risolti i seguenti compromessi (trade-offs):

- *Sicurezza (Crittografia) vs. Prestazioni e Recupero Dati*
  
  - *Conflitto:* L'implementazione di algoritmi di crittografia avanzati (cifratura locale per il "Diario delle evidenze" e cifratura End-to-End per l'inoltro delle pratiche) richiede potenza di calcolo, impattando potenzialmente sulla reattività, e rende impossibile il recupero dei dati in caso di smarrimento delle credenziali da parte dell'utente.
  - *Risoluzione:* Si assegna priorità assoluta alla sicurezza. Un lieve incremento dei tempi di latenza e l'impossibilità di decifrare i dati dal server sono considerati accettabili a fronte della garanzia di inviolabilità e della conformità al GDPR, data la natura estremamente sensibile dei dati trattati nel safeguarding accademico.

#v(1.5em)

- *Usabilità vs. Autenticazione Forte (Controllo Accessi)*

  - *Conflitto:* Meccanismi di sicurezza stringenti (es. Multi-Factor Authentication frequente, timeout di sessione molto brevi) prevengono l'accesso non autorizzato ai dispositivi lasciati incustoditi, ma generano attrito per l'utente, che si trova già in uno stato di vulnerabilità psicologica e necessita di immediatezza (obiettivo: attenuare l'esitazione).
  - *Risoluzione:* Si bilanciano i due aspetti attraverso l'implementazione di un login sicuro ma "frictionless" per le operazioni di base, integrando una funzione rapida di "Panic Button" per l'oscuramento immediato in caso di interruzione. Verifiche di identità più rigorose saranno richieste esclusivamente all'inoltro formale della segnalazione.

#v(1.5em)

- *Tracciabilità Trasparente vs. Anonimato e Spazio di Archiviazione*
  
  - *Conflitto:* Da un lato, il sistema deve permettere alla vittima di tracciare in trasparenza l'iter della pratica; dall'altro, deve preservare la confidenzialità. Inoltre, tracciare ogni singola azione del Consigliere di Fiducia tramite un Audit Log inalterabile (WORM) per garantire responsabilità istituzionale, aumenta sensibilmente il carico di scrittura e archiviazione sul database.
  - *Risoluzione:* L'architettura implementerà un disaccoppiamento dei dati. All'utente verrà fornito un identificativo di tracciamento univoco slegato dai propri dati anagrafici. Contestualmente, si accetta il maggior carico sul database pur di garantire la registrazione WORM e l'archiviazione delle pratiche in sola lettura, elementi legali imprescindibili per l'integrità del processo.

#v(1.5em)

- *Sviluppo del Modulo AI (Tempi/Costi) vs. Privacy e Accuratezza del Triage*
  
  - *Conflitto:* Sviluppare un modello AI personalizzato ex-novo richiederebbe costi e tempi elevati. D'altra parte, l'utilizzo di API cloud esterne standard violerebbe le normative sulla privacy (AI Act e GDPR), esponendo i dati a rischi di conservazione e riaddestramento.
  - *Risoluzione:* Per ottimizzare i tempi (time-to-market) nel pieno rispetto normativo, si opterà per l'integrazione di modelli forniti tramite API enterprise strettamente "stateless" (Zero-Retention). Si accetta il maggior costo architetturale per garantire che i prompt in input non vengano mai memorizzati, mantenendo un livello di affidabilità supervisionata dal Consigliere di Fiducia.

#v(1.5em)

- *Disponibilità Immediata (Supporto Offline) vs. Complessità di Sincronizzazione*
  
  - *Conflitto:* Consentire all'utente di registrare eventi nel diario e consultare la mappa dei servizi anche in assenza di connessione internet richiede lo sviluppo di logiche complesse lato client (caching locale, code di sincronizzazione, gestione dei conflitti).
  - *Risoluzione:* Si sceglie di privilegiare il supporto continuo. Le vittime devono poter raccogliere evidenze nel momento esatto in cui si verificano, indipendentemente dalla copertura di rete universitaria, giustificando a pieno l'incremento della complessità implementativa.