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
  [Manutenibilità ed Estensibilità], [Maintenance / Cost], [Media], [RNF\_PK\_01, RNF\_PK\_02, RNF\_IM\_01],
  [Prestazioni e Concorrenza], [Performance], [Bassa], [RNF\_P\_02, RNF\_P\_01],
)

#v(1em)

- *Sicurezza, Privacy e Conformità Normativa (Dependability - Security)* — Priorità Massima
  - La tutela dei dati personali e sensibili in ottemperanza al GDPR (Regolamento UE 2016/679) e all'AI Act costituisce il vincolo architetturale prioritario, con separazione logica netta tra l'anagrafica dell'utente e il contenuto della segnalazione.
  - Il sistema protegge i dati tramite cifratura locale AES-256 per il Diario mobile (chiave in Keystore/Keychain hardware con _Recovery Key_ opzionale), cifratura ibrida _End-to-End_ per le segnalazioni (decifrabili solo da mittente e CDF tramite chiave istituzionale in HSM/KMS) e autenticazione SSO istituzionale (SAML 2.0 / Shibboleth, IDEM-GARR) con controllo degli accessi basato sui ruoli.
  - Nel Triage IA, per prevenire la riconoscibilità anche tramite identificativi indiretti (date, corsi, dipartimenti, ruoli o dettagli contestuali), il testo passa attraverso una redazione automatica con segnaposto (`[PERSONA]`, `[DIPARTIMENTO]`, `[DATA]`, `[LUOGO]`) seguita da revisione assistita dell'utente prima dell'invio. L'inferenza usa modelli _on-premise_ oppure servizi esterni vincolati da DPA (art. 28 GDPR), trattamento in area SEE (o garanzie equivalenti) e _Zero-Retention_ senza riaddestramento, soggetti a verifica documentale (DPO/DPIA) e tecnica periodica.
  - Il logging tecnico applica la minimizzazione e distingue la _pseudonimizzazione_ (dato comunque personale ai sensi del GDPR) dall'_anonimizzazione_ irreversibile: registra solo metadati operativi (esiti HTTP, endpoint generici, latenze, errori e token di richiesta opachi a rotazione con granularità temporale ridotta), escludendo payload e testi in chiaro. L'accesso è riservato ai soli Amministratori di Sistema (esclusi CDF e utenti), con _retention_ massima di 90 giorni per i log applicativi (6 mesi per gli accessi sistemistici) e successiva cancellazione automatica o aggregazione anonima irreversibile.

#v(1.5em)

