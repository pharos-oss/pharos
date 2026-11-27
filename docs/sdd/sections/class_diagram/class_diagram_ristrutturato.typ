#import "../../../templates/common.typ": palette-primary, readable-text, table-style

= Class Diagram Ristrutturato
#[
  #set par(justify: false)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (auto, auto,auto, auto),
      inset: 8pt,
      align: horizon,
table.header(
    [*Sottosistema*],
    [*Classi / Interfacce principali*],
    [*Relazioni e vincoli chiave*],
    [*Riferimenti*],
  ),

  [Applicazione Web Utente (PWA)],
  [ InterfacciaUtente,
    GestoreCifraturaClient,
    RedattoreOnDevice,
    ArchivioOfflineLocale],
  [ Cifratura AES-256 locale ed E2EE _client-side_;
    redazione _on-device_ prima del Triage;
    cache offline per EventoDiario e ServizioTerritoriale;
    Panic Button.],
  [RF\_GU\_01–03, RF\_GU\_11, RNF\_U\_01–04, RNF\_A\_01, RNF\_A\_03],

  [Applicazione Web CDF],
  [InterfacciaCDF,
    ClientDecifraturaCDF],
  [Decifratura E2EE tramite IServizioHSM senza
    esporre la chiave privata; nessuna dipendenza
    in lettura sull'Audit Log.],
  [RF\_GCDF\_01–09, RNF\_U\_03, RNF\_A\_01, RNF\_P\_02],

  [Controllo Accessi e Sicurezza],
  [GestoreAccessiSicurezza,
    Sessione,
    LoggerApplicativo,
    IServizioSSO],
  [Punto di ingresso unico per le interfacce;
    autenticazione SAML 2.0 e RBAC (RuoloSistema);
    logging tecnico pseudonimizzato.],
  [RNF\_IF\_01, RNF\_A\_01, RNF\_S\_01],

  [Gestione Utente (MO\_GU)],
  [GestoreDiario,
    GestoreSegnalazione],
  [Sincronizzazione cifrata di Diario/EventoDiario,
    validazione Allegato, bozze e inoltro Segnalazione,
    integrazioni (con propagazione a GestorePratiche)
    e interruzione iter.],
  [RF\_GU\_01–06, RF\_GU\_08, RF\_GU\_09, RF\_GU\_11],

  [Gestione CDF (MO\_GCDF)],
  [GestorePratiche],
  [Presa in carico, avanzamento con StatoPratica
    e NotaCDF, richiesta integrazioni, chiusura
    con EsitoPratica (`solaLettura = true`),
    gestione PeriodoAssenza, tracciamento
    su GestoreAuditLog.],
  [RF\_GCDF\_01–07, RNF\_A\_02, RNF\_L\_02],

  [Triage Guidato & Modulo IA],
  [GestoreTriage,
    ModuloIATriage,
    IProviderIA,
    AdattatoreProviderIA,
    ValutazioneIA],
  [Ricezione solo di testo depurato;
    elaborazione _stateless_ con ValutazioneIA
    transiente (`<<DTO>>`);
    disaccoppiamento del provider esterno
    via Adapter.],
  [RF\_GU\_10, RNF\_P\_01, RNF\_IM\_02, RNF\_L\_01],

  [Reportistica CUG],
  [GestoreReport,
    MetadatoStatistico,
    ReportStatistico],
  [Aggregazione dei soli metadati non identificativi
    senza accesso ai contenuti cifrati;
    tracciamento delle esportazioni
    su GestoreAuditLog.],
  [RF\_GCDF\_08, RF\_GCDF\_09, RNF\_L\_02],

  [Gestione Notifiche],
  [GestoreNotifiche,
    Notifica,
    IServizioNotifiche],
  [Invio notifiche generiche in-app ed e-mail
   senza contenuti riservati, leggendo i soli
   contatti da AccountIstituzionale.],
    
  [RF\_GU\_07],

  [Persistenza Dati e Audit WORM],
  [ AccountIstituzionale,
    Utente,
    Cdf,
    entità cifrate,
    GestoreAuditLog,
    VoceAudit,
    InterfacciaAuditDPO],
  [Separazione logica in tre domini
    (Anagrafica, Contenuti Cifrati, Metadati);
    integrità _hash-chaining_ su VoceAudit
    e consultazione riservata a DPO/Sicurezza
    su canale separato.],
  [RNF\_A\_01, RNF\_A\_02, RNF\_O\_01, RNF\_L\_02],
)

]
]