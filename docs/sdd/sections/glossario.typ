#pagebreak()

= Glossario

Di seguito sono riportati i termini specifici del dominio e i concetti tecnici rilevanti utilizzati all'interno del presente System Design Document (SDD), organizzati in ordine alfabetico per facilitarne la consultazione e ridurre le ambiguità.

- *API (Application Programming Interface):* Interfaccia software che consente la comunicazione e lo scambio di dati tra diversi componenti o sottosistemi (ad esempio, tra il backend di Pharos e il provider del modulo AI).

- *Audit Log (Log inalterabile / WORM):* Registro di sistema utilizzato per tracciare ogni operazione critica e ogni accesso ai dati sensibili da parte del personale preposto. È basato sul principio *WORM* (Write Once, Read Many) per garantire la sua impossibilità di modifica del dato e la responsabilità istituzionale.

- *BCE (Boundary-Control-Entity):* Pattern architetturale adottato per la decomposizione orientata agli oggetti, che separa in modo netto le interfacce utente (Boundary), la logica di coordinamento e applicativa (Control) e i dati persistenti (Entity).

- *Cifratura End-to-End (E2E):* Sistema di comunicazione sicura applicato all'inoltro delle pratiche. Garantisce che solo l'utente mittente e il Consigliere di Fiducia destinatario possano leggere i dati in chiaro. Il server che ospita la piattaforma elabora le informazioni in forma cifrata senza possedere le chiavi di decifrazione.

- *Consigliere di Fiducia (CDF):* Figura istituzionale accademica di riferimento preposta all'ascolto, alla presa in carico e alla gestione formale e protetta delle segnalazioni relative a molestie, mobbing, straining o abusi.

- *CUG (Comitato Unico di Garanzia):* Organo accademico deputato a promuovere le pari opportunità, valorizzare il benessere lavorativo e contrastare le discriminazioni. Interagisce con il sistema ricevendo dal CDF esclusivamente report statistici e aggregati.

- *Diario delle evidenze:* Spazio privato e confidenziale all'interno della piattaforma in cui la vittima può annotare, datare e raccogliere prove multimediali di eventi lesivi. I dati al suo interno sono protetti tramite *Cifratura locale*.

- *GDPR (General Data Protection Regulation):* Regolamento UE 2016/679 sulla protezione dei dati personali e sensibili. Costituisce il riferimento normativo stringente per tutte le scelte architetturali di Pharos legate alla privacy, all'anonimato e alla crittografia.

- *Panic Button:* Meccanismo di sicurezza implementato a livello di interfaccia utente (UI) che consente l'oscuramento immediato e la chiusura rapida dell'applicazione, tutelando la privacy della vittima in caso di interruzione fisica improvvisa durante l'utilizzo.

- *RAD (Requirements Analysis Document):* Documento di analisi che formalizza i requisiti funzionali, non funzionali, i casi d'uso e i modelli di sistema, dal quale il presente SDD deriva e giustifica le proprie decisioni architetturali.

- *Safeguarding accademico:* L'insieme complessivo delle misure preventive, procedurali e di intervento progettate dall'Ateneo per tutelare la propria comunità contro ogni forma di abuso o violenza.

- *SDD (System Design Document):* Il presente documento. Descrive la progettazione tecnica della piattaforma Pharos, traducendo i requisiti del RAD in un'architettura software implementabile, decomponendo il sistema e definendone i trade-off.

- *Triage IA (o Triage guidato):* Modulo accessorio basato su intelligenza artificiale che valuta e classifica semanticamente le annotazioni. Fornisce all'utente un inquadramento preliminare e orientativo sulla gravità dell'evento, senza alcun valore legale o sostitutivo dell'iter formale.

- *Zero-Retention (Modello AI Stateless):* Politica e configurazione architetturale vincolante per i servizi di Intelligenza Artificiale (Triage IA) secondo cui i dati e i prompt testuali inviati non vengono memorizzati in alcun log dal provider, né utilizzati per l'addestramento futuro dei modelli, in stretta ottemperanza ai requisiti di privacy.