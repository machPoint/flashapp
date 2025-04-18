# 🌌 Cosmic Theme for MathFlash

A beautiful space-themed UI for the MathFlash app that creates a sense of wonder and exploration perfect for mathematical discovery.

## ✨ Features

- **Dark Space Backgrounds** with vibrant purple and blue accents
- **Animated UI Elements** for an engaging experience
- **Accessibility Options** including high contrast mode
- **Light & Dark Variants** of the cosmic theme
- **Seamless Integration** with the existing theme engine

## 📱 Screens

The cosmic theme includes several beautifully designed screens:

### Login Screen

A stunning space-themed login interface with:
- Animated entrance effects
- Clean form design with cosmic styling
- Social login options
- Subtle space background

### Flashcard Screen

An immersive cosmic flashcard experience featuring:
- Interactive cards with flip animation
- Progress tracking with animated progress bar
- Space-themed statistics display
- Intuitive navigation controls

### Theme Demo Screen

A showcase of the cosmic theme with:
- Theme application controls
- Navigation to themed screens
- Light/dark mode toggles
- Beautiful cosmic styling

## 🚀 How to Use

### Applying the Cosmic Theme

```dart
// Get the ThemeProvider
final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

// Set the cosmic theme
themeProvider.setThemeType(ThemeConstants.cosmicTheme);
```

### Navigating to Cosmic Screens

```dart
// Show the cosmic login screen
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const CosmicLoginScreen()),
);

// Show the cosmic flashcard screen
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => CosmicFlashcardScreen(
      flashcards: yourFlashcardsList,
    ),
  ),
);

// Show the cosmic theme demo
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const CosmicThemeDemo()),
);
```

## 🔧 Implementation Details

The cosmic theme is implemented using:

1. **Theme Model**: A robust theme model with all necessary properties
2. **Theme Repository**: For storing and retrieving theme preferences
3. **Theme Provider**: State management for the theme
4. **Predefined Themes**: Collection of theme presets including cosmic
5. **Theme Constants**: Configuration values for the theme system

## 🎨 Design Elements

The cosmic theme uses these key design elements:

- **Color Palette**:
  - Deep space blue: `#0A0E1B`
  - Lighter space blue: `#141A31`
  - Vibrant purple: `#9C42F5`
  - Bright blue: `#58C4F6`

- **Typography**:
  - Primary font: Poppins
  - Headings: Bold weight with subtle glow effects
  - Body text: Regular weight with high contrast against backgrounds

- **UI Components**:
  - Cards with subtle gradients and shadows
  - Buttons with glowing effects
  - Progress indicators with cosmic animations
  - Icons with space theme

## 📂 File Structure

```
lib/
├── theme/
│   ├── models/
│   │   └── theme_model.dart
│   ├── providers/
│   │   └── theme_provider.dart
│   ├── repositories/
│   │   └── theme_repository.dart
│   ├── screens/
│   │   ├── theme_selection_screen.dart
│   │   └── custom_theme_editor.dart
│   ├── themes/
│   │   ├── predefined_themes.dart
│   │   └── cosmic_theme.dart
│   ├── widgets/
│   │   ├── theme_preview_card.dart
│   │   └── theme_preview_section.dart
│   └── theme_constants.dart
├── screens/
│   ├── cosmic_login_screen.dart
│   ├── cosmic_flashcard_screen.dart
│   └── cosmic_theme_demo.dart
└── ...
```

## 🔮 Future Enhancements

Potential improvements for the cosmic theme:

1. **Particle Animations**: Add floating particles to simulate stars
2. **Planet Illustrations**: Include planet illustrations as decorative elements
3. **Custom Transitions**: Create space-themed transitions between screens
4. **Theme Customizer**: Allow users to customize the cosmic theme colors
5. **Sound Effects**: Add optional space-themed sound effects for interactions

---

Created with 💜 for MathFlash
