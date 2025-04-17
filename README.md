# MathFlash

MathFlash is a mobile-only Flutter app for Android that delivers visually appealing, static flashcards focused on math concepts. Each card is pre-generated (PNG/SVG), tightly themed, and designed for fast consumption and educational clarity.

## Features
- Static flashcard viewer (swipe/tap navigation)
- Pre-loaded image cards (PNG/SVG)
- Topic-specific packs (Geometry, Statistics, etc.)
- One-time purchase per pack (no free cards)
- Minimalist, mobile-native UI with dark/light themes
- All content is local (bundled or CDN, but usable offline)

## Directory Structure
```
mathflash/
├── assets/        # Flashcard images (PNGs, SVGs)
├── packs/         # Pack definitions and metadata
├── lib/           # Flutter app source code
├── pubspec.yaml   # Project config and dependencies
└── README.md      # This file
```

## Getting Started
1. Ensure you have Flutter installed and added to your PATH.
2. Get dependencies:
   ```
   flutter pub get
   ```
3. Run the app on an Android device or emulator:
   ```
   flutter run
   ```

## Notes
- Add your flashcard images to the `assets/` directory and pack metadata to `packs/`.
- The app uses the `flutter_svg` package for SVG support.

---

For more information, see the [Flutter documentation](https://docs.flutter.dev/).
