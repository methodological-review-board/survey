library(readxl)
library(here)
library(datadictionary)

######################################## Importazione Dataset
dataMRB <- read_excel(here("data", "dati.xlsx"))
dataMRB <- data.frame(dataMRB)

######################################## DATACLEANING

## 1.1. Eliminazione di righe == preview (compilazioni pre-15 aprile),
## questionari non completi
## prime due righe ridondanti

datacleaned <- dataMRB[-(c(1:12, 62, 67)), -(c(2:6,8:17))]
datacleaned <- datacleaned[datacleaned$Finished == "True", ]

## Rinominazione degli item ID

item_renamed <- matrix(data = c("Start date", "Finished", 1, 2.1, 2.2, 2.3, 2.4,
                                2.5, 3, 4, 5, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6,
                                6.7, 7.1, 7.2, 7.3, 8.1, 8.2, 8.3, 8.4, 8.5,
                                8.6, 9.1, 9.2, 9.3, 10.1, 10.2, 10.3, 10.4,
                                10.5, 11.1, 11.2, 11.3, 12.1, 12.2, 13.1,
                                13.2, 13.3, 13.4, 13.5, 14, 15, 16
), 1, 48)

colnames(datacleaned) <- as.character(datacleaned[1, ])  # Set first row as column names
colnames(datacleaned) <- item_renamed

## Rinominazione righe
row_renamed <- matrix(data = c(1:53), nrow = 53, ncol = 1)
rownames(datacleaned) <- as.character(datacleaned[,1])
rownames(datacleaned) <- row_renamed

######################################## DATA DICTIONARY
dictionary <- create_dictionary(datacleaned)
write.csv(dictionary, "data_dictionary.csv", row.names = FALSE)

########################################################################################
######################################## FUNZIONI DESCRITTIVE AGGREGATE

## Funzione per plot frequenze
require(ggplot2)

plot_frequenze <- function(colonna, titolo) {
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]), ]
  
  if (nrow(dati_filtrati) == 0) {
    warning("Nessun dato disponibile per il grafico.")
    return(NULL)
  }
  
  freq_table <- as.data.frame(table(Risposta = dati_filtrati[[colonna]]))
  colnames(freq_table)[2] <- "Frequenza"
  freq_table$Percentuale <- (freq_table$Frequenza / sum(freq_table$Frequenza)) * 100
  N <- sum(freq_table$Frequenza)
  
  ggplot(freq_table, aes(x = Risposta, y = Percentuale)) +
    geom_col(width = 0.7, fill = "#89BFEA", show.legend = FALSE) +
    geom_text(aes(label = paste0("n=", Frequenza)), vjust = -0.4, size = 6) +
    labs(
      title = titolo,
      subtitle = paste("N =", N),
      x = "Risposta",
      y = "Percentuale"
    ) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, 100)) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

## Funzione per likert "Per niente-Molto"

