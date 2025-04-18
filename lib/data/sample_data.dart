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
        thumbnailPath: 'assets/images/flashcards/geometry/thumbnail.png',
        flashcards: [
          Flashcard(
            id: 'geo_1',
            imagePath: 'assets/images/flashcards/geometry/triangles.png',
            topic: 'Geometry',
            title: 'Types of Triangles',
          ),
          Flashcard(
            id: 'geo_2',
            imagePath: 'assets/images/flashcards/geometry/circles.png',
            topic: 'Geometry',
            title: 'Circle Properties',
          ),
          Flashcard(
            id: 'geo_3',
            imagePath: 'assets/images/flashcards/geometry/quadrilaterals.png',
            topic: 'Geometry',
            title: 'Quadrilaterals',
          ),
          Flashcard(
            id: 'geo_4',
            imagePath: 'assets/images/flashcards/geometry/angles.png',
            topic: 'Geometry',
            title: 'Angle Relationships',
          ),
        ],
      ),
      Pack(
        id: 'stats_distributions',
        name: 'Statistics Distributions',
        description: 'Common statistical distributions explained',
        topic: 'Statistics',
        price: 2.99,
        thumbnailPath: 'assets/images/flashcards/statistics/thumbnail.png',
        flashcards: [
          // Normal distribution flashcard
          Flashcard(
            id: 'stats_1',
            imagePath: 'assets/images/flashcards/statistics/normal_distribution_sharp.png',
            topic: 'Statistics',
            title: 'Normal Distribution',
          ),
          Flashcard(
            id: 'stats_3',
            imagePath: 'assets/images/flashcards/statistics/binomial_distribution.png',
            topic: 'Statistics',
            title: 'Binomial Distribution',
          ),
          Flashcard(
            id: 'stats_4',
            imagePath: 'assets/images/flashcards/statistics/poisson_distribution.png',
            topic: 'Statistics',
            title: 'Poisson Distribution',
          ),
          Flashcard(
            id: 'stats_5',
            imagePath: 'assets/images/flashcards/statistics/chi_square_distribution.png',
            topic: 'Statistics',
            title: 'Chi-Square Distribution',
          ),
        ],
      ),
      Pack(
        id: 'geometry_advanced',
        name: 'Advanced Geometry',
        description: 'Advanced geometric concepts and theorems',
        topic: 'Geometry',
        price: 2.99,
        thumbnailPath: 'assets/images/flashcards/geometry/advanced_thumbnail.png',
        flashcards: [
          Flashcard(
            id: 'geo_adv_1',
            imagePath: 'assets/images/flashcards/geometry/conic_sections.png',
            topic: 'Geometry',
            title: 'Conic Sections',
          ),
          Flashcard(
            id: 'geo_adv_2',
            imagePath: 'assets/images/flashcards/geometry/3d_geometry.png',
            topic: 'Geometry',
            title: '3D Geometry',
          ),
        ],
      ),
    ];
  }
}
