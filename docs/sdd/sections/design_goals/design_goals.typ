La definizione degli obiettivi di design per il sistema Pharos si fonda sulla traduzione dei requisiti delineati nel RAD in attributi di qualità misurabili e prioritari, strutturati secondo le principali categorie di valutazione architetturale (Dependability, End User Criteria, Performance e Maintenance).

- *Sicurezza e Confidenzialità (Dependability - Security)* — Priorità Massima
  - Il sistema deve garantire la totale protezione dei dati personali e sensibili, in rigorosa ottemperanza al GDPR (Regolamento UE 2016/679).
  - L'architettura deve assicurare la separazione logica netta tra i dati anagrafici dell'*Utente* e il contenuto della *Segnalazione* (tramite cifratura End-to-End), garantendo che i dati in chiaro siano accessibili esclusivamente all'*Utente* e al *Consigliere di Fiducia (CDF)* autorizzato.
  - Il *Diario delle evidenze* personale sull'Applicazione Mobile deve operare in un ambiente protetto contro accessi non autorizzati, avvalendosi di cifratura locale dei dati.

#v(1.5em)

- *Usabilità e Accessibilità (End User Criteria)* — Priorità Alta
  - Le interfacce (conformi allo standard WCAG 2.1 livello AA) devono abbattere le barriere psicologiche e l'esitazione antecedente alla *Segnalazione*, offrendo un'esperienza intuitiva e rassicurante e integrando sull'Applicazione Mobile strumenti di tutela immediata come il *Panic Button*.
  - Il percorso di *Triage Guidato* tramite *Modulo IA* deve supportare l'*Utente* nell'inquadramento preliminare degli *Eventi* senza richiedere competenze tecniche o legali, garantendo la rimozione preventiva dei dati identificativi e politiche *Zero-Retention* (nessuna memorizzazione né riaddestramento sui testi analizzati).

#v(1.5em)

- *Prestazioni (Performance)* — Priorità Alta
  - L'Applicazione Web riservata al *Consigliere di Fiducia* deve garantire tempi di caricamento inferiori ai 2 secondi per consentire una gestione fluida e tempestiva delle *Pratiche*.
  - Il *Modulo IA* deve elaborare gli *Eventi* selezionati e restituire la *Valutazione IA* orientativa entro un tempo massimo di 5 secondi, evitando attese che compromettano la continuità del *Triage Guidato*.

#v(1.5em)

- *Trasparenza e Tracciabilità (Dependability e Maintenance)* — Priorità Media
  - Il sistema deve contrastare la percezione di inefficacia istituzionale fornendo all'*Utente* uno strumento chiaro per monitorare lo *Stato Pratica* e consultare le *Note CDF*.
  - Ogni accesso e operazione critica effettuata dal *Consigliere di Fiducia* sui dati sensibili deve essere registrata in un *Audit Log* inalterabile (WORM), mentre le *Pratiche* passate nello stato *Chiusa* o *Archiviata* devono essere bloccate in sola lettura a livello di database per garantirne l'integrità legale.

#v(1.5em)

- *Affidabilità (Dependability - Reliability)* — Priorità Media
  - L'Applicazione Mobile deve garantire il supporto offline, permettendo all'*Utente* di registrare *Eventi* e *Allegati* nel *Diario delle evidenze* e di consultare i *Servizi Territoriali* anche in assenza di rete, con sincronizzazione posticipata dei dati cifrati.
  - Il sistema deve assicurare la continuità operativa e il recupero dei dati tramite backup completi cifrati ogni 24 ore e monitoraggio mediante telemetria priva di dati identificativi.

#v(1.5em)

- *Manutenibilità ed Estensibilità (Maintenance)* — Priorità Media
  - Il design modulare e la containerizzazione (Docker) con pipeline CI/CD devono consentire aggiornamenti ed estensioni future (es. evoluzione del *Modulo IA* o nuove funzionalità di reportistica per il *CUG*) con impatto minimo sui componenti esistenti.
  - L'architettura deve favorire leggibilità e adattabilità per supportare il ciclo di vita a lungo termine della piattaforma nel contesto universitario.