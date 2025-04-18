import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/theme_provider.dart';
import 'package:mathflash/screens/home_screen.dart';

void main() {
  runApp(const MathFlashApp());
}

class MathFlashApp extends StatelessWidget {
  const MathFlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MathFlash',
            themeMode: themeProvider.themeMode,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            home: HomeScreen(
              toggleTheme: () => themeProvider.toggleTheme(),
            ),
          );
        },
      ),
    );
  }
}
