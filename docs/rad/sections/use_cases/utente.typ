#import "../../../templates/common.typ": callout-box

Nella presente sezione sono presentati i diversi casi d’uso del sistema, divisi per le varie gestioni. 

#v(0.5em)

=== Caso d'uso: Utente

#v(0.5em)

#align(center)[
  #figure(
    image("../../assets/images/UD_Utente.png", width: 90%), 
    caption: ["UD_Utente Use case diagram dell'utente"]
  )
]

#callout-box(title: "UC_01 Invio di integrazioni per una segnalazione")[
  *Identificativo:* UC_01 \
  *Nome:* Invio di integrazioni per una segnalazione \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Carmine Saggese, Alessia D'Amico \
  *Descrizione:* Lo UC descrive il processo mediante il quale l'Utente, a seguito di una notifica, fornisce informazioni e documenti aggiuntivi richiesti dal Consigliere di Fiducia per proseguire la lavorazione di una segnalazione. \
  *Attore Principale:* Utente (È interessato a fornire il materiale mancante per far procedere l'iter della segnalazione) \
  *Attori secondari:* Consigliere di Fiducia, Sistema (Notifiche)

  *Entry Condition:* \
  - Un Utente ha effettuato l'accesso al sistema \
  - L'Utente possiede una segnalazione passata allo stato «In attesa di integrazioni»

  *Exit condition (On success):* \ 
  - Il materiale integrativo viene allegato alla segnalazione \
  - La segnalazione torna nello stato «In lavorazione» \
  - Il Sistema notifica il Consigliere di Fiducia \

  *Exit condition (On failure):* \
  - Le integrazioni non vengono salvate \
  - Il Sistema mostra all'Utente un messaggio di errore \

  *Rilevanza/User Priority:* Elevata \
  *Frequenza stimata:* Bassa \
  *Extension point:* N/A \
  *Generalization of:* N/A

  #v(1em)

  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Utente:* Riceve una notifica di cambio stato in «In attesa di integrazioni», accede alla piattaforma e apre la segnalazione (Rif. SC_U_05).
  2. *Sistema:* Mostra la richiesta di integrazione inserita dal Consigliere di Fiducia.
  3. *Utente:* Seleziona dal diario gli eventi corrispondenti con i relativi allegati (Rif. SC_U_02), aggiunge un'eventuale breve nota testuale e invia le integrazioni.
  4. *Sistema:* Controlla la validità di eventuali nuovi allegati.
  5. *Sistema:* Cifra i nuovi materiali, li allega alla segnalazione, aggiorna lo stato in «In lavorazione» e invia una notifica al Consigliere di Fiducia.
  6. *Sistema:* Conferma all'Utente l'avvenuto invio delle integrazioni.

  #v(1em)

  *I Scenario/Flusso di eventi Alternativo: Allegato non valido (Rif. SC_U_07)*
  - 4.a1 *Sistema:* Rileva che un allegato aggiunto non rispetta le dimensioni massime o il formato consentito.
  - 4.a2 *Sistema:* Rifiuta il file mostrando un errore sui limiti ammessi e mantiene gli altri dati inseriti.
  - 4.a3 *Utente:* Allega una versione conforme o rimuove l'allegato e procede nuovamente all'invio.

  #v(0.5em)

  *Note:* N/A \
  *Special Requirements:* I materiali allegati tramite integrazione (inclusi gli eventi selezionati dal diario) devono risultare inaccessibili in chiaro e seguire le policy di cifratura del sistema.
]

