Nella definizione dell'architettura, poiché raramente è possibile ottimizzare simultaneamente tutti gli obiettivi senza generare conflitti, sono stati valutati e risolti i seguenti compromessi (_trade-offs_):

- *Sicurezza (Crittografia) vs. Prestazioni e Recupero Dati*
  - *Sicurezza (Crittografia) vs. Prestazioni e Recupero Dati*
  - *Conflitto:* La cifratura locale del Diario e quella _End-to-End_ (E2EE) delle segnalazioni introducono overhead computazionale e impediscono al server di recuperare i dati locali in caso di perdita del dispositivo o delle credenziali crittografiche.
  - *Risoluzione:* Si privilegia la riservatezza mediante cifratura ibrida con ciclo di vita delle chiavi così strutturato:
    - *Generazione:* al primo avvio il client genera (CSPRNG) una chiave AES-256 per il Diario e una coppia asimmetrica utente; ogni segnalazione usa una chiave effimera (DEK, AES-256-GCM) incapsulata con le chiavi pubbliche di CDF e utente. L'utente può inoltre generare una _Recovery Key_ (o passphrase derivata con Argon2id) per un backup cifrato delle proprie chiavi.
    - *Conservazione:* le chiavi utente non transitano mai in chiaro e risiedono nell'hardware sicuro del dispositivo (Android Keystore / iOS Keychain, protette da biometria/PIN); la chiave privata del CDF è custodita in HSM/KMS (SSO + MFA) con _escrow_ istituzionale per continuità in caso di avvicendamento.
    - *Recupero e perdita:* smarrito il dispositivo, con la _Recovery Key_ l'utente si riautentica via SSO su un nuovo terminale e ripristina le chiavi dal backup cifrato. Se perde sia dispositivo sia _Recovery Key_, i dati locali del Diario e le bozze non inviate sono *definitivamente irrecuperabili*; per le segnalazioni già inviate restano visibili gli stati via SSO, il fascicolo rimane decifrabile lato CDF e la revoca della sessione SSO blocca il dispositivo smarrito.

#v(1.5em)

- *Usabilità vs. Controllo degli Accessi*
  - *Conflitto:* Meccanismi di registrazione dedicati o verifiche d'identità ripetute rafforzano la protezione contro accessi abusivi, ma creano attrito cognitivo ed emotivo per utenti in condizioni di vulnerabilità, disincentivando l'uso della piattaforma.
  - *Risoluzione:* Si adotta l'autenticazione federata Single Sign-On (SSO) tramite il Provider di Identità di Ateneo (SAML 2.0 / Shibboleth, federazione IDEM-GARR), che assicura un accesso istituzionale basato sui ruoli senza introdurre nuove credenziali. La protezione fisica durante l'utilizzo su dispositivo personale è affidata al _Panic Button_.

#v(1.5em)

- *Tracciabilità Legale vs. Confidenzialità e Carico di Archiviazione*
  - *Tracciabilità e Integrità vs. Confidenzialità e Carico di Archiviazione*
  - *Conflitto:* Consentire il monitoraggio trasparente dello stato della pratica, registrare le operazioni del Consigliere di Fiducia (CDF) in un _Audit Log_ su storage inalterabile (WORM) e congelare in sola lettura le pratiche chiuse o archiviate rafforza l'_accountability_ amministrativa e la protezione contro manomissioni, ma incrementa il carico di scrittura e lo spazio di archiviazione e richiede controlli rigorosi per non esporre dati sensibili nei tracciati.
  - *Risoluzione:* Il disaccoppiamento logico tra anagrafica e contenuto cifrato preserva la confidenzialità pur permettendo all'utente di consultare gli stati dalla propria dashboard autenticata, mentre l'_Audit Log_ registra solo metadati operativi senza mai includere il testo in chiaro delle segnalazioni. Si riconosce esplicitamente che lo storage WORM (affiancato da _hash-chaining_) costituisce una garanzia tecnica di integrità e non alterabilità ma *non equivale automaticamente a validità probatoria legale*, la quale richiede anche presidi procedurali e giuridici esterni (identificazione tramite SSO, catena di custodia, marcatura temporale e valutazione nelle sedi competenti). Si accetta pertanto il maggiore onere di archiviazione e scrittura come costo proporzionato al livello di tracciabilità richiesto.