plot_likert_molto <- function(colonna, titolo) {
  dati <- datacleaned[[colonna]]
  
  mappa_likert <- c(
    "Per niente" = "Per niente", "per niente" = "Per niente",
    "Poco" = "Poco", "poco" = "Poco",
    "Abbastanza" = "Abbastanza", "abbastanza" = "Abbastanza",
    "Molto" = "Molto", "molto" = "Molto"
  )
  
  dati_raggruppati <- mappa_likert[as.character(dati)]
  dati_raggruppati <- dati_raggruppati[!is.na(dati_raggruppati) & dati_raggruppati != ""]
  
  livelli_ordinati <- c("Per niente", "Poco", "Abbastanza", "Molto")
  dati_fattore <- factor(dati_raggruppati, levels = livelli_ordinati, ordered = TRUE)
  
  freq_table <- as.data.frame(table(Risposta = dati_fattore))
  colnames(freq_table)[2] <- "Frequenza"
  freq_table$Percentuale <- (freq_table$Frequenza / sum(freq_table$Frequenza)) * 100
  N <- sum(freq_table$Frequenza)
  
  ggplot(freq_table, aes(x = Risposta, y = Percentuale)) +
    geom_col(width = 0.7, fill = "#89BFEA", show.legend = FALSE) +
    geom_text(aes(label = paste0("n=", Frequenza)), vjust = -0.4, size = 5.2) +
    labs(
      title = titolo,
      subtitle = paste("N =", N),
      x = "Risposta",
      y = "Percentuale"
    ) +
    scale_x_discrete(drop = FALSE, limits = livelli_ordinati) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, 100)) +
    theme_minimal(base_size = 15) +
    theme(
      plot.title = element_text(face = "bold", size = 17, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

## Funzione likert "Per niente-Completamente"

plot_likert_completamente <- function(colonna, titolo) {
  dati <- datacleaned[[colonna]]
  
  mappa_likert_1 <- c(
    "Per niente" = "Per niente", "per niente" = "Per niente",
    "Poco" = "Poco", "poco" = "Poco",
    "Abbastanza" = "Abbastanza", "abbastanza" = "Abbastanza",
    "Completamente" = "Completamente", "completamente" = "Completamente"
  )
  
  dati_raggruppati <- mappa_likert_1[as.character(dati)]
  dati_raggruppati <- dati_raggruppati[!is.na(dati_raggruppati) & dati_raggruppati != ""]
  
  livelli_ordinati <- c("Per niente", "Poco", "Abbastanza", "Completamente")
  dati_fattore <- factor(dati_raggruppati, levels = livelli_ordinati, ordered = TRUE)
  
  freq_table <- as.data.frame(table(Risposta = dati_fattore))
  colnames(freq_table)[2] <- "Frequenza"
  freq_table$Percentuale <- (freq_table$Frequenza / sum(freq_table$Frequenza)) * 100
  N <- sum(freq_table$Frequenza)
  
  ggplot(freq_table, aes(x = Risposta, y = Percentuale)) +
    geom_col(width = 0.7, fill = "#89BFEA", show.legend = FALSE) +
    geom_text(aes(label = paste0("n=", Frequenza)), vjust = -0.4, size = 5.2) +
    labs(
      title = titolo,
      subtitle = paste("N =", N),
      x = "Risposta",
      y = "Percentuale"
    ) +
    scale_x_discrete(drop = FALSE, limits = livelli_ordinati) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, 100)) +
    theme_minimal(base_size = 15) +
    theme(
      plot.title = element_text(face = "bold", size = 17, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

######################################## FUNZIONI DESCRITTIVE DISAGGREGATE


## Rinominare gruppi Strutturati e Non-strutturati
datacleaned$Gruppo <- ifelse(datacleaned$"1" %in% c("PO, PA, RTD, RTT"), "Strutturati",
                             ifelse(datacleaned$"1" %in% c("Dottorato, assegno di ricerca"), "Non-strutturati", NA))


## Funzione per TASSO DI RISPOSTA
plot_tasso_risposta <- function(totali_strutturati, totali_non_strutturati, titolo = "") {
  
  risposte_strutturati <- sum(datacleaned$Gruppo == "Strutturati", na.rm = TRUE)
  risposte_non_strutturati <- sum(datacleaned$Gruppo == "Non-strutturati", na.rm = TRUE)
  
  df <- data.frame(
    Gruppo = c("Strutturati", "Non-strutturati"),
    Risposte = c(risposte_strutturati, risposte_non_strutturati),
    Totali = c(totali_strutturati, totali_non_strutturati)
  )
  
  df$Percentuale <- (df$Risposte / df$Totali) * 100
  
  colori <- c("Strutturati" = "#4EB9BA", "Non-strutturati" = "#EF7D81")
  
  ggplot(df, aes(x = Gruppo, y = Percentuale, fill = Gruppo)) +
    geom_col(width = 0.7) +
    geom_text(aes(label = paste0("n=", Risposte)), vjust = -0.4, size = 4.5) +
    labs(
      title = titolo,
      subtitle = paste("Totali: Strutturati =", totali_strutturati, ", Non-strutturati =", totali_non_strutturati),
      x = "Gruppo",
      y = "Percentuale di risposta"
    ) +
    scale_fill_manual(values = colori) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, 100)) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

# Funzione per DEMOGRAFICHE
plot_demografiche <- function(colonna, titolo) {
  datacleaned$Gruppo <- ifelse(datacleaned$"1" %in% c("PO, PA, RTD, RTT"), "Strutturati",
                               ifelse(datacleaned$"1" %in% c("Dottorato, assegno di ricerca"), "Non-strutturati", NA))
  
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]) & !is.na(datacleaned$Gruppo), ]
  if (nrow(dati_filtrati) == 0) {
    warning("Nessun dato disponibile per il grafico.")
    return(NULL)
  }
  
  freq_table <- as.data.frame(table(Risposta = dati_filtrati[[colonna]], Gruppo = dati_filtrati$Gruppo))
  colnames(freq_table)[3] <- "Frequenza"
  freq_table <- freq_table[freq_table$Frequenza > 0, ]
  
  N <- nrow(datacleaned)  # Totale osservazioni (es. 53)
  freq_table$Percentuale <- (freq_table$Frequenza / N) * 100
  max_y <- max(freq_table$Percentuale) + 10
  
  colori <- c("Strutturati" = "#4EB9BA", "Non-strutturati" = "#EF7D81")
  etichette_legenda <- c(
    "Strutturati" = "Strutturati = PO, PA, RTD, RTT",
    "Non-strutturati" = "Non strutturati = Dottorato, assegno di ricerca"
  )
  
  ggplot(freq_table, aes(x = Risposta, y = Percentuale, fill = Gruppo)) +
    geom_col(position = position_dodge(width = 0.8), width = 0.7) +
    geom_text(aes(label = paste0("n=", Frequenza)),
              position = position_dodge(width = 0.8), vjust = -0.4, size = 5) +
    labs(
      title = titolo,
      subtitle = paste("N =", N),
      x = "Risposta",
      y = "Percentuale",
      fill = NULL
    ) +
    scale_fill_manual(values = colori, labels = etichette_legenda) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, max(100, max_y))) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      legend.position = "right",
      legend.text = element_text(size = 11),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

