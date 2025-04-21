import 'package:flutter/material.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:provider/provider.dart';

/// A reusable bottom navigation bar with cosmic styling
class CosmicBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CosmicBottomNav({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isCosmicTheme = themeProvider.themeType == 'cosmic';
    final currentTheme = themeProvider.currentTheme;

    return BottomNavigationBar(
      backgroundColor: isCosmicTheme 
          ? const Color(0xFF141A31) 
          : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: isCosmicTheme 
          ? const Color(0xFF9C42F5) 
          : currentTheme.primaryColor,
      unselectedItemColor: isCosmicTheme 
          ? Colors.white.withOpacity(0.5) 
          : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