#v(1.5em)

- *Tempi e Costi del Modulo IA vs. Privacy e Conformità Normativa*
  - *Tempi e Costi del Modulo IA vs. Privacy e Conformità Normativa*
  - *Conflitto:* Addestrare e manutenere un modello linguistico proprietario comporta costi e tempi insostenibili per il contesto accademico; d'altro canto, l'adozione non governata di servizi IA cloud di terze parti espone dati sensibili a rischi di conservazione, riutilizzo per l'addestramento o trasferimenti extra-SEE non conformi a GDPR e AI Act.
  - *Risoluzione:* Il modulo di Triage IA integra modelli ospitati _on-premise_ oppure servizi IA gestiti di terze parti selezionati sulla base di criteri normativi e tecnici vincolanti, applicati sempre a valle della pipeline di rimozione degli identificativi diretti e indiretti (redazione automatica più revisione assistita dell'utente). Un servizio IA esterno può essere adottato solo se soddisfa congiuntamente i seguenti requisiti:
    - stipula di un _Data Processing Agreement_ (DPA, art. 28 GDPR) che designi il fornitore quale responsabile del trattamento e disciplini i sub-responsabili;
    - localizzazione del trattamento nello Spazio Economico Europeo (SEE) o presenza di garanzie adeguate ai sensi del Capo V GDPR (decisioni di adeguatezza o Clausole Contrattuali Standard con relativa valutazione d'impatto sul trasferimento);
    - clausola contrattuale vincolante di _Zero-Retention_ (nessuna memorizzazione di prompt e risposte oltre l'elaborazione sincrona) ed esclusione esplicita del riaddestramento sui dati inviati;
    - conformità agli obblighi di trasparenza e gestione del rischio previsti dall'AI Act per sistemi di supporto non decisionali (esclusione di decisioni automatizzate vincolanti ai sensi dell'art. 22 GDPR) e cifratura TLS 1.3 in transito.
  - *Modalità di verifica:* prima della messa in esercizio, i requisiti legali e contrattuali sono verificati dal DPO di Ateneo mediante revisione di DPA, termini di servizio, elenco sub-responsabili, certificazioni di sicurezza (es. ISO/IEC 27001, ISO/IEC 27701 o SOC 2 Type II) e aggiornamento della DPIA. Sul piano tecnico, test automatizzati in pipeline CI/CD verificano la redazione dei payload in uscita, l'uso esclusivo degli endpoint/regioni SEE autorizzati e i flag di disattivazione del logging lato provider, con riesame periodico annuale o a ogni variazione contrattuale o di versione API.

#v(1.5em)

- *Operatività Offline vs. Complessità di Sincronizzazione*
  - *Conflitto:* Permettere la consultazione dei servizi territoriali e la registrazione cifrata di eventi nel diario in assenza di rete richiede logiche lato client più articolate sull'applicazione mobile (persistenza locale sicura, code di invio differito e gestione dei conflitti).
  - *Risoluzione:* Si privilegia la continuità d'uso: l'utente deve poter documentare un episodio nel momento stesso in cui accade, indipendentemente dalla copertura di rete. La maggiore complessità implementativa sul client mobile risulta pertanto pienamente giustificata.

#v(1.5em)

- *Osservabilità del Sistema vs. Anonimato (Correlazione Temporale)*
  - *Conflitto:* Un logging centralizzato dettagliato facilita l'individuazione rapida delle anomalie, ma la registrazione di indirizzi IP, identificativi utente o _timestamp_ granulari può consentire di risalire all'identità del segnalante incrociando i log di sistema.
  - *Risoluzione:* Si limita volontariamente la granularità diagnostica della telemetria applicando minimizzazione, pseudonimizzazione degli identificativi di richiesta tramite token opachi a rotazione (riconoscendo che il dato pseudonimizzato resta comunque personale ai sensi del GDPR) e riduzione della granularità temporale per ostacolare la correlazione, con accesso riservato agli Amministratori di Sistema e cancellazione o aggregazione irreversibilmente anonima a scadenza della _retention_. Una diagnosi più laboriosa degli errori è preferibile a qualsiasi rischio di esposizione indiretta dell'identità dell'utente.