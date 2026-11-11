#import "../../../templates/common.typ": palette-primary, readable-text, table-style

=== Gestione Utente (MO_GU)

La tabella seguente elenca gli oggetti Entity, Boundary e Control individuati per la Gestione Utente, derivati dai requisiti funzionali RF_GU_01 – RF_GU_11 e dai casi d'uso UC_01 – UC_04. 


#[
  #set text(size: 8pt)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.4fr, 0.9fr, 1.4fr, 1.5fr, 1.5fr, 1.1fr, 1.7fr),
      inset: 4.5pt,
      align: (x, y) => if y == 0 { center + horizon } else if x == 0 or x == 1 or x == 5 { center + horizon } else { left + horizon },

      text(fill: readable-text(palette-primary))[*Nome*],
      text(fill: readable-text(palette-primary))[*Tipologia*],
      text(fill: readable-text(palette-primary))[*Attributi*],
      text(fill: readable-text(palette-primary))[*Metodi*],
      text(fill: readable-text(palette-primary))[*Relazioni*],
      text(fill: readable-text(palette-primary))[*Requisiti*],
      text(fill: readable-text(palette-primary))[*Descrizione*],

      // ── ENTITY ──

      [*Utente*], [Entity],
      [id, nome, cognome, \ email, ruolo],
      [ottieniProfilo(), \ aggiornaDati()],
      [Diario (1), \ Segnalazione (0..\*)],
      [RF_GU_01 – \ RF_GU_11],
      [Utente registrato sulla piattaforma Pharos (studente o dipendente).],

      [*Diario*], [Entity],
      [id, utenteId, \ dataCreazione, cifrato],
      [impostaCifratura(), \ ottieniEventi()],
      [Utente (1), \ EventoDiario (0..\*)],
      [RF_GU_01, \ RF_GU_02],
      [Diario personale per annotare eventi in modo privato e cifrato.],

      [*EventoDiario*], [Entity],
      [id, data, ora, \ luogo, descrizione, \ dataCreazione],
      [ottieniDettagli(), \ aggiornaDati()],
      [Diario (1), \ Allegato (0..\*), \ Segnalazione (0..\*)],
      [RF_GU_01, \ RF_GU_03],
      [Singolo evento annotato nel diario con data, ora, luogo, descrizione e allegati.],

      [*Segnalazione*], [Entity],
      [id, tipologia, \ descrizione, stato, \ dataCreazione, dataInvio],
      [impostaStato(), \ ottieniDettagli()],
      [Utente (1), \ Allegato (0..\*), \ EventoDiario (0..\*), \ Notifica (0..\*), \ ValutazioneIA (0..1)],
      [RF_GU_04 – \ RF_GU_06, \ RF_GU_08, \ RF_GU_09],
      [Segnalazione formale inviata al CDF; include lo stato Bozza per il salvataggio temporaneo.],

      [*Allegato*], [Entity],
      [id, nomeFile, \ formato, dimensione, \ contenutoCifrato],
      [ottieniFile(), \ impostaContenuto()],
      [EventoDiario (1), \ Segnalazione (0..1)],
      [RF_GU_01],
      [File multimediale associato a un evento o a una segnalazione.],

      [*Notifica*], [Entity],
      [id, tipo, messaggio, \ dataInvio, letta],
      [segnaComeLetta(), \ ottieniMessaggio()],
      [Segnalazione (1)],
      [RF_GU_07],
      [Notifica di aggiornamento stato ricevuta dall'utente.],

      [*ValutazioneIA*], [Entity],
      [id, gravita, \ tipologiaViolenza, \ passiSuggeriti, \ dataValutazione],
      [impostaRisultato(), \ ottieniValutazione()],
      [Segnalazione (1)],
      [RF_GU_10, \ RF_GU_11],
      [Risultato del triage IA: gravità, tipologia di violenza, passi suggeriti.],

      [*ServizioTerr.*], [Entity],
      [id, nome, indirizzo, \ telefono, email, \ tipologia],
      [ottieniDettaglio(), \ ottieniContatti()],
      [ValutazioneIA (0..\*)],
      [RF_GU_11],
      [Struttura di assistenza territoriale (centri antiviolenza, sportelli, servizi legali) consultabile nella rubrica.],

      // ── BOUNDARY ──

      [*InterfacciaUtente*], [Boundary],
      [—],
      [mostraDiario(), \ mostraFormSegn(), \ mostraTriage(), \ mostraRubrica()],
      [GestoreDiario (1), \ GestoreSegn (1)],
      [RF_GU_01 – \ RF_GU_11],
      [Interfaccia grafica unificata per la gestione del diario, l'invio delle segnalazioni e il triage IA.],

      // ── CONTROL ──

      [*GestoreDiario*], [Control],
      [—],
      [aggiungiEvento(), \ rimuoviEvento(), \ cifraContenuto(), \ validaAllegato()],
      [InterfacciaUtente (1), \ Diario (1), \ EventoDiario (0..\*), \ Allegato (0..\*)],
      [RF_GU_01 – \ RF_GU_03],
      [Gestisce la logica di creazione, modifica, cifratura e validazione degli eventi e degli allegati.],

      [*GestoreSegn*], [Control],
      [—],
      [inviaSegnalazione(), \ interrompiIter(), \ avviaTriageIA(), \ anonimizzaTesto(), \ recuperaServizi()],
      [InterfacciaUtente (1), \ Segnalazione (0..\*), \ Notifica (0..\*), \ ValutazioneIA (0..1), \ ServizioTerr. (0..\*)],
      [RF_GU_04 – \ RF_GU_11],
      [Coordina il ciclo di vita delle segnalazioni, l'interazione con l'IA e il recapito delle notifiche.]
    )
  ]
]
#v(4em)

