import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/repositories/theme_repository.dart';
import 'package:mathflash/theme/theme_constants.dart';

/// A production-grade theme provider that manages theme state and preferences
class ThemeProvider extends ChangeNotifier {
  /// Theme repository for storage and retrieval
  final ThemeRepository _repository = ThemeRepository();
  
  /// Current theme mode (system, light, dark)
  ThemeMode _themeMode = ThemeMode.system;
  
  /// Current theme type
  String _themeType = ThemeConstants.defaultTheme;
  
  /// Current theme model
  ThemeModel? _currentTheme;
  
  /// Font scale factor
  double _fontScale = ThemeConstants.defaultFontScale;
  
  /// Whether to use system font
  bool _useSystemFont = false;
  
  /// Whether the theme is currently being initialized
  bool _isInitializing = true;
  
  /// Whether the theme is currently being changed
  bool _isChanging = false;
  
  /// Get the current theme mode
  ThemeMode get themeMode => _themeMode;
  
  /// Get the current theme type
  String get themeType => _themeType;
  
  /// Get the current theme model
  ThemeModel get currentTheme => _currentTheme!;
  
  /// Get the current font scale
  double get fontScale => _fontScale;
  
  /// Get whether to use system font
  bool get useSystemFont => _useSystemFont;
  
  /// Get whether dark mode is active
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
  
  /// Get whether the theme is currently initializing
  bool get isInitializing => _isInitializing;
  
  /// Get whether the theme is currently changing
  bool get isChanging => _isChanging;
  
  /// Constructor
  ThemeProvider() {
    _initialize();
  }
  
  /// Initialize the theme provider
  Future<void> _initialize() async {
    _isInitializing = true;
    notifyListeners();
    
    try {
      // Initialize the repository
      await _repository.initialize();
      
      // Load theme mode
      _themeMode = await _repository.getThemeMode();
      
      // Load theme type
      final prefs = await SharedPreferences.getInstance();
      _themeType = prefs.getString(ThemeConstants.themeTypeKey) ?? 
          ThemeConstants.defaultTheme;
      
      // Load font scale
      _fontScale = await _repository.getFontScale();
      
      // Load system font preference
      _useSystemFont = await _repository.getUseSystemFont();
      
      // Load the current theme
      await _loadCurrentTheme();
    } catch (e) {
      // If there's an error, use default values
      _themeMode = ThemeMode.system;
      _themeType = ThemeConstants.defaultTheme;
      _fontScale = ThemeConstants.defaultFontScale;
      _useSystemFont = false;
      
      // Load a default theme
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;
      _currentTheme = _repository.getAllThemes(isDark: isDark).first;
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }
  
  /// Load the current theme
  Future<void> _loadCurrentTheme() async {
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _currentTheme = await _repository.getCurrentTheme(
      platformBrightness: brightness,
    );
    
    // Apply font scale
    if (_currentTheme != null) {
      _currentTheme = _currentTheme!.copyWith(
        fontScale: _fontScale,
        fontFamily: _useSystemFont ? null : _currentTheme!.fontFamily,
      );
    }
  }
  
  /// Set the theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _isChanging = true;
    notifyListeners();
    
    try {
      _themeMode = mode;
      await _repository.saveThemeMode(mode);
      await _loadCurrentTheme();
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
  
  /// Toggle between light and dark mode
  Future<void> toggleLightDark() async {
    final newMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }
  
  /// Set the theme type
  Future<void> setThemeType(String type) async {
    if (_themeType == type) return;
    
    _isChanging = true;
    notifyListeners();
    
    try {
      _themeType = type;
      await _repository.saveThemeType(type);
      await _loadCurrentTheme();
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
  
  /// Set a custom theme
  Future<void> setCustomTheme(ThemeModel theme) async {
    _isChanging = true;
    notifyListeners();
    
    try {
      await _repository.saveCustomTheme(theme);
      _themeType = ThemeConstants.customTheme;
      await _loadCurrentTheme();
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
  
  /// Set the font scale
  Future<void> setFontScale(double scale) async {
    if (_fontScale == scale) return;
    
    _isChanging = true;
    notifyListeners();
    
    try {
      _fontScale = scale;
      await _repository.saveFontScale(scale);
      
      // Update the current theme with the new font scale
      if (_currentTheme != null) {
        _currentTheme = _currentTheme!.copyWith(fontScale: scale);
      }
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
  
  /// Set whether to use system font
  Future<void> setUseSystemFont(bool useSystemFont) async {
    if (_useSystemFont == useSystemFont) return;
    
    _isChanging = true;
    notifyListeners();
    
    try {
      _useSystemFont = useSystemFont;
      await _repository.saveUseSystemFont(useSystemFont);
      
      // Update the current theme with the new font family
      if (_currentTheme != null) {
        _currentTheme = _currentTheme!.copyWith(
          fontFamily: useSystemFont ? null : _currentTheme!.fontFamily,
        );
      }
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
  
  /// Get all available themes
  List<ThemeModel> getAllThemes() {
    return _repository.getAllThemes(isDark: isDarkMode);
  }
  
  /// Get the theme data for the current theme
  ThemeData getThemeData() {
    if (_currentTheme == null) {
      // If there's no current theme, use a default theme
      final isDark = isDarkMode;
      return _repository.getAllThemes(isDark: isDark).first.toThemeData();
    }
    
    return _currentTheme!.toThemeData();
  }
  
  /// Reset to default theme
  Future<void> resetToDefault() async {
    _isChanging = true;
    notifyListeners();
    
    try {
      await _repository.saveThemeType(ThemeConstants.defaultTheme);
      await _repository.saveThemeMode(ThemeMode.system);
      await _repository.saveFontScale(ThemeConstants.defaultFontScale);
      await _repository.saveUseSystemFont(false);
      
      _themeType = ThemeConstants.defaultTheme;
      _themeMode = ThemeMode.system;
      _fontScale = ThemeConstants.defaultFontScale;
      _useSystemFont = false;
      
      await _loadCurrentTheme();
    } finally {
      _isChanging = false;
      notifyListeners();
    }
  }
}
