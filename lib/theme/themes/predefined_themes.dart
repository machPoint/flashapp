import 'package:flutter/material.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/theme_constants.dart';
import 'package:mathflash/theme/themes/cosmic_theme.dart';

/// Collection of predefined themes for the app
class PredefinedThemes {
  // Default light theme
  static ThemeModel defaultLight = ThemeModel(
    id: 'default_light',
    name: 'Default Light',
    themeType: ThemeConstants.defaultTheme,
    isDark: false,
    primaryColor: Colors.blue,
    secondaryColor: Colors.blueAccent,
    backgroundColor: Colors.white,
    surfaceColor: Colors.white,
    textColor: Colors.black87,
    secondaryTextColor: Colors.black54,
    accentColor: Colors.blue.shade300,
    errorColor: Colors.red.shade700,
  );
  
  // Default dark theme
  static ThemeModel defaultDark = ThemeModel(
    id: 'default_dark',
    name: 'Default Dark',
    themeType: ThemeConstants.defaultTheme,
    isDark: true,
    primaryColor: Colors.blue,
    secondaryColor: Colors.blueAccent,
    backgroundColor: const Color(0xFF121212),
    surfaceColor: const Color(0xFF1E1E1E),
    textColor: Colors.white,
    secondaryTextColor: Colors.white70,
    accentColor: Colors.blue.shade300,
    errorColor: Colors.red.shade400,
  );
  
  // Blue light theme
  static ThemeModel blueLight = ThemeModel(
    id: 'blue_light',
    name: 'Blue',
    themeType: ThemeConstants.blueTheme,
    isDark: false,
    primaryColor: Colors.blue.shade600,
    secondaryColor: Colors.lightBlue.shade300,
    backgroundColor: Colors.blue.shade50,
    surfaceColor: Colors.white,
    textColor: Colors.blueGrey.shade900,
    secondaryTextColor: Colors.blueGrey.shade700,
    accentColor: Colors.lightBlue.shade200,
    errorColor: Colors.red.shade700,
  );
  
  // Blue dark theme
  static ThemeModel blueDark = ThemeModel(
    id: 'blue_dark',
    name: 'Blue Dark',
    themeType: ThemeConstants.blueTheme,
    isDark: true,
    primaryColor: Colors.blue.shade400,
    secondaryColor: Colors.lightBlue.shade200,
    backgroundColor: const Color(0xFF0A1929),
    surfaceColor: const Color(0xFF0F2744),
    textColor: Colors.blue.shade50,
    secondaryTextColor: Colors.blue.shade100,
    accentColor: Colors.lightBlue.shade200,
    errorColor: Colors.red.shade400,
  );
  
  // Green light theme
  static ThemeModel greenLight = ThemeModel(
    id: 'green_light',
    name: 'Green',
    themeType: ThemeConstants.greenTheme,
    isDark: false,
    primaryColor: Colors.green.shade600,
    secondaryColor: Colors.lightGreen.shade300,
    backgroundColor: Colors.green.shade50,
    surfaceColor: Colors.white,
    textColor: Colors.grey.shade900,
    secondaryTextColor: Colors.grey.shade700,
    accentColor: Colors.lightGreen.shade200,
    errorColor: Colors.red.shade700,
  );
  
  // Green dark theme
  static ThemeModel greenDark = ThemeModel(
    id: 'green_dark',
    name: 'Green Dark',
    themeType: ThemeConstants.greenTheme,
    isDark: true,
    primaryColor: Colors.green.shade400,
    secondaryColor: Colors.lightGreen.shade200,
    backgroundColor: const Color(0xFF0A2918),
    surfaceColor: const Color(0xFF0F3D25),
    textColor: Colors.green.shade50,
    secondaryTextColor: Colors.green.shade100,
    accentColor: Colors.lightGreen.shade200,
    errorColor: Colors.red.shade400,
  );
  
  // Purple light theme
  static ThemeModel purpleLight = ThemeModel(
    id: 'purple_light',
    name: 'Purple',
    themeType: ThemeConstants.purpleTheme,
    isDark: false,
    primaryColor: Colors.purple.shade600,
    secondaryColor: Colors.purpleAccent.shade100,
    backgroundColor: Colors.purple.shade50,
    surfaceColor: Colors.white,
    textColor: Colors.grey.shade900,
    secondaryTextColor: Colors.grey.shade700,
    accentColor: Colors.purpleAccent.shade100,
    errorColor: Colors.red.shade700,
  );
  
