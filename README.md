# Retry Bot

> Automazione OCR sicura che previene i click errati con un protocollo "Proponi e Verifica".

[![Python Version](https://img.shields.io/badge/python-3.9+-blue.svg?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg?style=for-the-badge)](https://github.com/psf/black)
[![CI](https://github.com/ciroautuori/RetryBot/actions/workflows/ci.yml/badge.svg)](https://github.com/ciroautuori/RetryBot/actions/workflows/ci.yml)

<!-- Inserisci qui uno screenshot o una GIF del bot in azione! -->
![Retry Bot Demo](https://via.placeholder.com/800x400.png?text=Aggiungi+una+GIF+del+Bot+in+Azione+Qui)

---

## 📖 Descrizione

**Retry Bot** è uno script di automazione intelligente progettato per identificare e cliccare in modo affidabile i pulsanti "Retry" che appaiono sullo schermo. A differenza dei semplici bot basati su coordinate fisse, impiega un sofisticato protocollo di sicurezza a due fasi ("Proponi e Verifica") che combina l'analisi dei contorni di OpenCV con la verifica testuale di Tesseract OCR.

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
    ```bash
    git clone https://github.com/ciroautuori/RetryBot.git
    cd RetryBot
    ```

2.  **Crea un ambiente virtuale (consigliato):**
    ```bash
    python -m venv venv
    source venv/bin/activate  # Su Windows: venv\Scripts\activate
    ```

3.  **Installa le dipendenze Python:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Avvia il Bot:**
    ```bash
    python retry-bot.py
    ```
    Il bot inizierà la scansione. Per fermarlo, premi `CTRL+C` nel terminale o attiva il failsafe di PyAutoGUI muovendo il mouse in un angolo dello schermo.

## 🏛️ Architettura

Il progetto è volutamente semplice e contenuto in un unico script, `retry-bot.py`, per la massima portabilità. Il flusso logico è il seguente:

1.  **Loop Principale**: Esegue una scansione a intervalli regolari.
2.  **FASE 1: PROPONI (`find_button_candidates`)**: Scatta uno screenshot della regione di interesse e usa OpenCV per trovare contorni che assomigliano a pulsanti.
3.  **FASE 2: VERIFICA (`verify_candidate_is_retry`)**: Per ogni candidato, esegue Tesseract OCR su un ritaglio dell'immagine. Procede solo se trova la parola "Retry" con una confidenza superiore alla soglia.
4.  **FASE 3: ESEGUI (`execute_click_and_reset`)**: Se un bersaglio è confermato, muove il mouse, clicca e lo riporta alla posizione di riposo.

## 🗺️ Roadmap Futura

Il progetto è attivo e ci sono piani per migliorarlo. Le prossime funzionalità includono:
*   [ ] **Interfaccia Grafica (GUI)**: Creare una semplice UI con Tkinter o PyQT per configurare i parametri senza modificare il codice.
*   [ ] **Supporto Multi-Lingua**: Permettere la configurazione di diverse parole chiave (es. "Riprova", "Try Again").
*   [ ] **Riconoscimento di Icone**: Aggiungere la capacità di riconoscere pulsanti basati su icone (es. un'icona di refresh 🔄) oltre al testo.

## 🤝 Contribuire

I contributi sono i benvenuti! Se vuoi migliorare Retry Bot, per favore leggi le nostre [linee guida per la contribuzione](CONTRIBUTING.md). Puoi iniziare cercando tra le [issue aperte](https://github.com/ciroautuori/RetryBot/issues).

## 📄 Licenza

Questo progetto è rilasciato sotto la Licenza MIT. Vedi il file [LICENSE](LICENSE) per maggiori dettagli.

---
*Progetto creato e mantenuto da Ciro Autuori.*
