Nella definizione dell'architettura, poiché raramente è possibile ottimizzare simultaneamente tutti gli obiettivi senza generare conflitti, sono stati valutati e risolti i seguenti compromessi (trade-offs):

- *Sicurezza (Crittografia) vs. Prestazioni e Recupero Dati*
  - *Conflitto:* L'implementazione di meccanismi di crittografia avanzati (cifratura locale per il *Diario delle evidenze* e cifratura End-to-End per le *Segnalazioni*) introduce un sovraccarico computazionale, incidendo potenzialmente sulla reattività, e impedisce la decifrazione lato server in caso di perdita delle chiavi da parte dell'*Utente*.
  - *Risoluzione:* Si assegna priorità assoluta alla sicurezza. Un lieve incremento della latenza e l'impossibilità di recupero in chiaro lato server sono considerati accettabili a fronte della garanzia di inviolabilità e della piena conformità al GDPR, data la natura estremamente sensibile dei dati trattati nel safeguarding accademico.

#v(1.5em)

- *Usabilità vs. Autenticazione (Controllo Accessi)*
  - *Conflitto:* Procedure di registrazione dedicate o verifiche di identità ripetute e invasive aumentano la protezione contro accessi non autorizzati, ma introducono attrito per un *Utente* in condizione di vulnerabilità, rischiando di scoraggiare l'utilizzo della piattaforma.
  - *Risoluzione:* Si adotta l'autenticazione federata *Single Sign-On (SSO)* tramite il *Provider di Identità di Ateneo* (protocollo SAML 2.0 / Shibboleth, federazione IDEM-GARR), che garantisce un controllo degli accessi istituzionale e basato sui ruoli senza richiedere la creazione di nuove credenziali. La tutela immediata durante l'uso su dispositivo personale è inoltre demandata al *Panic Button* per l'oscuramento e l'uscita rapida.

#v(1.5em)

- *Tracciabilità Trasparente vs. Confidenzialità e Spazio di Archiviazione*
  - *Conflitto:* Il sistema deve permettere all'*Utente* di monitorare in trasparenza lo *Stato Pratica* e al contempo tutelarne la riservatezza. Inoltre, registrare ogni accesso del *Consigliere di Fiducia* ai dati sensibili in un *Audit Log* inalterabile (WORM) e mantenere immutabili le *Pratiche* concluse aumenta sensibilmente il carico di scrittura e lo spazio di archiviazione sul database.
  - *Risoluzione:* L'*Utente* monitora l'avanzamento della propria *Pratica* direttamente dalla dashboard autenticata via SSO, mentre a livello di persistenza il disaccoppiamento logico tra dati anagrafici e contenuto narrativo (protetto da cifratura End-to-End) preserva la confidenzialità. Contestualmente, si accetta il maggior onere di archiviazione per garantire la registrazione WORM e il blocco in sola lettura delle *Pratiche* nello stato *Chiusa* o *Archiviata*, requisiti imprescindibili per l'integrità del processo.

#v(1.5em)

- *Sviluppo del Modulo IA (Tempi/Costi) vs. Privacy e Accuratezza del Triage*
  - *Conflitto:* Addestrare un modello di intelligenza artificiale proprietario ex-novo comporterebbe tempi e costi insostenibili; d'altra parte, l'impiego di API cloud standard violerebbe GDPR e AI Act, esponendo testi sensibili a rischi di conservazione e riaddestramento.
  - *Risoluzione:* Si sceglie di integrare il *Modulo IA* tramite modelli ospitati in locale (*on-premise*) oppure API enterprise rigorosamente *stateless* in regime *Zero-Retention*, preceduti dalla rimozione automatica dei dati identificativi. Si accetta il maggior vincolo architetturale e di costo operativo pur di impedire qualsiasi memorizzazione dei prompt, mantenendo la *Valutazione IA* come supporto puramente orientativo che non sostituisce mai il *Consigliere di Fiducia*.

#v(1.5em)

- *Disponibilità Immediata (Supporto Offline) vs. Complessità di Sincronizzazione*
  - *Conflitto:* Consentire all'*Utente* di registrare *Eventi* e *Allegati* nel *Diario delle evidenze* e di consultare i *Servizi Territoriali* anche in assenza di connettività richiede logiche client-side più complesse (persistenza locale cifrata, code di sincronizzazione differita e gestione dei conflitti).
  - *Risoluzione:* Si privilegia la continuità d'uso, ovvero gli *Utenti* devono poter raccogliere evidenze nel momento stesso in cui gli *Eventi* si verificano, indipendentemente dalla copertura di rete, giustificando pienamente l'incremento di complessità implementativa sull'Applicazione Mobile.