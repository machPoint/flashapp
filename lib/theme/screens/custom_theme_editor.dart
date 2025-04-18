import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/theme/theme_constants.dart';

/// A screen for creating and editing custom themes
class CustomThemeEditor extends StatefulWidget {
  const CustomThemeEditor({Key? key}) : super(key: key);

  @override
  State<CustomThemeEditor> createState() => _CustomThemeEditorState();
}

class _CustomThemeEditorState extends State<CustomThemeEditor> {
  late ThemeModel _editingTheme;
  final TextEditingController _nameController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // Initialize with the current theme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      final currentTheme = provider.currentTheme;
      
      setState(() {
        // Create a copy of the current theme with isCustom set to true
        _editingTheme = currentTheme.copyWith(
          id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
          name: 'Custom Theme',
          themeType: ThemeConstants.customTheme,
          isCustom: true,
        );
        _nameController.text = _editingTheme.name;
      });
    });
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Custom Theme'),
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _saveTheme(themeProvider),
              ),
            ],
          ),
          body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Theme name
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Theme Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(name: value);
                          });
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Dark mode toggle
                      SwitchListTile(
                        title: const Text('Dark Theme'),
                        subtitle: const Text('Enable dark mode for this theme'),
                        value: _editingTheme.isDark,
                        onChanged: (value) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(isDark: value);
                          });
                        },
                      ),
                      
                      const Divider(),
                      
                      // Color pickers
                      const Text(
                        'Colors',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      
                      // Primary color
                      _buildColorPicker(
                        label: 'Primary Color',
                        color: _editingTheme.primaryColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(primaryColor: color);
                          });
                        },
                      ),
                      
                      // Secondary color
                      _buildColorPicker(
                        label: 'Secondary Color',
                        color: _editingTheme.secondaryColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(secondaryColor: color);
                          });
                        },
                      ),
                      
                      // Background color
                      _buildColorPicker(
                        label: 'Background Color',
                        color: _editingTheme.backgroundColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(backgroundColor: color);
                          });
                        },
                      ),
                      
                      // Surface color
                      _buildColorPicker(
                        label: 'Surface Color',
                        color: _editingTheme.surfaceColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(surfaceColor: color);
                          });
                        },
                      ),
                      
                      // Text color
                      _buildColorPicker(
                        label: 'Text Color',
                        color: _editingTheme.textColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(textColor: color);
                          });
                        },
                      ),
                      
                      // Secondary text color
                      _buildColorPicker(
                        label: 'Secondary Text Color',
                        color: _editingTheme.secondaryTextColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(secondaryTextColor: color);
                          });
                        },
                      ),
                      
                      // Accent color
                      _buildColorPicker(
                        label: 'Accent Color',
                        color: _editingTheme.accentColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(accentColor: color);
                          });
                        },
                      ),
                      
                      // Error color
                      _buildColorPicker(
                        label: 'Error Color',
                        color: _editingTheme.errorColor,
                        onColorChanged: (color) {
                          setState(() {
                            _editingTheme = _editingTheme.copyWith(errorColor: color);
                          });
                        },
                      ),
                      
                      const Divider(),
                      
                      // Font selection
                      const Text(
                        'Typography',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Font Family',
                          border: OutlineInputBorder(),
                        ),
                        value: _editingTheme.fontFamily,
                        items: ThemeConstants.supportedFontFamilies
                            .map((font) => DropdownMenuItem(
                                  value: font,
                                  child: Text(font),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _editingTheme = _editingTheme.copyWith(fontFamily: value);
                            });
                          }
                        },
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Preview
                      const Text(
                        'Preview',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _editingTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sample Heading',
                              style: TextStyle(
                                color: _editingTheme.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: _editingTheme.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This is how your text will look with this theme. The quick brown fox jumps over the lazy dog.',
                              style: TextStyle(
                                color: _editingTheme.textColor,
                                fontFamily: _editingTheme.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Secondary text example',
                              style: TextStyle(
                                color: _editingTheme.secondaryTextColor,
                                fontSize: 12,
                                fontFamily: _editingTheme.fontFamily,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Primary button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _editingTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Button',
                                    style: TextStyle(
                                      color: _contrastColor(_editingTheme.primaryColor),
                                      fontFamily: _editingTheme.fontFamily,
                                    ),
                                  ),
                                ),
                                
                                // Secondary button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _editingTheme.secondaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Button',
                                    style: TextStyle(
                                      color: _contrastColor(_editingTheme.secondaryColor),
                                      fontFamily: _editingTheme.fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
  
  Widget _buildColorPicker({
    required String label,
    required Color color,
    required ValueChanged<Color> onColorChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(label),
          ),
          GestureDetector(
            onTap: () => _showColorPicker(context, color, onColorChanged),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showColorPicker(
    BuildContext context,
    Color initialColor,
    ValueChanged<Color> onColorChanged,
  ) {
    // In a production app, you would use a color picker package
    // For simplicity, we'll use a predefined set of colors
    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];
    
    final shades = [
      50, 100, 200, 300, 400, 500, 600, 700, 800, 900,
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Color'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final color = colors[index];
              
              // For white and black, we don't have shades
              if (color == Colors.black || color == Colors.white) {
                return GestureDetector(
                  onTap: () {
                    onColorChanged(color);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                );
              }
              
              return GestureDetector(
                onTap: () {
                  // Show shades for this color
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Select ${_colorName(color)} Shade'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemCount: shades.length,
                          itemBuilder: (context, shadeIndex) {
                            final shade = shades[shadeIndex];
                            final shadeColor = _getColorShade(color, shade);
                            
                            return GestureDetector(
                              onTap: () {
                                onColorChanged(shadeColor);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: shadeColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Center(
                                  child: Text(
                                    shade.toString(),
                                    style: TextStyle(
                                      color: _contrastColor(shadeColor),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('CANCEL'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
        ],
      ),
    );
  }
  
  void _saveTheme(ThemeProvider provider) {
    // Update the theme name from the text field
    final updatedTheme = _editingTheme.copyWith(
      name: _nameController.text.isNotEmpty
          ? _nameController.text
          : 'Custom Theme',
    );
    
    // Save the theme
    provider.setCustomTheme(updatedTheme);
    
    // Navigate back
    Navigator.of(context).pop();
  }
  
  /// Determines a contrasting color (black or white) for the given color
  Color _contrastColor(Color color) {
    // Calculate the perceptive luminance (human eye favors green)
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    
    // Return black for bright colors, white for dark colors
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
  
  /// Get the name of a color
  String _colorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.deepPurple) return 'Deep Purple';
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.lightBlue) return 'Light Blue';
    if (color == Colors.cyan) return 'Cyan';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.green) return 'Green';
    if (color == Colors.lightGreen) return 'Light Green';
    if (color == Colors.lime) return 'Lime';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.amber) return 'Amber';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.deepOrange) return 'Deep Orange';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.grey) return 'Grey';
    if (color == Colors.blueGrey) return 'Blue Grey';
    if (color == Colors.black) return 'Black';
    if (color == Colors.white) return 'White';
    return 'Color';
  }
  
  /// Get a shade of a color
  Color _getColorShade(Color color, int shade) {
    if (color == Colors.red) return Colors.red[shade]!;
    if (color == Colors.pink) return Colors.pink[shade]!;
    if (color == Colors.purple) return Colors.purple[shade]!;
    if (color == Colors.deepPurple) return Colors.deepPurple[shade]!;
    if (color == Colors.indigo) return Colors.indigo[shade]!;
    if (color == Colors.blue) return Colors.blue[shade]!;
    if (color == Colors.lightBlue) return Colors.lightBlue[shade]!;
    if (color == Colors.cyan) return Colors.cyan[shade]!;
    if (color == Colors.teal) return Colors.teal[shade]!;
    if (color == Colors.green) return Colors.green[shade]!;
    if (color == Colors.lightGreen) return Colors.lightGreen[shade]!;
    if (color == Colors.lime) return Colors.lime[shade]!;
    if (color == Colors.yellow) return Colors.yellow[shade]!;
    if (color == Colors.amber) return Colors.amber[shade]!;
    if (color == Colors.orange) return Colors.orange[shade]!;
    if (color == Colors.deepOrange) return Colors.deepOrange[shade]!;
    if (color == Colors.brown) return Colors.brown[shade]!;
    if (color == Colors.grey) return Colors.grey[shade]!;
    if (color == Colors.blueGrey) return Colors.blueGrey[shade]!;
    return color;
  }
}
