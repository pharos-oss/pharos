#import "../../templates/common.typ": table-style, palette-primary, readable-text

= Glossario <glossario>
La seguente sezione definisce in modo univoco il vocabolario condiviso del sistema Pharos, raccogliendo i termini tecnici e di dominio estratti dai requisiti, dal modello degli oggetti e dai diagrammi comportamentali. Per ciascuna voce vengono riportate la definizione ufficiale, l'elenco dei sinonimi da evitare al fine di prevenire ambiguità terminologiche e i riferimenti agli artefatti in cui il concetto è impiegato.

#[
  #set text(size: 8pt)
  #align(center)[
    #table(
      ..table-style(palette-primary),
      columns: (1.5fr, 3.5fr, 1.5fr, 1.5fr),
      inset: (x: 8pt, y: 8pt),
      align: (x, y) => if y == 0 { center + horizon } else if x == 0 { center + horizon } else { left + horizon },

      text(fill: readable-text(palette-primary))[*Termine*],
      text(fill: readable-text(palette-primary))[*Definizione*],
      text(fill: readable-text(palette-primary))[*Sinonimi da evitare*],
      text(fill: readable-text(palette-primary))[*Riferimenti*],

      [*Utente*],
      [#block(breakable: false)[Utente registrato sulla piattaforma Pharos (studente o dipendente).]],
      [Vittima, Segnalante],
      [#block(breakable: false)[MO_GU, \ RF_GU_01 - RF_GU_11]],

      [*Consigliere di Fiducia (CDF)*],
      [#block(breakable: false)[Figura istituzionale di riferimento a cui inviare segnalazioni protette relative a molestie, mobbing, violenza di genere, stalking, straining, discriminazione e abusi. Gestisce le segnalazioni degli utenti.]],
      [#block(breakable: false)[Admin, Gestore, \ Operatore]],
      [#block(breakable: false)[Definizioni, MO_GCDF, \ RF_GCDF_01 - RF_GCDF_09]],

      [*Comitato Unico di Garanzia (CUG)*],
      [#block(breakable: false)[Organo accademico preposto alla tutela delle pari opportunità e al benessere lavorativo.]],
      [Comitato],
      [#block(breakable: false)[Definizioni, SC_CDF_04, \ MO_GCDF]],

      [*Safeguarding accademico*],
      [#block(breakable: false)[Insieme delle misure preventive e di intervento progettate per tutelare la comunità universitaria contro abusi e violenze.]],
      [Tutela generica],
      [Definizioni],

      [*Diario delle evidenze (o Diario)*],
      [#block(breakable: false)[Spazio confidenziale all'interno della piattaforma in cui l'utente può registrare, datare e raccogliere prove relative agli eventi di molestie, mobbing, violenza di genere, stalking, straining, discriminazione e abusi. È un ambiente personale per annotare eventi in modo privato e cifrato.]],
      [#block(breakable: false)[Blocco note, \ Archivio personale, \ Spazio privato]],
      [#block(breakable: false)[Definizioni, MO_GU, \ RF_GU_01 - RF_GU_03]],

      [*Evento (EventoDiario)*],
      [#block(breakable: false)[Singolo evento annotato nel diario con data, ora, luogo, descrizione e allegati.]],
      [#block(breakable: false)[Fatto, Annotazione, \ Episodio]],
      [#block(breakable: false)[MO_GU, \ RF_GU_01, RF_GU_03, \ STD_02]],

      [*Allegato Multimediale (o Allegato)*],
      [#block(breakable: false)[File (inclusi documenti PDF, e-mail e file multimediali) associato a un evento o a una segnalazione.]],
      [Documento extra, File],
      [#block(breakable: false)[MO_GU, \ RF_GU_01, RF_GU_05, \ RF_GU_08, RNF_U_02, \ MU_04 - MU_08]],

      [*Segnalazione*],
      [#block(breakable: false)[Comunicazione formale inviata al Consigliere di Fiducia. I dati anagrafici del mittente restano strettamente confidenziali e logicamente separati dai fatti narrati.]],
      [#block(breakable: false)[Denuncia, Reclamo, \ Ticket]],
      [#block(breakable: false)[MO_GU, \ RF_GU_04 - RF_GU_09, \ STD_01]],

      [*Bozza*],
      [#block(breakable: false)[Stato di una segnalazione per il salvataggio temporaneo. Permette all'utente di salvare una segnalazione, così da completarla in un momento successivo.]],
      [#block(breakable: false)[Salvataggio temporaneo, \ Incompleta]],
      [#block(breakable: false)[MO_GU, \ RF_GU_04]],

      [*Pratica*],
      [#block(breakable: false)[Procedura di gestione a cura del Consigliere di Fiducia contenente la segnalazione associata, lo storico degli stati e le note.]],
      [Fascicolo, Caso],
      [#block(breakable: false)[MO_GCDF, \ RF_GCDF_01 - RF_GCDF_06]],

      [*Stato Pratica*],
      [#block(breakable: false)[Stato corrente nel flusso della pratica (Inviata, Presa in carico, In lavorazione, In attesa di integrazioni, Chiusa, Archiviata).]],
      [Fase],
      [#block(breakable: false)[MO_GCDF, RF_GU_06, \ RF_GCDF_03 - RF_GCDF_06 - RF_GCDF_05, \ STD_01, \ SD_03, \ MU_07, \ UC_01]],

      [*Nota CDF*],
      [#block(breakable: false)[Nota o appuntamento inserito dal Consigliere di Fiducia, visibile all'utente nella cronologia della pratica.]],
      [Avviso, Messaggio],
      [#block(breakable: false)[MO_GCDF, \ RF_GCDF_04, RF_GU_06]],

      [*Esito Pratica*],
      [#block(breakable: false)[Esito formale di chiusura della pratica (Risolta con procedura informale, Avviata procedura formale, Non procedibile).]],
      [Risoluzione, Verdetto],
      [#block(breakable: false)[MO_GCDF, \ RF_GCDF_06]],

      [*Integrazione*],
      [#block(breakable: false)[Informazioni, allegati, nuovi eventi o note esplicative aggiunte dall'utente in risposta a una richiesta del Consigliere di Fiducia per la pratica in corso.]],
      [Aggiunta, Dettagli extra],
      [RF_GU_08, RF_GCDF_05],

      [*Triage Guidato*],
      [#block(breakable: false)[Percorso interattivo iniziale che aiuta l'utente a classificare l'evento e ad acquisire consapevolezza sulla sua natura.]],
      [Screening automatico],
      [Definizioni, RF_GU_10],

      [*Modulo IA*],
      [#block(breakable: false)[Componente software che analizza i dati del triage guidato per produrre la Valutazione IA.]],
      [Bot, AI generica, AI],
      [#block(breakable: false)[UC_02, \ SD_01, \ MO_GU, \ RF_GU_10]],

      [*Valutazione IA*],
      [#block(breakable: false)[Risultato del triage IA contenente la valutazione della gravità, la tipologia di violenza e i passi suggeriti. I dati vengono resi anonimi dal sistema prima dell'invio al Modulo IA.]],
      [#block(breakable: false)[Output automatico, \ Esito automatico]],
      [#block(breakable: false)[MO_GU, \ RF_GU_10]],

      [*Servizio Territoriale*],
      [#block(breakable: false)[Struttura di assistenza territoriale (centri antiviolenza, sportelli servizi legali) consultabile nella rubrica dell'applicazione.]],
      [#block(breakable: false)[Aiuto esterno, \ Struttura locale]],
      [#block(breakable: false)[MO_GU, \ RF_GU_11]],

      [*Periodo Assenza*],
      [#block(breakable: false)[Periodo di indisponibilità del Consigliere di Fiducia con date di inizio e fine e attivazione di un avviso automatico per gli utenti.]],
      [#block(breakable: false)[Ferie, Congedo, \ Fuori ufficio]],
      [#block(breakable: false)[MO_GCDF, \ RF_GCDF_07]],

      [*Report Statistico*],
      [#block(breakable: false)[Report aggregato e anonimizzato generato per il Comitato Unico di Garanzia indicando tipologia di violenza e componente accademica.]],
      [Statistiche, Resoconto],
      [#block(breakable: false)[MO_GCDF, \ RF_GCDF_08, RF_GCDF_09]],

      [*Panic Button (Chiusura rapida)*],
      [#block(breakable: false)[Funzionalità dell'app mobile che fornisce l'oscuramento o l'uscita immediata per proteggere la privacy dell'utente qualora venga interrotto durante l'uso.]],
      [#block(breakable: false)[Kill switch, \ Uscita di emergenza]],
      [RNF_U_04]
    )
  ]
]