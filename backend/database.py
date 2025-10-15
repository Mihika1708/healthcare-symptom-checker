from supabase import create_client
import os
from dotenv import load_dotenv

load_dotenv()

def init_supabase():
    """Initialize Supabase client"""
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_KEY")
    
    if not url or not key:
        raise ValueError("Supabase URL and key must be set in environment variables")
    
    return create_client(url, key)

# Initialize Supabase client
supabase = init_supabase()