Healthcare Symptom Checker
An AI-powered web application for symptom analysis and health condition suggestions, built for educational purposes.

🚀 Features
Symptom Analysis: Input symptoms and get AI-powered analysis
Probable Conditions: Receive likely medical conditions based on symptoms
Educational Recommendations: Get appropriate next steps and advice
Safety First: Built-in disclaimers for educational use only
Query History: Track previous symptom analyses
Responsive Design: Works on desktop and mobile devices

🛠️ Tech Stack
Backend
FastAPI - Modern Python web framework
Python 3.11 - Programming language
Supabase - PostgreSQL database
Hugging Face API - LLM integration for symptom analysis

Frontend
Flutter Web - Cross-platform framework
Dart - Programming language
Responsive UI - Material Design components

📋 Prerequisites
Python 3.11+
Flutter SDK
Supabase Account (for database)
Git

## 📁 Project Structure
healthcare-symptom-checker/
├── backend/
│   ├── app/
│   │   ├── main.py              # FastAPI application
│   │   ├── api/
│   │   │   └── endpoints.py     # API routes
│   │   ├── models/
│   │   │   └── schemas.py       # Pydantic models
│   │   ├── services/
│   │   │   ├── llm_service.py   # AI symptom analysis
│   │   │   └── database_service.py # Database operations
│   │   └── config.py            # Configuration
│   └── requirements.txt         # Python dependencies
└── frontend/
    ├── lib/
    │   ├── main.dart            # Flutter app entry
    │   ├── app/
    │   │   └── app.dart         # App configuration
    │   ├── models/              # Data models
    │   ├── services/            # API services
    │   ├── screens/             # UI screens
    │   └── widgets/             # Reusable components
    └── pubspec.yaml            # Flutter dependencies

## ⚡ Quick Start

### Backend Setup
```bash
cd backend
python3.11 -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
cd app
python main.py
```
### Frontend Setup
```bash
cd frontend
flutter clean 
flutter pub get
flutter run -d chrome
```

🔌 API Endpoints
Symptom Analysis

POST /api/v1/analyze-symptoms - Analyze symptoms and get recommendations
GET /api/v1/query-history - Get analysis history
GET /api/v1/health - Health check

🎯 Key Features in Detail
1. Intelligent Symptom Analysis
Pattern-based symptom matching
AI-powered condition suggestions
Confidence level indicators

2. Safety & Education
Clear medical disclaimers
Educational recommendations only
Encourages professional consultation

3. User Experience
Clean, intuitive interface
Responsive design
Real-time feedback
History tracking

⚠️ Important Disclaimers
⚠️ MEDICAL DISCLAIMER: This application is for educational purposes only and is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of qualified healthcare providers with any medical concerns.
