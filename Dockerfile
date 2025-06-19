# Usa un'immagine Python ufficiale e leggera come base
FROM python:3.11-slim

# Imposta la directory di lavoro all'interno del container
WORKDIR /app

# Copia prima il file delle dipendenze per sfruttare la cache di Docker
COPY requirements.txt .

# Installa le dipendenze
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia il codice sorgente dell'applicazione nella directory di lavoro
COPY ./src /app/src

# Esponi la porta su cui girerà l'applicazione
EXPOSE 8000

# Comando per avviare l'applicazione in produzione
# Il server viene avviato tramite docker-compose per lo sviluppo
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
