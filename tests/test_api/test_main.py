from fastapi.testclient import TestClient
from src.main import app

# Istanzia un client di test per l'applicazione
client = TestClient(app)


def test_read_root_health_check():
    """
    Verifica che l'endpoint di health check ('/') funzioni correttamente.
    """
    # Esegui una richiesta GET all'endpoint '/'
    response = client.get("/")

    # Verifica che la risposta abbia uno status code 200 (OK)
    assert response.status_code == 200

    # Verifica che il corpo della risposta JSON sia quello atteso
    expected_response = {"status": "ok", "project_name": "cliPy"}
    assert response.json() == expected_response
