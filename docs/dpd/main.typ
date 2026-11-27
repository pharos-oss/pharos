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
  ("Riferimento", "DPD_Pharos"),
  ("Data", "27/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

// One row per change: (date, version, description, authors).
// The last row's version is the one shown in the footer.
#let revision-history = (
  ("27/11/2026", "0.1", "Stesura introduzione del documento e descrizione design pattern", "Carmine Saggese, Alessia D'Amico, Leonardo Trotta"), 
)

#show: doc-template.with(
  title: "Design Pattern Document",
  doc-type: "Progetto Pharos",
  reference: "DPD_Pharos",
  metadata: metadata,
  revision-history: revision-history,
  cover-logo-height: 9cm,
)
#show link: it => text(fill: blue, underline(it)) 
#show ref: set text(fill: blue)

#include "sections/introduzione.typ"

#pagebreak(weak: true)

= Design Patterns 

#include "sections/patterns/adapter.typ"

#include "sections/patterns/state.typ"

#include "sections/patterns/observer.typ"