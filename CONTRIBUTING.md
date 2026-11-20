# Linee Guida per la Contribuzione e Flusso di Lavoro
**Progetto Pharos**

Questo documento illustra nel dettaglio gli standard operativi, il flusso Git e le convenzioni di tracciamento stabilite dal Team per garantire un ciclo di sviluppo (SDLC) ordinato, tracciabile e di alta qualità.

## 1. Board Kanban e gestione dei task (GitHub Projects)
Il coordinamento e l'avanzamento dei lavori avvengono esclusivamente tramite la Kanban Board di GitHub Projects. Il ciclo di vita di ogni task attraversa obbligatoriamente le seguenti colonne:
- **Backlog:** Issue pianificate ma non ancora avviate.
- **To Do:** Issue pronte per essere prese in carico nel breve termine.
- **In Progress:** Issue attualmente in lavorazione da parte di uno o più assegnatari.
- **In Review:** Sviluppo terminato, Pull Request aperta e in attesa di approvazione/revisione.
- **Done:** PR mergiata, codice integrato e issue chiusa.

*Nota:* Le segnalazioni di bug o comportamenti inattesi devono essere aperte tempestivamente dai team member sotto forma di Issue, utilizzando l'apposito template, affinché possano essere classificate nel Backlog.

## 2. Nomenclatura, Etichette (Labels) e tipologie di Issue
Ogni entità (Issue o PR) deve essere categorizzata con precisione utilizzando le seguenti label concordate:
- `feat`: Sviluppo di una nuova funzionalità.
- `fix`: Risoluzione di un comportamento inatteso o di un errore.
- `docs`: Modifiche, aggiunte o refactoring della documentazione.
- `test`: Creazione o aggiornamento di test (unit, integration, e2e).
- `refactor`: Ristrutturazione del codice senza alterazione del comportamento esterno.
- `CI/CD`: Modifiche a pipeline, automazioni o workflow di GitHub Actions.

## 3. Strategia di branching e protezione (Gitflow)
Il repository adotta una strategia Gitflow classica adattata alle nostre esigenze di Continuous Integration, regolata da strict **Branch Protections**:
- **Nessun push diretto:** È severamente vietato pushare codice direttamente sui branch `main` e `dev`. Qualsiasi integrazione richiede obbligatoriamente l'apertura di una Pull Request.
- `main`: Branch di produzione. Contiene unicamente codice stabile, testato e rilasciabile.
- `dev`: Branch di sviluppo e integrazione. Raccoglie tutte le feature e i fix in vista della prossima release.
- **Branch di lavoro:** Per ogni Issue presa in carico, lo sviluppatore deve staccare un nuovo branch partendo **sempre da `dev`**. La denominazione deve rispettare rigorosamente la specifica **[Conventional Branch](https://conventionalbranch.org/)**.

- Formato nomenclatura: `tipo/nome-issue` (es. `feat/autenticazione-utente` oppure `fix/crash-login`).

## 4. Convenzioni per i messaggi di commit
Per mantenere una *history* chiara e navigabile, ogni commit deve seguire rigorosamente la specifica **[Conventional Commits v1.0.0](https://www.conventionalcommits.org/it/v1.0.0/)**.
La struttura base da utilizzare è: tipo: descrizione (es. docs: Creazione e correzioni ortografiche svolte sul Class Diagram).


## 5. Pull Request (PR) e Code review
Ogni modifica al codice deve essere ispezionata. L'apertura di una PR deve rispettare i seguenti requisiti:
- **Assegnazione reviewer:** Sono obbligatori **sempre 2 reviewer** (1 TM e 1 PM),sia per task minori che per core-features.
- **Approvazione Project Manager (PM):** Il merge è subordinato all'autorizzazione finale esplicita da parte dei PM.
- **SLA (Service Level Agreement) per le Code review:**

  - *Modifiche Critiche / Core:* La review deve essere completata entro **24 ore** dall'apertura della PR.
  - *Modifiche Standard / Minori:* La review deve essere completata entro e non oltre **36 ore**.

## 6. Politiche di Merge
Il merge effettivo della Pull Request è demandato al reviewer del codice o all'Accountable, il quale agirà solo dopo aver ottenuto il via libera dai PM. Le strategie di merge dipendono dal branch di destinazione:
- **Verso `dev`:** È obbligatorio l'utilizzo di un **Merge commit classico**.
- **Verso `main`:** Si utilizza un **Merge Commit classico** per preservare l'integrità del rilascio integrato da `dev`.


## 7. Pull Request review checklist (Criteri di Validazione)
Per approvare una Pull Request, i reviewer devono accertarsi che rispetti i seguenti criteri definiti nel documento PRCheck_Pharos, dunque dovranno marcare come [x] se verificato o N/A se non applicabile (giustificando nei commenti).

**P1 - Bloccanti e Automazione**
- **RC1:** Pipeline CI/CD: tutti i check automatici (linter, formattatori, test, build) risultano verdi.
- **RC2:** Compilabilità e Rendering: l'app e i documenti compilano senza errori o warning bloccanti.
- **RC3:** Stato del Branch: aggiornato rispetto al target e senza conflitti.
- **RC4:** Scope e Atomicità: risolve un singolo task, ha un titolo esplicativo e non include modifiche fuori contesto.

**P2 - Requisiti e Coerenza**
- **RC5:** Copertura Requisiti: soddisfatti i criteri di accettazione ed edge case gestiti.
- **RC6:** Allineamento con l'Esistente: integrazione coerente senza contraddire docs/codice preesistenti.
- **RC7:** Allineamento Testo/Diagrammi: flussi e componenti coincidono con i diagrammi PlantUML.
- **RC8:** Allineamento Design/Implementazione: architettura e codice rispecchiano le specifiche (o doc aggiornata).

**P3 - Correttezza Tecnica e Output**
- **RC9:** Assenza Codice Morto: nuovo codice invocato e nuovi file inclusi correttamente.
- **RC10:** Qualità e Leggibilità: codice modulare; prosa documentale chiara; diagrammi leggibili.
- **RC11:** Correttezza Formale: rispetto principi architetturali, riferimenti dinamici Typst e UML 2.x.
- **RC12:** Test e Tracciabilità: test automatici presenti e passanti; requisiti coperti.
- **RC13:** Verifica Output: controllo pratico del risultato.

**P4 - Standard e Igiene**
- **RC14:** Uniformità e Template: registro e struttura coerenti, rispetto dei template Typst.
- **RC15:** Naming e Glossario: identificatori e nomi file coerenti con il Glossario.
- **RC16:** Metadati e Storico: aggiornamento della tabella revisioni/changelog se applicabile.
- **RC17:** Igiene del Repository: assenza di file temporanei, codice commentato, TODO non tracciati.