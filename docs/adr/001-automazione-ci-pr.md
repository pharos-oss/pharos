# ADR 001: Standardizzazione dei Commit e Automazione della Pipeline CI per la Documentazione Typst

- **Stato:** Approvato
- **Autori:** Gianmarco Raimondi
- **Data:** 18-11-2026

## Contesto e enunciato del problema

Attualmente, le revisioni delle Pull Request per la documentazione RAD avvengono in modo manuale. I revisori investono tempo prezioso nell'identificare errori banali, quali refusi ortografici, file binari non autorizzati o commit con messaggi non semantici. Inoltre, chi revisiona i documenti Typst è costretto a compilarli in locale per verificare la corretta impaginazione. Manca un tollgate automatico che certifichi la corretta compilazione del codice Typst prima del merge e un sistema centralizzato per uniformare l'esecuzione dei comandi sia in locale che in Continuous Integration (CI).

Come possiamo automatizzare il processo applicando il paradigma *Shift-Left*, bloccando gli errori direttamente sulla macchina dello sviluppatore, standardizzando i comandi di workflow e fornendo output documentali già pronti per i revisori?

## Fattori determinanti della decisione

- Riduzione del tempo speso in revisioni manuali (code review) per questioni formali, ortografiche o stilistiche.
- Adesione rigorosa al principio DRY (Don't Repeat Yourself) per evitare discrepanze tra script locali e workflow di CI.
- Feedback istantaneo per lo sviluppatore per evitare i tempi di esecuzione in cloud.
- Architettura "Zero-Dependencies": indipendenza dai linguaggi di scripting e necessità di evitare l'installazione globale di runtime (Python, Node.js) sulla macchina dello sviluppatore.
- Miglioramento della "Reviewer Experience", permettendo ai revisori di validare l'impaginazione in modo rapido e accessibile.
- Tracciabilità semantica della cronologia Git per facilitare la gestione del progetto e la reportistica.
- Riproducibilità e scalabilità: l'infrastruttura deve garantire risultati identici nel tempo, indipendentemente dagli aggiornamenti futuri dei tool.

## Opzioni considerate

- Orchestrazione Git Hook: `prek` (Ecosistema Rust, Drop-in replacement)
- Orchestrazione Git Hook: `pre-commit` (Framework Python)
- Orchestrazione Git Hook: Husky (Ecosistema Node.js)
- Task Runner (Scripting): `Just` (Ecosistema Rust)
- Task Runner (Scripting): Script Bash custom su GitHub Actions
- Validazione e Build Typst: Azione GitHub nativa (`setup-typst`) integrata con `actions/upload-artifact`
- Validazione Typst: Esecuzione tramite container Docker ufficiale Typst
- Ottimizzazione CI: Caching strategico (`actions/cache`)
- Reviewer Experience: PR Bot Commenting (`marocchino/sticky-pull-request-comment`)
- Spell Checking: CSpell
- Spell Checking: Typos (crate-ci, in Rust) / Vale
- Standardizzazione Git: `commitizen` integrato nei git hook



## Esito della decisione

Opzione scelta: **Architettura ibrida basata su `prek` per i git hook, `Just` come task runner universale, `CSpell` per il controllo ortografico, con pipeline GitHub Actions ottimizzata via Caching e PR Bot Commenting per il rilascio dei PDF.**

La decisione evolve la proposta iniziale sostituendo pre-commit con prek. Essendo un binario Rust autonomo, prek annulla la dipendenza globale da Python garantendo al contempo il supporto all'isolamento degli ambienti (sandbox) per tool come CSpell (che necessita di Node.js confinato).

Per rispettare il principio DRY, introduciamo Just: tramite un singolo justfile centralizzato standardizziamo i comandi (es. just lint, just build). La CI invocherà direttamente le ricette di Just, eliminando la duplicazione della logica tra ambiente locale e remoto.

Infine, l'azione setup-typst si occuperà di installare l'ambiente Typst nel runner CI, dopodiché verrà eseguito un comando esplicito di compilazione (invocando la relativa ricetta, es. just build-pdf) per generare effettivamente i file PDF a ogni PR. Questi PDF verranno poi caricati come artefatti tramite GitHub Actions, consentendo ai revisori di scaricarli e ispezionarli immediatamente dal browser. Si conferma l'utilizzo di commitizen per i Conventional Commits e l'aggiornamento automatico del CHANGELOG.md.

Per migliorare le performance e l'usabilità della pipeline CI, integriamo due ottimizzazioni finali:
1. **Caching degli Environment:** Implementiamo `actions/cache` per memorizzare la sandbox di `prek`. Questo evita il download ripetuto di Node.js e dei dizionari CSpell a ogni esecuzione, abbattendo i tempi di setup della CI.
2. **Zero-Click Review:** Utilizziamo `sticky-pull-request-comment` a fine pipeline. Non appena `setup-typst` compila e carica il PDF come artefatto, il bot pubblica un commento automatico nel thread della PR contenente il link diretto per scaricare e leggere l'anteprima, eliminando la necessità per i revisori di cercare i file nei log di GitHub.

### Conseguenze positive

- PR chiare e ispezionabili: i revisori non devono clonare il repo e installare tool per leggere i documenti impaginati, il PDF del relativo documento viene allegato direttamente nella discussione della PR tramite bot.
- Performance CI massimizzate grazie al caching strategico, il feedback sulla PR è pressoché istantaneo.
- Dev Experience eccellente: nessun requisito di sistema (né Python né Node.js globali) grazie a `prek` che scarica e gestisce gli eseguibili in isolamento.
- Manutenibilità elevata (DRY): i comandi di test e validazione risiedono solo nel `justfile`. Un'eventuale modifica si applica istantaneamente sia ai dev che a GitHub Actions.
- Nessun file "spazzatura" o eccessivamente pesante finirà nel repository.
- Generazione e aggiornamento automatico del file `CHANGELOG.md`, migliorando la visibilità degli aggiornamenti.
- Tempi di CI ridotti grazie all'uso di azioni native rispetto all'avvio di container Docker.

### Conseguenze negative

- Leggero attrito iniziale per il team di sviluppo che dovrà abituarsi a formattare rigidamente i messaggi di commit secondo le regole di `commitizen` e ad utilizzare i comandi tramite `Just`.
- L'upload dei PDF (Artifacts) allunga di qualche secondo i tempi di esecuzione della pipeline su GitHub Actions rispetto alla sola validazione a riga di comando.
- Leggero aumento della verbosità del file YAML della GitHub Action per configurare correttamente le chiavi di cache e i permessi del bot per i commenti.

## Pro e contro delle opzioni considerate

### prek
Tool di gestione git hook scritto in Rust, sostituto diretto di `pre-commit`.
- **Pro:** È un eseguibile standalone che non richiede Python sulla macchina ospite.
- **Pro:** Esecuzione estremamente veloce; isola nativamente toolchain terze (come l'ambiente Node.js necessario per CSpell) in sandbox sicure.
- **Contro:** Rispetto a `pre-commit`, è uno strumento più recente e con una community in fase di espansione.

### Just
Task runner moderno, scritto in Rust, focalizzato sull'esecuzione di comandi (salvati in un `justfile`).
- **Pro:** Astrae il sistema operativo permettendo esecuzioni cross-platform (Windows, macOS, Linux) per lo stesso alias (es. `just check-docs`).
- **Pro:** Permette di mantenere pipeline CI estremamente pulite delegando l'esecuzione della logica direttamente allo strumento locale.
- **Contro:** Richiede l'installazione di un ulteriore eseguibile binario sulla macchina di sviluppo.

### Caching (`actions/cache`)
- **Pro:** Azzera i tempi di inattività (idle/download time) dei server CI, salvando il budget di minuti GitHub Actions dell'organizzazione.
- **Contro:** Richiede attenzione nella definizione della chiave di invalidazione (hash del file `.pre-commit-config.yaml`) per evitare cache corrotte.

### PR Bot Commenting (`marocchino/sticky-pull-request-comment`)
- **Pro:** Trasforma radicalmente l'esperienza di revisione. Il documento viene posto all'utente anziché costretto a cercarlo. Se il PDF viene ricompilato, il bot aggiorna il commento esistente senza fare spam.

### Pipeline Automatica e GitHub Artifacts
Integrazione di `setup-typst` con l'azione `actions/upload-artifact`.
- **Pro:** Genera il PDF in cloud e lo allega ai check della PR. Gli stakeholder di progetto possono validare l'impaginazione in modo totalmente passivo dal browser.
- **Contro:** Aumenta marginalmente il consumo di spazio di storage gratuito fornito da GitHub Actions per l'hosting temporaneo dei file.

### pre-commit (Scartato in favore di prek)
Framework per la gestione dei git hook, configurabile tramite file YAML.
- **Pro:** Supporta moduli nativi pronti all'uso per l'igiene del repo e si esegue istantaneamente in locale (Shift-Left).
- **Contro:** Richiede che Python sia installato sulla macchina dello sviluppatore per il setup iniziale, violando il requisito di zero-dependencies locali.

### CSpell
Strumento di spell checking configurabile e orientato al codice.
- **Pro:** La dipendenza da Node.js viene gestita in modo isolato e invisibile dal runner (`prek`) in cache.
- **Pro:** La sua configurazione tramite file JSON lo rende estremamente scalabile per l'aggiunta di termini di dominio (es. Pharos), ignorando nativamente i costrutti sintattici di Typst.
- **Contro:** Richiede comunque il download in background di eseguibili JS.

### Husky
Strumento di gestione degli hook per l'ecosistema JavaScript/TypeScript.
- **Pro:** Standard diffusissimo nei progetti web.
- **Contro:** Impone l'inizializzazione di un ecosistema NPM (`package.json`, `node_modules`) a livello di repository, non giustificato per un progetto Typst.

### Script Bash Custom in CI
Automazione artigianale eseguita tramite workflow GitHub.
- **Pro:** Non richiede installazioni locali o dipendenze terze.
- **Contro:** Fallisce l'obiettivo Shift-Left (l'errore si scopre solo dopo il push) e viola il principio DRY frammentando gli script tra CI e OS locali.

### Typos / Vale
Alternative per spell checking e linting grammaticale.
- **Pro:** Typos è ultra-veloce (Rust); Vale permette controlli grammaticali avanzati.
- **Contro:** Typos genera troppi falsi positivi sull'italiano testuale. Vale richiede un setup di regole e regex troppo oneroso per adattarsi a Typst.

### Azione GitHub `setup-typst`
Binario Typst nativo eseguito nei runner di GitHub.
- **Pro:** Scarica l'eseguibile e compila in frazioni di secondo, massimizzando la velocità della CI.
- **Contro:** La versione di Typst utilizzata deve essere mantenuta manualmente nel file YAML.

### Container Docker (Immagine Typst)
Esecuzione della compilazione all'interno di un'immagine Docker ufficiale.
- **Pro:** Offre parità assoluta e riproducibilità totale.
- **Contro:** Rallenta inutilmente la pipeline a causa dei tempi di pull e avvio del container a ogni esecuzione.

### Commitizen
Strumento a riga di comando per redigere commit standardizzati.
- **Pro:** Assicura che il team segua la specifica dei Conventional Commits.
- **Pro:** Permette l'aggiornamento automatico e strutturato del `CHANGELOG.md`.
- **Contro:** Blocca i commit non formattati, creando potenziale frustrazione iniziale per chi non è abituato.

## Link

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [prek framework](https://prek.j178.dev)
- [Just (Task Runner)](https://just.systems/)
- [CSpell](https://cspell.org/)
- [Typst setup-typst Action](https://github.com/typst-community/setup-typst)
- [Commitizen](https://commitizen-tools.github.io/commitizen/)