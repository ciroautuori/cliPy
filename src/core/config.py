from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    """
    Gestisce le impostazioni dell'applicazione, caricandole da variabili d'ambiente.
    """
    # Carica le variabili dal file .env
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    # Impostazioni dell'applicazione
    PROJECT_NAME: str = "cliPy"
    PROJECT_VERSION: str = "0.1.0"
    PROJECT_DESCRIPTION: str = "Un bot Python di eccellenza, costruito con un'architettura solida."

# Istanza singola delle impostazioni, da importare nel resto dell'applicazione
settings = Settings()
