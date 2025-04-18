import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/account_provider.dart';
import 'package:mathflash/screens/pack_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MathFlash'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: const FlashcardHomeView(),
    );
  }
}

class FlashcardHomeView extends StatelessWidget {
  const FlashcardHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final user = accountProvider.currentUser;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome message with personalization if logged in
            Text(
              user.isGuest 
                  ? 'Welcome to MathFlash' 
                  : 'Welcome back, ${user.displayName}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Your math flashcard app',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Explore our collection of math flashcards designed to help you master key concepts in geometry and statistics.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // Main action button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PackSelectionScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.collections_bookmark),
              label: const Text('View Packs'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            
            // Show purchased packs if user is logged in
            if (!user.isGuest && user.purchasedPackIds.isNotEmpty) ...[  
              const SizedBox(height: 40),
              Text(
                'Your Purchased Packs',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: user.purchasedPackIds.map((packId) {
                  return ActionChip(
                    avatar: Icon(
                      packId.contains('geometry') 
                          ? Icons.category 
                          : Icons.bar_chart,
                      size: 18,
                    ),
                    label: Text(_formatPackName(packId)),
                    onPressed: () {
                      // Navigate to specific pack
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackSelectionScreen(),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  String _formatPackName(String packId) {
    return packId
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
