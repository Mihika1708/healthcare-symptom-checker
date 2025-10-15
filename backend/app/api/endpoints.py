from fastapi import APIRouter, HTTPException
from app.models.schemas import SymptomRequest, SymptomResponse, QueryHistory
from app.services.llm_service import LLMService
from app.services.database_service import DatabaseService
from typing import List

router = APIRouter()
llm_service = LLMService()
db_service = DatabaseService()

@router.post("/analyze-symptoms", response_model=SymptomResponse)
async def analyze_symptoms(request: SymptomRequest):
    """Analyze symptoms and return probable conditions"""
    try:
        # Get analysis from LLM
        response = await llm_service.analyze_symptoms(
            request.symptoms, 
            request.age, 
            request.gender
        )
        
        # Save to database
        query_id = await db_service.save_query(
            request.symptoms,
            {
                "probable_conditions": [condition.dict() for condition in response.probable_conditions],
                "recommended_next_steps": response.recommended_next_steps,
                "disclaimer": response.disclaimer
            }
        )
        
        response.query_id = query_id
        return response
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error analyzing symptoms: {str(e)}")

@router.get("/query-history", response_model=List[QueryHistory])
async def get_query_history(limit: int = 10):
    """Get recent query history"""
    try:
        history = await db_service.get_query_history(limit)
        return history
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error fetching history: {str(e)}")

@router.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy", "service": "Healthcare Symptom Checker"}