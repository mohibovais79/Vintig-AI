"""Firebase Admin helpers."""

from pathlib import Path
from typing import Optional

import firebase_admin
from firebase_admin import auth, credentials

_firebase_app: Optional[firebase_admin.App] = None


def init_firebase(credential_path: Path) -> firebase_admin.App:
    """Initialize Firebase Admin SDK once and reuse the app."""
    global _firebase_app

    if _firebase_app is not None:
        return _firebase_app

    try:
        _firebase_app = firebase_admin.get_app()
        return _firebase_app
    except ValueError:
        cred = credentials.Certificate(str(credential_path))
        _firebase_app = firebase_admin.initialize_app(cred)
        return _firebase_app


def verify_token(id_token: str) -> dict:
    """Verify a Firebase ID token and return the decoded payload."""
    if not id_token:
        raise ValueError("Missing Firebase ID token")
    return auth.verify_id_token(id_token)
