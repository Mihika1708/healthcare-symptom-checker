import React from 'react';
import { AlertTriangle, CheckCircle, ArrowRight, ExternalLink } from 'lucide-react';
import ConditionItem from './ConditionItem';

const ResultCard = ({ results, darkMode }) => {
  if (!results) return null;

  const getConfidenceColor = (confidence) => {
    switch (confidence.toLowerCase()) {
      case 'high':
        return 'text-red-500';
      case 'medium':
        return 'text-yellow-500';
      case 'low':
        return 'text-green-500';
      default:
        return 'text-gray-500';
    }
  };

  return (
    <div className="space-y-6 animate-slide-up">
      {/* Results Card */}
      <div className={`rounded-2xl shadow-lg border transition-all duration-300 ${
        darkMode ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'
      } p-6`}>
        <div className="flex items-center space-x-3 mb-6">
          <div className={`p-2 rounded-lg ${
            darkMode ? 'bg-green-600' : 'bg-green-500'
          }`}>
            <CheckCircle className="h-5 w-5 text-white" />
          </div>
          <div>
            <h3 className={`text-lg font-bold ${
              darkMode ? 'text-white' : 'text-gray-900'
            }`}>
              Analysis Results
            </h3>
            <p className={`text-sm ${
              darkMode ? 'text-gray-400' : 'text-gray-600'
            }`}>
              Based on your symptoms
            </p>
          </div>
        </div>

        {/* Probable Conditions */}
        <div className="mb-6">
          <h4 className={`font-semibold mb-4 ${
            darkMode ? 'text-gray-300' : 'text-gray-700'
          }`}>
            Probable Conditions
          </h4>
          <div className="space-y-3">
            {results.probable_conditions?.map((condition, index) => (
              <ConditionItem 
                key={index}
                condition={condition}
                darkMode={darkMode}
              />
            ))}
          </div>
        </div>

        {/* Recommended Next Steps */}
        <div className="mb-6">
          <h4 className={`font-semibold mb-4 ${
            darkMode ? 'text-gray-300' : 'text-gray-700'
          }`}>
            Recommended Next Steps
          </h4>
          <div className="space-y-2">
            {results.recommended_next_steps?.map((step, index) => (
              <div key={index} className="flex items-start space-x-3">
                <ArrowRight className={`h-4 w-4 mt-1 flex-shrink-0 ${
                  darkMode ? 'text-blue-400' : 'text-blue-500'
                }`} />
                <p className={`text-sm ${
                  darkMode ? 'text-gray-300' : 'text-gray-700'
                }`}>
                  {step}
                </p>
              </div>
            ))}
          </div>
        </div>

        {/* Disclaimer */}
        <div className={`rounded-lg p-4 border ${
          darkMode 
            ? 'bg-yellow-900/20 border-yellow-800' 
            : 'bg-yellow-50 border-yellow-200'
        }`}>
          <div className="flex items-start space-x-3">
            <AlertTriangle className={`h-5 w-5 mt-0.5 flex-shrink-0 ${
              darkMode ? 'text-yellow-400' : 'text-yellow-600'
            }`} />
            <div>
              <p className={`text-sm font-medium ${
                darkMode ? 'text-yellow-300' : 'text-yellow-800'
              }`}>
                Important Disclaimer
              </p>
              <p className={`text-sm mt-1 ${
                darkMode ? 'text-yellow-200' : 'text-yellow-700'
              }`}>
                {results.disclaimer}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Emergency Card */}
      <div className={`rounded-2xl shadow-lg border transition-all duration-300 ${
        darkMode ? 'bg-red-900/20 border-red-800' : 'bg-red-50 border-red-200'
      } p-6`}>
        <div className="flex items-center space-x-3 mb-4">
          <AlertTriangle className="h-6 w-6 text-red-500" />
          <h3 className={`text-lg font-bold ${
            darkMode ? 'text-red-300' : 'text-red-800'
          }`}>
            Emergency Warning
          </h3>
        </div>
        <p className={`text-sm mb-4 ${
          darkMode ? 'text-red-200' : 'text-red-700'
        }`}>
          If you experience any of the following symptoms, seek immediate medical attention:
        </p>
        <ul className={`text-sm space-y-2 ${
          darkMode ? 'text-red-200' : 'text-red-700'
        }`}>
          <li className="flex items-center space-x-2">
            <div className="w-1.5 h-1.5 bg-red-500 rounded-full"></div>
            <span>Chest pain or pressure</span>
          </li>
          <li className="flex items-center space-x-2">
            <div className="w-1.5 h-1.5 bg-red-500 rounded-full"></div>
            <span>Difficulty breathing</span>
          </li>
          <li className="flex items-center space-x-2">
            <div className="w-1.5 h-1.5 bg-red-500 rounded-full"></div>
            <span>Severe bleeding</span>
          </li>
          <li className="flex items-center space-x-2">
            <div className="w-1.5 h-1.5 bg-red-500 rounded-full"></div>
            <span>Sudden weakness or numbness</span>
          </li>
        </ul>
        <button className={`w-full mt-4 py-2 px-4 rounded-lg font-semibold text-sm transition-colors flex items-center justify-center space-x-2 ${
          darkMode 
            ? 'bg-red-600 hover:bg-red-700 text-white' 
            : 'bg-red-500 hover:bg-red-600 text-white'
        }`}>
          <ExternalLink className="h-4 w-4" />
          <span>Find Emergency Services</span>
        </button>
      </div>
    </div>
  );
};

export default ResultCard;