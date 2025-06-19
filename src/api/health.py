from fastapi import APIRouter

router = APIRouter()

@router.get("/", tags=["Health Check"])
def read_root():
    """
    Endpoint di health check per verificare che il servizio sia attivo.
    """
    return {"status": "ok", "project_name": "cliPy"}
