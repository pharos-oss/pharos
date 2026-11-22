# pharos

## Tools del Progetto

L'ecosistema di Pharos si basa su strumenti moderni e leggeri:

* **[Just](https://just.systems/) (`just`)**: Un task runner scritto in Rust. Funge da orchestratore per i comandi. Invece di ricordare lunghi comandi da terminale, utilizziamo ricette semplici e standardizzate.
* **[prek](https://github.com/jdx/prek)**: Un orchestratore di Git Hook ultraleggero. Controlla automaticamente ogni commit prima del salvataggio.
* **[CSpell](https://cspell.org)**: Un correttore ortografico orientato al codice. Verifica che non ci siano refusi nei documenti Typst, ignorandone la sintassi. Viene eseguito in background da `prek`.
* **[Commitizen](https://commitizen-tools.github.io/commitizen/)**: Uno strumento che impone le regole dei *Conventional Commits* (es. `feat: aggiunta sezione`, `fix: corretto refuso`). Viene eseguito in background da `prek`.
* **[Typst](https://typst.app/)**: Il compilatore documentale super-veloce che trasforma i nostri file sorgente (`.typ`) in PDF.

---

## Setup Iniziale

Per iniziare a contribuire, è necessario configurare gli hook locali. Sono stati preparati degli script automatici per facilitare questo processo.

**⚠️ Importante:** Gli script devono essere eseguiti rimanendo nella **root (cartella principale) del progetto**.

### Utenti macOS e Linux (Terminale)
```bash
chmod +x scripts/setup.sh

./scripts/setup.sh
```

**Post-Setup per Linux/macOS:**
Se lo script ha dovuto installare manualmente `just` o `prek` (senza usare `brew`), questi sono stati scaricati nelle tue cartelle utente locali (`~/bin` e `~/.local/bin`). 
Per poterli usare, **devi assicurarti che queste cartelle siano nel tuo `PATH` permanente**. 

Aggiungi queste due righe in fondo al file di configurazione della tua shell (`~/.bashrc` oppure `~/.zshrc`):
```bash
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
```
Salva il file e ricarica il terminale (oppure esegui `source ~/.bashrc` / `source ~/.zshrc`).

### Utenti Windows (PowerShell)
```powershell
.\scripts\setup.ps1
```

*(Lo script verificherà l'installazione dei binari e attiverà gli hook di `prek`. Non sono necessarie configurazioni manuali del PATH, Winget se ne occuperà automaticamente).*

---

## Flusso di Lavoro (Just Commands)

Una volta completato il setup, questi saranno i comandi utilizzabili:
> **Note per utenti Windows:** Utilizzate **Git Bash** o **WSL** per eseguire i comandi `just`. Evitate il Prompt dei Comandi (CMD) o PowerShell, poiché non riconoscono nativamente la sintassi Unix usata nel nostro `justfile`.

| Comando | Descrizione | Esempio |
|---------|-------------|---------|
| `just build <nome_doc>` | Compila un singolo documento specifico. | `just build rad` |
| `just build-all` | Compila massivamente tutti i documenti Typst in `docs/`. | `just build-all` |
| `just watch <nome_doc>` | Avvia la compilazione con live-reload a ogni salvataggio. | `just watch sdd` |
| `just lint` | Forza l'esecuzione manuale dei controlli di qualità sui file. | `just lint` |
| `just clean` | Svuota la cartella di output, eliminando i PDF generati. | `just clean` |
| `just` | Mostra a schermo la lista di tutti i comandi disponibili. | `just` |

---

## Regole di Qualità e Commit

Ad ogni `git commit`, `prek` verifica automaticamente i file modificati.

### 1. Formato dei Messaggi di Commit
Vengono utilizzati i *Conventional Commits*. Il formato richiesto è:
`<tipo>(<ambito>): <descrizione>` (l'ambito tra parentesi è facoltativo).

* **Tipi ammessi:** `feat`, `fix`, `docs`, `chore`, `refactor`, `ci`.
* **Esempi:** `docs(rad): aggiunta sezione requisiti` oppure `fix(sdd): corretto diagramma`.

### 2. Vincoli sui File e Ortografia
* **Dimensioni massime:** 1 MB sia per le immagini (`.png`, `.jpg`, `.svg`, ecc.) che per gli altri file.
* **Nomenclatura:** Bloccati i file che differiscono solo per maiuscole/minuscole o non validi su Windows.
* **Dizionario (CSpell):** Se un acronimo corretto o un termine tecnico viene segnalato come errore, va aggiunto alla lista `"words"` nel file `.cspell.json` nella root del progetto.

---

## CI/CD su GitHub Actions (Diff-Driven)

La remota ottimizza i tempi di esecuzione analizzando automaticamente i file modificati (`git diff`), indipendentemente dal titolo della Pull Request:

1. **Compilazione Mirata:** Se si modifica solo file dentro una cartella specifica (es. `docs/rad/`), la pipeline compila esclusivamente quel documento.
2. **Compilazione Massiva:** Se si modifica template condivisi o configurazioni globali (es. `justfile`), la pipeline forza la ricompilazione di tutti i PDF per prevenire regressioni.
3. **Skip Compilazione:** Se i commit riguardano esclusivamente l'infrastruttura di codice o script fuori dall'ambito documentale, la generazione di Typst viene saltata per risparmiare risorse.