## Funzione per visualizzazione dati disaggregati - DICOTOMICHE

plot_confronto_gruppi <- function(colonna, titolo) {
  datacleaned$Gruppo <- ifelse(datacleaned$`1` == "PO, PA, RTD, RTT", "Strutturati",
                               ifelse(datacleaned$`1` == "Dottorato, assegno di ricerca", "Non-strutturati", NA))
  
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]) & !is.na(datacleaned$Gruppo), ]
  if (nrow(dati_filtrati) == 0) {
    warning("Nessun dato disponibile per il grafico.")
    return(NULL)
  }
  
  freq_table <- as.data.frame(table(Gruppo = dati_filtrati$Gruppo, Risposta = dati_filtrati[[colonna]]))
  colnames(freq_table)[3] <- "Frequenza"
  
  totali <- aggregate(Frequenza ~ Gruppo, data = freq_table, sum)
  freq_table <- merge(freq_table, totali, by = "Gruppo", suffixes = c("", "_Totale"))
  freq_table$Percentuale <- (freq_table$Frequenza / freq_table$Frequenza_Totale) * 100
  
  # Colori fissi per le risposte
  colori_risposta <- c("Sì" = "#81C784", "No" = "#E57373")  # verde, rosso
  
  # Calcolo del limite Y: sempre almeno 100, ma aggiungo margine se necessario
  max_y <- max(100, max(freq_table$Percentuale) + 7)
  
  ggplot(freq_table, aes(x = Gruppo, y = Percentuale, fill = Risposta)) +
    geom_col(position = position_dodge(width = 0.7), width = 0.6) +
    geom_text(aes(label = paste0("n=", Frequenza)),
              position = position_dodge(width = 0.7), vjust = -0.5, size = 4.5) +
    scale_fill_manual(values = colori_risposta) +
    scale_y_continuous(limits = c(0, max_y), breaks = seq(0, 100, by = 10)) +
    labs(
      title = titolo,
      subtitle = paste("N =", sum(freq_table$Frequenza)),
      x = "Gruppo",
      y = "Percentuale",
      fill = "Risposta"
    ) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}

