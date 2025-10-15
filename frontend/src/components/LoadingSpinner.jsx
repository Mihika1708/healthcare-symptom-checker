import React from 'react';
import { Activity } from 'lucide-react';

const LoadingSpinner = ({ darkMode, message = "Analyzing symptoms..." }) => {
  return (
    <div className={`rounded-2xl shadow-lg border transition-all duration-300 ${
      darkMode ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'
    } p-8 animate-fade-in`}>
      <div className="flex flex-col items-center justify-center space-y-4">
        <div className="relative">
          <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-blue-500"></div>
          <Activity className="h-6 w-6 text-blue-500 absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2" />
        </div>
        <div className="text-center">
          <h3 className={`font-semibold mb-2 ${
            darkMode ? 'text-white' : 'text-gray-900'
          }`}>
            {message}
          </h3>
          <p className={`text-sm ${
            darkMode ? 'text-gray-400' : 'text-gray-600'
          }`}>
            This may take a few moments...
          </p>
        </div>
      </div>
    </div>
  );
};

export default LoadingSpinner;