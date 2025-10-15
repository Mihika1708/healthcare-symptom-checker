from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class SymptomRequest(BaseModel):
    symptoms: str
    age: Optional[int] = None
    gender: Optional[str] = None

class ConditionSuggestion(BaseModel):
    condition: str
    confidence: str
    description: str

class SymptomResponse(BaseModel):
    probable_conditions: List[ConditionSuggestion]
    recommended_next_steps: List[str]
    disclaimer: str
    query_id: Optional[str] = None

class QueryHistory(BaseModel):
    id: str
    symptoms: str
    response: dict
    created_at: datetime