import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/providers/enhanced_theme_provider.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<EnhancedThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Theme',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            // Theme grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: AppTheme.values.length,
              itemBuilder: (context, index) {
                final theme = AppTheme.values[index];
                final isSelected = theme == themeProvider.currentTheme;
                
                return _buildThemeCard(
                  context,
                  theme,
                  themeProvider,
                  isSelected,
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Theme preview
            Text(
              'Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildThemePreview(context, themeProvider),
          ],
        ),
      ),
    );
  }
  
  Widget _buildThemeCard(
    BuildContext context,
    AppTheme theme,
    EnhancedThemeProvider themeProvider,
    bool isSelected,
  ) {
    // Get colors for this theme
    Color primaryColor;
    Color backgroundColor;
    Color textColor;
    
    switch (theme) {
      case AppTheme.light:
        primaryColor = Colors.blue;
        backgroundColor = Colors.white;
        textColor = Colors.black;
        break;
      case AppTheme.dark:
        primaryColor = Colors.blue.shade300;
        backgroundColor = Colors.grey.shade900;
        textColor = Colors.white;
        break;
      case AppTheme.blue:
        primaryColor = Colors.blue.shade700;
        backgroundColor = Colors.blue.shade50;
        textColor = Colors.black;
        break;
      case AppTheme.green:
        primaryColor = Colors.green.shade700;
        backgroundColor = Colors.green.shade50;
        textColor = Colors.black;
        break;
      case AppTheme.purple:
        primaryColor = Colors.purple.shade300;
        backgroundColor = Colors.grey.shade900;
        textColor = Colors.white;
        break;
      case AppTheme.orange:
        primaryColor = Colors.orange.shade700;
        backgroundColor = Colors.orange.shade50;
        textColor = Colors.black;
        break;
      case AppTheme.highContrast:
        primaryColor = Colors.yellow;
        backgroundColor = Colors.black;
        textColor = Colors.yellow;
        break;
    }
    
    return InkWell(
      onTap: () {
        themeProvider.setTheme(theme);
      },
      child: Card(
        elevation: isSelected ? 8 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isSelected 
              ? BorderSide(color: primaryColor, width: 3) 
              : BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: isSelected 
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                themeProvider.getThemeName(theme),
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildThemePreview(BuildContext context, EnhancedThemeProvider themeProvider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mock app bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sample Screen',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Mock content
            Text(
              'Heading',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'This is how text will appear in the selected theme.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            
            // Mock buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Primary Button'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Secondary'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Mock flashcard
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample Flashcard',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Icon(
                      Icons.image,
                      size: 60,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
