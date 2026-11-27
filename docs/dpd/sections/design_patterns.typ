= Design Patterns <design_patterns>

In questo sezione vengono descritti i tre _design pattern_ utilizzati nella progettazione di Pharos, ovvero *Adapter* (@pattern_adapter), *State* (@pattern_state) e *Observer* (@pattern_observer). Pertanto, pattern *State* e *Observer* collaborano direttamente nella gestione delle pratiche poichè ogni transizione valida sul ciclo di vita innesca la notifica degli eventi a soli metadati verso gli osservatori registrati.

#include "patterns/adapter.typ"

#v(5em)

#include "patterns/state.typ"

#v(5em)

#include "patterns/observer.typ"