#import "../../templates/common.typ": palette-primary, callout-box

= Sistema Corrente <sis_corrente>
Il sistema attualmente in uso presso l'Università degli Studi di Salerno per la gestione delle segnalazioni di abusi, molestie, mobbing, straining e stalking è caratterizzato da processi non digitalizzati e da una netta frammentazione dei servizi di supporto. Gli utenti che desiderano cercare aiuto devono interfacciarsi in autonomia con le figure preposte, come il Comitato Unico di Garanzia (CUG) e il Consigliere di Fiducia (attualmente in fase di attivazione), avvalendosi di canali di comunicazione tradizionali (e-mail istituzionale).

Come evidenziato dall'analisi dei bisogni di business, questo modello presenta diverse barriere strutturali, ovvero:

- *Scarsa tracciabilità*: le procedure non sono strutturate e l'utente non possiede alcuno strumento per verificare in modo trasparente lo stato di avanzamento della propria pratica.

- *Gestione inefficiente delle evidenze*: la raccolta delle prove a supporto degli eventi lesivi avviene in maniera disordinata da parte dell'utente, senza un sistema che ne certifichi l'ordine cronologico.

- *Disorientamento e diffidenza*: l'assenza di un percorso guidato e confidenziale disincentiva le segnalazioni; i dati dimostrano infatti che il 17% degli utenti non sa a chi segnalare l'evento e il 26% ritiene che la segnalazione non porterebbe ad alcun risultato.

#v(1em)

== Scenari

#v(0.5em)

#callout-box(title: "SC_1 Segnalazione manuale via e-mail")[

  *Partecipanti:* Utente (Studente/Dipendente), Consigliere di Fiducia

  *Flusso di eventi:*

  + L'utente ha subito o assistito a un evento di molestia/mobbing e cerca i contatti istituzionali sul portale web dell'Università di Salerno.
  + L'utente individua la pagina del Consigliere di Fiducia (o del CUG) e ne annota l'indirizzo e-mail istituzionale.
  + L'utente raccoglie autonomamente le prove a supporto (es. screenshot, e-mail, documenti), salvandole sul proprio dispositivo.
  + L'utente redige un'e-mail descrivendo l'accaduto, allega le prove e la invia dalla propria casella di posta personale al Consigliere di Fiducia.
  + Il Consigliere di Fiducia riceve l'e-mail ed esamina la segnalazione e gli allegati.
  + Il Consigliere di Fiducia risponde proponendo una data e un'ora per un colloquio conoscitivo.
  + L'utente conferma la propria disponibilità per l'appuntamento.
  + Il Consigliere di Fiducia fissa l'appuntamento sul proprio calendario personale.
]

#pagebreak()

#callout-box(title: "SC_1_ALT Segnalazione manuale con richiesta di integrazioni")[

  *Partecipanti:* Utente (Studente/Dipendente), Consigliere di Fiducia

  *Flusso di eventi:* i passi 1–4 coincidono con lo scenario SC_1.

  #set enum(start: 5)
  + Il Consigliere di Fiducia riceve l'e-mail e analizza la segnalazione, ma ritiene le informazioni insufficienti.
  + Il Consigliere di Fiducia chiede all'utente ulteriori integrazioni.
  + L'utente recupera il materiale mancante e lo invia al Consigliere di Fiducia.
  + Il Consigliere di Fiducia esamina le nuove informazioni e propone una data e un'ora per il colloquio conoscitivo.
  + L'utente conferma la propria disponibilità per l'appuntamento.
  + Il Consigliere di Fiducia fissa l'appuntamento sul proprio calendario personale.
]

#v(2em)

== Activity Diagram
In questa sezione viene mostrato il diagramma delle attività del sistema corrente, illustrando il flusso operativo attuale e le interazioni tra gli attori coinvolti nella gestione delle segnalazioni.

#v(0.5em)

#figure(
  image("../assets/images/AD_01_Sistema_Corrente.png", width: 80%),
  caption: ["Activity Diagram: Diagramma delle Attività del Sistema Corrente"]
)