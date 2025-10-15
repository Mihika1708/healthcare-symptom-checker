import React, { useState } from 'react';
import SymptomForm from '../components/SymptomForm';
import ResultCard from '../components/ResultCard';
import LoadingSpinner from '../components/LoadingSpinner';
import { Activity, Shield, Clock, Users } from 'lucide-react';
import { symptomAPI } from '../services/api';

const SymptomChecker = ({ darkMode }) => {
  const [results, setResults] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const handleAnalysis = async (formData) => {
    setLoading(true);
    setError('');
    setResults(null);
    
    try {
      // Use actual API call
      const analysisResults = await symptomAPI.analyzeSymptoms(
        formData.symptoms,
        formData.age,
        formData.gender
      );
      setResults(analysisResults);
    } catch (err) {
      setError(err.message);
      // Fallback to mock data if API fails
      const mockResults = {
        probable_conditions: [
          {
            condition: "Common Cold",
            confidence: "medium",
            description: "Viral infection affecting nose and throat"
          },
          {
            condition: "Seasonal Allergies", 
            confidence: "low",
            description: "Allergic reaction to environmental factors"
          }
        ],
        recommended_next_steps: [
          "Rest and stay hydrated",
          "Monitor symptoms for changes",
          "Consult healthcare professional if symptoms worsen",
          "Consider over-the-counter remedies for symptom relief"
        ],
        disclaimer: "This analysis is for educational purposes only. Always consult qualified healthcare providers for proper diagnosis and treatment.",
        query_id: "mock-id-123"
      };
      setResults(mockResults);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-7xl mx-auto">
      {/* Hero Section */}
      <div className={`rounded-2xl p-8 mb-8 animate-fade-in ${
        darkMode 
          ? 'bg-gradient-to-r from-blue-800 to-purple-900' 
          : 'bg-gradient-to-r from-blue-600 to-cyan-600'
      } text-white`}>
        <div className="flex flex-col lg:flex-row items-center justify-between">
          <div className="flex items-center space-x-4 mb-6 lg:mb-0">
            <div className="p-3 bg-white/20 rounded-xl">
              <Activity className="h-8 w-8" />
            </div>
            <div>
              <h1 className="text-3xl font-bold">Symptom Checker</h1>
              <p className="text-blue-100">AI-powered health insights for educational purposes</p>
            </div>
          </div>
          
          <div className="grid grid-cols-2 lg:grid-cols-3 gap-4">
            <div className="flex items-center space-x-2">
              <Shield className="h-4 w-4 text-green-300" />
              <span className="text-sm">Educational Only</span>
            </div>
            <div className="flex items-center space-x-2">
              <Clock className="h-4 w-4 text-yellow-300" />
              <span className="text-sm">Quick Analysis</span>
            </div>
            <div className="flex items-center space-x-2">
              <Users className="h-4 w-4 text-blue-300" />
              <span className="text-sm">AI-Powered</span>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Input Form - 2/3 width on large screens */}
        <div className="lg:col-span-2 space-y-6">
          <SymptomForm 
            onSubmit={handleAnalysis} 
            loading={loading}
            darkMode={darkMode}
          />
          
          {loading && (
            <LoadingSpinner 
              darkMode={darkMode}
              message="Analyzing your symptoms with AI..."
            />
          )}

          {error && (
            <div className={`rounded-xl p-6 ${
              darkMode ? 'bg-red-900/20 border-red-800' : 'bg-red-50 border-red-200'
            } border animate-slide-up`}>
              <div className="flex items-center space-x-3">
                <div className="p-2 bg-red-100 rounded-lg">
                  <Activity className="h-5 w-5 text-red-600" />
                </div>
                <div>
                  <h3 className="font-semibold text-red-800 dark:text-red-200">Connection Issue</h3>
                  <p className="text-sm text-red-600 dark:text-red-300">
                    Using demo data. {error}
                  </p>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Results Sidebar - 1/3 width on large screens */}
        <div className="space-y-6">
          {results && <ResultCard results={results} darkMode={darkMode} />}
          
          {/* Info Card */}
          {!results && !loading && (
            <div className={`rounded-2xl shadow-lg border transition-all duration-300 ${
              darkMode ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'
            } p-6 animate-fade-in`}>
              <h3 className={`font-semibold mb-4 ${
                darkMode ? 'text-white' : 'text-gray-900'
              }`}>
                How It Works
              </h3>
              <div className="space-y-3">
                <div className="flex items-start space-x-3">
                  <div className={`p-1 rounded ${
                    darkMode ? 'bg-blue-600' : 'bg-blue-500'
                  }`}>
                    <span className="text-white text-sm font-bold">1</span>
                  </div>
                  <p className={`text-sm ${
                    darkMode ? 'text-gray-300' : 'text-gray-600'
                  }`}>
                    Describe your symptoms in detail
                  </p>
                </div>
                <div className="flex items-start space-x-3">
                  <div className={`p-1 rounded ${
                    darkMode ? 'bg-blue-600' : 'bg-blue-500'
                  }`}>
                    <span className="text-white text-sm font-bold">2</span>
                  </div>
                  <p className={`text-sm ${
                    darkMode ? 'text-gray-300' : 'text-gray-600'
                  }`}>
                    AI analyzes possible conditions
                  </p>
                </div>
                <div className="flex items-start space-x-3">
                  <div className={`p-1 rounded ${
                    darkMode ? 'bg-blue-600' : 'bg-blue-500'
                  }`}>
                    <span className="text-white text-sm font-bold">3</span>
                  </div>
                  <p className={`text-sm ${
                    darkMode ? 'text-gray-300' : 'text-gray-600'
                  }`}>
                    Get recommendations and next steps
                  </p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default SymptomChecker;