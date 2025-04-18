// Helper function for generating placeholder content
import 'package:flutter/material.dart';
import 'package:mathflash/models/flashcard.dart';

// Generate placeholder content based on flashcard title
Widget getPlaceholderContent(Flashcard flashcard) {
  // Content based on flashcard topic and title
  if (flashcard.topic == 'Geometry') {
    if (flashcard.title.contains('Triangle')) {
      return Column(
        children: [
          const Text(
            'Types of triangles:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• Equilateral: All sides equal'),
          const Text('• Isosceles: Two sides equal'),
          const Text('• Scalene: No sides equal'),
          const Text('• Right: Has a 90° angle'),
          const Text('• Acute: All angles < 90°'),
          const Text('• Obtuse: One angle > 90°'),
        ],
      );
    } else if (flashcard.title.contains('Circle')) {
      return Column(
        children: [
          const Text(
            'Circle properties:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• Area = πr²'),
          const Text('• Circumference = 2πr'),
          const Text('• Diameter = 2r'),
          const Text('• Central angle = 360°'),
        ],
      );
    } else if (flashcard.title.contains('Quadrilateral')) {
      return Column(
        children: [
          const Text(
            'Types of quadrilaterals:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• Square: All sides equal, all angles 90°'),
          const Text('• Rectangle: Opposite sides equal, all angles 90°'),
          const Text('• Rhombus: All sides equal'),
          const Text('• Parallelogram: Opposite sides parallel'),
          const Text('• Trapezoid: One pair of parallel sides'),
        ],
      );
    }
  } else if (flashcard.topic == 'Statistics') {
    if (flashcard.title.contains('Normal')) {
      return Column(
        children: [
          const Text(
            'Normal distribution:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• Bell-shaped curve'),
          const Text('• Mean = Median = Mode'),
          const Text('• 68-95-99.7 rule'),
          const Text('• Standard form: z = (x-μ)/σ'),
        ],
      );
    } else if (flashcard.title.contains('Binomial')) {
      return Column(
        children: [
          const Text(
            'Binomial distribution:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('• Fixed number of trials'),
          const Text('• Two possible outcomes'),
          const Text('• Trials are independent'),
          const Text('• P(X=k) = nCk × pᵏ × (1-p)ⁿ⁻ᵏ'),
        ],
      );
    }
  }
  
  // Default content if no specific match
  return const Text(
    'Tap to view flashcard content',
    style: TextStyle(fontStyle: FontStyle.italic),
  );
}
