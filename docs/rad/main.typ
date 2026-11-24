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
  ("Data", "23/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

// One row per change: (date, version, description, authors).
// The last row's version is the one shown in the footer.
#let revision-history = (
  ("01/11/2026", "0.1", "Stesura introduzione del documento", "Gianmarco Raimondi, Carmine Saggese"),
  ("03/11/2026", "0.2", "Definizione sistema corrente e sistema proposto", "Tutti i TM"),
  ("06/11/2026", "0.3", "Stesura degli scenari utente e CDF", "Tutti i TM"),
  ("07/11/2026", "0.4", "Definizione dei casi d'uso utente e CDF", "Tutti i TM"),
  ("09/11/2026", "0.5", "Stesura dei requisiti funzionali e non funzionali", "Tutti i TM"),
  ("12/11/2026", "0.6", "Stesura della tabella degli oggetti e del diagramma delle classi", "Francesco Imbriaco, Alessia D'Amico, Leonardo Trotta, Mario Senatore"),
  ("17/11/2026", "0.7", "Stesura dei diagrammi di sequenza", "Tutti i TM"),
  ("20/11/2026", "0.8", "Inserimento dei mockup e dei diagrammi navigazionali", "Francesco Imbriaco, Alessia D'Amico, Carmine Saggese, Leonardo Trotta"),
  ("20/11/2026", "0.9", "Inserimento del glossario", "Gianmarco Raimondi"),
  ("23/11/2026", "1.0", "Revisione finale", "Tutti i TM"),
)

#show: doc-template.with(
  title: "Requirements Analysis Document",
  doc-type: "Progetto Pharos",
  reference: "RAD_Pharos",
  metadata: metadata,
  revision-history: revision-history,
  cover-logo-height: 9cm,
)
#show link: it => text(fill: blue, underline(it)) 
#show ref: set text(fill: blue)

#pagebreak(weak: true)

#include "sections/introduzione.typ"

#pagebreak(weak: true)

#include "sections/sistema_corrente.typ"

#pagebreak(weak: true)

#include "sections/sistema_proposto.typ"

#pagebreak(weak: true)

#include "sections/requisiti_sistema.typ"

#pagebreak(weak: true)

#include "sections/modelli_sistema.typ"

#pagebreak(weak: true)

#include "sections/glossary.typ"