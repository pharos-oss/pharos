#import "../../templates/common.typ" : table-style, palette-primary

= Introduzione <introduzione>
Il presente documento descrive la progettazione tecnica del sistema Pharos, una piattaforma digitale articolata in un'applicazione mobile per gli utenti e un'applicazione web per il Consigliere di Fiducia, finalizzata a facilitare l'individuazione e la segnalazione di eventi di molestie in ambito accademico. L'SDD traduce i requisiti formalizzati nel Requirements Analysis Document (RAD) in decisioni architetturali concrete, definendo la decomposizione in sottosistemi, le strategie di _mapping_ hardware/software e le politiche di sicurezza e persistenza dei dati.

== Obiettivi del sistema
Il sistema Pharos è progettato per raggiungere i seguenti obiettivi, derivati dai requisiti funzionali e non funzionali specificati nel RAD:

1. *Fornire un'applicazione mobile accessibile e intuitiva che consenta agli utenti (studenti, personale docente e tecnico-amministrativo) di annotare eventi nel diario delle evidenze, consultare i servizi territoriali e comporre e inviare segnalazioni relative a eventi di violenza di genere, _stalking_, _mobbing_, _straining_ e abusi, mediante un triage guidato e riservato.*

2. *Implementare il modulo IA di triage guidato per la classificazione semantica automatica degli eventi, supportando l'utente nell'inquadramento preliminare dell'evento e della sua gravità, senza sostituirsi alle figure istituzionali competenti.*

3. *Realizzare un'applicazione web (_dashboard_) riservata al Consigliere di Fiducia (CDF) per la gestione strutturata delle pratiche, il monitoraggio dello stato di avanzamento, la richiesta di integrazioni documentali e la generazione di report statistici aggregati.*

4. *Adottare misure rigorose per la protezione dei dati personali e sensibili attraverso meccanismi di crittografia (locale ed _End-to-End_), anonimizzazione e controllo degli accessi federato, nel rispetto del GDPR (Regolamento UE 2016/679) e dell'AI Act (Regolamento UE 2024/1689).*

5. *Assicurare la scalabilità e la manutenibilità dell'architettura, adottando _pattern_ di decomposizione in sottosistemi che favoriscano l'indipendenza dei componenti e la possibilità di evoluzione incrementale.*

#pagebreak()

== Design goals
#include "design_goals/design_goals.typ"

== Trade offs
#include "design_goals/trade_offs.typ"

#pagebreak()

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
  [BCE], [Boundary-Control-Entity — _pattern_ architetturale per la decomposizione degli oggetti di analisi in oggetti di design],
  [API], [Application Programming Interface — interfaccia per la comunicazione tra componenti software],
  [Triage Guidato], [Modulo basato su intelligenza artificiale per la classificazione semantica delle segnalazioni, che supporta l'utente nell'inquadramento preliminare dell'evento],
  [_Safeguarding_ accademico], [Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze],
  [Diario delle evidenze], [Spazio confidenziale all'interno della piattaforma in cui l'utente può registrare, datare e raccogliere prove relative agli eventi di _mobbing_ o molestie],
  [CUG], [Comitato Unico di Garanzia, organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo],
  [Consigliere di Fiducia], [Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie o _mobbing_],
  [GDPR], [General Data Protection Regulation — Regolamento (UE) 2016/679 sulla protezione dei dati personali e sulla privacy],
  [AI Act], [_Artificial Intelligence Act_ — Regolamento (UE) 2024/1689 che stabilisce regole armonizzate sull'intelligenza artificiale nell'Unione Europea, classificando i sistemi in base al rischio e imponendo vincoli di trasparenza, tracciabilità e tutela dei diritti fondamentali]
)

#pagebreak()

== Riferimenti
- *Statement of Work (SoW) - Progetto Pharos:* Documento fondativo del progetto. Costituisce la fonte primaria per la definizione dello _scope_, dei vincoli, delle esclusioni e degli obiettivi di progetto concordati.

