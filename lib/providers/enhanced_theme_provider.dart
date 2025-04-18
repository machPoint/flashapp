import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum representing the available theme options in the app
enum AppTheme {
  light,
  dark,
  blue,
  green,
  purple,
  orange,
  highContrast
}

/// Enhanced theme provider that supports multiple themes beyond just light/dark
class EnhancedThemeProvider extends ChangeNotifier {
  // Default theme
  AppTheme _currentTheme = AppTheme.light;
  
  // Theme mode for system integration
  ThemeMode _themeMode = ThemeMode.light;
  
  // Getter for current theme
  AppTheme get currentTheme => _currentTheme;
  
  // Getter for theme mode
  ThemeMode get themeMode => _themeMode;
  
  // Convenience getter for dark mode
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  // Constructor
  EnhancedThemeProvider() {
    _loadThemePreference();
  }
  
  // Load saved theme preference
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString('app_theme');
      
      if (savedTheme != null) {
        _currentTheme = AppTheme.values.firstWhere(
          (theme) => theme.toString() == savedTheme,
          orElse: () => AppTheme.light,
        );
        
        // Update theme mode based on theme
        _updateThemeMode();
        notifyListeners();
      }
    } catch (e) {
      // Fallback to default theme if there's an error
      _currentTheme = AppTheme.light;
      _themeMode = ThemeMode.light;
    }
  }
  
  // Save theme preference
  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_theme', _currentTheme.toString());
    } catch (e) {
      // Silently fail if unable to save
    }
  }
  
  // Update theme mode based on current theme
  void _updateThemeMode() {
    switch (_currentTheme) {
      case AppTheme.light:
      case AppTheme.blue:
      case AppTheme.green:
      case AppTheme.orange:
        _themeMode = ThemeMode.light;
        break;
      case AppTheme.dark:
      case AppTheme.purple:
      case AppTheme.highContrast:
        _themeMode = ThemeMode.dark;
        break;
    }
  }
  
  // Set a specific theme
  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    _updateThemeMode();
    _saveThemePreference();
    notifyListeners();
  }
  
  // Toggle between light and dark mode
  void toggleLightDark() {
    if (_themeMode == ThemeMode.light) {
      setTheme(AppTheme.dark);
    } else {
      setTheme(AppTheme.light);
    }
  }
  
  // Get theme name for display
  String getThemeName(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.blue:
        return 'Blue';
      case AppTheme.green:
        return 'Green';
      case AppTheme.purple:
        return 'Purple';
      case AppTheme.orange:
        return 'Orange';
      case AppTheme.highContrast:
        return 'High Contrast';
    }
  }
  
  // Get theme data for the current theme
  ThemeData getThemeData() {
    switch (_currentTheme) {
      case AppTheme.light:
        return _lightTheme;
      case AppTheme.dark:
        return _darkTheme;
      case AppTheme.blue:
        return _blueTheme;
      case AppTheme.green:
        return _greenTheme;
      case AppTheme.purple:
        return _purpleTheme;
      case AppTheme.orange:
        return _orangeTheme;
      case AppTheme.highContrast:
        return _highContrastTheme;
    }
  }
  
  // Light theme
  ThemeData get _lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      cardTheme: const CardTheme(
        elevation: 4,
      ),
    );
  }
  
  // Dark theme
  ThemeData get _darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      cardTheme: const CardTheme(
        elevation: 4,
      ),
    );
  }
  
  // Blue theme
  ThemeData get _blueTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
        primary: Colors.blue.shade700,
        secondary: Colors.lightBlue,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.blue.shade50,
      ),
    );
  }
  
  // Green theme
  ThemeData get _greenTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.light,
        primary: Colors.green.shade700,
        secondary: Colors.lightGreen,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.green.shade50,
      ),
    );
  }
  
  // Purple theme
  ThemeData get _purpleTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Brightness.dark,
        primary: Colors.purple.shade300,
        secondary: Colors.purpleAccent,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade800,
      ),
    );
  }
  
  // Orange theme
  ThemeData get _orangeTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        brightness: Brightness.light,
        primary: Colors.orange.shade700,
        secondary: Colors.deepOrange,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.orange.shade50,
      ),
    );
  }
  
  // High contrast theme
  ThemeData get _highContrastTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.yellow,
        secondary: Colors.yellow,
        surface: Colors.black,
        background: Colors.black,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.yellow,
        onBackground: Colors.yellow,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.yellow),
        bodyMedium: TextStyle(color: Colors.yellow),
        titleLarge: TextStyle(color: Colors.yellow),
        titleMedium: TextStyle(color: Colors.yellow),
      ),
      cardTheme: const CardTheme(
        color: Colors.black,
      ),
    );
  }
}
