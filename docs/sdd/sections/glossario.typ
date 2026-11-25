#import "../../templates/common.typ" : table-style, palette-primary

#pagebreak()

= Glossario <glossario>

Di seguito sono riportati i termini specifici del dominio e i concetti tecnici utilizzati nel presente System Design Document (SDD), in ordine alfabetico. Le definizioni dei termini di dominio coincidono con quelle del glossario del RAD; per ciascuna voce sono indicati i sinonimi da evitare, per garantire la coerenza terminologica tra tutti gli artefatti.

#table(
  columns: (1.1fr, 2.6fr, 1.1fr),
  ..table-style(palette-primary),
  inset: 8pt,
  align: (col, row) => if row == 0 or col == 0 { center + horizon } else { left + horizon },
  table.header(
    [*Termine*],
    [*Definizione*],
    [*Sinonimi da evitare*],
  ),
  [*AI Act*], [Regolamento (UE) 2024/1689 sull'intelligenza artificiale. Insieme al GDPR motiva la scelta di modelli ospitati in locale o di API stateless in regime Zero-Retention per il Modulo IA.], [—],
  [*Allegato Multimediale (o Allegato)*], [File (inclusi documenti PDF, e-mail e file multimediali) associato a un evento o a una segnalazione.], [Documento extra, File],
  [*API*], [Application Programming Interface — interfaccia software che consente la comunicazione e lo scambio di dati tra componenti o sottosistemi (ad esempio, tra il backend di Pharos e il provider del Modulo IA).], [—],
  [*Audit Log (o Log inalterabile)*], [Registro di sistema che traccia ogni operazione critica e ogni accesso ai dati sensibili da parte del personale preposto. Si basa sul principio WORM (Write Once, Read Many) per garantire l'immodificabilità dei dati registrati e la responsabilità istituzionale.], [—],
  [*BCE*], [Boundary-Control-Entity — pattern architetturale per la decomposizione orientata agli oggetti, che separa le interfacce utente (Boundary), la logica di coordinamento e applicativa (Control) e i dati persistenti (Entity).], [—],
  [*Bozza*], [Stato di una segnalazione per il salvataggio temporaneo. Permette all'utente di salvare una segnalazione, così da completarla in un momento successivo.], [Salvataggio temporaneo, Incompleta],
  [*CI/CD*], [Continuous Integration / Continuous Delivery — pipeline automatizzata di build, test e rilascio che consente aggiornamenti frequenti e controllati della piattaforma.], [—],
  [*Cifratura End-to-End (E2E)*], [Sistema di comunicazione sicura applicato all'inoltro delle segnalazioni. Solo l'utente mittente e il Consigliere di Fiducia destinatario possono leggere i dati in chiaro; il server elabora le informazioni in forma cifrata senza possedere le chiavi di decifrazione.], [—],
  [*Cifratura locale*], [Cifratura dei dati del Diario delle evidenze eseguita sul dispositivo dell'utente, prima di qualsiasi sincronizzazione. Il server non possiede le chiavi e non può decifrare i contenuti.], [—],
  [*Comitato Unico di Garanzia (CUG)*], [Organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo.], [Comitato],
  [*Consigliere di Fiducia (CDF)*], [Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie, mobbing, violenza di genere, stalking, straining, discriminazione e abusi. Gestisce le segnalazioni degli utenti.], [Admin, Gestore, Operatore],
  [*Diario delle evidenze (o Diario)*], [Spazio confidenziale all'interno della piattaforma in cui l'utente può registrare, datare e raccogliere prove relative agli eventi di molestie, mobbing, violenza di genere, stalking, straining, discriminazione e abusi. È un ambiente personale per annotare eventi in modo privato e cifrato.], [Blocco note, Archivio personale, Spazio privato],
  [*Docker*], [Tecnologia di containerizzazione usata per impacchettare i componenti del sistema e uniformarne il rilascio.], [—],
  [*Esito Pratica*], [Esito formale di chiusura della pratica (Risolta con procedura informale, Avviata procedura formale, Non procedibile).], [Risoluzione, Verdetto],
  [*Evento (EventoDiario)*], [Singolo evento annotato nel diario con data, ora, luogo, descrizione e allegati.], [Fatto, Annotazione, Episodio],
  [*GDPR*], [General Data Protection Regulation — Regolamento UE 2016/679 sulla protezione dei dati personali e sensibili. È il riferimento normativo per tutte le scelte architetturali di Pharos relative a privacy, anonimato e crittografia.], [—],
  [*Integrazione*], [Informazioni, allegati, nuovi eventi o note esplicative aggiunte dall'utente in risposta a una richiesta del Consigliere di Fiducia per la pratica in corso.], [Aggiunta, Dettagli extra],
  [*Modulo IA*], [Componente software che analizza i dati del triage guidato per produrre la Valutazione IA.], [Bot, AI generica, AI],
  [*Nota CDF*], [Nota o appuntamento inserito dal Consigliere di Fiducia, visibile all'utente nella cronologia della pratica.], [Avviso, Messaggio],
  [*On-premise*], [Modalità di installazione in cui un servizio, ad esempio il modello del Modulo IA, è ospitato su infrastrutture controllate dall'Ateneo anziché su servizi cloud di terzi.], [—],
  [*Panic Button (Chiusura rapida)*], [Funzionalità dell'app mobile che fornisce l'oscuramento o l'uscita immediata per proteggere la privacy dell'utente qualora venga interrotto durante l'uso.], [Kill switch, Uscita di emergenza],
  [*Periodo Assenza*], [Periodo di indisponibilità del Consigliere di Fiducia con date di inizio e fine e attivazione di un avviso automatico per gli utenti.], [Ferie, Congedo, Fuori ufficio],
  [*Pratica*], [Procedura di gestione a cura del Consigliere di Fiducia contenente la segnalazione associata, lo storico degli stati e le note.], [Fascicolo, Caso],
  [*Provider di Identità di Ateneo (IdP)*], [Servizio dell'Ateneo che autentica gli utenti istituzionali tramite protocollo SAML 2.0 / Shibboleth, nella federazione IDEM-GARR.], [—],
  [*RAD*], [Requirements Analysis Document — documento che formalizza i requisiti funzionali e non funzionali, i casi d'uso e i modelli di sistema, dal quale il presente SDD deriva e giustifica le proprie decisioni architetturali.], [—],
  [*Report Statistico*], [Report aggregato e anonimizzato generato per il Comitato Unico di Garanzia indicando tipologia di violenza e componente accademica.], [Statistiche, Resoconto],
  [*Safeguarding accademico*], [Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze.], [Tutela generica],
  [*SDD*], [System Design Document — il presente documento. Descrive la progettazione tecnica della piattaforma Pharos, traducendo i requisiti del RAD in un'architettura software implementabile, decomponendo il sistema e definendone i trade-off.], [—],
  [*Segnalazione*], [Comunicazione formale inviata al Consigliere di Fiducia. I dati anagrafici del mittente restano strettamente confidenziali e logicamente separati dai fatti narrati.], [Denuncia, Reclamo, Ticket],
  [*Servizio Territoriale*], [Struttura di assistenza territoriale (centri antiviolenza, sportelli servizi legali) consultabile nella rubrica dell'applicazione.], [Aiuto esterno, Struttura locale],
  [*SSO (Single Sign-On)*], [Autenticazione federata che consente di accedere a Pharos con le credenziali istituzionali già in possesso dell'utente, senza creare nuove credenziali.], [—],
  [*Stato Pratica*], [Stato corrente nel flusso della pratica (Inviata, Presa in carico, In lavorazione, In attesa di integrazioni, Chiusa, Archiviata).], [Fase],
  [*Triage Guidato*], [Percorso interattivo iniziale che aiuta l'utente a classificare l'evento e ad acquisire consapevolezza sulla sua natura.], [Screening automatico],
  [*Utente*], [Utente registrato sulla piattaforma Pharos (studente o dipendente).], [Vittima, Segnalante],
  [*Valutazione IA*], [Risultato del triage IA contenente la valutazione della gravità, la tipologia di violenza e i passi suggeriti. I dati vengono resi anonimi dal sistema prima dell'invio al Modulo IA.], [Output automatico, Esito automatico],
  [*WCAG 2.1 (Web Content Accessibility Guidelines)*], [Linee guida W3C sull'accessibilità dei contenuti web. Pharos adotta il livello di conformità AA.], [—],
  [*Zero-Retention (Modello IA Stateless)*], [Politica e configurazione architetturale vincolante per i servizi di intelligenza artificiale (Modulo IA) secondo cui i dati e i prompt testuali inviati non vengono memorizzati in alcun log dal provider né utilizzati per l'addestramento futuro dei modelli, in conformità ai requisiti di privacy.], [—],
)