=== Gestione Consigliere di Fiducia (MO_GCDF)

La tabella seguente elenca gli oggetti Entity, Boundary e Control individuati per la Gestione Consigliere di Fiducia, derivati dai requisiti funzionali RF_GCDF_01 – RF_GCDF_09 e dai casi d'uso UC_CDF_1 – UC_CDF_2.

#v(1em)

#[
  #set text(size: 8pt)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.2fr, 0.9fr, 1.4fr, 1.5fr, 1.4fr, 1.1fr, 1.7fr),
      inset: 4pt,
      align: (x, y) => if y == 0 { center + horizon } else if x == 0 or x == 1 or x == 5 { center + horizon } else { left + horizon },

      text(fill: readable-text(palette-primary))[*Nome*],
      text(fill: readable-text(palette-primary))[*Tipologia*],
      text(fill: readable-text(palette-primary))[*Attributi*],
      text(fill: readable-text(palette-primary))[*Metodi*],
      text(fill: readable-text(palette-primary))[*Relazioni*],
      text(fill: readable-text(palette-primary))[*Requisiti*],
      text(fill: readable-text(palette-primary))[*Descrizione*],

      // ── ENTITY ──

      [*Cdf*], [Entity],
      [id, nome, cognome, \ email, ruolo],
      [ottieniProfilo(), \ aggiornaStato()],
      [Pratica (0..\*), \ PeriodoAssenza (0..\*)],
      [RF_GCDF_01 – \ RF_GCDF_09],
      [Consigliere di Fiducia che gestisce le segnalazioni degli utenti.],

      [*Pratica*], [Entity],
      [id, dataRicezione, \ tipologia],
      [impostaStato(), \ ottieniDettagli()],
      [Cdf (1), \ Segnalazione (1), \ StatoPratica (1..\*), \ NotaCDF (0..\*), \ EsitoPratica (0..1)],
      [RF_GCDF_01, \ RF_GCDF_03, \ RF_GCDF_04, \ RF_GCDF_06],
      [Pratica gestita dal CDF: segnalazione associata, storico stati e note.],

      [*StatoPratica*], [Entity],
      [id, stato, \ dataTransizione, note],
      [ottieniStato()],
      [Pratica (1)],
      [RF_GCDF_03, \ RF_GCDF_04],
      [Stato corrente nel flusso (Inviata, Presa in carico, In lavorazione, Chiusa, Archiviata).],

      [*NotaCDF*], [Entity],
      [id, testo, \ dataInserimento, \ visibileUtente],
      [ottieniTesto()],
      [Pratica (1)],
      [RF_GCDF_04],
      [Nota o appuntamento inserito dal CDF, visibile all'utente nella cronologia.],

      [*EsitoPratica*], [Entity],
      [id, esito, \ notaConclusiva, \ dataChiusura],
      [ottieniEsito()],
      [Pratica (1)],
      [RF_GCDF_06],
      [Esito formale di chiusura (Risolta con procedura informale, Avviata procedura formale, Non procedibile).],

      [*ReportStatistico*], [Entity],
      [id, periodo, \ datiAggregati, \ dataGenerazione, \ formato],
      [impostaDati(), \ ottieniReport()],
      [—],
      [RF_GCDF_08, \ RF_GCDF_09],
      [Report aggregato e anonimizzato per il CUG (tipologia, componente accademica).],

      [*PeriodoAssenza*], [Entity],
      [id, dataInizio, \ dataFine, \ avvisoAttivo],
      [attivaAvviso(), \ disattivaAvviso()],
      [Cdf (1)],
      [RF_GCDF_07],
      [Periodo di indisponibilità del CDF con date di inizio e fine e avviso automatico.],

      // ── BOUNDARY ──

      [*InterfacciaCDF*], [Boundary],
      [—],
      [mostraDashboard(), \ mostraDettPratica(), \ mostraReport()],
      [GestorePratiche (1), \ GestoreReport (1)],
      [RF_GCDF_01 – \ RF_GCDF_09],
      [Interfaccia riservata al CDF per consultare le pratiche, aggiornare gli stati ed esportare i report.],

      // ── CONTROL ──

      [*GestorePratiche*], [Control],
      [—],
      [prendiInCarico(), \ aggiornaStato(), \ chiudiPratica(), \ gestisciAssenza()],
      [InterfacciaCDF (1), \ Pratica (0..\*), \ StatoPratica (0..\*), \ NotaCDF (0..\*), \ EsitoPratica (0..\*)],
      [RF_GCDF_01 – \ RF_GCDF_07],
      [Coordina la logica di avanzamento, integrazione, chiusura delle pratiche e assenze del CDF.],

      [*GestoreReport*], [Control],
      [—],
      [generaReport(), \ aggregaDati(), \ esportaDati()],
      [InterfacciaCDF (1), \ ReportStatistico (0..\*), \ Pratica (0..\*)],
      [RF_GCDF_08, \ RF_GCDF_09],
      [Si occupa di estrarre dati anonimizzati e generare documenti statistici.]
    )
  ]
]