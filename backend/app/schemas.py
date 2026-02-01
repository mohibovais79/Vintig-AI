"""Pydantic schemas for API payloads."""

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class OnboardingPayload(BaseModel):
    """Incoming data captured from the Flutter onboarding flow."""

    preferred_style: str = Field(..., description="Selected interior design style")
    budget: int = Field(..., ge=0, description="Budget in PKR")
    location: str = Field(..., min_length=2, description="City or region")
    additional_notes: Optional[str] = Field(
        default=None,
        description="Optional free-form text captured during onboarding.",
    )


class OnboardingRecord(OnboardingPayload):
    user_id: str
    created_at: datetime