#callout-box(title: "UC_02 Esecuzione del triage guidato tramite IA")[
  *Identificativo:* UC_02 \
  *Nome:* Esecuzione del triage guidato tramite Intelligenza Artificiale \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Alessia D'Amico, Carmine Saggese \
  *Descrizione:* Lo UC descrive l'utilizzo del modulo di Intelligenza Artificiale da parte dell'Utente per ottenere una valutazione orientativa su episodi annotati nel diario, al fine di decidere se avviare una segnalazione formale. \
  *Attore Principale:* Utente (Interessato a comprendere la gravità di uno o più eventi e orientarsi sulle decisioni da prendere) \
  *Attori secondari:* Sistema (Modulo AI)

  *Entry Condition:* \
  - Un Utente ha effettuato l'accesso al sistema \
  - L'Utente ha annotato nel diario almeno un episodio \

  *Exit condition (On success):* \
  - Il Sistema mostra all'Utente l'esito orientativo della valutazione \
  - L'Utente sceglie se procedere o meno con una segnalazione formale \

  *Exit condition (On failure):* \
  - La valutazione non viene fornita a causa di un disservizio del modulo AI \
  - Il Sistema mostra un messaggio di errore e ripristina lo stato iniziale \

  *Rilevanza/User Priority:* Media \
  *Frequenza stimata:* Bassa \
  *Extension point:* N/A \
  *Generalization of:* N/A

  #v(0.5em)

  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Utente:* Accede al diario, seleziona gli eventi di interesse (Rif. SC_U_02) e avvia il triage guidato.
  2. *Sistema:* Informa l'Utente che il triage è solo orientativo, svolto da un sistema di intelligenza artificiale, non sostituisce il Consigliere di Fiducia e non comporta alcun invio automatico. Richiede conferma.
  3. *Utente:* Conferma l'avviso per procedere.
  4. *Sistema:* Rimuove i dati identificativi dagli eventi selezionati e trasmette il testo al modulo AI.
  5. *Sistema (Modulo AI):* Analizza il testo e restituisce la valutazione.
  6. *Sistema:* Mostra all'Utente la valutazione della gravità, la tipologia di violenza più probabile e i passi dell'iter di segnalazione.
  7. *Sistema:* Chiede all'Utente se desidera inviare una segnalazione formale al Consigliere di Fiducia.
  8. *Utente:* Sceglie di procedere con l'invio della segnalazione.
  9. *Sistema:* Reindirizza l'Utente al modulo di segnalazione precompilando i dati degli eventi analizzati (Rif. SC_U_01).

  #v(0.5em)

  *I Scenario/Flusso di eventi Alternativo: Mantenimento nel diario senza segnalazione (Rif. SC_U_02)*
  - 8.a1 *Utente:* Sceglie di non avviare la segnalazione per il momento.
  - 8.a2 *Sistema:* Chiude il modulo di triage, mantiene gli eventi salvati nel diario e riporta l'Utente alla Home.

  #v(0.5em)

  *Note:* N/A \
  *Special requirments*: Il processo di anonimizzazione (rimozione dei dati identificativi) prima della trasmissione al modulo AI deve essere rigoroso per prevenire l'esposizione di dati personali sensibili. Inoltre, i dati inviati non devono essere memorizzati o utilizzati per l'addestramento del modello AI.
]

#callout-box(title: "UC_03 Composizione e inoltro di una segnalazione")[
  *Identificativo:* UC_03 \
  *Nome:* Composizione e inoltro di una segnalazione \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Gianmarco Raimondi, Leonardo Trotta \
  *Descrizione:* Lo UC descrive la funzionalità di registrazione di eventi nel diario personale e la successiva composizione, salvataggio in bozza e invio di una nuova segnalazione cifrata. \
  *Attore Principale:* Utente (È interessato a documentare un evento lesivo e a segnalarlo ufficialmente) \
  *Attori secondari:* Consigliere di Fiducia, Sistema (Notifiche)

  *Entry Condition:* \
  - Un Utente ha effettuato l'accesso al sistema 
  - Il sistema fornisce l'accesso alla sezione Diario e Segnalazioni

  *Exit condition (On success):* \
  - La segnalazione viene creata e inviata al Consigliere di Fiducia 
  - L'Utente visualizza la segnalazione nello stato «Inviata» 
  - Il Sistema notifica il Consigliere di Fiducia

  *Exit condition (On failure):* \
  - Nessuna segnalazione viene inviata 
  - Il Sistema mostra all'Utente un messaggio di errore o mantiene i dati salvati in bozza locale

  *Rilevanza/User Priority:* Elevata \
  *Frequenza stimata:* Bassa (es. 2/settimana) \
  *Extension point:* NA \
  *Generalization of:* NA

  #v(1em)

  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Utente:* Richiede di aggiungere un nuovo evento al diario personale.
  2. *Sistema:* Chiede di inserire i dettagli compilando un modulo (data, luogo, descrizione, file allegato).
  3. *Utente:* Inserisce i dati richiesti, allega un file probatorio e clicca "Salva evento".
  4. *Sistema:* Controlla che i dati siano validi (campi obbligatori compilati, file < es. 50MB, formato ammesso).
  5. *Sistema:* Cifra l'evento e lo salva correttamente nel diario personale.
  6. *Utente:* Richiede di creare una nuova segnalazione, compila i campi e allega gli eventi precedentemente salvati nel diario.
  7. *Utente:* Clicca "Invia Segnalazione".
  8. *Sistema:* Aggiorna lo stato in «Inviata», elimina le eventuali bozze associate e notifica il Consigliere di Fiducia.

  #v(1em)

  *I Scenario/Flusso di eventi Alternativo: L'allegato non è valido (Rif. SC_U_07)*
  - 4.a1 *Sistema:* Rileva che l'allegato supera i 50MB o ha un formato non consentito.
  - 4.a2 *Sistema:* Restituisce un messaggio di errore che indica i limiti ammessi.
  - 4.a3 *Sistema:* Attende una nuova compilazione mantenendo i dati testuali già inseriti nel modulo.

  #v(1em)

  *II Scenario/Flusso di eventi Alternativo: Salvataggio in bozza (Rif. SC_U_06)*
  - 7.b1 *Utente:* Sospende la compilazione e richiede il salvataggio in bozza della segnalazione.
  - 7.b2 *Sistema:* Salva la bozza in forma cifrata senza inviare alcuna notifica.
  - 7.b3 *Utente:* In una sessione successiva, riapre la bozza dalla lista, completa l'inserimento e riprende dal passo 6.

  #v(1em)

  *I Scenario/Flusso di eventi di ERRORE: I dati non possono essere salvati*
  - 5.a1 *Sistema:* Restituisce un messaggio di errore che invita a ritentare l'operazione di salvataggio.
  - 5.a2 *Sistema:* Attende una nuova azione dell'utente.

  #v(1em)

  *Note:* NA \
  *Special Requirements:* I dati salvati nel diario e le bozze temporanee devono risultare inaccessibili al Consigliere di Fiducia fino all'invio definitivo.
]

