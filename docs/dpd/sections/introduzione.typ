#import "../../templates/common.typ": table-style, palette-primary

= Introduzione <introduzione>

Il presente *Design Pattern Document (DPD)* formalizza e giustifica le scelte di progettazione dettagliata basate su _design pattern_ orientati agli oggetti adottate per la piattaforma *Pharos*. Il documento si colloca a valle della definizione dei requisiti nel *Requirements Analysis Document (RAD)* e della decomposizione architetturale nel *System Design Document (SDD)*, fungendo da ponte tra l'architettura ad alto livello e l'implementazione del codice sorgente.

In conformità con i principi di buona ingegneria del software, la selezione dei pattern segue un approccio rigorosamente guidato dai problemi reali del dominio (_problem-driven_), evitando fenomeni di _over-engineering_ o l'introduzione forzata di astrazioni non necessarie. Vengono pertanto documentati esclusivamente i *tre design pattern principali* che risolvono criticità strutturali e comportamentali concrete di Pharos, ciascuno corredato da:

- Categoria di appartenenza secondo la tassonomia _Gang of Four (GoF)_;
- Contesto applicativo, problema progettuale affrontato e motivazione della scelta;
- Struttura tramite diagramma delle classi UML;
- Mappatura puntuale dei ruoli del pattern sui componenti e sulle entità reali di Pharos;
- Analisi delle conseguenze in termini di vantaggi architetturali e _trade-off_;

== Contesto del progetto e vincoli progettuali
*Pharos* è una piattaforma digitale progettata per l'Università degli Studi di Salerno a supporto delle attività di _safeguarding_ accademico coordinate dal Comitato Unico di Garanzia (CUG) e dal Consigliere di Fiducia (CDF). Il sistema consente a studenti e personale universitario di:

- documentare episodi in modo riservato mediante un *Diario delle evidenze* protetto da cifratura _End-to-End_ (E2EE) lato client;

- effettuare un inquadramento preliminare non vincolante tramite un modulo di *Triage Guidato* basato su Intelligenza Artificiale, preceduto da de-identificazione _on-device_;

- inoltrare e seguire segnalazioni formali verso il *CDF*, con gestione strutturata del ciclo di vita della pratica, notifiche prive di dati sensibili e reportistica aggregata per il CUG.

L'architettura multi-tier definita nell'SDD impone vincoli stringenti su tre direttrici principali, che guidano direttamente la scelta dei design pattern descritti in questo documento:

1. *Indipendenza dal motore IA e conformità normativa:* il supporto sia a modelli _on-premise_ sia a provider IA esterni vincolati da DPA (art. 28 GDPR), area SEE e clausola _Zero-Retention_ richiede un disaccoppiamento netto tra la logica applicativa di triage e l'infrastruttura di inferenza.

2. *Integrità del ciclo di vita e immutabilità legale:* la lavorazione di una `Pratica` attraversa sei stati ben definiti e deve garantire strutturalmente il blocco in sola lettura (_read-only_) una volta raggiunti gli stati terminali (`Chiusa` e `Archiviata`).

3. *Separazione degli effetti trasversali e minimizzazione dei dati:* gli eventi di aggiornamento e accesso alle pratiche devono alimentare in modo disaccoppiato sia il sistema di notifiche verso l'Utente sia l'Audit Log Immodificabile (WORM con _hash-chaining_), impedendo la propagazione di contenuti sensibili in chiaro.

== Riferimenti
- *RAD\_Pharos (V1.0, 23/11/2026):* _Requirements Analysis Document - Progetto Pharos_. Specifica dei requisiti funzionali (`RF`), non funzionali (`RNF`), casi d'uso, modello degli oggetti e diagrammi di stato.

- *SDD\_Pharos (V0.4):* _System Design Document - Progetto Pharos_. Definizione dei design goal, risoluzione dei trade-off architetturali, architettura proposta e decomposizione in sottosistemi.

- *Bruegge, B., & Dutoit, A. H. (2013):* _Object-Oriented Software Engineering: Using UML, Patterns, and Java_ (3ª ed.). Pearson.

- *Regolamento (UE) 2016/679 (GDPR)* e *Regolamento (UE) 2024/1689 (AI Act):* quadro normativo di riferimento per privacy-by-design, minimizzazione dei dati e sistemi di IA.

#v(5em
)

== Panoramica del documento
La tabella seguente riepiloga i tre design pattern selezionati e il loro posizionamento rispetto all'architettura definita nell'SDD e ai requisiti del RAD.

#table(
  columns: (0.85fr, 1fr, 1.8fr, 1.5fr),
  ..table-style(palette-primary),
  inset: 7pt,
  align: horizon,
  table.header(
    [*Pattern*],
    [*Categoria GoF*],
    [*Problema risolto in Pharos*],
    [*Sottosistemi SDD e Requisiti RAD*],
  ),
  [*Adapter*],
  [Strutturale],
  [Disaccoppia il sottosistema _Triage Guidato_ dall'implementazione del motore IA (_on-premise_ o provider esterno con DPA e _Zero-Retention_), isolando formati API e controlli di conformità.],
  [Triage Guidato, Modulo IA di Triage (`RF_GU_10`, `RNF_IM_02`, `RNF_L_01`, `RNF_P_01`)],
  [*State*],
  [Comportamentale],
  [Incapsula regole di transizione e operazioni lecite per i sei stati della `Pratica` (_Inviata_, _Presa in carico_, _In lavorazione_, _In attesa di integrazioni_, _Chiusa_, _Archiviata_), garantendo il blocco _read-only_ sugli stati terminali.],
  [MO\_GU, MO\_GCDF, Persistenza Dati (`RF_GU_04`–`06`, `RF_GU_08`–`09`, `RF_GCDF_01`–`06`, `RNF_A_02`)],
  [*Observer*],
  [Comportamentale],
  [Disaccoppia la logica di lavorazione delle pratiche dalla generazione di notifiche anonime verso l'Utente e dalla registrazione _append-only_ dei metadati sull'_Audit Log Immodificabile_.],
  [MO\_GU, MO\_GCDF, Gestione Notifiche, Audit Log Immodificabile (`RF_GU_07`, `RNF_L_02`, `RNF_S_01`)],
)