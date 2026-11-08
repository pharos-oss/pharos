#import "../../../templates/common.typ": callout-box

#callout-box(title: "UC_CDF_1 Prendere in carico una segnalazione")[
  *Identificativo:* UC_CDF_1 \
  *Nome:* Prendere in carico una segnalazione \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Francesco Imbriaco \
  *Descrizione:* Lo UC descrive il processo mediante il quale il Consigliere di Fiducia esamina le segnalazioni ricevute e prende in carico una nuova segnalazione nello stato «Inviata».

  *Attore Principale:* Consigliere di Fiducia (È interessato a esaminare e prendere in carico le nuove segnalazioni per avviarne la lavorazione) \
  *Attori secondari:* Sistema (Notifiche)

  *Entry Condition:* \
  - Il Consigliere di Fiducia ha effettuato l'accesso al sistema \
  - Esiste almeno una segnalazione nello stato «Inviata» \

  *Exit condition (On success):* \
  - La segnalazione passa nello stato «Presa in carico» \
  - Il Sistema notifica l'Utente \

  *Exit condition (On failure):* \
  - La segnalazione resta nello stato «Inviata» \

  *Rilevanza/User Priority:* Elevata \
  *Frequenza stimata:* 5/giorno \
  *Extension point:* NA \
  *Generalization of:* NA \

  #v(1em)
  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Consigliere di Fiducia:* Richiede l'elenco delle segnalazioni.
  2. *Sistema:* Mostra le segnalazioni, evidenziando quelle nuove.
  3. *Consigliere di Fiducia:* Apre una nuova segnalazione.
  4. *Sistema:* Mostra tipologia, descrizione ed eventi allegati in ordine cronologico.
  5. *Consigliere di Fiducia:* Prende in carico la segnalazione.
  6. *Sistema:* Imposta lo stato «Presa in carico».
  7. *Sistema (Notifiche):* Notifica l'Utente.

  #v(1em)
  *I Scenario/Flusso di eventi Alternativo: Nessuna nuova segnalazione*
  - 2.a1 *Sistema:* Informa che non ci sono nuove segnalazioni.

  #v(1em)
  *Note:* NA \
  *Special Requirements:* Ogni accesso del Consigliere di Fiducia a una segnalazione viene registrato.
]