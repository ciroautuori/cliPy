from fastapi import FastAPI
from src.core.config import settings
from src.api import health

# Inizializzazione dell'applicazione FastAPI usando le impostazioni centralizzate
app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.PROJECT_VERSION,
    description=settings.PROJECT_DESCRIPTION,
)

# Includi i router dei moduli API
app.include_router(health.router)
