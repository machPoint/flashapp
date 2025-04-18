import 'package:flutter/material.dart';
import 'package:mathflash/theme/theme_constants.dart';

/// Represents a complete theme configuration
class ThemeModel {
  /// The unique identifier for this theme
  final String id;
  
  /// Display name for this theme
  final String name;
  
  /// Theme type (default, blue, green, etc.)
  final String themeType;
  
  /// Whether this theme is a dark theme
  final bool isDark;
  
  /// Primary color for this theme
  final Color primaryColor;
  
  /// Secondary color for this theme
  final Color secondaryColor;
  
  /// Background color for this theme
  final Color backgroundColor;
  
  /// Surface color for cards and elevated surfaces
  final Color surfaceColor;
  
  /// Primary text color
  final Color textColor;
  
  /// Secondary text color for less emphasis
  final Color secondaryTextColor;
  
  /// Accent color for highlights
  final Color accentColor;
  
  /// Error color
  final Color errorColor;
  
  /// Font family name
  final String fontFamily;
  
  /// Whether this theme is a custom user-defined theme
  final bool isCustom;
  
  /// Font scale factor
  final double fontScale;
  
  /// Creates a new theme model
  const ThemeModel({
    required this.id,
    required this.name,
    required this.themeType,
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.accentColor,
    required this.errorColor,
    this.fontFamily = ThemeConstants.defaultFontFamily,
    this.isCustom = false,
    this.fontScale = ThemeConstants.defaultFontScale,
  });
  
  /// Creates a copy of this theme with the given fields replaced
  ThemeModel copyWith({
    String? id,
    String? name,
    String? themeType,
    bool? isDark,
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? textColor,
    Color? secondaryTextColor,
    Color? accentColor,
    Color? errorColor,
    String? fontFamily,
    bool? isCustom,
    double? fontScale,
  }) {
    return ThemeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      themeType: themeType ?? this.themeType,
      isDark: isDark ?? this.isDark,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      accentColor: accentColor ?? this.accentColor,
      errorColor: errorColor ?? this.errorColor,
      fontFamily: fontFamily ?? this.fontFamily,
      isCustom: isCustom ?? this.isCustom,
      fontScale: fontScale ?? this.fontScale,
    );
  }
  
  /// Converts this theme model to a Flutter ThemeData object
  ThemeData toThemeData() {
    final brightness = isDark ? Brightness.dark : Brightness.light;
    
    // Create a color scheme based on our colors
    final colorScheme = ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: _contrastColor(primaryColor),
      onSecondary: _contrastColor(secondaryColor),
      onSurface: textColor,
      onBackground: textColor,
      onError: _contrastColor(errorColor),
      brightness: brightness,
    );
    
    // Create text theme with our font family and scale
    final textTheme = TextTheme(
      displayLarge: TextStyle(color: textColor, fontFamily: fontFamily),
      displayMedium: TextStyle(color: textColor, fontFamily: fontFamily),
      displaySmall: TextStyle(color: textColor, fontFamily: fontFamily),
      headlineLarge: TextStyle(color: textColor, fontFamily: fontFamily),
      headlineMedium: TextStyle(color: textColor, fontFamily: fontFamily),
      headlineSmall: TextStyle(color: textColor, fontFamily: fontFamily),
      titleLarge: TextStyle(color: textColor, fontFamily: fontFamily),
      titleMedium: TextStyle(color: textColor, fontFamily: fontFamily),
      titleSmall: TextStyle(color: textColor, fontFamily: fontFamily),
      bodyLarge: TextStyle(color: textColor, fontFamily: fontFamily),
      bodyMedium: TextStyle(color: textColor, fontFamily: fontFamily),
      bodySmall: TextStyle(color: secondaryTextColor, fontFamily: fontFamily),
      labelLarge: TextStyle(color: textColor, fontFamily: fontFamily),
      labelMedium: TextStyle(color: textColor, fontFamily: fontFamily),
      labelSmall: TextStyle(color: secondaryTextColor, fontFamily: fontFamily),
    ).apply(
      fontSizeFactor: fontScale,
      fontFamily: fontFamily,
    );
    
    // Create the theme data
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      textTheme: textTheme,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? colorScheme.surface : colorScheme.primary,
        foregroundColor: isDark ? colorScheme.onSurface : colorScheme.onPrimary,
        elevation: 4,
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: _contrastColor(primaryColor),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor.withOpacity(0.5);
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return null;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        thumbColor: primaryColor,
        overlayColor: primaryColor.withOpacity(0.3),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white24 : Colors.black12,
        thickness: 1,
      ),
      // Add transition animations for theme changes
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
  
  /// Converts this theme model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'themeType': themeType,
      'isDark': isDark,
      'primaryColor': primaryColor.value,
      'secondaryColor': secondaryColor.value,
      'backgroundColor': backgroundColor.value,
      'surfaceColor': surfaceColor.value,
      'textColor': textColor.value,
      'secondaryTextColor': secondaryTextColor.value,
      'accentColor': accentColor.value,
      'errorColor': errorColor.value,
      'fontFamily': fontFamily,
      'isCustom': isCustom,
      'fontScale': fontScale,
    };
  }
  
  /// Creates a theme model from a JSON map
  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'],
      name: json['name'],
      themeType: json['themeType'],
      isDark: json['isDark'],
      primaryColor: Color(json['primaryColor']),
      secondaryColor: Color(json['secondaryColor']),
      backgroundColor: Color(json['backgroundColor']),
      surfaceColor: Color(json['surfaceColor']),
      textColor: Color(json['textColor']),
      secondaryTextColor: Color(json['secondaryTextColor']),
      accentColor: Color(json['accentColor']),
      errorColor: Color(json['errorColor']),
      fontFamily: json['fontFamily'],
      isCustom: json['isCustom'],
      fontScale: json['fontScale'],
    );
  }
  
  /// Determines a contrasting color (black or white) for the given color
  Color _contrastColor(Color color) {
    // Calculate the perceptive luminance (human eye favors green)
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    
    // Return black for bright colors, white for dark colors
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
