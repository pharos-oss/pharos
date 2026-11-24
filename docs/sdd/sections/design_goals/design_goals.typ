La definizione degli obiettivi di design per il sistema Pharos si fonda sulla traduzione dei requisiti delineati nel RAD in attributi di qualità misurabili e prioritari, strutturati secondo le principali categorie di valutazione architetturale (Dependability, End User Criteria, Maintenance e Performance).

- *Sicurezza e Confidenzialità (Dependability - Security)* - Priorità Massima
  
  - Il sistema deve garantire la totale protezione dei dati personali e sensibili, in rigorosa ottemperanza al GDPR (Regolamento UE 2016/679).
  - L'architettura deve prevedere la separazione logica netta tra l'identità del segnalante e il contenuto della segnalazione (tramite cifratura End-to-End), assicurando che i dati siano accessibili esclusivamente al personale autorizzato (es. Consigliere di Fiducia) per la presa in carico della pratica.
  - Il "Diario delle evidenze" personale deve operare in un ambiente protetto contro accessi non autorizzati e attacchi informatici, avvalendosi di cifratura locale dei dati.

#v(1.5em)

- *Usabilità e Accessibilità (End User Criteria)* - Priorità Alta

  - L'interfaccia utente (conforme WCAG 2.1 livello AA) deve abbattere le barriere psicologiche e l'esitazione antecedente alla denuncia, offrendo un'esperienza intuitiva, rassicurante e user-friendly, integrando strumenti di tutela immediata come il "Panic Button".
  - L'integrazione del triage guidato tramite Intelligenza Artificiale deve supportare la vittima nella presa di consapevolezza in modo fluido, senza richiedere competenze tecniche o legali, garantendo l'anonimizzazione dei dati e politiche "Zero-Retention" (il modello non memorizza né riaddestra sui dati immessi).

#v(1.5em)

- *Trasparenza e Tracciabilità (Maintenance e Dependability)* - Priorità Media
  
  - Il sistema deve contrastare la percezione di inefficacia istituzionale fornendo alla vittima uno strumento trasparente per monitorare lo stato di avanzamento della pratica.
  - Ogni operazione critica sulla piattaforma (segnalazione, integrazione documenti, visualizzazione da parte degli organi preposti) deve essere tracciata tramite un Audit Log inalterabile (WORM) per garantire responsabilità e integrità del processo, prevenendo la dispersione documentale e garantendo la storicizzazione in sola lettura.

#v(1.5em)

- *Affidabilità (Dependability - Reliability)* - Priorità Media
  
  - Il sistema deve garantire il supporto offline, permettendo all'utente di consultare la rubrica dei servizi e registrare eventi nel diario anche in assenza di rete, con sincronizzazione posticipata.

#v(1.5em)

- *Manutenibilità ed Estensibilità (Maintenance)* - Priorità Media
  
  - Il design deve consentire future estensioni delle funzionalità (es. aggiornamento del modulo AI, aggiunta di nuovi ruoli per il CUG) con un impatto minimo sulle componenti esistenti.
  - L'architettura deve favorire la leggibilità e l'adattabilità del codice per supportare il ciclo di vita a lungo termine del progetto nel contesto universitario.

#pagebreak()