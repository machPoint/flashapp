import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/models/pack.dart';

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
      body: Column(
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
                Text(
                  '${_currentIndex + 1} / ${widget.pack.flashcards.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
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
                return FlashcardView(flashcard: flashcard);
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
      ),
    );
  }
}

class FlashcardView extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardView({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              flashcard.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          // Flashcard content (placeholder)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: flashcard.topic == 'Geometry' 
                    ? Colors.blue.shade50 
                    : Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  flashcard.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                  size: 80,
                  color: flashcard.topic == 'Geometry' 
                      ? Colors.blue.shade200 
                      : Colors.green.shade200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
