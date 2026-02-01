"""Authentication dependencies for Firebase ID token verification."""

from fastapi import Depends, Header, HTTPException, status

from .config import get_settings
from .firebase import init_firebase, verify_token


async def get_current_user(authorization: str = Header(alias="Authorization")) -> dict:
    """Extract and verify the Firebase ID token from the Authorization header."""

    if not authorization or not authorization.lower().startswith("bearer "):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Missing or invalid Authorization header.",
        )

    id_token = authorization.split(" ", 1)[1].strip()

    settings = get_settings()
    init_firebase(settings.firebase_credentials_path)

    try:
        decoded = verify_token(id_token)
    except Exception as exc:  # firebase_admin raises various exceptions
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired Firebase ID token.",
        ) from exc

    return decoded
