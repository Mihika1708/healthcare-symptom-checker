import React, { useState, useEffect } from 'react';
import SymptomChecker from './pages/SymptomChecker';
import Header from './components/Header';
import './styles/index.css';

function App() {
  const [darkMode, setDarkMode] = useState(false);

  useEffect(() => {
    // Check system preference or saved theme
    const savedTheme = localStorage.getItem('theme');
    const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    if (savedTheme === 'dark' || (!savedTheme && systemPrefersDark)) {
      setDarkMode(true);
    }
  }, []);

  useEffect(() => {
    // Apply theme to document
    if (darkMode) {
      document.documentElement.classList.add('dark');
      localStorage.setItem('theme', 'dark');
    } else {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('theme', 'light');
    }
  }, [darkMode]);

  const toggleTheme = () => {
    setDarkMode(!darkMode);
  };

  return (
    <div className={`min-h-screen transition-colors duration-300 ${
      darkMode 
        ? 'dark:bg-gray-900 dark:text-white bg-gradient-to-br from-gray-900 to-blue-900' 
        : 'bg-gradient-to-br from-blue-50 to-cyan-100'
    }`}>
      <Header darkMode={darkMode} toggleTheme={toggleTheme} />
      <main className="container mx-auto px-4 py-8">
        <SymptomChecker darkMode={darkMode} />
      </main>
    </div>
  );
}

export default App;

