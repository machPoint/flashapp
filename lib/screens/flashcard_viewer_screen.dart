import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/models/pack.dart';
import 'package:mathflash/widgets/cosmic_bottom_nav.dart';
import 'package:mathflash/widgets/theme_aware_flashcard.dart';

class FlashcardViewerScreen extends StatefulWidget {
  final Pack pack;

  const FlashcardViewerScreen({super.key, required this.pack});

  @override
  State<FlashcardViewerScreen> createState() => _FlashcardViewerScreenState();
}

class _FlashcardViewerScreenState extends State<FlashcardViewerScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextCard() {
    if (_currentIndex < widget.pack.flashcards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pack.name),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(child: Column(
        children: [
          // Pack info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  widget.pack.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.pack.topic,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Card ${_currentIndex + 1}/${widget.pack.flashcards.length}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: widget.pack.flashcards.length > 1 ? 
                        _currentIndex / (widget.pack.flashcards.length - 1) : 0.0,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          // Flashcard viewer
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.pack.flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = widget.pack.flashcards[index];
                return FlashcardView(
                  flashcard: flashcard,
                  currentIndex: _currentIndex,
                  totalCards: widget.pack.flashcards.length,
                );
              },
            ),
          ),
          
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: _currentIndex < widget.pack.flashcards.length - 1 ? _nextCard : null,
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: CosmicBottomNav(
        currentIndex: 1, // Explore tab
        onTap: (index) {
          // Handle navigation
          if (index == 0) {
            Navigator.of(context).pop(); // Go back to home
          }
        },
      ),
    );
  }
}

class FlashcardView extends StatelessWidget {
  final Flashcard flashcard;
  final int currentIndex;
  final int totalCards;

  const FlashcardView({
    super.key, 
    required this.flashcard,
    required this.currentIndex,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ThemeAwareFlashcard(
        flashcard: flashcard,
        heroTag: 'flashcard_view',
      ),
    );
  }
}
