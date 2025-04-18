import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/models/pack.dart';
import 'package:mathflash/screens/flashcard_viewer_screen_helper.dart';

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
          
          // Flashcard content - actual image
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: flashcard.topic == 'Geometry' 
                    ? Colors.blue.shade50 
                    : (flashcard.title.contains('Dark') ? Colors.blueGrey.shade100 : Colors.green.shade50),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Placeholder in case image is not found
                  Center(
                    child: Icon(
                      flashcard.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                      size: 80,
                      color: flashcard.topic == 'Geometry' 
                          ? Colors.blue.shade200 
                          : Colors.green.shade200,
                    ),
                  ),
                  
                  // Actual image with error handling
                  Center(
                    child: Image.asset(
                      flashcard.imagePath,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      errorBuilder: (context, error, stackTrace) {
                        // If image fails to load, show a placeholder with content
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Topic icon
                              Icon(
                                flashcard.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                                size: 60,
                                color: flashcard.topic == 'Geometry' 
                                    ? Colors.blue.shade300 
                                    : Colors.green.shade300,
                              ),
                              const SizedBox(height: 16),
                              
                              // Flashcard title
                              Text(
                                flashcard.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              
                              // Placeholder content based on flashcard title
                              getPlaceholderContent(flashcard),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
