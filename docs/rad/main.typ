// =============================================================================
// MAIN - standard document built with doc-template.
// Example document: copy this folder to start a real one (e.g. docs/example/).
// CLI: typst compile --root . example/main.typ
// =============================================================================
#import "../templates/template.typ": doc-template
#import "../templates/common.typ": info, warn, danger, table-style, readable-text, palette-primary
// Once copied into the docs repository, adjust the two imports above to the new
// location: with the submodule in `docs/templates/` and the document in
// `docs/example/`, they become:
//
//   #import "../templates/template.typ": doc-template
//   #import "../templates/common.typ": info, warn, danger, table-style, readable-text, palette-primary

// Cover metadata: one row per (label, value) pair; () omits the table.
// No "Versione" row: the template adds it from the last revision-history entry.
#let metadata = (
  ("Riferimento", "RAD_Pharos"),
  ("Data", "01/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

// One row per change: (date, version, description, authors).
// The last row's version is the one shown in the footer.
#let revision-history = (
  ("01/11/2026", "0.1", "Stesura introduzione del documento", "Gianmarco Raimondi, Carmine Saggese"),
  ("03/11/2026", "0.2", "Descrizione del sistema corrente", "Carmine Saggese, Francesco Imbriaco, Leonardo Trotta"),
  ("03/11/2026", "0.2", "Definizione del sistema proposto", "Alessia D'Amico, Gianmarco Raimondi, Mario Senatore"),
  ("06/11/2026", "0.3", "Stesura degli scenari utente 1 - 4", "Alessia D'Amico, Leonardo Trotta"),
  ("06/11/2026", "0.3", "Stesura degli scenari utente 5 - 8", "Carmine Saggese, Mario Senatore"),
  ("06/11/2026", "0.3", "Stesura degli scenari CDF", "Gianmarco Raimondi, Francesco Imbriaco"),
  ("07/11/2026", "0.4", "Definizione dei casi d'uso utente 1 - 2; Definizione dei casi d'uso utente 3 - 4", "Carmine Saggese, Alessia D'Amico, Gianmarco Raimondi, Leonardo Trotta"),
  ("07/11/2026", "0.4", "Definizione dei casi d'uso CDF", "Mario Senatore, Francesco Imbriaco"),
  ("09/11/2026", "0.5", "Stesura dei requisiti funzionali e non funzionali", "Tutti")
)

#show: doc-template.with(
  title: "Requirements Analysis Document",
  doc-type: "Progetto Pharos",
  reference: "RAD_Pharos",
  metadata: metadata,
  revision-history: revision-history,
)
#show link: it => text(fill: blue, underline(it)) 
#show ref: set text(fill: blue)

#include "sections/introduzione.typ"

#include "sections/sistema_corrente.typ"

#include "sections/sistema_proposto.typ"

#include "sections/requisiti_sistema.typ"

#include "sections/modelli_sistema.typ"