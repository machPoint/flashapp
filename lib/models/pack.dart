import 'package:mathflash/models/flashcard.dart';

class Pack {
  final String id;
  final String name;
  final String description;
  final String topic;
  final double price;
  final List<Flashcard> flashcards;
  final String thumbnailPath;

  Pack({
    required this.id,
    required this.name,
    required this.description,
    required this.topic,
    required this.price,
    required this.flashcards,
    required this.thumbnailPath,
  });
}
