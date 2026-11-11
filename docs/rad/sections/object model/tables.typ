#import "../../../templates/common.typ": palette-primary, readable-text, table-style

=== Gestione Utente (MO_GU)

La tabella seguente elenca gli oggetti Entity, Boundary e Control individuati per la Gestione Utente, derivati dai requisiti funzionali RF_GU_01 – RF_GU_11 e dai casi d'uso UC_01 – UC_04. 


#[
  #set text(size: 8pt)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.4fr, 0.9fr, 1.4fr, 1.5fr, 1.4fr, 1.1fr, 1.7fr),
      inset: 7pt,
      align: (x, y) => if y == 0 { center + horizon } else if x == 0 or x == 1 or x == 5 { center + horizon } else { left + horizon },

      text(fill: readable-text(palette-primary))[*Nome*],
      text(fill: readable-text(palette-primary))[*Tipologia*],
      text(fill: readable-text(palette-primary))[*Attributi*],
      text(fill: readable-text(palette-primary))[*Metodi*],
      text(fill: readable-text(palette-primary))[*Relazioni*],
      text(fill: readable-text(palette-primary))[*Requisiti*],
      text(fill: readable-text(palette-primary))[*Descrizione*],

      // ── ENTITY ──

      [*UE*], [Entity],
      [id, nome, cognome, \ email, ruolo],
      [ottieniDati(), \ aggiornaDati()],
      [Diario (1), \ Segnalazione (0..\*)],
      [RF_GU_01 – \ RF_GU_11],
      [Utente registrato sulla piattaforma Pharos (studente o dipendente).],

      [*Diario*], [Entity],
      [id, utenteId, \ dataCreazione, cifrato],
      [impostaCifratura(), \ ottieniEventi()],
      [Utente (1), \ EventoDiario (0..\*)],
      [RF_GU_01, \ RF_GU_02],
      [Diario personale dell'utente per annotare eventi in forma privata e cifrata.],

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

      // ── BOUNDARY ──

      [*InterfacciaUtente*], [Boundary],
      [—],
      [mostraDiario(), \ mostraFormSegn(), \ mostraTriage()],
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
      [inviaSegnalazione(), \ interrompiIter(), \ avviaTriageIA(), \ anonimizzaTesto()],
      [InterfacciaUtente (1), \ Segnalazione (0..\*), \ Notifica (0..\*), \ ValutazioneIA (0..1)],
      [RF_GU_04 – \ RF_GU_11],
      [Coordina il ciclo di vita delle segnalazioni, l'interazione con l'IA e il recapito delle notifiche.]
    )
  ]
]