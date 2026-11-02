#import "../../templates/common.typ" : table-style, palette-primary

= Introduzione
Il presente documento definisce le specifiche e i requisiti per *"Pharos"*, una piattaforma web progettata per abilitare il safeguarding all'interno del contesto accademico.

== Scopo del sistema 
 Lo scopo primario del sistema è fornire all'intera comunità universitaria uno strumento digitale integrato e confidenziale per prevenire, documentare e contrastare fenomeni di violenza di genere, stalking, mobbing, straining e abusi. Offrendo un ambiente sicuro e procedurizzato, Pharos supporta le vittime nel percorso di presa di consapevolezza, tracciamento degli eventi e richiesta di assistenza istituzionale, concretizzando operativamente il principio fondante del progetto: "Mai più soli".

== Ambito del sistema (Scope)
Il sistema Pharos gestirà l'intero ciclo di tutela istituzionale interno all'ateneo. Pertanto, i confini del sistema includono le seguenti funzionalità:

- *Un modulo di triage guidato, utile per l'inquadramento preliminare e consapevole dell'episodio da parte dell'utente.*

- *Un "diario delle evidenze" personale, volto a consentire la storicizzazione cronologica e sicura di atti discriminatori o abusanti.*

- *L'implementazione di un hub di assistenza diretta che centralizzi e faciliti il primo contatto, il supporto psicologico tramite counseling e l'inoltro di segnalazioni protette agli organi preposti.*

- *L'integrazione di un modulo accessorio basato su intelligenza artificiale per la classificazione semantica automatica delle segnalazioni.*

- *La realizzazione di un iter di gestione formale delle segnalazioni, per avviare e monitorare in modo strutturato le pratiche verso il Consigliere di Fiducia, garantendo trasparenza sullo stato di avanzamento*

Il sistema Pharos, d'altronde, non funge da sostituto formale alle denunce presso le Forze dell'ordine, ma opera esclusivamente come strumento di supporto psicologico, documentazione preventiva e raccordo istituzionale con figure di garanzia interne, quali il Consigliere di Fiducia e il CUG.

== Obiettivi e criteri di successo 
La progettazione di Pharos risponde alle criticità sistemiche evidenziate dallo studio europeo UniSAFE, secondo cui, sebbene il 62% della comunità accademica abbia subito violenze, il tasso di segnalazione istituzionale è fermo al 13%. Il successo della piattaforma, quindi, è legato al raggiungimento dei seguenti obiettivi misurabili:

1. *Incrementare il tasso globale di segnalazione interna colmando il gap informativo, facilitando l'accesso alle informazioni, e quindi riducendo l'incidenza (attualmente pari al 17%) degli utenti che dichiarano di non sapere a quale figura di garanzia rivolgersi.*
 
2. *Attenuare l'esitazione psicologica antecedente alla denuncia mediante il triage guidato, diminuendo la percentuale di vittime che non considerano l'episodio sufficientemente grave (47%) o che non riescono a riconoscere autonomamente il comportamento come abuso (31%).*

3. *Offrire un canale di comunicazione confidenziale e protetto capace di abbattere le resistenze legate al timore di ritorsioni, fattore che attualmente dissuade il 12% delle vittime.*

#block(breakable: false)[
4. *Contrastare la percezione di inefficacia istituzionale, fattore che attualmente frena il 26% delle vittime, convinte dell'inutilità della segnalazione, garantendo la totale trasparenza dell'iter e la tracciabilità della pratica da parte dell'utente."*

5. *Colmare il divario di segnalazione tra le diverse componenti accademiche, focalizzandosi sulle fasce più vulnerabili, in particolare gli studenti, il cui tasso di denuncia (7%) risulta attualmente molto inferiore rispetto a quello del personale universitario (23%).*
]

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
  [Safeguarding accademico],  [Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze],
  [Diario delle evidenze], [Spazio confidenziale all'interno della piattaforma in cui la vittima può registrare, datare e raccogliere prove relative agli episodi di mobbing o molestie],
  [Triage guidato], [Percorso interattivo iniziale che aiuta l'utente a classificare l'episodio e ad acquisire consapevolezza sulla sua natura],
  [CUG], [Comitato Unico di Garanzia, organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo],
  [Consigliere di Fiducia], [Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie o mobbing]
)

== Riferimenti
- *UniSAFE Survey - Gender-based violence and institutional responses (Version 1.0.0):* Lipinsky, A., Schredl, C., Baumann, H., Humbert, A. L., Tanwar, J., Bondestam, F., Freund, F., & Lomazzi, V. (2022).  [Data set]. GESIS, Cologne. DOI: https://doi.org/10.7802/2475.
- *Linee Guida del CUG (Comitato Unico di Garanzia):* Documentazione e regolamenti interni di Ateneo relativi alle procedure di supporto, segnalazione e tutela del benessere lavorativo e studentesco.
- *GDPR (Regolamento UE 2016/679)*: Regolamento Generale sulla Protezione dei Dati. Riferimento normativo fondamentale per la definizione dei requisiti non funzionali di privacy, crittografia e anonimato delle segnalazioni gestite dal sistema.
- *Object-Oriented Software Engineering: Using UML, Patterns, and Java (Bruegge, B., & Dutoit, A. H.)*: Testo accademico adottato come linea guida metodologica per la strutturazione dei casi d'uso, dei modelli di sistema (Modello a Oggetti e Dinamico) e per la stesura della documentazione.

== Panoramica del documento 
Il presente *Requirements Analysis Document* (RAD) ha lo scopo di formalizzare i requisiti funzionali e non funzionali della piattaforma *Pharos*, il comportamento atteso del sistema, stabilendo i confini del dominio applicativo, e fornendo una base concordata tra il team di sviluppo e gli stakeholder.

Il testo si rivolge principalmente ai docenti e agli stakeholders interni ed esterni(studenti e personale accademico, Consigliere di Fiducia, CUG), nonché al team di sviluppo come guida architetturale per le successive fasi di progettazione, implementazione e testing.

Il documento è strutturato in modo da fornire una scomposizione progressiva delle specifiche della piattaforma Pharos, partendo dal contesto generale per arrivare alla formalizzazione tecnica dei modelli. I capitoli successivi sono organizzati come segue:

- *Capitolo 1 - Introduzione*: Definisce lo scopo del sistema, l'ambito di sistema, gli obiettivi e criteri di successo, definizioni, acronimi e abbreviazioni, riferimenti bibliografici e la presente struttura documentale.
- *Capitolo 2 - Il Sistema Attuale*: Analizza i processi attualmente in uso presso l'Ateneo per la gestione delle segnalazioni e le relative criticità.
- *Capitolo 3 - Il Sistema Proposto*: Descrive in dettaglio la panoramica della nuova architettura, formalizzando i Requisiti Funzionali e i Requisiti Non Funzionali.
- *Capitolo 4 - Modelli del Sistema*: Fornisce la vista formale orientata agli oggetti tramite Scenari, Casi d'Uso UML, Modello degli Oggetti (Class Diagram), Modello Dinamico (Sequence Diagram) e Mockup delle Interfacce Utente.
- *Capitolo 5 - Glossario*: Raccoglie i termini tecnici, le entità di dominio e i concetti metodologici a supporto della comprensione del testo.