library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  titlePanel("Sviluppo del Methodological Review Board (MRB) in Psicologia"),
  
  sidebarLayout(
    sidebarPanel(
      width = 6,  # aumenta la larghezza a sinistra
      h4("Naviga tra i blocchi"),
      tabsetPanel(
        id = "sezione",
        
        tabPanel("1. Demografiche",
                 selectInput("categoria", "A quale categoria del personale appartieni all'interno dell'Ateneo?",
                             choices = c("PO, PA, RTD, RTT", "Dottorato, assegno di ricerca")),
                 
                 h5("Quali metodi utilizzi nella tua ricerca?"),
                 
                 radioButtons("metodo_quant_sper", "Quantitativo - Sperimentale",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("metodo_quant_oss", "Quantitativo - Osservazionale",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("metodo_quant_altro", "Quantitativo - Altro",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("metodo_qual", "Qualitativo",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("metodo_teorico", "Teorico",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("osf", "Hai un account su Open Science Framework (www.osf.io) o su altri repository open access (ad es., AsPredicted, Nature Scientific Data)?",
                              choices = c("Sì", "No", "Non lo so"))
        ),
        
        tabPanel("2. Crisi di replicabilità",
                 radioButtons("replicabilita", "Negli ultimi anni si è parlato del frequente fallimento della replica dei risultati nella ricerca psicologica (noto come crisi di replicabilità). Ne hai mai sentito parlare?",
                              choices = c("Sì", "No")),
                 radioButtons("importanza_rep", "Pensi che la crisi di replicabilità sia un problema rilevante per il progresso scientifico?",
                              choices = c("Sì", "No")),
                 h5("Ti chiediamo di indicare quanto ritieni che i seguenti fattori possano essere cause della crisi di replicabilità. (0 = per niente, 4 = molto)"),
                 sliderInput("metodi_obsoleti", "Metodi obsoleti", 0, 4, value = 0),
                 sliderInput("dati_scarso", "Dati di scarsa qualità", 0, 4, value = 0),
                 sliderInput("validita_esterna", "Mancanza di validità esterna", 0, 4, value = 0),
                 sliderInput("validita_interna", "Mancanza di validità interna", 0, 4, value = 0),
                 sliderInput("bias", HTML("Publication bias<sup>1</sup>"), 0, 4, value = 0),
                 sliderInput("gradi_liberta", HTML("Gradi di libertà del ricercatore<sup>2</sup>"), 0, 4, value = 0),
                 
                 sliderInput("frode", "Frode", 0, 4, value = 0)
        ),
        
        
        tabPanel("3. Open Science",
                 h5("Le seguenti affermazioni riguardano la tua familiarità con la pre-registrazione e l'Open Science. Ti chiediamo di indicare se hai già sentito parlare di queste pratiche."),
                 
                 radioButtons("os_prereg_ip", "Pre-registrazione\u00B3 delle ipotesi di uno studio",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("os_prereg_analisi", "Pre-registrazione del piano di analisi dei dati di uno studio",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("os_rr", "Registered Report\u2074",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 h5("Le seguenti affermazioni riguardano le pratiche di pre-registrazione. Ti chiediamo di indicare se hai utilizzato una di queste pratiche in almeno uno dei tuoi studi."),
                 radioButtons("uso_ipotesi", "Ho pre-registrato le ipotesi",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 radioButtons("uso_analisi", "Ho pre-registrato il piano di analisi dei dati",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 radioButtons("uso_rr", "Ho pubblicato un Registered Report",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 radioButtons("open_mat", "Ho condiviso per quanto possibile strumenti e materiali utilizzati (open materials)",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 radioButtons("open_code", "Ho condiviso pubblicamente i codici/script utilizzati per l'analisi dei dati (open code)",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 radioButtons("open_data", "Ho reso disponibili i dati utilizzati su una repository pubblica (open data)",
                              choices = c("No, mai", "Sì ma non personalmente", "Sì personalmente")),
                 
                 h5("Le seguenti affermazioni riguardano alcune pratiche di Open Science. Per ciascuna, ti chiediamo di indicare quanto ritieni possa contribuire al progresso della tua disciplina. (0 = per niente, 4 = molto)"),
                 sliderInput("val_ipotesi", "Pre-registrare le ipotesi", 0, 4, 0),
                 sliderInput("val_analisi", "Pre-registrare il piano analisi dei dati", 0, 4, 0),
                 sliderInput("val_rr", "Registered Report", 0, 4, 0),
                 
                 h5("Pensando al tuo prossimo progetto di ricerca, quanto ritieni probabile l'utilizzo di ciascuna delle seguenti pratiche? (0 = per niente, 4 = molto)"),
                 sliderInput("futuro_ipotesi", "Pre-registrazione delle ipotesi", 0, 4, 0),
                 sliderInput("futuro_analisi", "Pre-registrazione del piano d'analisi dei dati", 0, 4, 0),
                 sliderInput("futuro_materiali", "Condivisione di strumenti e materiali utilizzati (open materials)", 0, 4, 0),
                 sliderInput("futuro_codice", "Condivisione publica dei codici/script utilizzati per l'analisi dei dati (open code)", 0, 4, 0),
                 sliderInput("futuro_dati", "Condivisione dei dati raccolti su una repository pubblica (open data)", 0, 4, 0),
        ),
        
        
        tabPanel("4. Methodological Review Board",
                 h5("In relazione alla parte metodologica, psicometrica e statistica, generalmente con chi ti confronti prima di condurre il tuo studio?"),
                 
                 radioButtons("confronto_gruppo", "Qualcuno del gruppo di ricerca",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("confronto_esterno", "Un esperto esterno che inserisco come co-autore",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 radioButtons("confronto_noesterno", "Un esperto esterno non inserisco come co-autore",
                              choices = c("Sì", "No"), inline = TRUE),
                 
                 h5("Pensando alla possibilità di pre-registrare uno dei tuoi prossimi studi, indica il tuo grado di accordo per ciascuna affermazione. (0 = per niente, 4 = completamente)"),
                 sliderInput("aiuto_mrb", "Avrei bisogno di qualcuno che mi assista nel preparare la pre-registrazione dello studio", 0, 4, 0),
                 sliderInput("fiducia_mrb", "Confrontarmi con il Methodological Review Board mi darebbe sicurezza nel sottoporre il mio studio a peer-review", 0, 4, 0),
                 
                 h5("Pensando all'implementazione di un Methodological Review Board, ti chiediamo di indicare il tuo grado di accordo rispetto all'utilità che potrebbe avere in relazione a ciascuna delle seguenti affermazioni. (0 = per niente, 4 = completamente)"),
                 sliderInput("utilita_istituzionale", "Fungere da punto di riferimento per l'ambito metodologico a livello istituzionale", 0, 4, 0),
                 sliderInput("collaborazioni", "Promuovere collaborazioni più solide tra i membri del mio dipartimento", 0, 4, 0),
                 sliderInput("sprechi", "Previenire sprechi di risorse (tempo, denaro, risorse umane, ecc.)", 0, 4, 0),
                 sliderInput("qualita", "Migliorare la qualità della ricerca prodotta", 0, 4, 0),
                 sliderInput("buone_pratiche", "Promuovere la diffusione delle buone pratiche", 0, 4, 0),
                 radioButtons("integrazione", "Pensi che un eventuale Methodological Review Board dovrebbe essere integrato all'interno del Comitato Etico del dipartimento?",
                              choices = c("Sì", "No"))
        ),
        
        tabPanel("5. Commenti finali",
                 textAreaInput("commento", "Quali elementi dovrebbe avere un eventuale Methodological Review Board di dipartimento (es., anonimato dei progetti di studio sottoposti, momenti di confronto sui feedback, ecc.)?", "", width = "100%"),
                 radioButtons("tavola_rotonda", "Ritieni utile l'organizzazione di una tavola rotonda di confronto sul Methodological Review Board e sui suoi possibili ambiti d'azione?",
                              choices = c("Sì", "No")),
                 actionButton("submit", "Invia tutte le risposte"),
                 uiOutput("grazie")
        )
      )
    ),
    
    mainPanel(
      width = 6,
      conditionalPanel(
        condition = "input.sezione == '1. Demografiche'",
        h4("Gentile collega,"),
        p("Questa survey si inserisce all’interno del progetto di Ateneo Terza Missione e Open Science – Linea B “Sviluppo del Methodological Review Board (MRB) in Psicologia”, di cui è responsabile il Prof. Gianmarco Altoè (gianmarco.altoe@unipd.it)."),
        
        p("L’obiettivo è raccogliere opinioni, bisogni e aspettative riguardo alla creazione di un MRB che, in linea con i principi dell’Open Science, mira a promuovere la trasparenza, la qualità metodologica e l’integrità nella ricerca in psicologia."),
        
        p("Le tue risposte saranno raccolte in forma anonima e ci aiuteranno a delineare il campo di azione del MRB."),
        
        p("Ti ringraziamo fin da ora per il tuo contributo, condizione indispensabile per la buona riuscita del progetto."),
        
        p("Compila i blocchi a sinistra, poi invia tutto nell'ultima sezione.")  ),
      
      conditionalPanel(
        condition = "input.sezione == '2. Crisi di replicabilità'",
        h4(""),
        HTML("
  <div style='background-color:#f8f9fa; border-left: 4px solid #18BC9C; padding: 15px; margin-top: 20px; border-radius: 5px;'>
    <p>📗 <strong>Definizioni</strong></p>

    <p style='margin-top:10px;'>
      <sup>1</sup> <strong>Publication bias</strong>: la tendenza a pubblicare più facilmente studi con risultati significativi, mentre quelli con risultati non significativi vengono trascurati, distorcendo la percezione della ricerca. 
      Un altro fattore coinvolto nel publication bias è il <strong>File drawer problem</strong>, cioè il fenomeno per cui gli studi con risultati negativi o non significativi non vengono proposti per la pubblicazione rispetto a quelli con risultati positivi, creando un'immagine distorta della realtà scientifica.
    </p>

    <p style='margin-top:10px;'>
      <sup>2</sup> <strong>Gradi di libertà del ricercatore</strong>: le scelte metodologiche e analitiche che i ricercatori possono fare durante uno studio, come la selezione dei dati, l'inclusione o l'esclusione di variabili e la scelta dei metodi statistici (ad es., <em>p-hacking</em>). 
      Queste decisioni possono influenzare i risultati e la replicabilità della ricerca. 
      Tra di essi rientra anche l'<strong>Author bias</strong>, cioè la tendenza di un autore a influenzare i risultati di uno studio con le proprie opinioni, esperienze o convinzioni, anziché presentare le informazioni in modo completamente oggettivo.
    </p>
  </div>
  ")
      ),
      conditionalPanel(
        condition = "input.sezione == '3. Open Science'",
        h4(""),
        HTML("
  <div style='background-color:#f8f9fa; border-left: 4px solid #18BC9C; padding: 15px; margin-top: 20px; border-radius: 5px;'>
    <p>📗 <strong>Definizioni</strong></p>
    <p style='margin-top:10px;'><sup>3</sup> <strong>Pre-registrazione</strong>: il processo di registrazione pubblica di un piano di ricerca, inclusi obiettivi, metodi e analisi previste, prima che lo studio venga effettivamente condotto.</p>
    <p style='margin-top:10px;'><sup>4</sup> <strong>Registered Report</strong>: un tipo di pubblicazione scientifica in cui il protocollo di ricerca, inclusi obiettivi, metodi e analisi previste, viene registrato e sottoposto a peer review prima che lo studio venga condotto.</p>
  </div>
  ")
      ),
      
      conditionalPanel(
        condition = "input.sezione == '4. Methodological Review Board'",
        h4(""),
        p("Il Methodological Review Board è pensato come un servizio multidisciplinare che fornisce supporto allo sviluppo dei progetti di ricerca, fornendo suggerimenti relativi alla formulazione dei quesiti di ricerca, giustificazione della dimensione del campione e raccolta dei dati, scelta degli strumenti per rilevare i costrutti di interesse, implementazione dell’analisi dei dati, nell’ambito di un processo di pre-registrazione e Open Science (es., tramite piattaforme quali OSF)."),
        p("Al fine di definire al meglio il campo d'azione di un potenziale Methodological Review Board, ti chiediamo di rispondere ancora a qualche domanda.")
      ),
      
      conditionalPanel(
        condition = "input.sezione == '5. Commenti finali'",
        h4(""),
        p("Nel presente blocco puoi scegliere se riportare la tua opinione."), 
        p("Ricorda che per noi ogni risposta può fare la differenza.")
      )
    )
    
  )
)

server <- function(input, output) {
  
  observeEvent(input$submit, {
    
    obbligatori <- c(
      input$categoria,
      input$metodo_quant_sper,
      input$metodo_quant_oss,
      input$metodo_quant_altro,
      input$metodo_qual,
      input$metodo_teorico,
      input$osf,
      input$replicabilita,
      input$importanza_rep,
      input$metodi_obsoleti,
      input$dati_scarso,
      input$validita_esterna,
      input$validita_interna,
      input$bias,
      input$gradi_liberta,
      input$frode,
      input$os_prereg_ip,
      input$os_prereg_analisi,
      input$os_rr,
      input$uso_ipotesi,
      input$uso_analisi,
      input$uso_rr,
      input$open_mat,
      input$open_code,
      input$open_data,
      input$val_ipotesi,
      input$val_analisi,
      input$val_rr,
      input$futuro_ipotesi,
      input$futuro_analisi,
      input$futuro_materiali,
      input$futuro_codice,
      input$futuro_dati,
      input$confronto_gruppo,
      input$confronto_esterno,
      input$confronto_noesterno,
      input$aiuto_mrb,
      input$fiducia_mrb,
      input$utilita_istituzionale,
      input$collaborazioni,
      input$sprechi,
      input$qualita,
      input$buone_pratiche,
      input$integrazione,
      input$tavola_rotonda
    )
    
    if (any(sapply(obbligatori, function(x) is.null(x) || x == ""))) {
      showModal(modalDialog(
        title = "Attenzione",
        "Per favore, rispondi a tutte le domande prima di inviare.",
        easyClose = TRUE,
        footer = modalButton("Chiudi")
      ))
      return()
    }
    
    risposte <- data.frame(
      timestamp = Sys.time(),
      categoria = input$categoria,
      metodo_quant_sper = input$metodo_quant_sper,
      metodo_quant_oss = input$metodo_quant_oss,
      metodo_quant_altro = input$metodo_quant_altro,
      metodo_qual = input$metodo_qual,
      metodo_teorico = input$metodo_teorico,
      osf = input$osf,
      replicabilita = input$replicabilita,
      importanza_rep = input$importanza_rep,
      metodi_obsoleti = input$metodi_obsoleti,
      dati_scarso = input$dati_scarso,
      validita_esterna = input$validita_esterna,
      validita_interna = input$validita_interna,
      bias = input$bias,
      gradi_liberta = input$gradi_liberta,
      frode = input$frode,
      os_prereg_ip = input$os_prereg_ip,
      os_prereg_analisi = input$os_prereg_analisi,
      os_rr = input$os_rr,
      uso_ipotesi = input$uso_ipotesi,
      uso_analisi = input$uso_analisi,
      uso_rr = input$uso_rr,
      open_mat = input$open_mat,
      open_code = input$open_code,
      open_data = input$open_data,
      val_ipotesi = input$val_ipotesi,
      val_analisi = input$val_analisi,
      val_rr = input$val_rr,
      futuro_ipotesi = input$futuro_ipotesi,
      futuro_analisi = input$futuro_analisi,
      futuro_materiali = input$futuro_materiali,
      futuro_codice = input$futuro_codice,
      futuro_dati = input$futuro_dati,
      confronto_gruppo = input$confronto_gruppo,
      confronto_esterno = input$confronto_esterno,
      confronto_noesterno = input$confronto_noesterno,
      aiuto_mrb = input$aiuto_mrb,
      fiducia_mrb = input$fiducia_mrb,
      utilita_istituzionale = input$utilita_istituzionale,
      collaborazioni = input$collaborazioni,
      sprechi = input$sprechi,
      qualita = input$qualita,
      buone_pratiche = input$buone_pratiche,
      integrazione = input$integrazione,
      commento = input$commento,
      tavola_rotonda = input$tavola_rotonda,
      stringsAsFactors = FALSE
    )
    
    write.table(risposte, "risposte_complete.csv", sep = ";", append = TRUE,
                row.names = FALSE, col.names = !file.exists("risposte_complete.csv"))
    
    output$grazie <- renderUI({
      HTML("<p>Grazie per aver completato il sondaggio.</p><p style='margin-top: 10px;'>La risposta è stata registrata.</p>")
    })
  })
}

shinyApp(ui = ui, server = server)