- *Requirements Analysis Document (RAD) - Progetto Pharos, V1.0 (23/11/2026):* Documento di analisi dei requisiti del sistema Pharos. Definisce i requisiti funzionali e non funzionali, gli scenari, i casi d'uso e il modello di sistema.

- *UniSAFE Survey - Gender-based violence and institutional responses (Version 1.0.0):* Lipinsky, A., Schredl, C., Baumann, H., Humbert, A. L., Tanwar, J., Bondestam, F., Freund, F., & Lomazzi, V. (2022). [Data set]. GESIS, Cologne. DOI: #link("https://doi.org/10.7802/2475")[10.7802/2475].

- *Linee Guida del CUG (Comitato Unico di Garanzia):* Documentazione e regolamenti interni di Ateneo relativi alle procedure di supporto, segnalazione e tutela del benessere lavorativo e studentesco. Disponibili sul portale istituzionale: #link("https://cug.unisa.it/normativa-di-riferimento")[Sezione CUG di Ateneo].

- *GDPR (Regolamento UE 2016/679):* Regolamento Generale sulla Protezione dei Dati. Riferimento normativo fondamentale per la definizione dei requisiti non funzionali di privacy, crittografia e anonimato delle segnalazioni gestite dal sistema. Testo ufficiale: #link("https://eur-lex.europa.eu/eli/reg/2016/679/oj")[EUR-Lex: Regolamento (UE) 2016/679].

- *AI Act (Regolamento UE 2024/1689):* Regolamento europeo sull'intelligenza artificiale. Riferimento normativo per la governance, la trasparenza, la non ritenzione dei dati e la supervisione umana del modulo ausiliario di Triage IA. Testo ufficiale: #link("https://eur-lex.europa.eu/eli/reg/2024/1689/oj")[EUR-Lex: Regolamento (UE) 2024/1689].

- *Object-Oriented Software Engineering: Using UML, Patterns, and Java:* Bruegge, B., & Dutoit, A. H. (2013). Pearson, 3ª Edizione. Testo accademico adottato come linea guida metodologica per la strutturazione dell'architettura e la stesura della documentazione. ISBN: 978-1292024011.

== Panoramica del documento
Il presente System Design Document (SDD) ha lo scopo di descrivere le decisioni di progettazione tecnica del sistema Pharos, traducendo i requisiti formalizzati nel RAD in un'architettura software concreta e implementabile.

Il testo si rivolge al team di sviluppo e ai docenti del corso, fornendo una guida architetturale per le successive fasi di implementazione e _testing_.

Il documento è strutturato in modo da fornire una scomposizione progressiva delle scelte progettuali, partendo dal contesto attuale per arrivare alla definizione dei servizi dei sottosistemi, e si estende fino al _class diagram_ ristrutturato. I capitoli successivi sono organizzati come segue:

- @introduzione: *Introduzione*: Presenta gli obiettivi del sistema, i _design goal_ e _trade-off_, le definizioni, i riferimenti bibliografici e la presente struttura documentale.
- @architettura_corrente: *Architettura del Sistema Corrente*: Descrive l'organizzazione attuale del sistema in uso presso l'Ateneo, i componenti coinvolti e i relativi limiti strutturali.
- @architettura_proposta: *Architettura del Sistema Proposto*: Presenta la panoramica dell'architettura progettata per Pharos, evidenziandone i componenti principali e le relative interazioni.
- @decomposizione_sottosistemi: *Decomposizione in sottosistemi*: Illustra l'articolazione a livelli del sistema, le responsabilità dei singoli sottosistemi e la tracciabilità rispetto ai requisiti del RAD, corredate dai diagrammi delle dipendenze e dell'architettura.
- @mappatura_hw_sw: *Mappatura Hardware/Software*: Chiarisce la distribuzione del sistema e le relazioni tra le sue componenti software e l’infrastruttura hardware, offrendo un riferimento per la progettazione e l’implementazione.