- *Trasparenza, Integrità Legale e Tracciabilità (Dependability)* — Priorità Alta
  - Per contrastare la percezione di inefficacia istituzionale, la piattaforma consente all'utente di monitorare in modo chiaro lo stato di avanzamento della pratica e di consultare le note visibili del CDF.
  - A supporto dell'_accountability_, le operazioni del CDF sui dati sensibili sono registrate in un _Audit Log_ su storage WORM con verifica crittografica (_hash-chaining_), mentre le pratiche «Chiuse» o «Archiviate» sono bloccate in sola lettura a livello applicativo e di database. Lo storage WORM garantisce l'integrità tecnica contro manomissioni, ma non equivale di per sé a piena validità probatoria legale, che dipende anche da presidi procedurali e giuridici esterni (identificazione SSO, marcatura temporale e catena di custodia).
  - L'_Audit Log_ traccia solo metadati, senza mai includere testi in chiaro: accessi del CDF, apertura/decifratura di pratiche e allegati, presa in carico, cambi di stato, note, richieste di integrazione, chiusura/archiviazione, gestione assenze ed esportazione report CUG (con _timestamp_ sincronizzato, ID operatore, ID pratica, azione ed esito). Per _Separation of Duties_, il CDF non può modificare né consultare il repository WORM: l'accesso in sola lettura (anch'esso tracciato) è riservato a DPO, responsabile sicurezza di Ateneo o autorità competenti su richiesta motivata. I record sono conservati secondo le policy di Ateneo (indicativamente 5 anni dalla chiusura/archiviazione), con dismissione sicura a scadenza.

#v(1.5em)

- *Usabilità e Accessibilità (End User Criteria)* — Priorità Alta
  - Le interfacce web e mobile, conformi allo standard WCAG 2.1 livello AA, sono progettate per ridurre le barriere psicologiche e l'esitazione antecedente alla segnalazione, integrando sull'applicazione mobile strumenti di tutela immediata come il _Panic Button_ per l'oscuramento o l'uscita rapida.
  - Il percorso di Triage Guidato ribadisce con chiarezza in ogni passaggio che la valutazione IA è puramente orientativa e non sostituisce il CDF né avvia un invio formale.
  - Il caricamento degli allegati garantisce tolleranza agli errori, segnalando istantaneamente formato o dimensioni non conformi senza perdere i dati testuali già inseriti.

#v(1.5em)

- *Affidabilità e Continuità Operativa (Dependability - Reliability)* — Priorità Alta
  - La continuità operativa e la persistenza dei dati sono garantite da backup completi cifrati eseguiti automaticamente ogni 24 ore con replica _off-site_, che assicurano un _Recovery Point Objective_ (RPO) massimo di 24 ore, affiancati da una procedura documentata di ripristino basata su containerizzazione Docker con _Recovery Time Objective_ (RTO) massimo di 4 ore per i servizi principali.
  - Poiché la sola esecuzione dei backup non dimostra la recuperabilità nei tempi previsti, ogni salvataggio prevede una verifica automatica di integrità (_checksum_) con allerta in caso di errore, integrata da test di ripristino (_restore drill_) trimestrali — e a seguito di modifiche strutturali a database o infrastruttura — in un ambiente di _staging_ isolato. Ogni test verifica decifratura mediante chiavi di _recovery_ separate, coerenza di database e allegati tramite _smoke test_ automatizzati e rispetto effettivo dell'RTO, con verbalizzazione dell'esito.
  - Per garantire l'operatività anche in assenza di connettività, l'applicazione mobile supporta la modalità _offline_ per consultare la rubrica e la mappa dei servizi territoriali e per annotare eventi cifrati nel diario, con sincronizzazione posticipata al ripristino della rete.

#v(1.5em)

- *Manutenibilità, Estensibilità e Contenimento dei Costi (Maintenance / Cost)* — Priorità Media
  - L'architettura adotta una decomposizione modulare, la containerizzazione tramite Docker e pipeline automatizzate di _Continuous Integration / Continuous Deployment_ (CI/CD) per standardizzare build, test delle API e rilascio degli artefatti web e mobile.
  - Tale impostazione, unita al riuso di componenti istituzionali esistenti (SSO di Ateneo) e di modelli IA non addestrati _ex novo_, contiene i costi di sviluppo e consente di estendere il sistema nel tempo (ad esempio evolvendo il modulo IA o la reportistica per il CUG) con impatto minimo.

#v(1.5em)  

- *Prestazioni e Gestione della Concorrenza (Performance)* — Priorità Bassa
  - Le soglie prestazionali sono verificate mediante test di carico automatizzati in ambiente di pre-produzione equivalente alla produzione, con un dataset rappresentativo (almeno 1.000 pratiche archiviate e 50 pratiche attive) e un carico simulato pari al picco istituzionale atteso (fino a 50 utenti mobili concorrenti sul modulo di triage e 10 sessioni concorrenti sulla web app del CDF, su rete con RTT $<=$ 50 ms e banda $>=$ 10 Mbps).
  - *Caricamento pratiche web CDF ($<$ 2 s):* misurato _end-to-end_ lato client dall'invio della richiesta autenticata (apertura della vista pratica o applicazione di un filtro sulla lista paginata) fino al rendering interattivo dei metadati e del testo decifrato (escluso il download _on-demand_ di allegati multimediali pesanti). Soglia di successo: 95° percentile (p95) $<$ 2 s, p99 $<=$ 3 s e tasso di errore HTTP 5xx $<$ 0,5%.
  - *Risposta del Triage IA ($<$ 5 s):* misurata _end-to-end_ lato client dalla conferma di invio del testo (lunghezza media fino a 2.500 caratteri) alla visualizzazione completa della valutazione strutturata sull'app mobile, includendo redazione, rete, inferenza e serializzazione. Soglia di successo: 95° percentile (p95) $<$ 5 s, p99 $<=$ 8 s e tasso di errore/timeout $<$ 1%.

#v(1.5em)

La matrice seguente collega ciascun obiettivo di design ai requisiti non funzionali del RAD associati e alle principali decisioni architetturali adottate per soddisfarli.

#v(1.5em)

#table(
  columns: (1.1fr, 0.9fr, 2.2fr),
  ..table-style(palette-primary),
  inset: 7pt,
  align: left + horizon,
  table.header(
    [*Obiettivo di Design*],
    [*RNF associati*],
    [*Decisioni architetturali*],
  ),
  [Sicurezza, Privacy e Conformità],
  [RNF\_A\_01, RNF\_IF\_01, RNF\_IM\_02, RNF\_L\_01, RNF\_S\_01],
  [Separazione logica DB tra anagrafica e contenuto; cifratura locale AES-256 (Keystore/Keychain + _Recovery Key_ opzionale) ed E2EE ibrida con chiave CDF in HSM/KMS; SSO SAML 2.0 / Shibboleth (IDEM-GARR) con RBAC; redazione automatica + revisione utente per identificativi diretti/indiretti e servizi IA _on-premise_ o esterni verificati (DPA, SEE, _Zero-Retention_); logging minimizzato con pseudonimizzazione a rotazione, accesso ristretto e _retention_ automatizzata.],
  [Trasparenza, Integrità e Audit],
  [RNF\_A\_02, RNF\_L\_02],
  [Macchina a stati persistita con note visibili all'utente; blocco _read-only_ applicativo e DB per pratiche chiuse/archiviate; _Audit Log_ su storage WORM con _hash-chaining_, _Separation of Duties_ (accesso DPO/Sicurezza) e _retention_ definita.],
  [Usabilità e Accessibilità],
  [RNF\_U\_01, RNF\_U\_02, RNF\_U\_03, RNF\_U\_04],
  [Interfacce conformi a WCAG 2.1 AA; componente globale _Panic Button_ su mobile; disclaimer persistenti in ogni passo del Triage IA; validazione asincrona degli allegati con preservazione dello stato dei form.],
  [Affidabilità e Continuità Operativa],
  [RNF\_O\_01, RNF\_A\_03],
  [Architettura _offline-first_ su mobile (storage cifrato, rubrica/mappa locali e coda di sincronizzazione); backup giornalieri cifrati _off-site_ (RPO $<=$ 24 h), deploy containerizzato con RTO $<=$ 4 h e _restore drill_ trimestrali in _staging_.],
  [Manutenibilità ed Estensibilità],
  [RNF\_PK\_01, RNF\_PK\_02, RNF\_IM\_01],
  [Decomposizione modulare con adattatori disaccoppiati (motore IA e reportistica CUG); containerizzazione Docker; pipeline CI/CD automatizzate per build, test API e rilascio; riuso di IdP di Ateneo e modelli IA pre-addestrati.],
  [Prestazioni e Concorrenza],
  [RNF\_P\_02, RNF\_P\_01],
  [Query indicizzate e paginazione lato server per la dashboard CDF; invocazione asincrona con gestione timeout per il Triage IA; suite automatizzata di test di carico in pre-produzione con verifica p95 ($<$ 2 s e $<$ 5 s).],
)