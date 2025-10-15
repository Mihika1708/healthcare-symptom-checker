import React from 'react';
import { TrendingUp, AlertCircle, Info } from 'lucide-react';

const ConditionItem = ({ condition, darkMode }) => {
  const getConfidenceIcon = (confidence) => {
    switch (confidence.toLowerCase()) {
      case 'high':
        return <AlertCircle className="h-4 w-4 text-red-500" />;
      case 'medium':
        return <TrendingUp className="h-4 w-4 text-yellow-500" />;
      case 'low':
        return <Info className="h-4 w-4 text-green-500" />;
      default:
        return <Info className="h-4 w-4 text-gray-500" />;
    }
  };

  const getConfidenceColor = (confidence) => {
    switch (confidence.toLowerCase()) {
      case 'high':
        return 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-300';
      case 'medium':
        return 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300';
      case 'low':
        return 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300';
      default:
        return 'bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-300';
    }
  };

  return (
    <div className={`rounded-xl border transition-all duration-300 hover:shadow-md ${
      darkMode ? 'bg-gray-700/50 border-gray-600' : 'bg-gray-50 border-gray-200'
    } p-4`}>
      <div className="flex items-start justify-between mb-2">
        <div className="flex items-center space-x-3">
          {getConfidenceIcon(condition.confidence)}
          <h5 className={`font-semibold ${
            darkMode ? 'text-white' : 'text-gray-900'
          }`}>
            {condition.condition}
          </h5>
        </div>
        <span className={`px-2 py-1 rounded-full text-xs font-medium ${getConfidenceColor(condition.confidence)}`}>
          {condition.confidence} confidence
        </span>
      </div>
      <p className={`text-sm ${
        darkMode ? 'text-gray-300' : 'text-gray-600'
      }`}>
        {condition.description}
      </p>
    </div>
  );
};

export default ConditionItem;