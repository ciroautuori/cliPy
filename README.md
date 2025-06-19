# cliPy 🚀

[![Python](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.104.0-green.svg)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)

**cliPy** è un bot di automazione progettato per risolvere un problema specifico e frustrante per gli sviluppatori che usano assistenti AI in VS Code: **i blocchi dovuti a chiamate API.**

---

## 🎯 Scopo del Progetto

Gli assistenti AI come **Cline agent AI in VS Code** a volte si bloccano durante la generazione di codice, richiedendo un intervento manuale per premere un pulsante "Retry". Questo interrompe il flusso di lavoro, specialmente quando si utilizzano configurazioni complesse come due agenti in esecuzione contemporanea su uno schermo diviso.

**cliPy automatizza questo processo.** Monitora lo schermo, rileva quando il pulsante "Retry" appare e lo preme automaticamente, permettendo un flusso di lavoro di sviluppo assistito da AI veramente continuo e senza interruzioni.

## 🛠️ Utilizzo Principale

L'obiettivo è consentire a uno sviluppatore di lavorare con **due istanze di Cline agent AI in split-screen**, con `cliPy` che agisce in background per sbloccare entrambi i lati in modo autonomo ogni volta che si verifica un blocco.

## ⚙️ Installazione e Avvio

*Prerequisiti: [Docker](https://docs.docker.com/get-docker/) e [Docker Compose](https://docs.docker.com/compose/install/)*

1.  **Clonare il repository:**
    ```bash
    git clone <URL_DEL_TUO_REPOSITORY>
    cd cliPy
    ```

2.  **Configurare le variabili d'ambiente:**
    Copiare il file `env.example` in `.env` e compilare i valori necessari.
    ```bash
    cp env.example .env
    ```

3.  **Costruire e avviare il container:**
    ```bash
    docker-compose up --build
    ```

L'applicazione sarà accessibile su `http://localhost:8019`.

## ✅ Esecuzione dei Test

Per garantire la stabilità del codice, eseguire la suite di test `pytest` con il comando:

```bash
docker-compose run --rm app pytest
```
L'opzione --rm assicura che il container di test venga rimosso dopo l'esecuzione, mantenendo il sistema pulito.

## 🎬 Prossimi Sviluppi
Video Dimostrativo: Verrà aggiunto un breve video o GIF a questo README per mostrare cliPy in azione.
