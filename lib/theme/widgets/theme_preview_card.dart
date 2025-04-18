import 'package:flutter/material.dart';
import 'package:mathflash/theme/models/theme_model.dart';

/// A card that displays a preview of a theme
class ThemePreviewCard extends StatelessWidget {
  /// The theme to preview
  final ThemeModel theme;
  
  /// Whether this theme is currently selected
  final bool isSelected;
  
  /// Callback when the card is tapped
  final VoidCallback onTap;
  
  const ThemePreviewCard({
    Key? key,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme header
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Center(
                child: Text(
                  theme.name,
                  style: TextStyle(
                    color: _contrastColor(theme.primaryColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Theme content preview
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sample text
                    Text(
                      'Sample Text',
                      style: TextStyle(
                        color: theme.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Secondary text',
                      style: TextStyle(
                        color: theme.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Sample button
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Button',
                          style: TextStyle(
                            color: _contrastColor(theme.primaryColor),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Selected indicator
            if (isSelected)
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: _contrastColor(theme.primaryColor),
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
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
