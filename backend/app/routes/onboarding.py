"""Routes responsible for onboarding data persistence."""

from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException, status
from firebase_admin import firestore

from ..auth import get_current_user
from ..config import get_settings
from ..schemas import OnboardingPayload, OnboardingRecord

router = APIRouter(prefix="/onboarding", tags=["onboarding"])


@router.post("", response_model=OnboardingRecord, status_code=status.HTTP_201_CREATED)
async def save_onboarding_data(
    payload: OnboardingPayload,
    user: dict = Depends(get_current_user),
):
    """Persist onboarding responses for the authenticated Firebase user."""

    user_id = user.get("uid")
    if not user_id:
        raise HTTPException(status_code=400, detail="Invalid Firebase token: uid missing.")

    record = OnboardingRecord(
        **payload.model_dump(),
        user_id=user_id,
        created_at=datetime.utcnow(),
    )

    # Persist to Firestore under collection "onboarding"
    db = firestore.client()
    doc_ref = db.collection("onboarding").document(user_id)
    doc_ref.set(record.model_dump(mode="json"))

    return record
