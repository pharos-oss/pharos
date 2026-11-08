#import "../../../templates/common.typ": callout-box

#callout-box(title: "UC_01 Invio di integrazioni per una segnalazione")[
  *Identificativo:* UC_01 \
  *Nome:* Invio di integrazioni per una segnalazione \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Carmine Saggese, Alessia D'amico \
  *Descrizione:* Lo UC descrive il processo mediante il quale l'Utente, a seguito di una notifica, fornisce informazioni e documenti aggiuntivi richiesti dal Consigliere di Fiducia per proseguire la lavorazione di una segnalazione.

  *Attore Principale:* Utente (È interessato a fornire il materiale mancante per far procedere l'iter della segnalazione) \
  *Attori secondari:* Consigliere di Fiducia, Sistema (Notifiche)

  *Entry Condition:* \
  Un Utente ha effettuato l'accesso al sistema \
  *AND* \
  L'Utente possiede una segnalazione passata allo stato «In attesa di integrazioni»

  *Exit condition (On success):* \
  Il materiale integrativo viene allegato alla segnalazione \
  *AND* \
  La segnalazione torna nello stato «In lavorazione» \
  *AND* \
  Il Sistema notifica il Consigliere di Fiducia

  *Exit condition (On failure):* \
  Le integrazioni non vengono salvate \
  *AND* \
  Il Sistema mostra all'Utente un messaggio di errore

  *Rilevanza/User Priority:* Elevata \
  *Frequenza stimata:* Bassa \
  *Extension point:* NA \
  *Generalization of:* NA

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

  #v(1em)
  *Note:* NA \
  *Special Requirements:* I materiali allegati tramite integrazione (inclusi gli eventi selezionati dal diario) devono risultare inaccessibili in chiaro e seguire le policy di cifratura del sistema.
]

#v(2em)

#callout-box(title: "UC_02 Esecuzione del triage guidato tramite IA")[
  *Identificativo:* UC_02 \
  *Nome:* Esecuzione del triage guidato tramite Intelligenza Artificiale \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Alessia D'amico, Carmine Saggese \
  *Descrizione:* Lo UC descrive l'utilizzo del modulo di Intelligenza Artificiale da parte dell'Utente per ottenere una valutazione orientativa su episodi annotati nel diario, al fine di decidere se avviare una segnalazione formale.

  *Attore Principale:* Utente (Interessato a comprendere la gravità di uno o più eventi e orientarsi sulle decisioni da prendere) \
  *Attori secondari:* Sistema (Modulo AI)

  *Entry Condition:* \
  Un Utente ha effettuato l'accesso al sistema \
  *AND* \
  L'Utente ha annotato nel diario almeno un episodio

  *Exit condition (On success):* \
  Il Sistema mostra all'Utente l'esito orientativo della valutazione \
  *AND* \
  L'Utente sceglie se procedere o meno con una segnalazione formale

  *Exit condition (On failure):* \
  La valutazione non viene fornita a causa di un disservizio del modulo AI \
  *AND* \
  Il Sistema mostra un messaggio di errore e ripristina lo stato iniziale

  *Rilevanza/User Priority:* Media \
  *Frequenza stimata:* Bassa \
  *Extension point:* NA \
  *Generalization of:* NA

  #v(1em)
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

  #v(1em)
  *I Scenario/Flusso di eventi Alternativo: Mantenimento nel diario senza segnalazione (Rif. SC_U_02)*
  - 8.a1 *Utente:* Sceglie di non avviare la segnalazione per il momento.
  - 8.a2 *Sistema:* Chiude il modulo di triage, mantiene gli eventi salvati nel diario e riporta l'Utente alla Home.

  #v(1em)
  *Note:* NA \
  *Special Requirements:* Il sistema deve garantire che il testo trasmesso al modulo AI sia completamente privato di dati identificativi per tutelare la privacy dell'Utente.
]