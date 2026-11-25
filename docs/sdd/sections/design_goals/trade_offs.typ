Nella definizione dell'architettura, poiché raramente è possibile ottimizzare simultaneamente tutti gli obiettivi senza generare conflitti, sono stati valutati e risolti i seguenti compromessi (_trade-offs_):

- *Sicurezza (Crittografia) vs. Prestazioni e Recupero Dati*
  - *Conflitto:* L'adozione della cifratura locale per il Diario delle evidenze e della cifratura _End-to-End_ per le segnalazioni introduce un sovraccarico computazionale e rende tecnicamente impossibile il recupero in chiaro lato server dei dati locali del diario (e delle bozze) qualora l'utente smarrisca le proprie chiavi.
  - *Risoluzione:* Si assegna priorità assoluta alla riservatezza. Un lieve aumento della latenza e l'impossibilità di recupero lato server del diario privato sono accettati a fronte della garanzia di inviolabilità dei contenuti e della piena conformità al GDPR.

#v(1.5em)

- *Usabilità vs. Controllo degli Accessi*
  - *Conflitto:* Meccanismi di registrazione dedicati o verifiche d'identità ripetute rafforzano la protezione contro accessi abusivi, ma creano attrito cognitivo ed emotivo per utenti in condizioni di vulnerabilità, disincentivando l'uso della piattaforma.
  - *Risoluzione:* Si adotta l'autenticazione federata Single Sign-On (SSO) tramite il Provider di Identità di Ateneo (SAML 2.0 / Shibboleth, federazione IDEM-GARR), che assicura un accesso istituzionale basato sui ruoli senza introdurre nuove credenziali. La protezione fisica durante l'utilizzo su dispositivo personale è affidata al _Panic Button_.

#v(1.5em)

- *Tracciabilità Legale vs. Confidenzialità e Carico di Archiviazione*
  - *Conflitto:* Consentire il monitoraggio trasparente dello stato della pratica, registrare ogni accesso del Consigliere di Fiducia (CDF) in un _Audit Log_ inalterabile (WORM) e congelare in sola lettura le pratiche chiuse o archiviate tutela la validità probatoria, ma incrementa il carico di scrittura e lo spazio di archiviazione e richiede attenzione per non esporre dati sensibili.
  - *Risoluzione:* Il disaccoppiamento logico tra anagrafica e contenuto cifrato preserva la confidenzialità pur permettendo all'utente di consultare gli stati dalla propria dashboard autenticata. Si accetta il maggiore onere di archiviazione e scrittura sul database come costo necessario per garantire l'integrità dell'iter.

#v(1.5em)

- *Tempi e Costi del Modulo IA vs. Privacy e Conformità Normativa*
  - *Conflitto:* Addestrare un modello linguistico proprietario comporta costi e tempi insostenibili per il contesto accademico; al contrario, invocare API cloud consumer violerebbe GDPR e AI Act, esponendo racconti sensibili a rischi di conservazione o riaddestramento.
  - *Risoluzione:* Il modulo IA viene integrato mediante modelli ospitati _on-premise_ oppure API enterprise configurate in modalità _stateless_ e _Zero-Retention_, sempre a valle di un filtro automatico di anonimizzazione. Si accettano i maggiori vincoli infrastrutturali e operativi per escludere qualsiasi ritenzione dei prompt, mantenendo l'esito del triage strettamente orientativo.

#v(1.5em)

- *Operatività Offline vs. Complessità di Sincronizzazione*
  - *Conflitto:* Permettere la consultazione dei servizi territoriali e la registrazione cifrata di eventi nel diario in assenza di rete richiede logiche lato client più articolate sull'applicazione mobile (persistenza locale sicura, code di invio differito e gestione dei conflitti).
  - *Risoluzione:* Si privilegia la continuità d'uso: l'utente deve poter documentare un episodio nel momento stesso in cui accade, indipendentemente dalla copertura di rete. La maggiore complessità implementativa sul client mobile risulta pertanto pienamente giustificata.

#v(1.5em)

- *Osservabilità del Sistema vs. Anonimato (Correlazione Temporale)*
  - *Conflitto:* Un logging centralizzato dettagliato facilita l'individuazione rapida delle anomalie, ma la registrazione di indirizzi IP, identificativi utente o _timestamp_ granulari può consentire di risalire all'identità del segnalante incrociando i log di sistema.
  - *Risoluzione:* Si limita volontariamente la granularità diagnostica della telemetria, imponendo anonimizzazione e pseudonimizzazione dei log operativi. Una diagnosi più laboriosa degli errori lato client è preferibile a qualsiasi rischio di esposizione indiretta dell'identità dell'utente.