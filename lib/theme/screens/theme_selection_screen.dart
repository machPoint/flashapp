import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/theme/models/theme_model.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/theme/theme_constants.dart';
import 'package:mathflash/theme/widgets/theme_preview_card.dart';
import 'package:mathflash/theme/widgets/theme_preview_section.dart';

/// A screen for selecting and customizing themes
class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _fontScale = ThemeConstants.defaultFontScale;
  bool _useSystemFont = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize values from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ThemeProvider>(context, listen: false);
      setState(() {
        _fontScale = provider.fontScale;
        _useSystemFont = provider.useSystemFont;
      });
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final currentTheme = themeProvider.currentTheme;
        final allThemes = themeProvider.getAllThemes();
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Theme Settings'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Themes', icon: Icon(Icons.palette)),
                Tab(text: 'Mode', icon: Icon(Icons.brightness_4)),
                Tab(text: 'Accessibility', icon: Icon(Icons.accessibility_new)),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Themes tab
              _buildThemesTab(themeProvider, allThemes, currentTheme),
              
              // Mode tab
              _buildModeTab(themeProvider),
              
              // Accessibility tab
              _buildAccessibilityTab(themeProvider),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildThemesTab(ThemeProvider provider, List<ThemeModel> themes, ThemeModel currentTheme) {
    return Column(
      children: [
        // Preview section
        ThemePreviewSection(theme: currentTheme),
        
        const Divider(),
        
        // Theme selection
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = theme.id == currentTheme.id;
              
              return ThemePreviewCard(
                theme: theme,
                isSelected: isSelected,
                onTap: () => provider.setThemeType(theme.themeType),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildModeTab(ThemeProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Theme Mode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // System mode
          _buildModeOption(
            context: context,
            title: 'System',
            subtitle: 'Follow system dark/light mode',
            icon: Icons.brightness_auto,
            isSelected: provider.themeMode == ThemeMode.system,
            onTap: () => provider.setThemeMode(ThemeMode.system),
          ),
          
          const Divider(),
          
          // Light mode
          _buildModeOption(
            context: context,
            title: 'Light',
            subtitle: 'Always use light mode',
            icon: Icons.brightness_5,
            isSelected: provider.themeMode == ThemeMode.light,
            onTap: () => provider.setThemeMode(ThemeMode.light),
          ),
          
          const Divider(),
          
          // Dark mode
          _buildModeOption(
            context: context,
            title: 'Dark',
            subtitle: 'Always use dark mode',
            icon: Icons.brightness_3,
            isSelected: provider.themeMode == ThemeMode.dark,
            onTap: () => provider.setThemeMode(ThemeMode.dark),
          ),
          
          const Spacer(),
          
          // Reset button
          Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reset to Default Theme'),
              onPressed: () => _showResetConfirmation(context, provider),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccessibilityTab(ThemeProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Accessibility',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Font scale
          Text(
            'Text Size',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('A', style: TextStyle(fontSize: 14)),
              Expanded(
                child: Slider(
                  value: _fontScale,
                  min: ThemeConstants.minFontScale,
                  max: ThemeConstants.maxFontScale,
                  divisions: 7,
                  label: _fontScale.toStringAsFixed(1) + 'x',
                  onChanged: (value) {
                    setState(() {
                      _fontScale = value;
                    });
                  },
                  onChangeEnd: (value) {
                    provider.setFontScale(value);
                  },
                ),
              ),
              const Text('A', style: TextStyle(fontSize: 24)),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // System font
          SwitchListTile(
            title: const Text('Use System Font'),
            subtitle: const Text('Use your device\'s default font'),
            value: _useSystemFont,
            onChanged: (value) {
              setState(() {
                _useSystemFont = value;
              });
              provider.setUseSystemFont(value);
            },
          ),
          
          const SizedBox(height: 24),
          
          // High contrast theme shortcut
          ListTile(
            title: const Text('High Contrast Theme'),
            subtitle: const Text('Enhanced visibility for better readability'),
            leading: const Icon(Icons.contrast),
            trailing: provider.themeType == ThemeConstants.highContrastTheme
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () => provider.setThemeType(ThemeConstants.highContrastTheme),
          ),
        ],
      ),
    );
  }
  
  Widget _buildModeOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(icon),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
          : null,
      onTap: onTap,
    );
  }
  
  void _showResetConfirmation(BuildContext context, ThemeProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Theme'),
        content: const Text(
          'This will reset all theme settings to their default values. '
          'Are you sure you want to continue?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              provider.resetToDefault();
              Navigator.of(context).pop();
            },
            child: const Text('RESET'),
          ),
        ],
      ),
    );
  }
}