#callout-box(title: "UC_04 Monitoraggio e interruzione della segnalazione")[
  *Identificativo*: UC_04 \
  *Nome*: Monitoraggio e interruzione della segnalazione \
  *Data*: 07/11/2026 \
  *Versione*: 1.0 \
  *Autore*: Leonardo Trotta, Gianmarco Raimondi \
  *Descrizione*: Lo UC descrive la funzionalità di consultazione dello stato di avanzamento di una segnalazione attiva e la possibilità di ritirarla interrompendone l'iter ufficiale.

  *Entry Condition*:
  - Un Utente ha effettuato l'accesso al sistema 
  - L'Utente possiede almeno una segnalazione nello stato «Inviata» o «Presa in carico»
  
  *Exit condition (On success)*: \
  L'Utente visualizza correttamente le informazioni aggiornate sulla pratica \
  *OR* \
  La segnalazione viene archiviata definitivamente

  *Exit condition (On failure)*: \
  - Lo stato della segnalazione non subisce modifiche 
  - Il Sistema mostra un messaggio di errore

  *Rilevanza/User Priority*: Elevata \
  *Frequenza stimata*: Media (es. 5/giorno) \
  *Extension point*: NA \
  *Generalization of*: NA

  #v(1em)

  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Utente*: Richiede di visualizzare le proprie segnalazioni cliccando sull'apposita sezione.
  2. *Sistema*: Mostra l'elenco delle segnalazioni effettuate con il relativo stato.
  3. *Utente*: Seleziona una segnalazione per aprirne i dettagli.
  4. *Sistema*: Mostra la cronologia degli stati (es. «Inviata», «Presa in carico») e le eventuali note o appuntamenti fissati dal Consigliere di Fiducia (Rif. SC_U_05).

  #v(1em)

 * I Scenario/Flusso di eventi Alternativo: Rinuncia al proseguimento dell'iter (Rif. SC_U_08)*
  - 3.a1 *Utente*: Clicca sul comando per interrompere l'iter e ritirare la segnalazione.
  - 3.a2 *Sistema*: Mostra un avviso informando che l'azione comporterà l'archiviazione definitiva e richiede conferma.
  - 3.a3 *Utente*: Conferma la volontà di procedere.
  - 3.a4 *Sistema*: Imposta lo stato della segnalazione su «Archiviata» rendendola di sola lettura.
  - 3.a5 *Sistema*: Notifica il Consigliere di Fiducia dell'avvenuta interruzione dell'iter.

  #v(2em)

  *I Scenario/Flusso di eventi di ERRORE: Impossibile caricare i dettagli*
  - 4.a1 *Sistema*: Restituisce un messaggio di errore di connessione o di caricamento dati.
  - 4.a2 *Sistema*: Reindirizza l'Utente all'elenco generale delle segnalazioni.

  #v(1em)
  *Note*: NA \
  *Special Requirements*: Una volta portata nello stato «Archiviata», la segnalazione non può essere riaperta in alcun modo.
]