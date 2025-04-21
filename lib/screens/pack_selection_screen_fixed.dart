import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathflash/data/sample_data.dart';
import 'package:mathflash/models/pack.dart';
import 'package:mathflash/providers/account_provider.dart';
import 'package:mathflash/screens/account/account_screen.dart';
import 'package:mathflash/screens/flashcard_viewer_screen.dart';
import 'package:mathflash/theme/providers/theme_provider.dart';
import 'package:mathflash/widgets/cosmic_bottom_nav.dart';

class PackSelectionScreen extends StatelessWidget {
  const PackSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packs = SampleData.getPacks();
    final accountProvider = Provider.of<AccountProvider>(context);
    final user = accountProvider.currentUser;
    
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isCosmicTheme = themeProvider.themeType == 'cosmic';
    final currentTheme = themeProvider.currentTheme;
    
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Select a Pack'),
        backgroundColor: isCosmicTheme ? Colors.transparent : Theme.of(context).colorScheme.primaryContainer,
        elevation: isCosmicTheme ? 0 : 4,
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
      body: packs.isEmpty
          ? Center(
              child: Text(
                'No packs available yet',
                style: TextStyle(
                  fontSize: 18,
                  color: currentTheme.textColor,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with premium badge if applicable
                  Row(
                    children: [
                      Text(
                        'Available Packs',
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold,
                          color: currentTheme.textColor,
                        ),
                      ),
                      const Spacer(),
                      if (user.isPremium)
                        Chip(
                          label: const Text('Premium'),
                          backgroundColor: Colors.amber.shade100,
                          avatar: const Icon(Icons.star, color: Colors.amber),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Grid of packs
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: packs.length,
                      itemBuilder: (context, index) {
                        final pack = packs[index];
                        final isPurchased = user.purchasedPacks.contains(pack.id);
                        
                        return PackCard(
                          pack: pack,
                          isPurchased: isPurchased,
                          onTap: () {
                            if (isPurchased) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FlashcardViewerScreen(pack: pack),
                                ),
                              );
                            } else {
                              // Show purchase dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Purchase Pack'),
                                  content: Text('Would you like to purchase ${pack.name}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Simulate purchase
                                        accountProvider.purchasePack(pack.id);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Purchase'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class PackCard extends StatelessWidget {
  final Pack pack;
  final VoidCallback onTap;
  final bool isPurchased;

  const PackCard({
    super.key,
    required this.pack,
    required this.onTap,
    this.isPurchased = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isCosmicTheme = themeProvider.themeType == 'cosmic';
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: isCosmicTheme ? 8 : 4,
        color: isCosmicTheme ? const Color(0xFF141A31) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Placeholder for the pack image
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    color: pack.topic == 'Geometry' 
                        ? (isCosmicTheme ? const Color(0xFF3A86FF) : Colors.blue.shade200)
                        : (isCosmicTheme ? const Color(0xFF58C4F6) : Colors.green.shade200),
                    decoration: isCosmicTheme ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: pack.topic == 'Geometry'
                            ? [const Color(0xFF3A86FF), const Color(0xFF7B2CBF)]
                            : [const Color(0xFF58C4F6), const Color(0xFF9C42F5)],
                      ),
                    ) : null,
                    child: Center(
                      child: Icon(
                        pack.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // Pack title
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCosmicTheme ? Colors.white : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pack.topic,
                        style: TextStyle(
                          fontSize: 14,
                          color: pack.topic == 'Geometry' 
                              ? (isCosmicTheme ? const Color(0xFF3A86FF) : Colors.blue.shade700)
                              : (isCosmicTheme ? const Color(0xFF58C4F6) : Colors.green.shade700),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPurchased ? 'Purchased' : 'Available for purchase',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPurchased 
                              ? (isCosmicTheme ? Colors.greenAccent : Colors.green)
                              : (isCosmicTheme ? Colors.grey.shade400 : Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Action button
                      Container(
                        decoration: BoxDecoration(
                          color: isPurchased
                              ? (isCosmicTheme ? const Color(0xFF3A86FF) : Colors.blue)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            isPurchased
                                ? Icon(
                                    Icons.visibility,
                                    size: 18,
                                    color: isCosmicTheme ? Colors.white : Colors.white,
                                  )
                                : Icon(
                                    Icons.shopping_cart,
                                    size: 18,
                                    color: Colors.grey.shade700,
                                  ),
                            const SizedBox(width: 4),
                            Text(
                              isPurchased ? 'View' : 'Buy',
                              style: TextStyle(
                                fontSize: 12,
                                color: isPurchased ? Colors.white : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Purchased badge
            if (isPurchased)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCosmicTheme ? const Color(0xFF9C42F5) : Colors.green,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