## Funzione per visualizzazione dati disaggregati - TRICOTOMICHE
plot_confronto_gruppi_2 <- function(colonna, titolo) {
  datacleaned$Gruppo <- ifelse(datacleaned$`1` %in% c("PO, PA, RTD, RTT"), "Strutturati",
                               ifelse(datacleaned$`1` %in% c("Dottorato, assegno di ricerca"), "Non-strutturati", NA))
  
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]) & !is.na(datacleaned$Gruppo), ]
  
  risposta_map <- c(
    "No, mai" = "No, mai",
    "Sì, ma non l'ho gestito personalmente" = "Sì, ma non l'ho gestito personalmente",
    "Sì, l'ho gestito personalmente" = "Sì, l'ho gestito personalmente"
  )
  dati_filtrati$Risposta <- risposta_map[as.character(dati_filtrati[[colonna]])]
  dati_filtrati <- dati_filtrati[!is.na(dati_filtrati$Risposta), ]
  
  livelli_ordinati <- c(
    "No, mai",
    "Sì, ma non l'ho gestito personalmente",
    "Sì, l'ho gestito personalmente"
  )
  dati_filtrati$Risposta <- factor(dati_filtrati$Risposta, levels = livelli_ordinati)
  
  freq_table <- as.data.frame(table(Gruppo = dati_filtrati$Gruppo, Risposta = dati_filtrati$Risposta))
  colnames(freq_table) <- c("Gruppo", "Risposta", "Frequenza")
  
  totali <- aggregate(Frequenza ~ Gruppo, data = freq_table, sum)
  freq_table <- merge(freq_table, totali, by = "Gruppo", suffixes = c("", "_Totale"))
  freq_table$Percentuale <- (freq_table$Frequenza / freq_table$Frequenza_Totale) * 100
  
  colori_risposta <- c(
    "No, mai" = "#E57373",
    "Sì, ma non l'ho gestito personalmente" = "#F4A261",
    "Sì, l'ho gestito personalmente" = "#81C784"
  )
  
  max_percentuale <- max(freq_table$Percentuale)
  limite_y <- max(100, max_percentuale + 7)
  
  ggplot(freq_table, aes(x = Gruppo, y = Percentuale, fill = Risposta)) +
    geom_col(position = position_dodge(width = 0.8), width = 0.7) +
    geom_text(aes(label = paste0("n=", Frequenza)),
              position = position_dodge(width = 0.8), vjust = -0.5, size = 5) +
    scale_fill_manual(values = colori_risposta, breaks = livelli_ordinati) +
    labs(
      title = titolo,
      subtitle = paste("N =", sum(freq_table$Frequenza)),
      x = "Gruppo",
      y = "Percentuale",
      fill = "Risposta"
    ) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, limite_y)) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 25, r = 15, b = 15, l = 15)
    )
}
    
## Funzione per dati disaggregati - LIKERT "Per niente-Molto"
plot_likert_gruppi_molto <- function(colonna, titolo) {
  datacleaned$Gruppo <- ifelse(datacleaned$`1` %in% c("PO, PA, RTD, RTT"), "Strutturati",
                               ifelse(datacleaned$`1` %in% c("Dottorato, assegno di ricerca"), "Non-strutturati", NA))
  
  mappa_likert <- c(
    "Per niente" = "Per niente", "per niente" = "Per niente",
    "Poco" = "Poco", "poco" = "Poco",
    "Abbastanza" = "Abbastanza", "abbastanza" = "Abbastanza",
    "Molto" = "Molto", "molto" = "Molto"
  )
  livelli_ordinati <- c("Per niente", "Poco", "Abbastanza", "Molto")
  colori_risposta <- c("Per niente" = "#E57373", "Poco" = "#F4A261", "Abbastanza" = "#F6D55C", "Molto" = "#81C784")
  
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]) & !is.na(datacleaned$Gruppo), ]
  dati_filtrati$Risposta <- mappa_likert[as.character(dati_filtrati[[colonna]])]
  dati_filtrati <- dati_filtrati[!is.na(dati_filtrati$Risposta) & dati_filtrati$Risposta != "", ]
  dati_filtrati$Risposta <- factor(dati_filtrati$Risposta, levels = livelli_ordinati, ordered = TRUE)
  
  freq_table <- as.data.frame(table(Gruppo = dati_filtrati$Gruppo, Risposta = dati_filtrati$Risposta))
  colnames(freq_table) <- c("Gruppo", "Risposta", "Frequenza")
  
  totali <- aggregate(Frequenza ~ Gruppo, data = freq_table, sum)
  freq_table <- merge(freq_table, totali, by = "Gruppo", suffixes = c("", "_Totale"))
  freq_table$Percentuale <- (freq_table$Frequenza / freq_table$Frequenza_Totale) * 100
  
  # Calcolo limite Y
  max_y <- max(100, max(freq_table$Percentuale) + 7)
  
  ggplot(freq_table, aes(x = Gruppo, y = Percentuale, fill = Risposta)) +
    geom_col(position = position_dodge(width = 0.8), width = 0.7) +
    geom_text(aes(label = paste0("n=", Frequenza)),
              position = position_dodge(width = 0.8), vjust = -0.5, size = 5) +
    scale_fill_manual(values = colori_risposta) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, max_y)) +
    labs(
      title = titolo,
      subtitle = paste("N =", sum(freq_table$Frequenza)),
      x = "Gruppo",
      y = "Percentuale",
      fill = "Risposta"
    ) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 20, r = 10, b = 10, l = 10)
    )
}
    
