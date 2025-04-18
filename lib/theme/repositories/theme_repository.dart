import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/theme_constants.dart';
import 'package:mathflash/theme/themes/predefined_themes.dart';

/// Repository for managing theme storage and retrieval
class ThemeRepository {
  /// Singleton instance
  static final ThemeRepository _instance = ThemeRepository._internal();
  
  /// Factory constructor
  factory ThemeRepository() => _instance;
  
  /// Internal constructor
  ThemeRepository._internal();
  
  /// Shared preferences instance
  SharedPreferences? _prefs;
  
  /// Initialize the repository
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// Get the current theme mode
  Future<ThemeMode> getThemeMode() async {
    await _ensureInitialized();
    
    final modeString = _prefs!.getString(ThemeConstants.themeModeKey) ?? 
        ThemeConstants.systemMode;
    
    switch (modeString) {
      case ThemeConstants.lightMode:
        return ThemeMode.light;
      case ThemeConstants.darkMode:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
  
  /// Save the current theme mode
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _ensureInitialized();
    
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = ThemeConstants.lightMode;
        break;
      case ThemeMode.dark:
        modeString = ThemeConstants.darkMode;
        break;
      default:
        modeString = ThemeConstants.systemMode;
    }
    
    await _prefs!.setString(ThemeConstants.themeModeKey, modeString);
  }
  
  /// Get the current theme
  Future<ThemeModel> getCurrentTheme({required Brightness platformBrightness}) async {
    await _ensureInitialized();
    
    // Get the theme type
    final themeType = _prefs!.getString(ThemeConstants.themeTypeKey) ?? 
        ThemeConstants.defaultTheme;
    
    // Get the theme mode
    final themeMode = await getThemeMode();
    
    // Determine if we should use dark mode
    bool useDarkMode;
    switch (themeMode) {
      case ThemeMode.light:
        useDarkMode = false;
        break;
      case ThemeMode.dark:
        useDarkMode = true;
        break;
      default:
        // Use system setting
        useDarkMode = platformBrightness == Brightness.dark;
    }
    
    // If it's a custom theme, load it from preferences
    if (themeType == ThemeConstants.customTheme) {
      return await _loadCustomTheme(useDarkMode);
    }
    
    // Otherwise, get a predefined theme
    return _getPredefinedTheme(themeType, useDarkMode);
  }
  
  /// Save the current theme type
  Future<void> saveThemeType(String themeType) async {
    await _ensureInitialized();
    await _prefs!.setString(ThemeConstants.themeTypeKey, themeType);
  }
  
  /// Save a custom theme
  Future<void> saveCustomTheme(ThemeModel theme) async {
    await _ensureInitialized();
    
    // Save the theme as a JSON string
    final themeJson = jsonEncode(theme.toJson());
    final key = _getCustomThemeKey(theme.isDark);
    await _prefs!.setString(key, themeJson);
    
    // Set the theme type to custom
    await saveThemeType(ThemeConstants.customTheme);
  }
  
  /// Get the font scale factor
  Future<double> getFontScale() async {
    await _ensureInitialized();
    return _prefs!.getDouble(ThemeConstants.fontScaleKey) ?? 
        ThemeConstants.defaultFontScale;
  }
  
  /// Save the font scale factor
  Future<void> saveFontScale(double scale) async {
    await _ensureInitialized();
    await _prefs!.setDouble(ThemeConstants.fontScaleKey, scale);
  }
  
  /// Get whether to use system font
  Future<bool> getUseSystemFont() async {
    await _ensureInitialized();
    return _prefs!.getBool(ThemeConstants.useSystemFontKey) ?? false;
  }
  
  /// Save whether to use system font
  Future<void> saveUseSystemFont(bool useSystemFont) async {
    await _ensureInitialized();
    await _prefs!.setBool(ThemeConstants.useSystemFontKey, useSystemFont);
  }
  
  /// Get all available themes
  List<ThemeModel> getAllThemes({required bool isDark}) {
    return PredefinedThemes.getAll(isDark: isDark);
  }
  
  /// Ensure the repository is initialized
  Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await initialize();
    }
  }
  
  /// Get a predefined theme
  ThemeModel _getPredefinedTheme(String themeType, bool isDark) {
    return PredefinedThemes.getByType(themeType, isDark: isDark);
  }
  
  /// Load a custom theme from preferences
  Future<ThemeModel> _loadCustomTheme(bool isDark) async {
    final key = _getCustomThemeKey(isDark);
    final themeJson = _prefs!.getString(key);
    
    if (themeJson == null) {
      // If no custom theme is saved, return the default theme
      return _getPredefinedTheme(ThemeConstants.defaultTheme, isDark);
    }
    
    try {
      final themeMap = jsonDecode(themeJson) as Map<String, dynamic>;
      return ThemeModel.fromJson(themeMap);
    } catch (e) {
      // If there's an error parsing the theme, return the default theme
      return _getPredefinedTheme(ThemeConstants.defaultTheme, isDark);
    }
  }
  
  /// Get the key for storing a custom theme
  String _getCustomThemeKey(bool isDark) {
    return isDark 
        ? '${ThemeConstants.customTheme}_dark' 
        : '${ThemeConstants.customTheme}_light';
  }
}
