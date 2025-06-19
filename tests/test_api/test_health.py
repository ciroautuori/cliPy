from fastapi.testclient import TestClient
from src.main import app

# Istanzia un client di test per l'applicazione
# Il client testa l'app FastAPI completa, che include tutti i router montati.
client = TestClient(app)


def test_health_check_endpoint():
    """
    Verifica che l'endpoint di health check ('/'), definito nel router 'health',
    risponda correttamente.
    """
    # Esegui una richiesta GET all'endpoint '/'
    response = client.get("/")

    # Verifica che la risposta abbia uno status code 200 (OK)
    assert response.status_code == 200

    # Verifica che il corpo della risposta JSON sia quello atteso
    # Questo ora viene letto dal file di configurazione
    expected_project_name = app.title  # Legge il titolo dall'istanza FastAPI
    expected_response = {"status": "ok", "project_name": expected_project_name}
    assert response.json() == expected_response
