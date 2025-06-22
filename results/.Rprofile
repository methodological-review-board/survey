
message("✅ .Rprofile eseguito — versione blindata")

# Attiva renv
tryCatch({
  source("renv/activate.R")
  message("✅ renv attivato")
}, error = function(e) {
  message("❌ Errore attivando renv: ", e$message)
})

# Carica setup.R
tryCatch({
  source("R/setup.R")
  message("✅ setup.R eseguito")
}, error = function(e) {
  message("❌ Errore in setup.R: ", e$message)
})

# Carica readxl dal percorso renv se necessario
tryCatch({
  suppressMessages(library(readxl))
  message("✅ readxl caricato")
}, error = function(e) {
  message("❌ ERRORE: Il pacchetto 'readxl' NON è stato caricato. Controlla l'ambiente renv o installalo con renv::install('readxl')")
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

# Apri il .qmd
tryCatch({
  if (interactive() && rstudioapi::isAvailable()) {
    rstudioapi::navigateToFile("analysis/data_analysis.qmd")
    message("✅ data_analysis.qmd aperto")
  }
}, error = function(e) {
  message("❌ Errore aprendo il .qmd: ", e$message)
})
