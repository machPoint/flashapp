import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/data/sample_data.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/theme/theme_constants.dart';
import 'package:mathflash/screens/cosmic_login_screen.dart';
import 'package:mathflash/screens/cosmic_flashcard_screen.dart';

/// A demo screen to showcase the cosmic theme
class CosmicThemeDemo extends StatelessWidget {
  const CosmicThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0A0E1B),
              const Color(0xFF141A31),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cosmic Theme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF9C42F5).withOpacity(0.7),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'A beautiful space-themed UI for MathFlash',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Theme selection
                Text(
                  'Apply Cosmic Theme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Apply theme button
                ElevatedButton.icon(
                  onPressed: () {
                    themeProvider.setThemeType(ThemeConstants.cosmicTheme);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cosmic theme applied!'),
                        backgroundColor: Color(0xFF9C42F5),
                      ),
                    );
                  },
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Apply Cosmic Theme'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C42F5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Demo screens
                Text(
                  'Demo Screens',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildDemoCard(
                        context: context,
                        title: 'Login Screen',
                        icon: Icons.login,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CosmicLoginScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDemoCard(
                        context: context,
                        title: 'Flashcards',
                        icon: Icons.style,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CosmicFlashcardScreen(
                                flashcards: SampleData.getPacks()
                                    .firstWhere((pack) => pack.id == 'stats_distributions')
                                    .flashcards,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildDemoCard(
                        context: context,
                        title: 'Dark Mode',
                        icon: Icons.dark_mode,
                        onTap: () {
                          themeProvider.setThemeMode(ThemeMode.dark);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Dark mode enabled'),
                              backgroundColor: Color(0xFF9C42F5),
                            ),
                          );
                        },
                      ),
                      _buildDemoCard(
                        context: context,
                        title: 'Light Mode',
                        icon: Icons.light_mode,
                        onTap: () {
                          themeProvider.setThemeMode(ThemeMode.light);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Light mode enabled'),
                              backgroundColor: Color(0xFF7B2CBF),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDemoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF58C4F6),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
