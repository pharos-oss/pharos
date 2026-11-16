# ADR 001: Standardizzazione dei Commit e Automazione della Pipeline CI per la Documentazione Typst

- **Stato:** Proposto
- **Autori:** Gianmarco Raimondi, Mario Senatore, Francesco Imbriaco
- **Data:** 09-11-2026

## Contesto e enunciato del problema

Attualmente, le revisioni delle Pull Request per la documentazione RAD avvengono in modo manuale. I revisori investono tempo prezioso nell'identificare errori banali, quali refusi ortografici, file binari non autorizzati o commit con messaggi non semantici. Manca inoltre un tollgate automatico che certifichi la corretta compilazione del codice Typst prima del merge. 
Come possiamo automatizzare il processo applicando il paradigma *Shift-Left*, bloccando gli errori direttamente sulla macchina dello sviluppatore e garantendo un controllo di qualità immutabile lato server?

## Fattori determinanti della decisione

- Riduzione del tempo speso in revisioni manuali (code review) per questioni formali o stilistiche.
- Feedback istantaneo per lo sviluppatore per evitare i tempi di esecuzione in cloud.
- Indipendenza dal linguaggio (il progetto usa Typst, è preferibile evitare l'inserimento forzato di framework Node.js o Python come dipendenze di sistema).
- Tracciabilità semantica della cronologia Git per facilitare la gestione del progetto e la reportistica.
- Riproducibilità e scalabilità: l'infrastruttura deve garantire risultati identici nel tempo, indipendentemente dagli aggiornamenti futuri dei tool.

## Opzioni considerate

- Orchestrazione: `pre-commit` (Framework agnostico)
- Orchestrazione: Husky (Ecosistema Node.js)
- Orchestrazione: Script Bash custom su GitHub Actions
- Validazione Typst: Azione GitHub nativa (`setup-typst`)
- Validazione Typst: Esecuzione tramite container Docker ufficiale Typst
- Spell Checking: CSpell
- Spell Checking: Typos (crate-ci, in Rust)
- Spell Checking: Vale
- Standardizzazione Git: `commitizen` integrato nei git hook

## Esito della decisione

Opzione scelta: **Architettura ibrida con `pre-commit` (locale) e GitHub Actions (remoto), integrando `setup-typst`, `CSpell` e `commitizen`**, perché bilancia l'immediatezza del feedback in locale con la sicurezza di una validazione in remoto. `pre-commit` gestisce i controlli su dimensioni e naming dei file alla radice in modo agnostico. `setup-typst` certifica la compilazione ultra-rapida in CI. `CSpell` garantisce flessibilità con dizionari italiani e di dominio (es. Pharos). Infine, `commitizen` viene adottato non solo per forzare i Conventional Commits, ma perché permette di aggiornare in automatico il file `CHANGELOG.md`, offrendo un tracciamento storico inestimabile senza alcuno sforzo manuale.

### Conseguenze positive

- PR pulite: i revisori possono concentrarsi sul contenuto architetturale e non sui refusi.
- Nessun file "spazzatura" o eccessivamente pesante (es. immagini > 1MB) finirà nel repository.
- Generazione e aggiornamento automatico del file `CHANGELOG.md`, migliorando la visibilità degli aggiornamenti per l'utente finale e gli stakeholder.
- Tempi di CI estremamente ridotti grazie all'uso di `setup-typst` anziché Docker.

### Conseguenze negative

- Leggero attrito inziale per il team di sviluppo che dovrà abituarsi a formattare rigidamente i messaggi di commit secondo le regole di `commitizen`.
- Necessità per ogni sviluppatore di installare `pre-commit` sulla propria macchina.

## Pro e contro delle opzioni considerate

### pre-commit
Framework per la gestione dei git hook, configurabile tramite file YAML.
- **Pro:** supporta moduli nativi pronti all'uso per l'igiene del repo (es. `check-added-large-files`).
- **Pro:** si esegue istantaneamente in locale prima della creazione del commit (Shift-Left).
- **Contro:** richiede che Python sia installato sulla macchina dello sviluppatore per il setup iniziale del framework.

### CSpell
Strumento di spell checking configurabile e orientato al codice.
- **Pro:** l'apparente svantaggio della dipendenza da Node.js viene neutralizzato dall'architettura di `pre-commit`. Il framework utilizza `nodeenv` per scaricare e confinare un ambiente Node minimale in una cache locale isolata.
- **Pro:** la sua configurazione testuale (file JSON per i dizionari) e l'uso rigoroso del *version pinning* nei git hook lo rendono estremamente scalabile. Se la terminologia cresce o se si aggiungono nuovi membri, il tool mantiene le stesse performance e lo stesso comportamento deterministico.
- **Pro:** gestisce eccellentemente l'italiano ed riesce a parsare i file `.typ` ignorando i costrutti sintattici.
- **Contro:** richiede comunque il download di eseguibili JS (seppur automatizzato e nascosto), risultando leggermente più pesante in termini di spazio su disco rispetto a binari nativi (es. Typos).

### Husky
Strumento di gestione degli hook per l'ecosistema JavaScript/TypeScript.
- **Pro:** è uno standard molto diffuso nei progetti web e facile da configurare.
- **Contro:** al contrario di `pre-commit`, Husky non isola l'ambiente: impone formalmente l'inizializzazione di un ecosistema NPM (`package.json`, `node_modules`) a livello di repository, una dipendenza architetturale ingiustificata per un progetto basato su Typst.

### Script Bash Custom in CI
Automazione artigianale eseguita tramite workflow GitHub.
- **Pro:** non richiede installazioni locali o dipendenze terze.
- **Contro:** fallisce l'obiettivo Shift-Left: l'errore viene notificato solo dopo il push, obbligando lo sviluppatore a fare commit di puro fix (es. "rimosso file pesante").

### Typos
Correttore ortografico ultra-veloce scritto in Rust.
- **Pro:** è estremamente performante e non richiede configurazione per il codice sorgente.
- **Contro:** è ottimizzato per l'inglese tecnico (nomi di variabili, funzioni) e genera continui falsi positivi valutando paragrafi di prosa descrittiva in italiano.

### Vale
Linter sintattico e grammaticale basato su Style Guide.
- **Pro:** permette controlli avanzati (es. divieto di uso della forma passiva).
- **Contro:** richiede un setup oneroso con regex complesse per adattarsi perfettamente alla sintassi non convenzionale di Typst.

### Azione GitHub `setup-typst`
Binario Typst nativo eseguito direttamente nei runner Ubuntu di GitHub.
- **Pro:** scarica l'eseguibile e compila in frazioni di secondo, massimizzando la velocità della CI.
- **Contro:** la versione di Typst utilizzata deve essere mantenuta nel file YAML (sebbene questo contribuisca al determinismo del version pinning).

### Container Docker (Immagine Typst)
Esecuzione della compilazione all'interno di un'immagine Docker ufficiale.
- **Pro:** offre parità assoluta e riproducibilità totale tra l'ambiente di sviluppo e la pipeline CI.
- **Contro:** rallenta inutilmente la pipeline a causa dei tempi di pull e avvio del container a ogni commit.

### Commitizen
Strumento a riga di comando per redigere commit standardizzati.
- **Pro:** assicura che il team segua la specifica dei Conventional Commits.
- **Pro:** permette l'aggiornamento automatico e strutturato del `CHANGELOG.md`.
- **Contro:** blocca i commit non formattati, creando potenziale frustrazione iniziale

## Link

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [pre-commit framework](https://pre-commit.com/)
- [CSpell](https://cspell.org/)
- [Typst setup-typst Action](https://github.com/typst-community/setup-typst)
- [Commitizen](https://commitizen-tools.github.io/commitizen/)