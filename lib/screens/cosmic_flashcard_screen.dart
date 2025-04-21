import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/widgets/cosmic_bottom_nav.dart';
import 'package:mathflash/widgets/theme_aware_flashcard.dart';
import 'package:provider/provider.dart';

class CosmicFlashcardScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  
  const CosmicFlashcardScreen({
    Key? key,
    required this.flashcards,
  }) : super(key: key);

  @override
  State<CosmicFlashcardScreen> createState() => _CosmicFlashcardScreenState();
}

class _CosmicFlashcardScreenState extends State<CosmicFlashcardScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.value = _currentIndex / (widget.flashcards.length - 1);
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  void _nextCard() {
    if (_currentIndex < widget.flashcards.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animationController.animateTo(
        _currentIndex / (widget.flashcards.length - 1),
      );
    }
  }
  
  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animationController.animateTo(
        _currentIndex / (widget.flashcards.length - 1),
      );
    }
  }
  
  // Flip functionality is now handled by the ThemeAwareFlashcard widget

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentTheme = themeProvider.currentTheme;
    
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Cosmic Math',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background with stars
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0E1B),
                  const Color(0xFF141A31),
                ],
              ),
              // Use a solid color with gradient instead of image
              // since we're not using the stars background image
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                
                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Card ${_currentIndex + 1}/${widget.flashcards.length}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _progressAnimation.value,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color(0xFF9C42F5),
                                ),
                                minHeight: 8,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Flashcard
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.flashcards.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      _animationController.animateTo(
                        index / (widget.flashcards.length - 1),
                      );
                    },
                    itemBuilder: (context, index) {
                      final flashcard = widget.flashcards[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ThemeAwareFlashcard(
                          flashcard: flashcard,
                          heroTag: 'cosmic_flashcard_${flashcard.id}',
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous button
                      ElevatedButton.icon(
                        onPressed: _currentIndex > 0 ? _previousCard : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF141A31),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      
                      // Flip button
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: const Color(0xFF9C42F5),
                        child: const Icon(Icons.flip),
                      ),
                      
                      // Next button
                      ElevatedButton.icon(
                        onPressed: _currentIndex < widget.flashcards.length - 1
                            ? _nextCard
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF141A31),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Stats row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        icon: Icons.access_time,
                        value: '12.3',
                        label: 'Minutes',
                      ),
                      _buildStatItem(
                        icon: Icons.auto_graph,
                        value: '9.8',
                        label: 'Score',
                      ),
                      _buildStatItem(
                        icon: Icons.local_fire_department,
                        value: '24',
                        label: 'Streak',
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
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
  
  // Flashcard building is now handled by the ThemeAwareFlashcard widget
  
  // Card front is now handled by the ThemeAwareFlashcard widget
  
  // Card back is now handled by the ThemeAwareFlashcard widget
  
  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF141A31),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color(0xFF58C4F6),
            size: 24,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  // Explanations are now handled by the ThemeAwareFlashcard widget
}
