= Architettura del Sistema Corrente <architettura_corrente>

Attualmente, presso l'Università degli Studi di Salerno non è presente un'architettura software dedicata alla gestione delle segnalazioni di abusi, molestie, mobbing, straining e stalking. L'organizzazione esistente poggia su strumenti istituzionali generici non integrati tra loro e su flussi operativi manuali:

- *Portale Web Istituzionale di Ateneo:* espone pagine informative statiche contenenti i regolamenti e i recapiti e-mail del Comitato Unico di Garanzia (CUG) e del Consigliere di Fiducia (CDF), senza offrire funzionalità interattive di compilazione guidata o inoltro protetto.
- *Infrastruttura di Posta Elettronica Istituzionale:* costituisce l'unico canale digitale impiegato per l'invio delle segnalazioni, la trasmissione degli allegati e le comunicazioni successive (richieste di integrazione e fissazione dei colloqui conoscitivi).
- *Dispositivi personali degli utenti:* utilizzati autonomamente dagli studenti e dal personale universitario per raccogliere e archiviare localmente le evidenze (screenshot, documenti PDF, e-mail, registrazioni audio) prive di cifratura dedicata e di marcatura cronologica certificata.
- *Strumenti personali del Consigliere di Fiducia:* casella di posta elettronica istituzionale, archivio locale e calendario personale adottati dal CDF per esaminare le segnalazioni, pianificare i colloqui e predisporre manualmente i riepiloghi statistici destinati al CUG.

Il flusso delle interazioni tra questi componenti è interamente guidato dall'iniziativa manuale degli attori, infatti l'utente ricerca autonomamente i recapiti sul portale web di Ateneo, raccoglie e conserva le prove sul proprio dispositivo e le invia tramite e-mail al CDF. Quest'ultimo analizza la corrispondenza e gestisce l'intero ciclo di vita del'iter mediante risposte e-mail asincrone, sia qualora si rendano necessarie integrazioni  sia per concordare e annotare sul proprio calendario personale la data di un colloquio conoscitivo.

Questa configurazione architetturale determina tre criticità strutturali:

1. *Assenza di confidenzialità strutturale:* manca una separazione logica tra l'identità dell'utente e il contenuto della segnalazione fin dal primo contatto, alimentando il timore di ritorsioni.

2. *Mancanza di persistenza centralizzata e tracciabilità:* non esiste una base di dati condivisa degli stati della segnalazione che consenta all'utente di monitorare l'avanzamento dell'iter e al CDF di estrarre report statistici aggregati senza elaborazione manuale.

3. *Assenza di supporto all'inquadramento preliminare:* manca qualsiasi strumento applicativo che aiuti l'utente a valutare la natura degli eventi subiti e a raccordarsi con i servizi territoriali di assistenza.