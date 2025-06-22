# Survey on Open Science practices and the Methodological Review Board

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
![R >= 4.2.0](https://img.shields.io/badge/R-%3E%3D%204.2.0-blue)

This repository contains all materials related to the survey conducted on Open Science and the Methodological Review Board (MRB).

---

## 📁 Folder Structure – `results/`

The `results/` folder includes all materials related to the analysis of the survey data. It is structured as a standalone R project and contains the following elements:

- `results.Rproj`: RStudio project file used to manage this specific analysis module within the larger `survey` repository.
- `.Rprofile`: Automatically loads required packages, reads data, and opens the main Quarto file when the project is opened.
- `renv/` and `renv.lock`: Ensure a reproducible R environment across systems using the `{renv}` package.
- `R/`: Contains the script `setup.R`, which defines paths, loads libraries, and imports data for use in the Quarto file.
- `analysis/`: Contains the core data analysis in the form of a Quarto presentation.
  - `data_analysis.qmd`: RevealJS presentation with all results and plots.
  - `data_analysis.html`: Rendered version of the presentation.
  - `data_analysis_cache/` and `data_analysis_files/`: Auto-generated folders by Quarto with cached computations and supporting assets.
- `data/`: Contains input data files:
  - `dati.xlsx`: Raw survey response data exported from Qualtrics.
  - `data_dictionary.csv`: Variable names and descriptions.
- `survey_qualtrics.pdf`: PDF version of the original questionnaire.
- `.png` files: Logos and visuals used within the presentation (e.g., `logo_MRB.png`, etc.).

> 🛠 This folder is self-contained and ready to run via RStudio. Opening `results.Rproj` will automatically prepare the environment and open the main analysis file.

---

## 📝 Links

You can access the original survey here:  
🔗 https://unipadova.qualtrics.com/jfe/form/SV_9NYvbilMLe7TGNU

You can visualize the Quarto presentation here:  
🔗 https://methodological-review-board.github.io/survey/data_analysis.html

---

## 🔁 Reproducing the environment

This project uses [`renv`](https://rstudio.github.io/renv/) to ensure reproducibility.

To recreate the original R environment used in this project, open the project in RStudio and run:

```r
renv::restore()
```

This will install all packages listed in `renv.lock` inside a private project library.

---

## 👤 Contact

For any questions or clarifications, feel free to contact:  
**Laura Sità** – _University of Padova_  
📧 laura.sita@studenti.unipd.it

---

## 📜 License

This project is distributed under the terms of the **GNU General Public License (GPL v3)**.  
See the [LICENSE](LICENSE) file for details.
