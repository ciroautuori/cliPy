from fastapi import FastAPI

# Inizializzazione dell'applicazione FastAPI
app = FastAPI(
    title="cliPy",
    description="Un bot Python di eccellenza, costruito con un'architettura solida.",
    version="0.1.0",
)

@app.get("/", tags=["Health Check"])
def read_root():
    """
    Endpoint di health check per verificare che il servizio sia attivo.
    """
    return {"status": "ok", "project_name": "cliPy"}
