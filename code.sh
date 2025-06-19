#!/bin/bash

# ===================================================================================
#
#   professionalize.sh
#
#   Uno script per professionalizzare un repository GitHub locale.
#   Genera README, LICENSE, CI, contributing guidelines e altro.
#   Creato con ❤️ per l'automazione e il design.
#
#   Autore: Il tuo Senior DevOps Engineer
#   Versione: 2.0 (The "Bellezza" Edition)
#
# ===================================================================================

# --- Configurazione del Progetto ---
PROJECT_NAME="Retry Bot"
GITHUB_USER="ciroautuori"
REPO_NAME="RetryBot"
SLOGAN="Automazione OCR sicura che previene i click errati con un protocollo \"Proponi e Verifica\"."
AUTHOR_NAME="Ciro Autuori"
COPYRIGHT_YEAR="2024"

# --- Stile e Colori ---
# Un tocco di classe per il terminale.
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_YELLOW='\033[0;33m'
COLOR_CYAN='\033[0;36m'
COLOR_WHITE='\033[1;37m'
COLOR_RESET='\033[0m'

# --- Funzioni Helper per un output leggibile ---
# La comunicazione è la chiave del successo.

# Stampa un'intestazione
print_header() {
    echo -e "${COLOR_BLUE}===================================================================${COLOR_RESET}"
    echo -e "${COLOR_WHITE}🚀  Inizio Professionalizzazione del Progetto: ${PROJECT_NAME} 🚀${COLOR_RESET}"
    echo -e "${COLOR_BLUE}===================================================================${COLOR_RESET}"
}

# Stampa un messaggio di successo
print_success() {
    echo -e "${COLOR_GREEN}✅  $1${COLOR_RESET}"
}

# Stampa un messaggio informativo
print_info() {
    echo -e "${COLOR_CYAN}✨  $1${COLOR_RESET}"
}

# Stampa un messaggio di avviso
print_warning() {
    echo -e "${COLOR_YELLOW}⚠️  $1${COLOR_RESET}"
}

# Stampa i passi successivi
print_next_steps() {
    echo -e "\n${COLOR_BLUE}===================================================================${COLOR_RESET}"
    echo -e "${COLOR_WHITE}💡  PROSSIMI PASSI CONSIGLIATI  💡${COLOR_RESET}"
    echo -e "${COLOR_BLUE}===================================================================${COLOR_RESET}"
    echo -e "${COLOR_WHITE}1. Rivedi i file generati per assicurarti che siano perfetti.${COLOR_RESET}"
    echo -e "${COLOR_WHITE}2. Esegui questi comandi per committare le modifiche:${COLOR_RESET}"
    echo -e "${COLOR_CYAN}\n   git add .\n   git commit -m \"docs: professionalize repository structure and documentation\"\n   git push\n${COLOR_RESET}"
}

# Funzione per creare una directory se non esiste
create_dir() {
    if [ -d "$1" ]; then
        print_warning "Directory già esistente: $1"
    else
        mkdir -p "$1"
        print_info "Creata directory: $1"
    fi
}

# Funzione per scrivere un file con animazione
# $1: Percorso del file
# $2: Contenuto del file (passato tramite heredoc)
write_file() {
    local filepath=$1
    local content=$2
    
    # Spinner di attesa per un effetto dinamico
    local spinner="/|\\-"
    echo -n -e "${COLOR_WHITE}📄  Creazione di $filepath... ${COLOR_RESET}"
    for i in {1..10}; do
        echo -n -e "${COLOR_YELLOW}${spinner:$((i%4)):1}\r${COLOR_RESET}"
        sleep 0.05
    done
    
    echo "$content" > "$filepath"
    echo -e "${COLOR_WHITE}📄  Creazione di $filepath... ${COLOR_GREEN}Fatto!${COLOR_RESET}"
}


# ===================================================================================
#                                 FASE DI ESECUZIONE
# ===================================================================================

