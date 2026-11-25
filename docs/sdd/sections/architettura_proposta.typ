= Architettura del Sistema Proposto <architettura_proposta>

== Panoramica

Per superare le criticità dell'organizzazione attuale, la piattaforma *Pharos* adotta un'architettura software client-server multi-tier, progettata per garantire la confidenzialità dei dati sensibili, la separazione logica tra l'identità dell'utente e il contenuto delle segnalazioni e la tracciabilità completa dell'iter di gestione delle pratiche.

A livello generale, il sistema si articola nei seguenti componenti principali:

- *Applicazione Mobile Utente:* client dedicato agli utenti della comunità accademica (studenti e personale universitario), progettato in conformità ai criteri di accessibilità WCAG 2.1 livello AA e dotato di una funzionalità di uscita e oscuramento rapido (*Panic Button*) per la tutela immediata della privacy durante l'uso. L'applicazione implementa una persistenza locale cifrata che consente all'utente di registrare eventi e allegati multimediali nel *Diario delle evidenze* e di consultare la rubrica e la mappa dei *Servizi Territoriali* anche in assenza di connettività di rete, sincronizzando i dati cifrati con il server alla successiva riconnessione. Inoltre, integra il percorso interattivo di *Triage Guidato*, la gestione delle segnalazioni in *Bozza*, l'inoltro formale, l'invio di *Integrazioni* e la consultazione della cronologia della pratica.

- *Applicazione Web Consigliere di Fiducia:* client web riservato al Consigliere di Fiducia e agli amministratori per la gestione operativa del sistema. Consente la consultazione delle segnalazioni ricevute, la presa in carico e l'aggiornamento dello stato delle pratiche, l'inserimento di note e appuntamenti, la richiesta di integrazioni, la gestione dei periodi di assenza e la generazione ed esportazione di report statistici anonimizzati (PDF e CSV) per il CUG.

- *Server Applicativo:* livello centrale che espone le interfacce di comunicazione ai client e coordina la logica applicativa dei due domini funzionali del sistema, ovvero la *Gestione Utente* (gestione del Diario, ciclo di vita delle segnalazioni, anonimizzazione dei testi e notifiche) e la *Gestione Consigliere di Fiducia* (avanzamento delle pratiche, chiusura in sola lettura e aggregazione dei dati statistici).

- *Modulo IA di Triage:* componente isolato e privo di persistenza dei dati (*stateless*), ospitato in locale o tramite API enterprise senza conservazione né riaddestramento. Riceve dal server applicativo il testo degli eventi selezionati dall'utente, preventivamente privato dei dati identificativi, e restituisce una valutazione orientativa su gravità, tipologia di violenza e passi dell'iter di segnalazione.

- *Livello di persistenza e sicurezza:* repository dei dati che mantiene logicamente separati i dati anagrafici dell'utente dal contenuto delle segnalazioni protette tramite cifratura End-to-End, impone il vincolo di sola lettura sulle pratiche archiviate e registra ogni accesso del Consigliere di Fiducia ai dati sensibili in un *Audit Log* immodificabile.

- *Sistemi esterni integrati:* comprendono il *Provider di Identità di Ateneo* (basato su protocollo SAML 2.0 / Shibboleth e compatibile con la federazione IDEM-GARR), che gestisce l'autenticazione federata Single Sign-On (SSO) e l'attribuzione dei ruoli applicativi mediante credenziali istituzionali. Inoltre, è presente anche il *Servizio di Notifiche*, incaricato di recapitare notifiche in-app ed e-mail ad ogni aggiornamento di stato senza esporre informazioni riservate della pratica.

#pagebreak()

Le interazioni principali tra i componenti si sviluppano lungo quattro flussi lineari:

1. *Autenticazione Single Sign-On (SSO):* entrambi i client effettuano l'accesso tramite il *Provider di Identità di Ateneo*, ottenendo una sessione autenticata vincolata al rispettivo ruolo applicativo (*Utente* o *Consigliere di Fiducia*).

2. *Gestione del Diario e Triage Guidato:* l'*Utente* registra *Eventi* e *Allegati* sull'Applicazione Mobile, dove vengono cifrati localmente e sincronizzati con il Server Applicativo per l'archiviazione cifrata nel database (restando inaccessibili al CDF fino all'invio di una *Segnalazione*). Quando l'*Utente* avvia il *Triage Guidato*, il Server Applicativo rimuove i dati identificativi dal testo e interroga il *Modulo IA* in modalità *stateless*, restituendo la *Valutazione IA* al client mobile.

3. *Inoltro e lavorazione della Pratica:* all'invio di una *Segnalazione*, il Server Applicativo applica la cifratura End-to-End, mantiene separati i dati anagrafici dell'*Utente* dal contenuto narrativo nel database, imposta lo *Stato Pratica* su *Inviata* e attiva il *Servizio di Notifiche*. Il CDF gestisce l'avanzamento dall'Applicazione Web, mentre ogni accesso ai dati sensibili viene registrato nell'*Audit Log (WORM)*.

4. *Generazione di Report Statistici per il CUG:* su richiesta del CDF tramite Applicazione Web, il Server Applicativo estrae dal database esclusivamente metadati aggregati e anonimizzati per periodo, tipologia di violenza e componente accademica, restituendo il *Report Statistico* esportabile in PDF e CSV.
