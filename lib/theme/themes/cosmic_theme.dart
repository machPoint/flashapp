import 'package:flutter/material.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/theme_constants.dart';

/// A cosmic/space-themed set of themes for the app
class CosmicTheme {
  // Cosmic dark theme (primary)
  static ThemeModel cosmicDark = ThemeModel(
    id: 'cosmic_dark',
    name: 'Cosmic',
    themeType: ThemeConstants.cosmicTheme,
    isDark: true,
    primaryColor: const Color(0xFF9C42F5), // Vibrant purple
    secondaryColor: const Color(0xFF58C4F6), // Bright blue
    backgroundColor: const Color(0xFF0A0E1B), // Deep space blue
    surfaceColor: const Color(0xFF141A31), // Slightly lighter space blue
    textColor: Colors.white,
    secondaryTextColor: Colors.white70,
    accentColor: const Color(0xFF58C4F6), // Bright blue
    errorColor: const Color(0xFFF85C5C), // Bright red
    fontFamily: 'Poppins',
  );
  
  // Cosmic light theme (alternative)
  static ThemeModel cosmicLight = ThemeModel(
    id: 'cosmic_light',
    name: 'Cosmic Light',
    themeType: ThemeConstants.cosmicTheme,
    isDark: false,
    primaryColor: const Color(0xFF7B2CBF), // Deeper purple
    secondaryColor: const Color(0xFF3A86FF), // Deeper blue
    backgroundColor: const Color(0xFFF0F4FF), // Very light blue
    surfaceColor: Colors.white,
    textColor: const Color(0xFF0A0E1B), // Deep space blue
    secondaryTextColor: const Color(0xFF141A31).withOpacity(0.7), // Lighter space blue
    accentColor: const Color(0xFF58C4F6), // Bright blue
    errorColor: const Color(0xFFE63946), // Bright red
    fontFamily: 'Poppins',
  );
  
  /// Get the cosmic theme based on dark mode preference
  static ThemeModel getCosmicTheme({required bool isDark}) {
    return isDark ? cosmicDark : cosmicLight;
  }
  
  /// Create a custom ThemeData with cosmic-specific overrides
  static ThemeData createCosmicThemeData(ThemeModel baseTheme) {
    // Get the base theme data
    final baseThemeData = baseTheme.toThemeData();
    
    // Create cosmic-specific text theme
    final textTheme = baseThemeData.textTheme.copyWith(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: baseTheme.textColor,
        fontSize: 32,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: baseTheme.textColor,
        fontSize: 28,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: baseTheme.textColor,
        fontSize: 24,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: baseTheme.textColor,
        fontSize: 20,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: baseTheme.textColor,
        fontSize: 18,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: baseTheme.textColor,
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: baseTheme.textColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: baseTheme.textColor,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: baseTheme.secondaryTextColor,
        fontSize: 12,
      ),
    ).apply(
      fontFamily: 'Poppins',
      displayColor: baseTheme.textColor,
      bodyColor: baseTheme.textColor,
    );
    
    // Create cosmic-specific button theme
    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: baseTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
        shadowColor: baseTheme.primaryColor.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
    
    // Create cosmic-specific card theme
    final cardTheme = CardTheme(
      color: baseTheme.surfaceColor,
      elevation: 8,
      shadowColor: baseTheme.isDark 
          ? baseTheme.primaryColor.withOpacity(0.2) 
          : Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
    );
    
    // Create cosmic-specific input decoration theme
    final inputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: baseTheme.isDark 
          ? Colors.black.withOpacity(0.2) 
          : Colors.grey.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: baseTheme.primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
    
    // Create cosmic-specific app bar theme
    final appBarTheme = AppBarTheme(
      backgroundColor: baseTheme.backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: baseTheme.textColor,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: baseTheme.textColor,
      ),
    );
    
    // Create the final theme data with cosmic overrides
    return baseThemeData.copyWith(
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: inputDecorationTheme,
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: baseTheme.backgroundColor,
      dialogBackgroundColor: baseTheme.surfaceColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: baseTheme.surfaceColor,
        selectedItemColor: baseTheme.primaryColor,
        unselectedItemColor: baseTheme.secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: baseTheme.primaryColor,
        unselectedLabelColor: baseTheme.secondaryTextColor,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: baseTheme.primaryColor,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
