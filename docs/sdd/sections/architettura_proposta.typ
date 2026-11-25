= Architettura del Sistema Proposto <architettura_proposta>

== Panoramica

Per superare le criticità dell'organizzazione attuale, la piattaforma Pharos adotta un'architettura software client-server multi-tier, progettata per garantire la confidenzialità dei dati sensibili, la separazione logica tra l'identità dell'utente e il contenuto delle segnalazioni e la tracciabilità completa dell'iter di gestione delle pratiche.

A livello generale, il sistema si articola nei seguenti componenti principali:

- *Applicazione Web Utente (PWA):* client web dedicato a studenti e personale universitario, progettato come Progressive Web Application (PWA) orientata principalmente all'utilizzo da dispositivi mobili, dotato di uscita rapida (Panic Button) e persistenza locale cifrata per l'operatività offline. Consente di gestire il Diario delle evidenze, consultare i Servizi Territoriali, eseguire la de-identificazione on-device dei testi per il Triage Guidato, cifrare End-to-End le segnalazioni e inviare integrazioni monitorandone lo stato.

- *Applicazione Web Consigliere di Fiducia:* client web riservato al Consigliere di Fiducia per la consultazione, presa in carico e lavorazione delle pratiche, la gestione di note, integrazioni e periodi di assenza, nonché la generazione ed esportazione di report statistici anonimizzati per il CUG.

- *Server Applicativo:* livello centrale che espone le interfacce ai client e coordina la logica dei due domini funzionali del sistema (Gestione Utente e Gestione Consigliere di Fiducia), gestendo l'inoltro delle richieste al modulo di triage, il coordinamento delle notifiche e l'aggregazione statistica, senza mai accedere in chiaro ai contenuti sensibili.

- *Modulo IA di Triage:* componente isolato e privo di persistenza (stateless), la cui modalità di deployment è demandata alla progettazione di dettaglio; riceve testi già depurati dai dati identificativi sul dispositivo dell'utente e restituisce una valutazione orientativa su gravità, tipologia di violenza e passi dell'iter di segnalazione.

- *Livello di Persistenza e Sicurezza:* repository dei dati che mantiene logicamente separati i dati anagrafici dal contenuto cifrato delle segnalazioni (affiancato dai soli metadati statistici non identificativi per la reportistica), impone la sola lettura sulle pratiche chiuse o archiviate e registra gli accessi del CDF in un *Audit Log* immodificabile.

- *Sistemi esterni integrati:* comprendono il Provider di Identità di Ateneo, che gestisce l'autenticazione federata Single Sign-On (SSO) e l'assegnazione dei ruoli tramite credenziali istituzionali, e il Servizio di Notifiche, incaricato di recapitare avvisi in-app ed e-mail privi di dettagli riservati.

Le interazioni principali tra i componenti si sviluppano lungo quattro flussi:

1. *Autenticazione SSO:* entrambi i client effettuano l'accesso tramite il Provider di Identità di Ateneo, ottenendo una sessione vincolata al rispettivo ruolo applicativo (Utente o Consigliere di Fiducia).

2. *Gestione del Diario e Triage Guidato:* l'Utente registra eventi e allegati cifrati localmente sul proprio client (sincronizzati in forma cifrata sul server e inaccessibili sia a quest'ultimo sia al CDF). All'avvio del Triage Guidato, il client decifra localmente solo gli eventi selezionati ed esegue la rimozione dei dati identificativi direttamente on-device, prima che qualsiasi contenuto lasci il dispositivo; solo il testo già depurato viene trasmesso su canale protetto al Server Applicativo, che lo inoltra al Modulo IA in modalità stateless.

3. *Inoltro e lavorazione della Pratica:* all'invio di una segnalazione, il client utente cifra localmente l'intero contenuto sensibile (cifratura End-to-End, decifrabile esclusivamente dall'utente e dal CDF) e trasmette separatamente i soli metadati statistici non identificativi (tipologia e componente accademica). Il Server Applicativo archivia separatamente identità, contenuto cifrato e metadati non identificativi senza poter leggere i fatti narrati, inizializza lo Stato Pratica e attiva il Servizio di Notifiche; il CDF gestisce l'avanzamento dall'Applicazione Web con registrazione di ogni accesso nell'Audit Log.

4. *Generazione di Report Statistici:* su richiesta del CDF tramite Applicazione Web, il Server Applicativo aggrega esclusivamente i metadati statistici non identificativi, senza accedere al contenuto cifrato delle pratiche, per produrre i Report Statistici destinati al CUG.

== Mappatura Hardware/Software
#include "hardware_software_mapping/descrizione_mappatura.typ"