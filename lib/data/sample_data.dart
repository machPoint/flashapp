import 'package:mathflash/models/flashcard.dart';
import 'package:mathflash/models/pack.dart';

// This is a placeholder for sample data
// In a real app, this would come from a backend or local database
class SampleData {
  static List<Pack> getPacks() {
    return [
      Pack(
        id: 'geometry_basics',
        name: 'Geometry Basics',
        description: 'Learn the fundamental concepts of geometry',
        topic: 'Geometry',
        price: 1.99,
        thumbnailPath: 'assets/geometry_thumbnail.png',
        flashcards: [
          Flashcard(
            id: 'geo_1',
            imagePath: 'assets/geometry/triangles.png',
            topic: 'Geometry',
            title: 'Types of Triangles',
          ),
          Flashcard(
            id: 'geo_2',
            imagePath: 'assets/geometry/circles.png',
            topic: 'Geometry',
            title: 'Circle Properties',
          ),
        ],
      ),
      Pack(
        id: 'stats_distributions',
        name: 'Statistics Distributions',
        description: 'Common statistical distributions explained',
        topic: 'Statistics',
        price: 2.99,
        thumbnailPath: 'assets/stats_thumbnail.png',
        flashcards: [
          Flashcard(
            id: 'stats_1',
            imagePath: 'assets/statistics/normal_distribution.png',
            topic: 'Statistics',
            title: 'Normal Distribution',
          ),
          Flashcard(
            id: 'stats_2',
            imagePath: 'assets/statistics/binomial_distribution.png',
            topic: 'Statistics',
            title: 'Binomial Distribution',
          ),
        ],
      ),
    ];
  }
}
