#import "../templates/template.typ": doc-template
#import "../templates/common.typ": info, warn, danger, table-style, readable-text, palette-primary

#let metadata = (
  ("Riferimento", "SDD_Pharos"),
  ("Data", "21/11/2026"),
  ("Destinatario", ""),
  ("Presentato da", ""),
  ("Approvato da", ""),
)

#let revision-history = (
  ("21/11/2026", "0.1", "Stesura introduzione del documento", "Francesco Imbriaco, Leonardo Trotta"),
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

#include "sections/architettura_corrente.typ"