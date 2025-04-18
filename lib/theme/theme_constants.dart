import 'package:flutter/material.dart';

/// Constants for the theme system
class ThemeConstants {
  // Theme mode names
  static const String systemMode = 'system';
  static const String lightMode = 'light';
  static const String darkMode = 'dark';
  
  // Theme types
  static const String defaultTheme = 'default';
  static const String blueTheme = 'blue';
  static const String greenTheme = 'green';
  static const String purpleTheme = 'purple';
  static const String orangeTheme = 'orange';
  static const String highContrastTheme = 'high_contrast';
  static const String cosmicTheme = 'cosmic';
  static const String customTheme = 'custom';
  
  // Storage keys
  static const String themeTypeKey = 'theme_type';
  static const String themeModeKey = 'theme_mode';
  static const String customPrimaryColorKey = 'custom_primary_color';
  static const String customSecondaryColorKey = 'custom_secondary_color';
  static const String customBackgroundColorKey = 'custom_background_color';
  static const String customTextColorKey = 'custom_text_color';
  static const String fontScaleKey = 'font_scale';
  static const String useSystemFontKey = 'use_system_font';
  
  // Default values
  static const double defaultFontScale = 1.0;
  static const double minFontScale = 0.8;
  static const double maxFontScale = 1.5;
  
  // Animation durations
  static const Duration themeChangeDuration = Duration(milliseconds: 300);
  
  // Accessibility
  static const double minContrastRatio = 4.5; // WCAG AA standard
  
  // Font families
  static const String defaultFontFamily = 'Roboto';
  static const List<String> supportedFontFamilies = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
  ];
  
  // Default colors for custom themes
  static const Color defaultPrimaryColor = Colors.blue;
  static const Color defaultSecondaryColor = Colors.blueAccent;
  static const Color defaultBackgroundColor = Colors.white;
  static const Color defaultTextColor = Colors.black87;
  
  // Prevent instantiation
  ThemeConstants._();
}
