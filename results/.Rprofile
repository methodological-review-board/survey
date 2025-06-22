message("✅ .Rprofile eseguito — versione blindata")

# Attiva renv
tryCatch({
  source("renv/activate.R")
  message("✅ renv attivato")
}, error = function(e) {
  message("❌ Errore attivando renv: ", e$message)
})

# Carica readxl
tryCatch({
  suppressMessages(library(readxl))
  message("✅ readxl caricato")
}, error = function(e) {
  message("❌ ERRORE: Il pacchetto 'readxl' NON è stato caricato. Installa con renv::install('readxl')")
})

# Carica dati
tryCatch({
  dati <- read_excel("data/dati.xlsx")
  assign("dati", dati, envir = .GlobalEnv)
  message("✅ dati.xlsx caricato")
}, error = function(e) {
  message("❌ Errore caricando dati.xlsx: ", e$message)
})

tryCatch({
  dictionary <- read.csv("data/data_dictionary.csv")
  assign("dictionary", dictionary, envir = .GlobalEnv)
  message("✅ data_dictionary.csv caricato")
}, error = function(e) {
  message("❌ Errore caricando data_dictionary.csv: ", e$message)
})

# Carica setup.R
tryCatch({
  source("R/setup.R")
  message("✅ setup.R eseguito")
}, error = function(e) {
  message("❌ Errore in setup.R: ", e$message)
})

# Apri automaticamente il QMD se non già aperto
tryCatch({
  if (interactive() && rstudioapi::isAvailable()) {
    Sys.sleep(1)  # attende che l'interfaccia RStudio sia pronta
    f <- "analysis/data_analysis.qmd"
    open_file <- tryCatch(rstudioapi::getActiveDocumentContext()$path, error = function(e) "")
    if (!grepl(f, open_file)) {
      rstudioapi::navigateToFile(f)
      message("✅ data_analysis.qmd aperto")
    } else {
      message("ℹ️ data_analysis.qmd già aperto")
    }
  }
}, error = function(e) {
  message("❌ Errore aprendo il QMD: ", e$message)
})
