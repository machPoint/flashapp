import 'package:flutter/material.dart';
import 'package:mathflash/theme/models/theme_model.dart';

/// A widget that displays a preview of UI elements with the current theme
class ThemePreviewSection extends StatelessWidget {
  /// The theme to preview
  final ThemeModel theme;
  
  const ThemePreviewSection({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: TextStyle(
              color: theme.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Sample UI elements
          Row(
            children: [
              // Sample card
              Expanded(
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Title',
                        style: TextStyle(
                          color: theme.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This is how content will look with this theme.',
                        style: TextStyle(
                          color: theme.secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: theme.accentColor,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.share,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Controls column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Button
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          'Primary Button',
                          style: TextStyle(
                            color: _contrastColor(theme.primaryColor),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Switch
                    Row(
                      children: [
                        Text(
                          'Switch',
                          style: TextStyle(
                            color: theme.textColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Checkbox
                    Row(
                      children: [
                        Text(
                          'Checkbox',
                          style: TextStyle(
                            color: theme.textColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.check,
                            color: _contrastColor(theme.primaryColor),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
