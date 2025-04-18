import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
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
  bool _isCardFlipped = false;
  
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
        _isCardFlipped = false;
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
        _isCardFlipped = false;
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
  
  void _toggleCardFlip() {
    setState(() {
      _isCardFlipped = !_isCardFlipped;
    });
  }

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
                        _isCardFlipped = false;
                      });
                      _animationController.animateTo(
                        index / (widget.flashcards.length - 1),
                      );
                    },
                    itemBuilder: (context, index) {
                      final flashcard = widget.flashcards[index];
                      return GestureDetector(
                        onTap: _toggleCardFlip,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _buildFlashcard(flashcard),
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
                        onPressed: _toggleCardFlip,
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF141A31),
        selectedItemColor: const Color(0xFF9C42F5),
        unselectedItemColor: Colors.white.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
  
  Widget _buildFlashcard(Flashcard flashcard) {
    return Hero(
      tag: 'flashcard_${flashcard.id}',
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isCardFlipped
                ? [const Color(0xFF141A31), const Color(0xFF0A0E1B)]
                : [const Color(0xFF9C42F5), const Color(0xFF58C4F6)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9C42F5).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                // Use a mathematical symbol instead of an image
                child: Icon(
                  Icons.functions,
                  size: 100,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            
            // Card content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topic badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      flashcard.topic,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Main content
                  Expanded(
                    child: Center(
                      child: _isCardFlipped
                          ? _buildCardBack(flashcard)
                          : _buildCardFront(flashcard),
                    ),
                  ),
                  
                  // Flip indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: Colors.white.withOpacity(0.7),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tap to flip',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontFamily: 'Poppins',
                          fontSize: 12,
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
  }
  
  Widget _buildCardFront(Flashcard flashcard) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title
        Text(
          flashcard.title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 24),
        
        // Image if available
        if (flashcard.imagePath != null && flashcard.imagePath.isNotEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                flashcard.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white.withOpacity(0.1),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildCardBack(Flashcard flashcard) {
    // This would normally contain the answer or explanation
    // For demo purposes, we'll just show some placeholder content
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explanation:',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            _getExplanationForTopic(flashcard.topic),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
  
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
  
  String _getExplanationForTopic(String topic) {
    switch (topic.toLowerCase()) {
      case 'algebra':
        return 'Algebra is the branch of mathematics dealing with symbols and the rules for manipulating these symbols. In elementary algebra, those symbols (today written as Latin and Greek letters) represent quantities without fixed values, known as variables.';
      case 'geometry':
        return 'Geometry is a branch of mathematics that studies the sizes, shapes, positions angles and dimensions of things. Flat shapes like squares, circles, and triangles are a part of flat geometry and are called 2D shapes.';
      case 'calculus':
        return 'Calculus is the mathematical study of continuous change, in the same way that geometry is the study of shape and algebra is the study of generalizations of arithmetic operations.';
      case 'statistics':
        return 'Statistics is the discipline that concerns the collection, organization, analysis, interpretation, and presentation of data. In applying statistics to a scientific, industrial, or social problem, it is conventional to begin with a statistical population or a statistical model to be studied.';
      default:
        return 'This topic covers fundamental concepts in mathematics that build the foundation for more advanced studies. Understanding these principles is essential for solving complex problems.';
    }
  }
}
