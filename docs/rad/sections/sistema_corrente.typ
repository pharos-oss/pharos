#import "../../templates/common.typ" : table-style, palette-primary
= Sistema Corrente
== Panoramica 
Il sistema attualmente in uso presso l'Università degli Studi di Salerno per la gestione delle segnalazioni di abusi, molestie, mobbing, straining e stalking, è caratterizzato da processi non digitalizzati e da una netta frammentazione dei servizi di supporto. Le vittime che desiderano cercare aiuto, devono interfacciarsi in autonomia con le figure preposte, come il Comitato Unico di Garanzia (CUG) e il Consigliere di Fiducia (attualmente in fase di attivazione), avvalendosi di canali di comunicazione tradizionali (e-mail istituzionale). Come evidenziato dall'analisi dei bisogni di business, questo modello presenta diverse "barriere" strutturali, ovvero: 

- *Scarsa tracciabilità*: Le procedure non sono strutturate e la vittima non possiede alcuno strumento per verificare in modo trasparente lo stato di avanzamento della propria pratica.

- *Gestione inefficiente delle evidenze*: La raccolta delle prove a supporto degli eventi lesivi avviene in maniera disordinata da parte della vittima, senza un sistema che ne certifichi l'ordine cronologico.

- *Disorientamento e diffidenza*: L'assenza di un percorso guidato e confidenziale disincentiva le segnalazioni; i dati dimostrano infatti che il 17% delle vittime non sa a chi segnalare l'episodio e il 26% ritiene che la segnalazione non porterebbe ad alcun risultato.

== Scenari
#[
  #set par(justify: false)
  #table(
    columns: (1fr, 1fr),
    ..table-style(palette-primary),
    align: left + horizon,
    inset: (y: 7pt, x: 8pt),
    stroke: 0.6pt + palette-primary.lighten(55%),

    table.cell(colspan: 2, fill: palette-primary, inset: (y: 9pt, x: 8pt))[#text(fill: white, size: 1.1em)[*Nome Scenario:* SC_1 Segnalazione manuale via e-mail]],
    table.cell(colspan: 2, fill: palette-primary.lighten(90%))[*Partecipanti:* Vittima (Studente/Dipendente), Consigliere di Fiducia],
    table.cell(colspan: 2, fill: palette-primary, align: center)[#text(fill: white)[*Flusso di eventi*]],
    table.cell(fill: palette-primary.lighten(70%), align: center)[*Vittima*],
    table.cell(fill: palette-primary.lighten(70%), align: center)[*Consigliere di Fiducia*],

    [La vittima ha subito o assistito a un episodio di molestia/mobbing e decide di cercare i contatti istituzionali. Naviga sul portale web dell'Università di Salerno.], table.cell(fill: luma(235))[],

    [La vittima individua la pagina del Consigliere di Fiducia (o del CUG) e ne annota l'indirizzo e-mail istituzionale.], table.cell(fill: luma(235))[],

    [La vittima raccoglie autonomamente le prove a supporto (es. screenshot, e-mail, documenti) in modo non strutturato salvandole sul proprio dispositivo.], table.cell(fill: luma(235))[],

    [La vittima redige un'e-mail descrivendo l'accaduto, allega le prove e la invia tramite posta ordinaria.], table.cell(fill: luma(235))[],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia riceve l'e-mail nella propria casella di posta istituzionale e ne prende visione.],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia esamina preliminarmente il caso e i documenti. Invia un'e-mail di risposta proponendo una data e un'ora per un colloquio conoscitivo.],

    [La vittima riceve l'e-mail e risponde confermando la propria disponibilità per l'appuntamento.], table.cell(fill: luma(235))[],

    table.cell(fill: luma(235))[], [Il Consigliere riceve la conferma e fissa l'appuntamento sul proprio calendario personale.],
  )
]

#v(2em)

#[
  #set par(justify: false)
  #table(
    columns: (1fr, 1fr),
    ..table-style(palette-primary),
    align: left + horizon,
    inset: (y: 7pt, x: 8pt),
    stroke: 0.6pt + palette-primary.lighten(55%),

    table.cell(colspan: 2, fill: palette-primary, inset: (y: 9pt, x: 8pt))[#text(fill: white, size: 1.1em)[*Nome Scenario:* SC_1 Alternativo Segnalazione manuale con richiesta di integrazioni]],
    table.cell(colspan: 2, fill: palette-primary.lighten(90%))[*Partecipanti:* Vittima (Studente/Dipendente), Consigliere di Fiducia],
    table.cell(colspan: 2, fill: palette-primary, align: center)[#text(fill: white)[*Flusso di eventi*]],
    table.cell(fill: palette-primary.lighten(70%), align: center)[*Vittima*],
    table.cell(fill: palette-primary.lighten(70%), align: center)[*Consigliere di Fiducia*],

    [La vittima ha subito o assistito a un episodio di molestia/mobbing e decide di cercare i contatti istituzionali. Naviga sul portale web dell'Università di Salerno.], table.cell(fill: luma(235))[],

    [La vittima individua la pagina del Consigliere di Fiducia (o del CUG) e ne annota l'indirizzo e-mail istituzionale.], table.cell(fill: luma(235))[],

    [La vittima raccoglie autonomamente le prove a supporto (es. screenshot, e-mail, documenti) in modo non strutturato salvandole sul proprio dispositivo.], table.cell(fill: luma(235))[],

    [La vittima redige un'e-mail descrivendo l'accaduto, allega le prime prove raccolte e la invia dalla propria casella di posta personale all'indirizzo istituzionale del Consigliere di Fiducia.], table.cell(fill: luma(235))[],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia riceve l'e-mail e analizza il caso, ma ritiene le informazioni fornite insufficienti per procedere.],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia risponde all'e-mail chiedendo alla vittima ulteriori dettagli o documenti integrativi.],

    [La vittima legge la richiesta, recupera il materiale mancante e lo invia in risposta al Consigliere di Fiducia.], table.cell(fill: luma(235))[],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia esamina le nuove informazioni e, ritenendole adeguate, invia un'e-mail proponendo una data e un'ora per il colloquio conoscitivo.],

    [La vittima riceve l'e-mail e risponde confermando la propria disponibilità per l'appuntamento.], table.cell(fill: luma(235))[],

    table.cell(fill: luma(235))[], [Il Consigliere di Fiducia riceve la conferma e fissa l'appuntamento sul proprio calendario personale.],
  )
]

== Activity Diagram 

#figure(
image("../assets/images/AD_1.png", width: 50%),
caption: ["AD_1 Activity Diagram scenario 1"],
)

#figure(
image("../assets/images/AD_1_Alternativo.png", width: 50%),
caption: ["AD_1 Activity Diagram scenario alternativo 1"],
)