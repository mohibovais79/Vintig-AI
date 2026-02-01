"""Entry point for the Vintig AI FastAPI backend."""

from fastapi import FastAPI

from app.config import get_settings
from app.firebase import init_firebase
from app.routes import onboarding


def create_app() -> FastAPI:
    settings = get_settings()
    init_firebase(settings.firebase_credentials_path)

    app = FastAPI(title="Vintig AI Backend", version="0.1.0")
    app.include_router(onboarding.router)
    return app


app = create_app()


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