  // Purple dark theme
  static ThemeModel purpleDark = ThemeModel(
    id: 'purple_dark',
    name: 'Purple Dark',
    themeType: ThemeConstants.purpleTheme,
    isDark: true,
    primaryColor: Colors.purple.shade400,
    secondaryColor: Colors.purpleAccent.shade100,
    backgroundColor: const Color(0xFF1A0E29),
    surfaceColor: const Color(0xFF2D1646),
    textColor: Colors.purple.shade50,
    secondaryTextColor: Colors.purple.shade100,
    accentColor: Colors.purpleAccent.shade100,
    errorColor: Colors.red.shade400,
  );
  
  // Orange light theme
  static ThemeModel orangeLight = ThemeModel(
    id: 'orange_light',
    name: 'Orange',
    themeType: ThemeConstants.orangeTheme,
    isDark: false,
    primaryColor: Colors.orange.shade600,
    secondaryColor: Colors.amber.shade300,
    backgroundColor: Colors.orange.shade50,
    surfaceColor: Colors.white,
    textColor: Colors.brown.shade900,
    secondaryTextColor: Colors.brown.shade700,
    accentColor: Colors.amber.shade200,
    errorColor: Colors.red.shade700,
  );
  
  // Orange dark theme
  static ThemeModel orangeDark = ThemeModel(
    id: 'orange_dark',
    name: 'Orange Dark',
    themeType: ThemeConstants.orangeTheme,
    isDark: true,
    primaryColor: Colors.orange.shade400,
    secondaryColor: Colors.amber.shade200,
    backgroundColor: const Color(0xFF2A1506),
    surfaceColor: const Color(0xFF3D2110),
    textColor: Colors.orange.shade50,
    secondaryTextColor: Colors.orange.shade100,
    accentColor: Colors.amber.shade200,
    errorColor: Colors.red.shade400,
  );
  
  // High contrast light theme (for accessibility)
  static ThemeModel highContrastLight = ThemeModel(
    id: 'high_contrast_light',
    name: 'High Contrast Light',
    themeType: ThemeConstants.highContrastTheme,
    isDark: false,
    primaryColor: Colors.black,
    secondaryColor: Colors.black87,
    backgroundColor: Colors.white,
    surfaceColor: Colors.white,
    textColor: Colors.black,
    secondaryTextColor: Colors.black87,
    accentColor: Colors.black,
    errorColor: Colors.red.shade900,
    fontScale: 1.2, // Slightly larger text for better readability
  );
  
  // High contrast dark theme (for accessibility)
  static ThemeModel highContrastDark = ThemeModel(
    id: 'high_contrast_dark',
    name: 'High Contrast Dark',
    themeType: ThemeConstants.highContrastTheme,
    isDark: true,
    primaryColor: Colors.yellow,
    secondaryColor: Colors.yellow.shade700,
    backgroundColor: Colors.black,
    surfaceColor: const Color(0xFF121212),
    textColor: Colors.yellow,
    secondaryTextColor: Colors.yellow.shade700,
    accentColor: Colors.yellow,
    errorColor: Colors.red.shade400,
    fontScale: 1.2, // Slightly larger text for better readability
  );
  
  /// Get all predefined themes
  static List<ThemeModel> getAll({required bool isDark}) {
    if (isDark) {
      return [
        CosmicTheme.cosmicDark, // Add cosmic theme first as it's our featured theme
        defaultDark,
        blueDark,
        greenDark,
        purpleDark,
        orangeDark,
        highContrastDark,
      ];
    } else {
      return [
        CosmicTheme.cosmicLight, // Add cosmic theme first as it's our featured theme
        defaultLight,
        blueLight,
        greenLight,
        purpleLight,
        orangeLight,
        highContrastLight,
      ];
    }
  }
  
  /// Get a theme by its type
  static ThemeModel getByType(String type, {required bool isDark}) {
    switch (type) {
      case cosmicTheme:
        return CosmicTheme.getCosmicTheme(isDark: isDark);
      case ThemeConstants.blueTheme:
        return isDark ? blueDark : blueLight;
      case ThemeConstants.greenTheme:
        return isDark ? greenDark : greenLight;
      case ThemeConstants.purpleTheme:
        return isDark ? purpleDark : purpleLight;
      case ThemeConstants.orangeTheme:
        return isDark ? orangeDark : orangeLight;
      case ThemeConstants.highContrastTheme:
        return isDark ? highContrastDark : highContrastLight;
      case ThemeConstants.defaultTheme:
      default:
        return isDark ? defaultDark : defaultLight;
    }
  }
  
  // Cosmic theme constant
  static const String cosmicTheme = 'cosmic';
  
  // Prevent instantiation
  PredefinedThemes._();
}
