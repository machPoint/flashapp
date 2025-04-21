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
                  
                  // Pack grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: packs.length,
                      itemBuilder: (context, index) {
                        final pack = packs[index];
                        final bool isPurchased = user.purchasedPackIds.contains(pack.id) || user.isPremium;
                        
                        return PackCard(
                          pack: pack,
                          isPurchased: isPurchased,
                          onTap: () {
                            if (isPurchased) {
                              // If purchased, navigate to the flashcard viewer
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FlashcardViewerScreen(pack: pack),
                                ),
                              );
                            } else {
                              // If not purchased, show purchase dialog
                              _showPurchaseDialog(context, pack, accountProvider);
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
  
  void _showPurchaseDialog(BuildContext context, Pack pack, AccountProvider accountProvider) {
    final user = accountProvider.currentUser;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Purchase ${pack.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pack icon
              Icon(
                pack.topic == 'Geometry' ? Icons.category : Icons.bar_chart,
                size: 48,
                color: pack.topic == 'Geometry' ? Colors.blue : Colors.green,
              ),
              const SizedBox(height: 16),
              
              // Pack details
              Text(
                pack.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Price
              Text(
                '\$${pack.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              // Premium upgrade suggestion
              if (!user.isPremium) ...[  
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'Or upgrade to Premium for access to all packs!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            if (!user.isPremium)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountScreen(),
                    ),
                  );
                },
                child: const Text('Premium Upgrade'),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                
                // Check if user is logged in
                if (user.isGuest) {
                  _showLoginRequiredDialog(context);
                  return;
                }
                
                // Process the purchase
                accountProvider.purchasePack(pack.id);
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${pack.name} purchased successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                
                // Navigate to the flashcard viewer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashcardViewerScreen(pack: pack),
                  ),
                );
              },
              child: const Text('Purchase'),
            ),
          ],
        );
      },
    );
  }
  
  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content: const Text(
            'You need to be logged in to purchase packs. Would you like to go to the account screen to sign in?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
              child: const Text('Go to Account'),
            ),
          ],
        );
      },
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pack.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price or status
                          isPurchased
                              ? Text(
                                  'Purchased',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  '\$${pack.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                          
                          // Action button
                          isPurchased
                              ? const Icon(
                                  Icons.visibility,
                                  size: 18,
                                  color: isCosmicTheme ? const Color(0xFF3A86FF) : Colors.blue,
                                )
                              : const Icon(
                                  Icons.shopping_cart,
                                  size: 18,
                                  color: Colors.orange,
                                ),
                        ],
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
                  child: const Icon(
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
