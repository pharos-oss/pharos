= Architettura del Sistema Proposto <architettura_proposta>

== Panoramica

Per superare le criticità dell'organizzazione attuale, la piattaforma Pharos adotta un'architettura software client-server multi-tier, progettata per garantire la confidenzialità dei dati sensibili, la separazione logica tra l'identità dell'utente e il contenuto delle segnalazioni e la tracciabilità completa dell'iter di gestione delle pratiche.

A livello generale, il sistema si articola nei seguenti componenti principali:

- *Applicazione Mobile Utente:* client dedicato a studenti e personale universitario, dotato di uscita rapida (Panic Button) e persistenza locale cifrata per l'utilizzo offline. Consente di gestire il Diario delle evidenze, consultare i Servizi Territoriali, eseguire il Triage Guidato e inviare segnalazioni o integrazioni monitorandone lo stato.

- *Applicazione Web Consigliere di Fiducia:* client web riservato al Consigliere di Fiducia per la consultazione, presa in carico e lavorazione delle pratiche, la gestione di note, integrazioni e periodi di assenza, nonché la generazione ed esportazione di Report Statistici anonimizzati per il CUG.

- *Server Applicativo:* livello centrale che espone le interfacce ai client e coordina la logica dei due domini funzionali del sistema (Gestione Utente e Gestione Consigliere di Fiducia), includendo l'anonimizzazione dei testi, il coordinamento delle notifiche e l'aggregazione statistica.

- *Modulo IA di Triage:* componente isolato e privo di persistenza (stateless), la cui modalità di deployment è demandata alla progettazione di dettaglio; riceve dal server il testo degli eventi preventivamente anonimizzato e restituisce una valutazione orientativa su gravità, tipologia di violenza e passi dell'iter di segnalazione.

- *Livello di Persistenza e Sicurezza:* repository dei dati che mantiene logicamente separati i dati anagrafici dal contenuto cifrato delle segnalazioni (affiancato da metadati non identificativi in chiaro per le statistiche), impone la sola lettura sulle pratiche chiuse o archiviate e registra gli accessi del CDF in un Audit Log immodificabile.

- *Sistemi Esterni Integrati:* comprendono il Provider di Identità di Ateneo, che gestisce l'autenticazione federata Single Sign-On (SSO) e l'assegnazione dei ruoli tramite credenziali istituzionali, e il Servizio di Notifiche, incaricato di recapitare avvisi in-app ed e-mail privi di dettagli riservati.

Le interazioni principali tra i componenti si sviluppano lungo quattro flussi:

1. *Autenticazione SSO:* entrambi i client effettuano l'accesso tramite il Provider di Identità di Ateneo, ottenendo una sessione vincolata al rispettivo ruolo applicativo (Utente o Consigliere di Fiducia).

2. *Gestione del Diario e Triage Guidato:* l'Utente registra eventi e allegati cifrati localmente sull'Applicazione Mobile (sincronizzati in forma cifrata sul server e inaccessibili sia a quest'ultimo sia al CDF). All'avvio del Triage Guidato, l'Applicazione Mobile decifra localmente solo gli eventi selezionati dall'utente e li invia in chiaro, su canale protetto, al Server Applicativo, che provvede ad anonimizzare il testo prima di interrogare il Modulo IA in modalità stateless.

3. *Inoltro e lavorazione della Pratica:* all'invio di una segnalazione, l'Applicazione Mobile cifra localmente il contenuto sensibile (cifratura End-to-End, decifrabile esclusivamente dal CDF) e trasmette su canale protetto i relativi metadati non identificativi in chiaro (es. tipologia e componente accademica). Il Server Applicativo archivia separatamente identità, contenuto cifrato e metadati, inizializza lo Stato Pratica e attiva il Servizio di Notifiche; il CDF gestisce l'avanzamento dall'Applicazione Web con registrazione di ogni accesso nell'Audit Log.

4. *Generazione di Report Statistici:* su richiesta del CDF tramite Applicazione Web, il Server Applicativo aggrega esclusivamente i metadati non identificativi salvati in chiaro, senza accedere al contenuto cifrato delle pratiche, per produrre i Report Statistici destinati al CUG.
