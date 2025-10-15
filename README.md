# 🏥 Healthcare Symptom Checker

A full-stack AI-powered symptom analysis application built for educational purposes.

## 🚀 Features

- **AI-Powered Analysis**: Intelligent symptom pattern matching
- **Modern Web Interface**: React frontend with dark/light themes
- **RESTful API**: FastAPI backend with comprehensive endpoints
- **Educational Focus**: Clear medical disclaimers and safety warnings

## 🛠️ Tech Stack

- **Backend**: Python, FastAPI
- **Frontend**: React, Tailwind CSS
- **Development**: Vite, Uvicorn

## 📁 Project Structure
healthcare-symptom-checker/
├── backend/ # Python FastAPI backend
│ ├── app/ # Application code
│ ├── requirements.txt # Python dependencies
│ └── simple_backend.py # Alternative simple server
├── frontend/ # React frontend
│ ├── src/ # React components
│ ├── public/ # Static files
│ └── package.json # Node dependencies
└── README.md # This file


## ⚡ Quick Start

### Backend Setup
```bash
cd backend
python -m venv venv
.\venv\Scripts\activate  # Windows
pip install -r requirements.txt
python -m uvicorn app.main:app --reload --port 8000
