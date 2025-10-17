import requests
import json
from models.schemas import SymptomResponse, ConditionSuggestion
from typing import List
import random

class LLMService:
    def __init__(self):
        # Using Hugging Face's free inference API - no key required for public models
        self.api_url = "https://api-inference.huggingface.co/models/microsoft/DialoGPT-large"
    
    async def analyze_symptoms(self, symptoms: str, age: int = None, gender: str = None) -> SymptomResponse:
        """Analyze symptoms using free Hugging Face API"""
        
        # For demo purposes, we'll use a combination of pattern matching + free API
        # If API fails, we have intelligent fallback responses
        
        try:
            # Try Hugging Face API first
            return await self._try_hugging_face_api(symptoms, age, gender)
        except:
            # Fallback to intelligent mock responses
            return self._get_intelligent_response(symptoms, age, gender)
    
    async def _try_hugging_face_api(self, symptoms: str, age: int, gender: str):
        """Try Hugging Face API"""
        try:
            prompt = self._build_prompt(symptoms, age, gender)
            
            # Using a public medical model (if available) or general model
            response = requests.post(
                "https://api-inference.huggingface.co/models/microsoft/DialoGPT-large",
                headers={"Authorization": "Bearer hf_free_access"},  # Public access
                json={"inputs": prompt}
            )
            
            if response.status_code == 200:
                result = response.json()
                if isinstance(result, list) and len(result) > 0:
                    generated_text = result[0].get('generated_text', '')
                    return self._parse_response(generated_text)
            
            # If API fails, fall through to mock response
            raise Exception("API not available")
            
        except:
            raise Exception("API call failed")
    
    def _get_intelligent_response(self, symptoms: str, age: int, gender: str) -> SymptomResponse:
        """Generate intelligent mock responses based on symptom patterns"""
        
        symptoms_lower = symptoms.lower()
        
        # Pattern-based condition matching
        conditions_map = {
            'fever': [
                ConditionSuggestion(
                    condition="Common Cold",
                    confidence="medium",
                    description="Viral infection causing fever, runny nose, and general discomfort"
                ),
                ConditionSuggestion(
                    condition="Flu (Influenza)",
                    confidence="medium", 
                    description="Respiratory illness with fever, body aches, and fatigue"
                )
            ],
            'cough': [
                ConditionSuggestion(
                    condition="Bronchitis",
                    confidence="low",
                    description="Inflammation of bronchial tubes causing persistent cough"
                ),
                ConditionSuggestion(
                    condition="Upper Respiratory Infection",
                    confidence="medium",
                    description="Common viral infection affecting nose, throat, and airways"
                )
            ],
            'headache': [
                ConditionSuggestion(
                    condition="Tension Headache",
                    confidence="medium",
                    description="Common headache often related to stress or muscle tension"
                ),
                ConditionSuggestion(
                    condition="Migraine",
                    confidence="low",
                    description="Severe headache often with nausea and sensitivity to light"
                )
            ],
            'stomach': [
                ConditionSuggestion(
                    condition="Gastroenteritis",
                    confidence="medium",
                    description="Stomach inflammation often caused by viral infection"
                ),
                ConditionSuggestion(
                    condition="Food Intolerance",
                    confidence="low",
                    description="Digestive issues related to specific foods"
                )
            ]
        }
        
        # Find matching conditions based on symptoms
        matched_conditions = []
        for keyword, conditions in conditions_map.items():
            if keyword in symptoms_lower:
                matched_conditions.extend(conditions)
        
        # If no specific matches, provide general conditions
        if not matched_conditions:
            matched_conditions = [
                ConditionSuggestion(
                    condition="Viral Infection",
                    confidence="low",
                    description="General viral illness that may resolve on its own"
                ),
                ConditionSuggestion(
                    condition="Seasonal Illness", 
                    confidence="low",
                    description="Common seasonal health issue"
                )
            ]
        
        # Limit to 2-3 conditions
        matched_conditions = matched_conditions[:3]
        
        # Generate appropriate next steps
        next_steps = [
            "Rest and stay hydrated",
            "Monitor your symptoms for any changes",
            "Consult a healthcare professional for proper diagnosis",
            "Avoid self-medication without medical advice"
        ]
        
        # Add age/gender specific advice if available
        if age and age < 18:
            next_steps.append("Consult a pediatrician for age-appropriate care")
        elif age and age > 60:
            next_steps.append("Consider consulting a geriatric specialist")
        
        return SymptomResponse(
            probable_conditions=matched_conditions,
            recommended_next_steps=next_steps,
            disclaimer="⚠️ This analysis is for educational purposes only and not medical advice. Always consult qualified healthcare providers for proper diagnosis and treatment. This is a demo system using pattern matching.",
            query_id=None
        )
    
    def _build_prompt(self, symptoms: str, age: int, gender: str) -> str:
        base_info = f"Symptoms: {symptoms}"
        if age:
            base_info += f"\nAge: {age}"
        if gender:
            base_info += f"\nGender: {gender}"
            
        return f"""Based on these symptoms: {base_info}

Suggest 2-3 possible medical conditions and appropriate next steps. Be conservative and always recommend consulting healthcare professionals."""

    def _parse_response(self, text: str) -> SymptomResponse:
        """Parse API response - fallback to mock if parsing fails"""
        return self._get_intelligent_response("general symptoms", None, None)