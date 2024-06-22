import 'dart:convert';

class Story {
  final String name;
  final String description;
  final List<String> image;
  final String verse;
  final String mainCharacter;
  final List<String> characters;
  final String author;

  Story({
    required this.name,
    required this.description,
    this.image = const [],
    required this.verse,
    required this.mainCharacter,
    this.characters = const [],
    required this.author,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      name: json['name'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      image: List<String>.from(json['image'] ?? ['images/unknown_icon.png']),
      verse: json['verse'] ?? 'Uncharted Territory',
      mainCharacter: json['main_character'],
      characters: List<String>.from(json['characters'] ?? const []),
      author: json['author'],
    );
  }
}

class Universe {
  final String name;
  final String description;
  final String image;
  final String multiverse;
  final int age;
  final Creator creator;
  final List<String> laws;

  Universe({
    required this.name,
    required this.description,
    required this.image,
    required this.multiverse,
    this.age = 0,
    required this.creator,
    this.laws = const [],
  });

  factory Universe.fromJson(Map<String, dynamic> json) {
    return Universe(
      name: json['name'] ?? 'Unknown Universe', // Default name
      description: json['description'] ?? 'No description available',
      image: json['image'] ?? 'images/unknown_icon.png', // Required field, handle potential error
      multiverse: json['multiverse'] ?? 'Unknown',
      age: json['age']?.toInt() ?? 0, // Convert age (if present) to int, default 0
      creator: Creator.fromJson(json['creator'] ?? {}), // Use empty map for missing creator
      laws: List<String>.from(json['laws'] ?? const []),
    );
  }
}

class Creator {
  final String name;

  Creator({required this.name});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      name: json['name'] ?? 'Unknown Creator', // Default name
    );
  }
}

class Multiverse {
  final String name;
  final String description;
  final String image;
  final int age;
  final Creator creator;
  final List<String> laws;

  Multiverse({
    required this.name,
    required this.description,
    required this.image,
    this.age = 0,
    required this.creator,
    this.laws = const [],
  });

  factory Multiverse.fromJson(Map<String, dynamic> json) {
    return Multiverse(
      name: json['name'] ?? 'Unknown Multiverse', // Default name
      description: json['description'] ?? 'No description available',
      image: json['image'] ?? 'images/unknown_icon.png', // Required field, handle potential error
      age: json['age']?.toInt() ?? 0, // Convert age (if present) to int, default 0
      creator: Creator.fromJson(json['creator'] ?? {}), // Use empty map for missing creator
      laws: List<String>.from(json['laws'] ?? const []),
    );
  }
}