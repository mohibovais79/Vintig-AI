from functools import lru_cache
from pathlib import Path

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class AppSettings(BaseSettings):
    """Application-level configuration loaded from environment variables."""

    firebase_credentials_path: Path = Field(
        default=Path(__file__).resolve().parent.parent
        / "vintigai-firebase-adminsdk-fbsvc-5e77b532b3.json",
        description="Path to the Firebase service account JSON file.",
    )
    data_dir: Path = Field(
        default=Path(__file__).resolve().parent.parent / "data",
        description="Directory used for storing simple JSON persistence files.",
    )

    model_config = SettingsConfigDict(
        env_file=".env",
        env_prefix="BACKEND_",
        extra="ignore",
    )


@lru_cache
def get_settings() -> AppSettings:
    settings = AppSettings()
    settings.data_dir.mkdir(parents=True, exist_ok=True)
    return settings
