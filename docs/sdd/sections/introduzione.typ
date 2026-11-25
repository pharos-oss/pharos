#import "../../templates/common.typ" : table-style, palette-primary

= Introduzione <introduzione>
Il presente documento descrive la progettazione tecnica del sistema *"Pharos"*, una piattaforma web finalizzata a facilitare l'individuazione e la segnalazione di episodi di molestie in ambito accademico supportando il Consigliere di Fiducia nello svolgimento delle proprie attività. L'SDD traduce i requisiti formalizzati nel Requirements Analysis Document (RAD) in decisioni architetturali concrete, definendo la decomposizione in sottosistemi, le strategie di mapping hardware/software e le politiche di sicurezza e persistenza dei dati.

== Obiettivi del sistema
Il sistema Pharos è progettato per raggiungere i seguenti obiettivi, derivati dai requisiti funzionali e non funzionali specificati nel RAD:

1. *Fornire un'interfaccia web accessibile e responsive che consenta agli utenti (studenti, personale docente e tecnico-amministrativo) di comporre e inviare segnalazioni relative a episodi di violenza di genere, stalking, mobbing, straining e abusi, mediante un percorso guidato e riservato.*

2. *Implementare il modulo di Triage IA per la classificazione semantica automatica delle segnalazioni, supportando l'utente nell'inquadramento preliminare dell'episodio e della sua gravità, senza sostituirsi alle figure istituzionali competenti.*

3. *Realizzare una dashboard riservata al Consigliere di Fiducia (CDF) per la gestione strutturata delle pratiche, il monitoraggio dello stato di avanzamento, la richiesta di integrazioni documentali e la generazione di report statistici aggregati.*

4. *Adottare misure per protezione dei dati personali e sensibili attraverso meccanismi di crittografia, anonimizzazione e controllo degli accessi nel rispetto della normativa GDPR (Regolamento UE 2016/679).*

5. *Assicurare la scalabilità e la manutenibilità dell'architettura, adottando pattern di decomposizione in sottosistemi che favoriscano l'indipendenza dei componenti e la possibilità di evoluzione incrementale.*

#pagebreak()

== Design Goals e Trade-off

== Definizioni, acronimi e abbreviazioni
#table(
  columns: 2,
  ..table-style(palette-primary),
  inset: 10pt,
  align:horizon,
  table.header(
   [*Nome*], 
   [*Definizione*],
  ),
  [SDD], [System Design Document — documento che descrive la progettazione tecnica del sistema, traducendo i requisiti del RAD in un'architettura software concreta],
  [RAD], [Requirements Analysis Document — documento che formalizza i requisiti funzionali e non funzionali del sistema],
  [BCE], [Boundary-Control-Entity — pattern architetturale per la decomposizione degli oggetti di analisi in oggetti di design],
  [API], [Application Programming Interface — interfaccia per la comunicazione tra componenti software],
  [Triage IA], [Modulo basato su intelligenza artificiale per la classificazione semantica delle segnalazioni, che supporta l'utente nell'inquadramento preliminare dell'episodio],
  [Safeguarding accademico], [Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze],
  [Diario delle evidenze], [Spazio confidenziale all'interno della piattaforma in cui la vittima può registrare, datare e raccogliere prove relative agli episodi di mobbing o molestie],
  [CUG], [Comitato Unico di Garanzia, organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo],
  [Consigliere di Fiducia], [Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie o mobbing],
  [GDPR], [General Data Protection Regulation — Regolamento UE 2016/679 sulla protezione dei dati personali]
)

#pagebreak()

== Riferimenti
- *Statement of Work (SoW) - Progetto Pharos:* Documento fondativo del progetto. Costituisce la fonte primaria per la definizione dello scope, dei vincoli, delle esclusioni e degli obiettivi di progetto concordati.

- *Requirements Analysis Document (RAD) - Progetto Pharos, V0.9:* Documento di analisi dei requisiti del sistema Pharos. Definisce i requisiti funzionali e non funzionali, gli scenari, i casi d'uso e il modello di sistema.

- *UniSAFE Survey - Gender-based violence and institutional responses (Version 1.0.0):* Lipinsky, A., Schredl, C., Baumann, H., Humbert, A. L., Tanwar, J., Bondestam, F., Freund, F., & Lomazzi, V. (2022). [Data set]. GESIS, Cologne. DOI: #link("https://doi.org/10.7802/2475")[10.7802/2475].

- *Linee Guida del CUG (Comitato Unico di Garanzia):* Documentazione e regolamenti interni di Ateneo relativi alle procedure di supporto, segnalazione e tutela del benessere lavorativo e studentesco. Disponibili sul portale istituzionale: #link("https://cug.unisa.it/normativa-di-riferimento")[Sezione CUG di Ateneo].

- *GDPR (Regolamento UE 2016/679):* Regolamento Generale sulla Protezione dei Dati. Riferimento normativo fondamentale per la definizione dei requisiti non funzionali di privacy, crittografia e anonimato delle segnalazioni gestite dal sistema. Testo ufficiale: #link("https://eur-lex.europa.eu/eli/reg/2016/679/oj")[EUR-Lex: Regolamento (UE) 2016/679].

- *Object-Oriented Software Engineering: Using UML, Patterns, and Java:* Bruegge, B., & Dutoit, A. H. (2013). Pearson, 3ª Edizione. Testo accademico adottato come linea guida metodologica per la strutturazione dell'architettura e la stesura della documentazione. ISBN: 978-1292024011.

== Panoramica del documento
Il presente *System Design Document* (SDD) ha lo scopo di descrivere le decisioni di progettazione tecnica della piattaforma *Pharos*, traducendo i requisiti formalizzati nel RAD in un'architettura software concreta e implementabile.

Il testo si rivolge al team di sviluppo e ai docenti del corso, fornendo una guida architetturale per le successive fasi di implementazione e testing.

Il documento è strutturato in modo da fornire una scomposizione progressiva delle scelte progettuali, partendo dal contesto attuale per arrivare alla definizione dei servizi dei sottosistemi, e si estende fino al class diagram ristrutturato. I capitoli successivi sono organizzati come segue:

- @introduzione: *Introduzione*: Presenta gli obiettivi del sistema, i design goal e trade-off, le definizioni, i riferimenti bibliografici e la presente struttura documentale.
- @architettura_corrente: *Architettura del Sistema Corrente*: Descrive l'organizzazione attuale del sistema in uso presso l'Ateneo, i componenti coinvolti e i relativi limiti strutturali.
- @architettura_proposta: *Architettura del Sistema Proposto*: Presenta la panoramica dell'architettura progettata per Pharos, evidenziandone i componenti principali e le relative interazioni.