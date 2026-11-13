#import "../../templates/common.typ": table-style, palette-primary, readable-text

= Glossario <glossario>
La seguente sezione definisce in modo univoco il vocabolario condiviso del sistema Pharos, raccogliendo i termini tecnici e di dominio estratti dai requisiti, dal modello degli oggetti e dai diagrammi comportamentali. Per ciascuna voce vengono riportate la definizione ufficiale, l'elenco dei sinonimi da evitare al fine di prevenire ambiguità terminologiche e i riferimenti agli artefatti in cui il concetto è impiegato.

#[
  #set text(size: 8pt)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.5fr, 3.5fr, 1.5fr, 1.5fr),
      inset: 8pt,
      align: (x, y) => if y == 0 { center + horizon } else if x == 0 { center + horizon } else { left + horizon },

      text(fill: readable-text(palette-primary))[*Termine*],
      text(fill: readable-text(palette-primary))[*Definizione*],
      text(fill: readable-text(palette-primary))[*Sinonimi da evitare*],
      text(fill: readable-text(palette-primary))[*Riferimenti*],

      [*Utente*],
      [Utente registrato sulla piattaforma Pharos (studente o dipendente).],
      [Vittima, Segnalante],
      [MO_GU, \ RF_GU_01 - RF_GU_11],

      [*Consigliere di Fiducia (CDF)*],
      [Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie o mobbing. Gestisce le segnalazioni degli utenti.],
      [Admin, Gestore, \ Operatore],
      [Definizioni, MO_GCDF, \ RF_GCDF_01 - RF_GCDF_09],

      [*Comitato Unico di Garanzia (CUG)*],
      [Organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo.],
      [Comitato],
      [Definizioni],

      [*Safeguarding accademico*],
      [Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze.],
      [Tutela generica],
      [Definizioni],

      [*Diario delle evidenze (o Diario)*],
      [Spazio confidenziale all'interno della piattaforma in cui la vittima può registrare, datare e raccogliere prove relative agli episodi di mobbing o molestie. È un ambiente personale per annotare eventi in modo privato e cifrato.],
      [Blocco note, \ Archivio personale, \ Spazio privato],
      [Definizioni, MO_GU, \ RF_GU_01 - RF_GU_03],

      [*Evento (EventoDiario)*],
      [Singolo evento annotato nel diario con data, ora, luogo, descrizione e allegati.],
      [Fatto, Annotazione, \ Episodio],
      [MO_GU],

      [*Allegato*],
      [File multimediale associato a un evento o a una segnalazione.],
      [Documento extra, File],
      [MO_GU],

      [*Segnalazione*],
      [Segnalazione formale inviata al Consigliere di Fiducia. I dati anagrafici del mittente restano strettamente confidenziali e logicamente separati dai fatti narrati.],
      [Denuncia, Reclamo, \ Ticket],
      [MO_GU, \ RF_GU_05],

      [*Bozza*],
      [Stato di una segnalazione per il salvataggio temporaneo. Permette all'utente di salvare una segnalazione, così da completarla in un momento successivo.],
      [Salvataggio temporaneo, \ Incompleta],
      [MO_GU, \ RF_GU_04],

      [*Pratica*],
      [Pratica gestita dal Consigliere di Fiducia contenente la segnalazione associata, lo storico degli stati e le note.],
      [Fascicolo, Caso],
      [MO_GCDF, \ RF_GCDF_01 - RF_GCDF_06],

      [*Stato Pratica*],
      [Stato corrente nel flusso della pratica (Inviata, Presa in carico, In lavorazione, Chiusa, Archiviata).],
      [Fase],
      [MO_GCDF],

      [*Nota CDF*],
      [Nota o appuntamento inserito dal Consigliere di Fiducia, visibile all'utente nella cronologia della pratica.],
      [Avviso, Messaggio],
      [MO_GCDF, \ RF_GCDF_04],

      [*Esito Pratica*],
      [Esito formale di chiusura della pratica (Risolta con procedura informale, Avviata procedura formale, Non procedibile).],
      [Risoluzione, Verdetto],
      [MO_GCDF, \ RF_GCDF_06],

      [*Integrazione*],
      [Informazioni, allegati, nuovi eventi o note esplicative aggiunte dall'utente in risposta a una richiesta del Consigliere di Fiducia per la pratica in corso.],
      [Aggiunta, Dettagli extra],
      [RF_GU_08, RF_GCDF_05],

      [*Triage Guidato*],
      [Percorso interattivo iniziale che aiuta l'utente a classificare l'episodio e ad acquisire consapevolezza sulla sua natura.],
      [Screening automatico],
      [Definizioni, RF_GU_10],

      [*Valutazione IA*],
      [Risultato del triage IA contenente la valutazione della gravità, la tipologia di violenza e i passi suggeriti. I dati vengono resi anonimi dal sistema prima dell'invio al modulo.],
      [Bot, AI generica],
      [MO_GU, \ RF_GU_10],

      [*Servizio Territoriale*],
      [Struttura di assistenza territoriale (centri antiviolenza, sportelli servizi legali) consultabile nella rubrica dell'applicazione.],
      [Aiuto esterno, \ Struttura locale],
      [MO_GU, \ RF_GU_11],

      [*Periodo Assenza*],
      [Periodo di indisponibilità del Consigliere di Fiducia con date di inizio e fine e attivazione di un avviso automatico per gli utenti.],
      [Ferie, Congedo, \ Fuori ufficio],
      [MO_GCDF, \ RF_GCDF_07],

      [*Report Statistico*],
      [Report aggregato e anonimizzato generato per il Comitato Unico di Garanzia indicando tipologia di violenza e componente accademica.],
      [Statistiche, Resoconto],
      [MO_GCDF, \ RF_GCDF_08],

      [*Panic Button (Chiusura rapida)*],
      [Funzionalità dell'app mobile che fornisce l'oscuramento o l'uscita immediata per proteggere la privacy dell'utente qualora venga interrotto durante l'uso.],
      [Kill switch, \ Uscita di emergenza],
      [RNF_U_04]
    )
  ]
]