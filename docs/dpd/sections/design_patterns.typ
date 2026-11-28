= Design Patterns <design_patterns>

In questa sezione vengono descritti i tre _design pattern_ utilizzati nella progettazione di Pharos, ovvero *Adapter* (@pattern_adapter), *State* (@pattern_state) e *Observer* (@pattern_observer). Pertanto, i pattern *State* e *Observer* collaborano direttamente nella gestione delle pratiche poiché ogni transizione valida sul ciclo di vita innesca la notifica di eventi composti esclusivamente da metadati verso gli osservatori registrati.

#include "patterns/adapter.typ"

#include "patterns/state.typ"

#include "patterns/observer.typ"