## Funzione per dati disaggregati - LIKERT "Per niente-Completamente"
plot_likert_gruppi_completamente <- function(colonna, titolo) {
  datacleaned$Gruppo <- ifelse(datacleaned$`1` %in% c("PO, PA, RTD, RTT"), "Strutturati",
                               ifelse(datacleaned$`1` %in% c("Dottorato, assegno di ricerca"), "Non-strutturati", NA))
  
  mappa_likert <- c(
    "Per niente" = "Per niente", "per niente" = "Per niente",
    "Poco" = "Poco", "poco" = "Poco",
    "Abbastanza" = "Abbastanza", "abbastanza" = "Abbastanza",
    "Completamente" = "Completamente", "completamente" = "Completamente"
  )
  
  livelli_ordinati <- c("Per niente", "Poco", "Abbastanza", "Completamente")
  colori_risposta <- c("Per niente" = "#E57373", "Poco" = "#F4A261", "Abbastanza" = "#F6D55C", "Completamente" = "#81C784")
  
  dati_filtrati <- datacleaned[!is.na(datacleaned[[colonna]]) & !is.na(datacleaned$Gruppo), ]
  dati_filtrati$Risposta <- mappa_likert[as.character(dati_filtrati[[colonna]])]
  dati_filtrati <- dati_filtrati[!is.na(dati_filtrati$Risposta) & dati_filtrati$Risposta != "", ]
  dati_filtrati$Risposta <- factor(dati_filtrati$Risposta, levels = livelli_ordinati, ordered = TRUE)
  
  freq_table <- as.data.frame(table(Gruppo = dati_filtrati$Gruppo, Risposta = dati_filtrati$Risposta))
  colnames(freq_table) <- c("Gruppo", "Risposta", "Frequenza")
  
  totali <- aggregate(Frequenza ~ Gruppo, data = freq_table, sum)
  freq_table <- merge(freq_table, totali, by = "Gruppo", suffixes = c("", "_Totale"))
  freq_table$Percentuale <- (freq_table$Frequenza / freq_table$Frequenza_Totale) * 100
  
  max_percentuale <- max(freq_table$Percentuale)
  limite_y <- max(100, max_percentuale + 7)  # margine per etichette
  
  ggplot(freq_table, aes(x = Gruppo, y = Percentuale, fill = Risposta)) +
    geom_col(position = position_dodge(width = 0.8), width = 0.7) +
    geom_text(aes(label = paste0("n=", Frequenza)),
              position = position_dodge(width = 0.8), vjust = -0.5, size = 5) +
    scale_fill_manual(values = colori_risposta) +
    labs(
      title = titolo,
      subtitle = paste("N =", sum(freq_table$Frequenza)),
      x = "Gruppo",
      y = "Percentuale",
      fill = "Risposta"
    ) +
    scale_y_continuous(breaks = seq(0, 100, by = 10), limits = c(0, limite_y)) +
    theme_minimal(base_size = 13) +
    theme(
      plot.title = element_text(face = "bold", size = 15, hjust = 0.5),
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold"),
      plot.margin = margin(t = 25, r = 15, b = 15, l = 15)
    )
}
