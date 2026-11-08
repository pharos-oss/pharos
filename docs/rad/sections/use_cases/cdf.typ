#import "../../../templates/common.typ": callout-box

=== Casi d'uso: Consigliere Di Fiducia

#v(19em)

#figure(
  image("Diagramma UC.png", width: 115%),
  caption: ["Diagramma Caso D'uso CDF"]
)

#pagebreak()

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
  *Extension point:* N/A \
  *Generalization of:* N/A \

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
  *Note:* N/A \
  *Special Requirements:* Ogni accesso del Consigliere di Fiducia a una segnalazione viene registrato.
]

#pagebreak()

#callout-box(title: "UC_CDF_2 Chiudere una pratica")[
  *Identificativo:* UC_CDF_2 \
  *Nome:* Chiudere una pratica \
  *Data:* 07/11/2026 \
  *Versione:* 1.0 \
  *Autore:* Mario Senatore \
  *Descrizione:* Lo UC descrive il processo mediante il quale il Consigliere di Fiducia chiude una pratica indicandone l'esito e la archivia in sola lettura.

  *Attore Principale:* Consigliere di Fiducia (È interessato a concludere formalmente la lavorazione di una pratica e archiviarla) \
  *Attori secondari:* Sistema (Notifiche)

  *Entry Condition:* \
  - Il Consigliere di Fiducia ha effettuato l'accesso al sistema \
  - La pratica è stata presa in carico e non è chiusa né archiviata

  *Exit condition (On success):* \
  - La pratica passa nello stato «Chiusa» e viene archiviata in sola lettura \
  - Il Sistema notifica l'Utente \

  *Exit condition (On failure):* \
  - La pratica resta aperta \

  *Rilevanza/User Priority:* Elevata \
  *Frequenza stimata:* 2/giorno \
  *Extension point:* N/A \
  *Generalization of:* N/A

  #v(1em)
  *FLUSSO DI EVENTI PRINCIPALE / MAIN SCENARIO*
  1. *Consigliere di Fiducia:* Apre la pratica e richiede la chiusura.
  2. *Sistema:* Chiede l'esito e una nota conclusiva.
  3. *Consigliere di Fiducia:* Seleziona l'esito, scrive la nota e conferma.
  4. *Sistema:* Imposta lo stato «Chiusa» e archivia la pratica in sola lettura.
  5. *Sistema (Notifiche):* Notifica l'Utente.

  #v(1em)
  *I Scenario/Flusso di eventi Alternativo: Esito non selezionato*
  - 3.a1 *Sistema:* Chiede di selezionare l'esito della pratica.

  #v(1em)
  *Note:* N/A \
  *Special Requirements:* N/A
]