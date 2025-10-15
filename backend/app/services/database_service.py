from supabase import create_client, Client
from app.config import settings
import json
from datetime import datetime

class DatabaseService:
    def __init__(self):
        self.client: Client = create_client(settings.SUPABASE_URL, settings.SUPABASE_KEY)
    
    async def save_query(self, symptoms: str, response: dict) -> str:
        """Save query to database and return query ID"""
        try:
            data = {
                "symptoms": symptoms,
                "response": response,
                "created_at": datetime.utcnow().isoformat()
            }
            result = self.client.table("symptom_queries").insert(data).execute()
            return result.data[0]['id'] if result.data else None
        except Exception as e:
            print(f"Error saving query: {e}")
            return None
    
    async def get_query_history(self, limit: int = 10):
        """Get recent query history"""
        try:
            result = self.client.table("symptom_queries")\
                .select("*")\
                .order("created_at", desc=True)\
                .limit(limit)\
                .execute()
            return result.data
        except Exception as e:
            print(f"Error fetching history: {e}")
            return []