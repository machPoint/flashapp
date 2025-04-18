import 'package:flutter/material.dart';
import 'package:mathflash/data/sample_data.dart';
import 'package:mathflash/models/pack.dart';
import 'package:mathflash/screens/flashcard_viewer_screen.dart';

class PackSelectionScreen extends StatelessWidget {
  const PackSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packs = SampleData.getPacks();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Pack'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: packs.isEmpty
          ? const Center(
              child: Text(
                'No packs available yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Packs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
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
                        return PackCard(
                          pack: pack,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashcardViewerScreen(pack: pack),
                              ),
                            );
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

  const PackCard({
    super.key,
    required this.pack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the pack image
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                color: pack.topic == 'Geometry' 
                    ? Colors.blue.shade200 
                    : Colors.green.shade200,
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
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('\$${pack.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
