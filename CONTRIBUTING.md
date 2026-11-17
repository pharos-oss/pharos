# Linee Guida per la Contribuzione e Flusso di Lavoro
**Progetto Pharos**

Questo documento illustra nel dettaglio gli standard operativi, il flusso Git e le convenzioni di tracciamento stabilite dal Team per garantire un ciclo di sviluppo (SDLC) ordinato, tracciabile e di alta qualità.

## 1. Board Kanban e gestione dei task (GitHub Projects)
Il coordinamento e l'avanzamento dei lavori avvengono esclusivamente tramite la Kanban Board di GitHub Projects. Il ciclo di vita di ogni task attraversa obbligatoriamente le seguenti colonne:
- **Backlog:** Issue pianificate ma non ancora avviate.
- **Da fare (To Do):** Issue pronte per essere prese in carico nel breve termine.
- **In corso (In Progress):** Issue attualmente in lavorazione da parte di uno o più assegnatari.
- **In review:** Sviluppo terminato, Pull Request aperta e in attesa di approvazione/revisione.
- **Fatto (Done):** PR mergiata, codice integrato e issue chiusa.

*Nota:* Le segnalazioni di bug o comportamenti inattesi devono essere aperte tempestivamente dai team member sotto forma di Issue, utilizzando l'apposito template, affinché possano essere classificate nel Backlog.

## 2. Nomenclatura, Etichette (Labels) e tipologie di Issue
Ogni entità (Issue o PR) deve essere categorizzata con precisione utilizzando le seguenti label concordate:
- `feat`: Sviluppo di una nuova funzionalità.
- `bug`: Risoluzione di un comportamento inatteso o di un errore.
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
La struttura base da utilizzare è: `azione -> descrizione dell'azione` (es. `docs -> Creazione e correzioni ortografiche svolte sul Class Diagram`).


## 5. Pull Request (PR) e Code review
Ogni modifica al codice deve essere ispezionata. L'apertura di una PR deve rispettare i seguenti requisiti:
- **Assegnazione reviewer:** Sono obbligatori **sempre 2 reviewer** (sia per task minori che per core-features).
- **Approvazione Project Manager (PM):** Il merge è subordinato all'autorizzazione finale esplicita da parte dei PM.
- **SLA (Service Level Agreement) per le Code review:**

  - *Modifiche Critiche / Core:* La review deve essere completata entro **24 ore** dall'apertura della PR.
  - *Modifiche Standard / Minori:* La review deve essere completata entro e non oltre **48 ore**.

## 6. Politiche di Merge
Il merge effettivo della Pull Request è demandato al reviewer del codice o all'Accountable, il quale agirà solo dopo aver ottenuto il via libera dai PM. Le strategie di merge dipendono dal branch di destinazione:
- **Verso `dev`:** È richiesto/consigliato l'utilizzo di **Merge commit classico**.
- **Verso `main`:** Si utilizza un **Merge Commit classico** per preservare l'integrità del rilascio integrato da `dev`.