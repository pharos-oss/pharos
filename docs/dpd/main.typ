// =============================================================================
// MAIN - Design Pattern Document (DPD_Pharos)
// CLI: typst compile --root . dpd/main.typ
// =============================================================================
#import "../templates/template.typ": doc-template

#let metadata = (
  ("Riferimento", "DPD_Pharos"),
  ("Data", "27/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

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

#include "sections/design_patterns.typ"