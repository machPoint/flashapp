import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/account_provider.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/screens/home_screen.dart';
import 'package:mathflash/widgets/upper_strip.dart';
// Cosmic theme is now accessible from the account screen

void main() {
  runApp(const MathFlashApp());
}

class MathFlashApp extends StatelessWidget {
  const MathFlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MathFlash',
            themeMode: themeProvider.themeMode,
            theme: themeProvider.getThemeData(),
            darkTheme: themeProvider.getThemeData(),
            home: const AppScaffold(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Upper strip with account access
          const UpperStrip(),
          
          // Main content area
          Expanded(
            child: HomeScreen(
              toggleTheme: () => Provider.of<ThemeProvider>(context, listen: false).toggleLightDark(),
            ),
          ),
        ],
      ),
    );
  }
}
