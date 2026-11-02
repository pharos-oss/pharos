#import "../../templates/common.typ": palette-primary

#let scenario-box = block.with(
  width: 100%,
  inset: 12pt,
  radius: 4pt,
  fill: palette-primary.lighten(93%),
  stroke: (left: 3pt + palette-primary),
)

= Sistema Corrente

#v(1em)

== Panoramica

Il sistema attualmente in uso presso l'Università degli Studi di Salerno per la gestione delle segnalazioni di abusi, molestie, mobbing, straining e stalking è caratterizzato da processi non digitalizzati e da una netta frammentazione dei servizi di supporto. Le vittime che desiderano cercare aiuto devono interfacciarsi in autonomia con le figure preposte, come il Comitato Unico di Garanzia (CUG) e il Consigliere di Fiducia (attualmente in fase di attivazione), avvalendosi di canali di comunicazione tradizionali (e-mail istituzionale).

Come evidenziato dall'analisi dei bisogni di business, questo modello presenta diverse "barriere" strutturali, ovvero:

- *Scarsa tracciabilità*: le procedure non sono strutturate e la vittima non possiede alcuno strumento per verificare in modo trasparente lo stato di avanzamento della propria pratica.

- *Gestione inefficiente delle evidenze*: la raccolta delle prove a supporto degli eventi lesivi avviene in maniera disordinata da parte della vittima, senza un sistema che ne certifichi l'ordine cronologico.

- *Disorientamento e diffidenza*: l'assenza di un percorso guidato e confidenziale disincentiva le segnalazioni; i dati dimostrano infatti che il 17% delle vittime non sa a chi segnalare l'episodio e il 26% ritiene che la segnalazione non porterebbe ad alcun risultato.

#v(2em)

== Scenari

#v(0.5em)

#scenario-box[
  === SC_1 Segnalazione manuale via e-mail

  #v(0.3em)

  *Partecipanti:* Vittima (Studente/Dipendente), Consigliere di Fiducia

  *Flusso di eventi:*

  + La vittima ha subito o assistito a un episodio di molestia/mobbing e cerca i contatti istituzionali sul portale web dell'Università di Salerno.
  + La vittima individua la pagina del Consigliere di Fiducia (o del CUG) e ne annota l'indirizzo e-mail istituzionale.
  + La vittima raccoglie autonomamente le prove a supporto (es. screenshot, e-mail, documenti), salvandole sul proprio dispositivo.
  + La vittima redige un'e-mail descrivendo l'accaduto, allega le prove e la invia dalla propria casella di posta personale al Consigliere di Fiducia.
  + Il Consigliere di Fiducia riceve l'e-mail ed esamina il caso e i documenti.
  + Il Consigliere di Fiducia risponde proponendo una data e un'ora per un colloquio conoscitivo.
  + La vittima conferma la propria disponibilità per l'appuntamento.
  + Il Consigliere di Fiducia fissa l'appuntamento sul proprio calendario personale.
]

#v(1.5em)

#scenario-box[
  === SC_1_ALT Segnalazione manuale con richiesta di integrazioni

  #v(0.3em)

  *Partecipanti:* Vittima (Studente/Dipendente), Consigliere di Fiducia

  *Flusso di eventi:* i passi 1–4 coincidono con lo scenario SC_1.

  #set enum(start: 5)
  + Il Consigliere di Fiducia riceve l'e-mail e analizza il caso, ma ritiene le informazioni insufficienti.
  + Il Consigliere di Fiducia chiede alla vittima ulteriori dettagli o documenti integrativi.
  + La vittima recupera il materiale mancante e lo invia al Consigliere di Fiducia.
  + Il Consigliere di Fiducia esamina le nuove informazioni e propone una data e un'ora per il colloquio conoscitivo.
  + La vittima conferma la propria disponibilità per l'appuntamento.
  + Il Consigliere di Fiducia fissa l'appuntamento sul proprio calendario personale.
]

#v(2em)

== Activity Diagram

#v(0.5em)

#figure(
  image("../assets/images/AD_Unico.jpg", width: 50%),

)