main() {
    print_header

    # --- Creazione Struttura Directory ---
    print_info "\n📁 Fase 1: Preparazione della struttura delle directory..."
    create_dir ".github/workflows"
    create_dir ".github/ISSUE_TEMPLATE"

    # --- Creazione dei File di Progetto ---
    print_info "\n📝 Fase 2: Generazione dei file di configurazione e documentazione..."

    # README.md
    readme_content=$(cat <<EOF
# ${PROJECT_NAME}

> ${SLOGAN}

[![Python Version](https://img.shields.io/badge/python-3.9+-blue.svg?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg?style=for-the-badge)](https://github.com/psf/black)
[![CI](https://github.com/${GITHUB_USER}/${REPO_NAME}/actions/workflows/ci.yml/badge.svg)](https://github.com/${GITHUB_USER}/${REPO_NAME}/actions/workflows/ci.yml)

<!-- Inserisci qui uno screenshot o una GIF del bot in azione! -->
![Retry Bot Demo](https://via.placeholder.com/800x400.png?text=Aggiungi+una+GIF+del+Bot+in+Azione+Qui)

---

## 📖 Descrizione

**${PROJECT_NAME}** è uno script di automazione intelligente progettato per identificare e cliccare in modo affidabile i pulsanti "Retry" che appaiono sullo schermo. A differenza dei semplici bot basati su coordinate fisse, impiega un sofisticato protocollo di sicurezza a due fasi ("Proponi e Verifica") che combina l'analisi dei contorni di OpenCV con la verifica testuale di Tesseract OCR.

Questo approccio garantisce un'altissima precisione e previene i click accidentali, rendendolo uno strumento sicuro e affidabile per automatizzare compiti ripetitivi in applicazioni, giochi o qualsiasi scenario in cui sia necessario un "riprova" persistente.

## ✨ Features Principali

*   **🛡️ Protocollo di Sicurezza "Proponi e Verifica"**: Il mouse non si muove mai senza una doppia conferma: prima la forma del pulsante (OpenCV), poi il testo "Retry" (Tesseract).
*   **🎯 Alta Affidabilità OCR**: Utilizza una soglia di confidenza minima (impostata al 65%) per prevenire il riconoscimento di testo errato.
*   **⚡ Scansione Efficiente**: Analizza solo una regione specifica dello schermo (il quadrante in basso a destra) per massimizzare le prestazioni e ridurre il carico sulla CPU.
*   **🖱️ Gestione Sicura del Mouse**: Dopo ogni click, il mouse torna a una posizione di riposo predefinita, lasciando il resto dello schermo libero per l'utente.
*   **🔧 Parametri Configurabili**: Le impostazioni chiave come la soglia di confidenza e gli intervalli di scansione sono definite come costanti all'inizio dello script per una facile personalizzazione.

## 🛠️ Stack Tecnologico

Il progetto è costruito con tecnologie robuste e ampiamente utilizzate:

![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![PyAutoGUI](https://img.shields.io/badge/PyAutoGUI-000000?style=for-the-badge)
![OpenCV](https://img.shields.io/badge/OpenCV-5C3EE8?style=for-the-badge&logo=opencv&logoColor=white)
![Tesseract](https://img.shields.io/badge/Tesseract-000000?style=for-the-badge&logo=Tesseract&logoColor=white)
![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)

## 📋 Prerequisiti

Prima di iniziare, assicurati di avere installato sul tuo sistema:

1.  **Python 3.9+**
2.  **Pip** (solitamente incluso con Python)
3.  **Tesseract OCR Engine**: Questa è una dipendenza di sistema, non un pacchetto Python. Segui la [guida ufficiale all'installazione per il tuo OS](https://github.com/tesseract-ocr/tessdoc).

## 🚀 Installazione e Avvio

1.  **Clona il repository:**
    \`\`\`bash
    git clone https://github.com/${GITHUB_USER}/${REPO_NAME}.git
    cd ${REPO_NAME}
    \`\`\`

2.  **Crea un ambiente virtuale (consigliato):**
    \`\`\`bash
    python -m venv venv
    source venv/bin/activate  # Su Windows: venv\\Scripts\\activate
    \`\`\`

3.  **Installa le dipendenze Python:**
    \`\`\`bash
    pip install -r requirements.txt
    \`\`\`

4.  **Avvia il Bot:**
    \`\`\`bash
    python retry-bot.py
    \`\`\`
    Il bot inizierà la scansione. Per fermarlo, premi \`CTRL+C\` nel terminale o attiva il failsafe di PyAutoGUI muovendo il mouse in un angolo dello schermo.

## 🏛️ Architettura

Il progetto è volutamente semplice e contenuto in un unico script, \`retry-bot.py\`, per la massima portabilità. Il flusso logico è il seguente:

1.  **Loop Principale**: Esegue una scansione a intervalli regolari.
2.  **FASE 1: PROPONI (\`find_button_candidates\`)**: Scatta uno screenshot della regione di interesse e usa OpenCV per trovare contorni che assomigliano a pulsanti.
3.  **FASE 2: VERIFICA (\`verify_candidate_is_retry\`)**: Per ogni candidato, esegue Tesseract OCR su un ritaglio dell'immagine. Procede solo se trova la parola "Retry" con una confidenza superiore alla soglia.
4.  **FASE 3: ESEGUI (\`execute_click_and_reset\`)**: Se un bersaglio è confermato, muove il mouse, clicca e lo riporta alla posizione di riposo.

## 🗺️ Roadmap Futura

Il progetto è attivo e ci sono piani per migliorarlo. Le prossime funzionalità includono:
*   [ ] **Interfaccia Grafica (GUI)**: Creare una semplice UI con Tkinter o PyQT per configurare i parametri senza modificare il codice.
*   [ ] **Supporto Multi-Lingua**: Permettere la configurazione di diverse parole chiave (es. "Riprova", "Try Again").
*   [ ] **Riconoscimento di Icone**: Aggiungere la capacità di riconoscere pulsanti basati su icone (es. un'icona di refresh 🔄) oltre al testo.

## 🤝 Contribuire

I contributi sono i benvenuti! Se vuoi migliorare ${PROJECT_NAME}, per favore leggi le nostre [linee guida per la contribuzione](CONTRIBUTING.md). Puoi iniziare cercando tra le [issue aperte](https://github.com/${GITHUB_USER}/${REPO_NAME}/issues).

## 📄 Licenza

Questo progetto è rilasciato sotto la Licenza MIT. Vedi il file [LICENSE](LICENSE) per maggiori dettagli.

---
*Progetto creato e mantenuto da ${AUTHOR_NAME}.*
EOF
)
    write_file "README.md" "$readme_content"

    # LICENSE
    license_content=$(cat <<EOF
MIT License

Copyright (c) ${COPYRIGHT_YEAR} ${AUTHOR_NAME}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
)
    write_file "LICENSE" "$license_content"

    # requirements.txt
    requirements_content=$(cat <<EOF
# Core Libraries for Automation and GUI Control
pyautogui

# Image Processing and Computer Vision
opencv-python
numpy

# Optical Character Recognition (OCR)
pytesseract
EOF
)
    write_file "requirements.txt" "$requirements_content"

    # .gitignore
    gitignore_content=$(cat <<EOF
# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
.env
.pytest_cache/
.mypy_cache/

# Distribution / packaging
/dist/
/build/
*.egg-info/

# IDE files
.idea/
.vscode/
*.swp
*.swo

# OS-generated files
.DS_Store
Thumbs.db

# This script
professionalize.sh
professionalize.py
EOF
)
    write_file ".gitignore" "$gitignore_content"
    
    # CONTRIBUTING.md
    contributing_content=$(cat <<EOF
# Come Contribuire a ${PROJECT_NAME}

Prima di tutto, grazie per il tuo interesse nel contribuire a questo progetto! Ogni contributo è apprezzato.

## Come Segnalare un Bug

Se trovi un bug, per favore [apri una issue](https://github.com/${GITHUB_USER}/${REPO_NAME}/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5BBug%5D%3A+) e fornisci quante più informazioni possibili.

## Proporre una Nuova Funzionalità

Se hai un'idea per una nuova funzionalità, [apri una issue](https://github.com/${GITHUB_USER}/${REPO_NAME}/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=%5BFeature%5D%3A+) per discuterla.

## Workflow per le Pull Request

1.  **Forka il repository** e clona il tuo fork in locale.
2.  **Crea un branch** per le tue modifiche: \`git checkout -b feat/nome-feature\` o \`fix/nome-bug\`.
3.  **Apporta le tue modifiche**. Se aggiungi nuove funzionalità, considera di aggiungere anche dei test.
4.  **Assicurati che il codice sia formattato**: Consigliamo l'uso di \`black\` e \`flake8\`.
5.  **Committa le tue modifiche** usando i [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):
    *   \`feat:\` per nuove funzionalità.
    *   \`fix:\` per correzioni di bug.
    *   \`docs:\` per modifiche alla documentazione.
    *   \`refactor:\` per refactoring del codice senza modifiche funzionali.
6.  **Fai il push** del tuo branch al tuo fork.
7.  **Apri una Pull Request** verso il branch \`main\` del repository originale.

Grazie ancora per il tuo contributo!
EOF
)
    write_file "CONTRIBUTING.md" "$contributing_content"
    
    # .github/workflows/ci.yml
    ci_content=$(cat <<EOF
name: CI

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install flake8 black

    - name: Check code formatting with Black
      run: |
        black --check .

    - name: Lint with flake8
      run: |
        # stop the build if there are Python syntax errors or undefined names
        flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
        # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
        flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
EOF
)
    write_file ".github/workflows/ci.yml" "$ci_content"

    # .github/ISSUE_TEMPLATE/bug_report.md
    bug_report_content=$(cat <<EOF
---
name: Segnalazione di Bug
about: Crea un report per aiutarci a migliorare
title: '[Bug]: '
labels: bug
assignees: ''

---

**Descrivi il bug**
Una descrizione chiara e concisa di qual è il bug.

**Come riprodurlo**
Passi per riprodurre il comportamento:
1.  Vai a '...'
2.  Clicca su '....'
3.  Vedi l'errore '....'

**Comportamento atteso**
Una descrizione chiara di cosa ti aspettavi che succedesse.

**Screenshot**
Se applicabile, aggiungi screenshot per aiutare a spiegare il problema.

**Ambiente:**
 - OS: [es. Windows 11, macOS Sonoma]
 - Versione di Python: [es. 3.10]

**Contesto aggiuntivo**
Aggiungi qui qualsiasi altro contesto sul problema.
EOF
)
    write_file ".github/ISSUE_TEMPLATE/bug_report.md" "$bug_report_content"
    
    # .github/ISSUE_TEMPLATE/feature_request.md
    feature_request_content=$(cat <<EOF
---
name: Proposta di Funzionalità
about: Suggerisci un'idea per questo progetto
title: '[Feature]: '
labels: enhancement
assignees: ''

---

**Il problema è legato a una tua frustrazione? Per favore, descrivila.**
Una descrizione chiara e concisa di qual è il problema. Es. "Sono sempre frustrato quando..."

**Descrivi la soluzione che vorresti**
Una descrizione chiara e concisa di cosa vorresti che succedesse.

**Descrivi le alternative che hai considerato**
Una descrizione chiara e concisa di eventuali soluzioni o funzionalità alternative che hai considerato.

**Contesto aggiuntivo**
Aggiungi qui qualsiasi altro contesto o screenshot sulla richiesta di funzionalità.
EOF
)
    write_file ".github/ISSUE_TEMPLATE/feature_request.md" "$feature_request_content"

    print_success "\n🎉 Professionalizzazione completata con successo! 🎉"
    print_next_steps
}

# Esegui la funzione principale
main