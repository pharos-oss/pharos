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
  ("Riferimento", "SDD_Pharos"),
  ("Data", "19/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

// One row per change: (date, version, description, authors).
// The last row's version is the one shown in the footer.
#let revision-history = (
  ("21/11/2026", "0.1", "Stesura introduzione del documento", "Francesco Imbriaco, Leonardo Trotta"),
    ("23/11/2026", "0.2", "Stesura sezioni design goals e trade offs", "Tutti i TM"),
  ("24/11/2026", "0.3", "Stesura dell'Architettura del sistema corrente e della Panoramica del sistema proposto", "Carmine Saggese"),
)

#show: doc-template.with(
  title: "System Design Document",
  doc-type: "Progetto Pharos",
  reference: "SDD_Pharos",
  metadata: metadata,
  revision-history: revision-history,
)
#show link: it => text(fill: blue, underline(it)) 
#show ref: set text(fill: blue)

#include "sections/introduzione.typ"

#pagebreak(weak: true)

#include "sections/architettura_corrente.typ"

#pagebreak(weak: true)

#include "sections/architettura_proposta.typ"