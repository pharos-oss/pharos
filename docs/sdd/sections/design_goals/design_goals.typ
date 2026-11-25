#import "../../../templates/common.typ": table-style, palette-primary

La definizione degli obiettivi di design di Pharos traduce i requisiti non funzionali del RAD in attributi di qualità prioritari, classificati secondo le categorie architetturali di riferimento (_Dependability_, _End User Criteria_, _Performance_, _Maintenance_ e vincoli di _Cost_). La tabella seguente ne sintetizza la priorità e la tracciabilità rispetto ai requisiti di sistema.

#v(0.8em)

#table(
  columns: (auto, auto, auto, auto),
  ..table-style(palette-primary),
  inset: 8pt,
  align: horizon,
  table.header(
    [*Obiettivo di Design*],
    [*Categoria*],
    [*Priorità*],
    [*RNF associati*],
  ),
  [Sicurezza, Privacy e Conformità], [Dependability (Security)], [Massima], [RNF\_A\_01, RNF\_IF\_01, RNF\_IM\_02, RNF\_L\_01, RNF\_S\_01],
  [Trasparenza, Integrità e Audit], [Dependability], [Alta], [RNF\_A\_02, RNF\_L\_02],
  [Usabilità e Accessibilità], [End User Criteria], [Alta], [RNF\_U\_01, RNF\_U\_02, RNF\_U\_03, RNF\_U\_04],
  [Affidabilità e Continuità Operativa], [Dependability (Reliability)], [Alta], [RNF\_O\_01, RNF\_A\_03],
  [Prestazioni e Concorrenza], [Performance], [Media-Alta], [RNF\_P\_02, RNF\_P\_01],
  [Manutenibilità ed Estensibilità], [Maintenance / Cost], [Media], [RNF\_PK\_01, RNF\_PK\_02, RNF\_IM\_01],
)

#v(1em)

- *Sicurezza, Privacy e Conformità Normativa (Dependability - Security)* — Priorità Massima
  - La tutela dei dati personali e sensibili in ottemperanza al GDPR (Regolamento UE 2016/679) e all'AI Act costituisce il vincolo architetturale prioritario, con separazione logica netta tra l'anagrafica dell'utente e il contenuto della segnalazione.
  - Il sistema protegge i dati tramite cifratura locale sul dispositivo per il Diario delle evidenze sull'applicazione mobile, cifratura _End-to-End_ per l'inoltro delle segnalazioni (leggibili in chiaro solo dall'utente e dal Consigliere di Fiducia autorizzato) e autenticazione federata Single Sign-On (SSO) integrata con il Provider di Identità di Ateneo (SAML 2.0 / Shibboleth, federazione IDEM-GARR) per il controllo degli accessi basato sui ruoli.
  - Riguardo al Triage IA, il testo degli eventi viene preventivamente privato dei dati identificativi ed elaborato in regime _Zero-Retention_ (modelli _on-premise_ o API enterprise _stateless_), precludendo memorizzazione e riaddestramento; analogamente, il logging centralizzato anonimizza o pseudonimizza la telemetria per impedire la correlazione tramite _timestamp_.

#v(1.5em)

- *Trasparenza, Integrità Legale e Tracciabilità (Dependability)* — Priorità Alta
  - Per contrastare la percezione di inefficacia istituzionale, la piattaforma consente all'utente di monitorare in modo chiaro lo stato di avanzamento della pratica e di consultare le note visibili del CDF.
  - Sul piano della validità legale e della responsabilità amministrativa, ogni accesso e operazione del CDF sui dati sensibili è tracciata in un _Audit Log_ inalterabile (WORM), mentre le pratiche passate nello stato «Chiusa» o «Archiviata» sono bloccate in sola lettura a livello di database.

#pagebreak()

- *Usabilità e Accessibilità (End User Criteria)* — Priorità Alta
  - Le interfacce web e mobile, conformi allo standard WCAG 2.1 livello AA, sono progettate per ridurre le barriere psicologiche e l'esitazione antecedente alla segnalazione, integrando sull'applicazione mobile strumenti di tutela immediata come il _Panic Button_ per l'oscuramento o l'uscita rapida.
  - Il percorso di Triage Guidato ribadisce con chiarezza in ogni passaggio che la valutazione IA è puramente orientativa e non sostituisce il CDF né avvia un invio formale.
  - Il caricamento degli allegati garantisce tolleranza agli errori, segnalando istantaneamente formato o dimensioni non conformi senza perdere i dati testuali già inseriti.

#v(1.5em)

- *Affidabilità e Continuità Operativa (Dependability - Reliability)* — Priorità Alta
  - La persistenza dei dati è garantita da backup completi cifrati eseguiti ogni 24 ore, assicurando un _Recovery Point Objective_ (RPO) massimo di un giorno.
  - Per garantire l'operatività anche in assenza di connettività, l'applicazione mobile supporta la modalità _offline_ per consultare la rubrica e la mappa dei servizi territoriali e per annotare eventi cifrati nel diario, con sincronizzazione posticipata al ripristino della rete.

#v(1.5em)

- *Manutenibilità, Estensibilità e Contenimento dei Costi (Maintenance / Cost)* — Priorità Media
  - L'architettura adotta una decomposizione modulare, la containerizzazione tramite Docker e pipeline automatizzate di _Continuous Integration / Continuous Deployment_ (CI/CD) per standardizzare build, test delle API e rilascio degli artefatti web e mobile.
  - Tale impostazione, unita al riuso di componenti istituzionali esistenti (SSO di Ateneo) e di modelli IA non addestrati _ex novo_, contiene i costi di sviluppo e consente di estendere il sistema nel tempo (ad esempio evolvendo il modulo IA o la reportistica per il CUG) con impatto minimo.

#v(1.5em)  

- *Prestazioni e Gestione della Concorrenza (Performance)* — Priorità Bassa
  - L'architettura sostiene fluidamente il traffico istituzionale previsto, garantendo sull'applicazione web riservata al CDF tempi di caricamento delle pratiche inferiori ai 2 secondi.
  - Per il modulo ausiliario di Triage IA è previsto un tempo massimo di risposta di 5 secondi, così da preservare la continuità del percorso guidato.
