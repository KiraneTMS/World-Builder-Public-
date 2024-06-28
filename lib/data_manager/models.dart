class HomeStory {
  final String name;
  final String description;
  final List<String> image;
  final String verse;
  final String mainCharacter;
  final List<String> characters;
  final String author;

  HomeStory({
    required this.name,
    required this.description,
    this.image = const [],
    required this.verse,
    required this.mainCharacter,
    this.characters = const [],
    required this.author,
  });

  factory HomeStory.fromJson(Map<String, dynamic> json) {
    return HomeStory(
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

class HomeUniverse {
  final String name;
  final String description;
  final List<String> image;
  final String multiverse;
  final int age;
  final Creator creator;
  final List<String> laws;

  HomeUniverse({
    required this.name,
    required this.description,
    required this.image,
    required this.multiverse,
    this.age = 0,
    required this.creator,
    this.laws = const [],
  });

  factory HomeUniverse.fromJson(Map<String, dynamic> json) {
    return HomeUniverse(
      name: json['name'] ?? 'Unknown Universe', // Default name
      description: json['description'] ?? 'No description available',
      image: List<String>.from(json['image'] ?? []),
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

class HomeMultiverse {
  final String name;
  final String description;
  final List<String> image;
  final int age;
  final Creator creator;
  final List<String> laws;

  HomeMultiverse({
    required this.name,
    required this.description,
    required this.image,
    this.age = 0,
    required this.creator,
    this.laws = const [],
  });

  factory HomeMultiverse.fromJson(Map<String, dynamic> json) {
    return HomeMultiverse(
      name: json['name'] ?? 'Unknown Multiverse', // Default name
      description: json['description'] ?? 'No description available',
      image: List<String>.from(json['image'] ?? ['images/unknown_icon.png']),
      age: json['age']?.toInt() ?? 0, // Convert age (if present) to int, default 0
      creator: Creator.fromJson(json['creator'] ?? {}), // Use empty map for missing creator
      laws: List<String>.from(json['laws'] ?? const []),
    );
  }
}

class Armor {
  final String name;
  final List<String> image;
  final String type;
  final String slot;
  final String tier;
  final String creator;
  final List<String> materials;
  final List<Ability> abilities;
  final String currentOwner;
  final String description;

  Armor({
    required this.name,
    required this.image,
    required this.type,
    required this.slot,
    required this.tier,
    required this.creator,
    required this.materials,
    required this.abilities,
    required this.currentOwner,
    required this.description,
  });

  factory Armor.fromJson(Map<String, dynamic> json) {
    var materialsList = json['materials'] as List<dynamic>? ?? ['???'];
    var abilitiesList = json['abilities'] as List<dynamic>? ?? ['???'];

    return Armor(
      name: json['name'] ?? '???',
      image: List<String>.from(json['image'] ?? ['images/unknown_icon.png']),
      type: json['type'] ?? '???',
      slot: json['slot'] ?? '???',
      tier: json['tier'] ?? '???',
      creator: json['creator'] ?? '???',
      materials: materialsList.map((material) => material.toString()).toList(),
      abilities: abilitiesList.map((abilityJson) => Ability.fromJson(abilityJson)).toList(),
      currentOwner: json['current_owner'] ?? '???',
      description: json['description'] ?? '???',
    );
  }
}

class Ability {
  final String name;
  final String description;

  Ability({
    required this.name,
    required this.description,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['name'] ?? 'Unnamed Ability',
      description: json['description'] ?? 'No description available',
    );
  }
}

// models.dart
// character.dart
class Character {
  final String name;
  final List<String> race;
  final List<String> image;
  final List<String> title;
  final int age;
  final String gender;
  final String hair;
  final List<String> eyes;
  final int height;
  final int weight;
  final String appearanceDescription;
  final String personalityDescription;
  final String backgroundHistory;
  final List<Power> powers;
  final String occupation;
  final List<Map<String, String>> goals;
  final List<Map<String, String>> relationships; // Updated to handle name, relation, description
  final List<String> storyAppearances;
  final List<String> quotes;

  Character({
    required this.name,
    required this.race,
    required this.image,
    required this.title,
    required this.age,
    required this.gender,
    required this.hair,
    required this.eyes,
    required this.height,
    required this.weight,
    required this.appearanceDescription,
    required this.personalityDescription,
    required this.backgroundHistory,
    required this.powers,
    required this.occupation,
    required this.goals,
    required this.relationships,
    required this.storyAppearances,
    required this.quotes,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // Convert powers JSON list to List<Power>
    List<Power> powersList = [];
    if (json['powers'] != null) {
      json['powers'].forEach((powerJson) {
        powersList.add(Power.fromJson(powerJson));
      });
    }

    // Convert relationships JSON list to List<Map<String, String>>
    List<Map<String, String>> relationshipsList = [];
    if (json['relationships'] != null) {
      json['relationships'].forEach((relationshipJson) {
        relationshipsList.add({
          'name': relationshipJson['name'] ?? '',
          'relation': relationshipJson['relation'] ?? '',
          'description': relationshipJson['description'] ?? '', // Ensure 'description' matches your JSON structure
        });
      });
    }

    return Character(
      name: json['name'] ?? 'Unknown',
      race: List<String>.from(json['Race'] ?? []),
      image: List<String>.from(json['image'] ?? ['images/unknown_icon.png']),
      title: List<String>.from(json['Title'] ?? []),
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'Unknown',
      hair: json['appearance']['hair'] ?? 'Unknown',
      eyes: List<String>.from(json['appearance']['eyes'] ?? []),
      height: json['appearance']['height'] ?? 0,
      weight: json['appearance']['weight'] ?? 0,
      appearanceDescription: json['appearance']['description'] ?? '',
      personalityDescription: json['personality']['description'] ?? '',
      backgroundHistory: json['background']['history'] ?? '',
      powers: powersList,
      occupation: json['occupation'] ?? '',
      goals: List<Map<String, String>>.from(json['goals'] ?? []),
      relationships: relationshipsList, // Assign converted relationships list
      storyAppearances: List<String>.from(json['story_appearances'] ?? []),
      quotes: List<String>.from(json['quotes'] ?? []),
    );
  }
}

class City {
  final String name;
  final List<String> image;
  final String country;
  final int population;
  final int area;
  final List<String> landmarks;
  final int founded;
  final String description;
  final List<String> currentLeaders;
  final List<String> pastLeaders;
  final List<String> culturalInfluences;
  final String economicFocus;

  City({
    required this.name,
    this.image = const [],
    required this.country,
    required this.population,
    required this.area,
    this.landmarks = const [],
    required this.founded,
    required this.description,
    this.currentLeaders = const [],
    this.pastLeaders = const [],
    this.culturalInfluences = const [],
    required this.economicFocus,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? 'Unknown',
      image: json['image'] is List ? List<String>.from(json['image']) : [],
      country: json['country'] ?? 'Unknown',
      population: json['population'] ?? 0,
      area: json['area'] ?? 0,
      landmarks: json['landmarks'] is List ? List<String>.from(json['landmarks']) : [],
      founded: json['founded'] ?? 0,
      description: json['description'] ?? '',
      currentLeaders: json['current_leaders'] is List ? List<String>.from(json['current_leaders']) : [],
      pastLeaders: json['past_leaders'] is List ? List<String>.from(json['past_leaders']) : [],
      culturalInfluences: json['cultural_influences'] is List ? List<String>.from(json['cultural_influences']) : [],
      economicFocus: json['economic_focus'] ?? '',
    );
  }
}

class ClassModel {
  final String name;
  final List<String> image;
  final String description;
  final List<String> skills;
  final List<String> specializations;
  final String lore;

  ClassModel({
    required this.name,
    this.image = const [],
    required this.description,
    this.skills = const [],
    this.specializations = const [],
    required this.lore,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      name: json['name'] ?? 'Unknown',
      image: json['image'] is List ? List<String>.from(json['image']) : [],
      description: json['description'] ?? '',
      skills: json['skills'] is List ? List<String>.from(json['skills']) : [],
      specializations: json['specializations'] is List ? List<String>.from(json['specializations']) : [],
      lore: json['lore'] ?? '',
    );
  }
}

class Continent {
  final String name;
  final List<String> image;
  final String planet;
  final int area;
  final List<String> climates;
  final List<String> biomes;

  Continent({
    required this.name,
    this.image = const [],
    required this.planet,
    required this.area,
    required this.climates,
    required this.biomes,
  });

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
      name: json['name'] ?? 'Unknown',
      image: json['image'] is List ? List<String>.from(json['image']) : [],
      planet: json['planet'] ?? 'Unknown',
      area: json['area'] ?? 0,
      climates: List<String>.from(json['climates'] ?? []),
      biomes: List<String>.from(json['biomes'] ?? []),
    );
  }
}
class Country {
  final String name;
  final String capital;
  final List<String> image;
  final String continent;
  final String planet;
  final int population;
  final int area;
  final String government;
  final List<String> countryLeader;
  final List<String> pastLeader;
  final String currency;
  final List<String> officialLanguages;
  final List<String> landmarks;
  final String description;

  Country({
    required this.name,
    required this.capital,
    this.image = const [],
    required this.continent,
    required this.planet,
    required this.population,
    required this.area,
    required this.government,
    required this.countryLeader,
    required this.pastLeader,
    required this.currency,
    required this.officialLanguages,
    required this.landmarks,
    required this.description,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? 'Unknown',
      capital: json['capital'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      continent: json['continent'] ?? 'Unknown',
      planet: json['planet'] ?? 'Unknown',
      population: json['population'] ?? 0,
      area: json['area'] ?? 0,
      government: json['government'] ?? 'Unknown',
      countryLeader: List<String>.from(json['country_leader'] ?? []),
      pastLeader: List<String>.from(json['past_leader'] ?? []),
      currency: json['currency'] ?? 'Unknown',
      officialLanguages: List<String>.from(json['official_languages'] ?? []),
      landmarks: List<String>.from(json['landmarks'] ?? []),
      description: json['description'] ?? 'No description available',
    );
  }
}
class Entity {
  final String name;
  final String type;
  final String universe;
  final String image;
  final String species;
  final String diet;
  final String habitat;
  final String description;
  final List<String> specialAbilities;

  Entity({
    required this.name,
    required this.type,
    required this.universe,
    required this.image,
    required this.species,
    required this.diet,
    required this.habitat,
    required this.description,
    required this.specialAbilities,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      name: json['name'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      universe: json['universe'] ?? 'Unknown',
      image: json['image'] ?? '',
      species: json['species'] ?? 'Unknown',
      diet: json['diet'] ?? 'Unknown',
      habitat: json['habitat'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      specialAbilities: List<String>.from(json['special_abilities'] ?? []),
    );
  }
}
class Event {
  final String name;
  final String storyRelevance;
  final List<String> image;
  final String date;
  final String location;
  final List<String> participants;
  final String description;
  final String spark;
  final String outcome;
  final List<String> relatedEvents;

  Event({
    required this.name,
    required this.storyRelevance,
    required this.image,
    required this.date,
    required this.location,
    required this.participants,
    required this.description,
    required this.spark,
    required this.outcome,
    required this.relatedEvents,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] ?? 'Unknown',
      storyRelevance: json['story_relevance'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      date: json['date'] ?? 'Unknown',
      location: json['location'] ?? 'Unknown',
      participants: List<String>.from(json['participants'] ?? []),
      description: json['description'] ?? 'No description available',
      spark: json['spark'] ?? 'Unknown',
      outcome: json['outcome'] ?? 'Unknown',
      relatedEvents: List<String>.from(json['related_events'] ?? []),
    );
  }
}
class SpiralArm {
  final String name;
  final int length;

  SpiralArm({required this.name, required this.length});

  factory SpiralArm.fromJson(Map<String, dynamic> json) {
    return SpiralArm(
      name: json['name'],
      length: json['length'],
    );
  }
}

class Galaxy {
  final String name;
  final List<String> image;
  final String type;
  final int diameter;
  final double mass;
  final Map<String, String> bulge;
  final Map<String, String> disk;
  final Map<String, String> halo;
  final List<SpiralArm> spiralArms;
  final List<String> solarSystems;

  Galaxy({
    required this.name,
    required this.image,
    required this.type,
    required this.diameter,
    required this.mass,
    required this.bulge,
    required this.disk,
    required this.halo,
    required this.spiralArms,
    required this.solarSystems,
  });

  factory Galaxy.fromJson(Map<String, dynamic> json) {
    var spiralArmsFromJson = json['spiral_arms'] as List;
    List<SpiralArm> spiralArmsList = spiralArmsFromJson.map((i) => SpiralArm.fromJson(i)).toList();

    return Galaxy(
      name: json['name'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      type: json['type'] ?? 'Unknown',
      diameter: json['diameter'] ?? 0,
      mass: json['mass'] ?? 0.0,
      bulge: Map<String, String>.from(json['bulge'] ?? {}),
      disk: Map<String, String>.from(json['disk'] ?? {}),
      halo: Map<String, String>.from(json['halo'] ?? {}),
      spiralArms: spiralArmsList,
      solarSystems: List<String>.from(json['solar_systems'] ?? []),
    );
  }
}
class Item {
  final String name;
  final String image;
  final String type;
  final String description;
  final List<String> abilities;

  Item({
    required this.name,
    required this.image,
    required this.type,
    required this.description,
    required this.abilities,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      type: json['type'] ?? 'Unknown',
      description: json['description'] ?? '',
      abilities: List<String>.from(json['abilities'] ?? []),
    );
  }
}
class Landform {
  final String name;
  final String type;
  final List<String> image;
  final String planetName;
  final List<String> continents;
  final List<String> countries;
  final Map<String, double> size;
  final String composition;
  final List<String> uniqueFeatures;

  Landform({
    required this.name,
    required this.type,
    required this.image,
    required this.planetName,
    required this.continents,
    required this.countries,
    required this.size,
    required this.composition,
    required this.uniqueFeatures,
  });

  factory Landform.fromJson(Map<String, dynamic> json) {
    return Landform(
      name: json['name'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      planetName: json['location']['planet_name'] ?? 'Unknown',
      continents: List<String>.from(json['location']['continents'] ?? []),
      countries: List<String>.from(json['location']['countries'] ?? []),
      size: Map<String, double>.from(json['size'] ?? {}),
      composition: json['composition'] ?? 'Unknown',
      uniqueFeatures: List<String>.from(json['unique_features'] ?? []),
    );
  }
}
class Language {
  final String name;
  final List<String> image;
  final String nativeName;
  final String languageFamily;
  final String writingSystem;
  final String description;

  Language({
    required this.name,
    required this.image,
    required this.nativeName,
    required this.languageFamily,
    required this.writingSystem,
    required this.description,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      nativeName: json['native_name'] ?? 'Unknown',
      languageFamily: json['language_family'] ?? 'Unknown',
      writingSystem: json['writing_system'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
    );
  }
}
class Law {
  final String name;
  final String description;
  final String category;

  Law({
    required this.name,
    required this.description,
    required this.category,
  });

  factory Law.fromJson(Map<String, dynamic> json) {
    return Law(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown',
    );
  }
}
class Multiverse {
  final String name;
  final String description;
  final List<String> image;
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
      image: List<String>.from(json['image'] ?? ['images/unknown_icon.png']),
      age: json['age']?.toInt() ?? 0, // Convert age (if present) to int, default 0
      creator: Creator.fromJson(json['creator'] ?? {}), // Use empty map for missing creator
      laws: List<String>.from(json['laws'] ?? const []),
    );
  }
}
class Place {
  final String name;
  final List<String> image;
  final String type;
  final String location;
  final int builtDate;
  final String owner;
  final String description;

  Place({
    required this.name,
    required this.image,
    required this.type,
    required this.location,
    required this.builtDate,
    required this.owner,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      type: json['type'] ?? 'Unknown',
      location: json['location'] ?? 'Unknown',
      builtDate: json['built_date'] ?? 0,
      owner: json['owner'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
class Moon {
  final String name;
  final int radius;
  final String composition;

  Moon({
    required this.name,
    required this.radius,
    required this.composition,
  });

  factory Moon.fromJson(Map<String, dynamic> json) {
    return Moon(
      name: json['name'] ?? 'Unknown',
      radius: json['radius'] ?? 0,
      composition: json['composition'] ?? 'Unknown',
    );
  }
}

class Planet {
  final String name;
  final List<String> image;
  final String type;
  final int radius;
  final double mass;
  final String atmosphere;
  final double orbitalPeriod;
  final double rotationPeriod;
  final List<Moon> moons;
  final bool habitable;

  Planet({
    required this.name,
    required this.image,
    required this.type,
    required this.radius,
    required this.mass,
    required this.atmosphere,
    required this.orbitalPeriod,
    required this.rotationPeriod,
    required this.moons,
    required this.habitable,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      type: json['type'] ?? 'Unknown',
      radius: json['radius'] ?? 0,
      mass: json['mass']?.toDouble() ?? 0.0,
      atmosphere: json['atmosphere'] ?? 'Unknown',
      orbitalPeriod: json['orbital_period']?.toDouble() ?? 0.0,
      rotationPeriod: json['rotation_period']?.toDouble() ?? 0.0,
      moons: (json['moons'] as List).map((moon) => Moon.fromJson(moon)).toList(),
      habitable: json['habitable'] ?? false,
    );
  }
}
class Power {
  final String name;
  final String associatedLaw;
  final String type;
  final String description;
  final List<String> image;

  Power({
    required this.name,
    required this.associatedLaw,
    required this.type,
    required this.description,
    required this.image,
  });

  factory Power.fromJson(Map<String, dynamic> json) {
    return Power(
      name: json['name'] ?? 'Unknown',
      associatedLaw: json['associated_law'] ?? 'Unknown',
      type: json['type'] ?? '???',
      description: json['description'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
    );
  }
}
class Biology {
  final int averageLifespan;
  final Height height;
  final List<String> distinguishingFeatures;

  Biology({
    required this.averageLifespan,
    required this.height,
    required this.distinguishingFeatures,
  });

  factory Biology.fromJson(Map<String, dynamic> json) {
    return Biology(
      averageLifespan: json['average_lifespan'] is int ? json['average_lifespan'] : 0,
      height: Height.fromJson(json['height']),
      distinguishingFeatures: List<String>.from(json['distinguishing_features'] ?? []),
    );
  }
}

class Height {
  final double min;
  final double max;

  Height({
    required this.min,
    required this.max,
  });

  factory Height.fromJson(Map<String, dynamic> json) {
    return Height(
      min: json['min']?.toDouble() ?? 0.0,
      max: json['max']?.toDouble() ?? 0.0,
    );
  }
}

class Culture {
  final String language;
  final String government;
  final String socialStructure;

  Culture({
    required this.language,
    required this.government,
    required this.socialStructure,
  });

  factory Culture.fromJson(Map<String, dynamic> json) {
    return Culture(
      language: json['language'] ?? 'Unknown',
      government: json['government'] ?? 'Unknown',
      socialStructure: json['social_structure'] ?? 'Unknown',
    );
  }
}

class Relations {
  final String allies;
  final String rivals;

  Relations({
    required this.allies,
    required this.rivals,
  });

  factory Relations.fromJson(Map<String, dynamic> json) {
    return Relations(
      allies: json['allies'] ?? 'Unknown',
      rivals: json['rivals'] ?? 'Unknown',
    );
  }
}

class Race {
  final String name;
  final String type;
  final List<String> image;
  final Biology biology;
  final Culture culture;
  final String habitat;
  final List<String> specialAbilities;
  final Relations relations;

  Race({
    required this.name,
    required this.type,
    required this.image,
    required this.biology,
    required this.culture,
    required this.habitat,
    required this.specialAbilities,
    required this.relations,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      name: json['name'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      biology: Biology.fromJson(json['biology']),
      culture: Culture.fromJson(json['culture']),
      habitat: json['habitat'] ?? 'Unknown',
      specialAbilities: List<String>.from(json['special_abilities'] ?? []),
      relations: Relations.fromJson(json['relations']),
    );
  }
}
class SolarSystem {
  final String name;
  final List<String> images;
  final List<Star> star;
  final List<String> planets;

  SolarSystem({
    required this.name,
    required this.images,
    required this.star,
    required this.planets,
  });

  factory SolarSystem.fromJson(Map<String, dynamic> json) {
    return SolarSystem(
      name: json['name'] ?? 'Unknown',
      images: List<String>.from(json['images'] ?? []),
      star: (json['star'] as List).map((star) => Star.fromJson(star)).toList(),
      planets: List<String>.from(json['planets'] ?? []),
    );
  }
}
class Star {
  final String name;
  final List<String> images;
  final String type;
  final double temperature;
  final double mass;

  Star({
    required this.name,
    required this.images,
    required this.type,
    required this.temperature,
    required this.mass,
  });

  factory Star.fromJson(Map<String, dynamic> json) {
    return Star(
      name: json['name'] ?? 'Unknown',
      images: List<String>.from(json['images'] ?? []),
      type: json['type'] ?? 'Unknown',
      temperature: json['temperature']?.toDouble() ?? 0.0,
      mass: json['mass']?.toDouble() ?? 0.0,
    );
  }
}
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
    required this.image,
    required this.verse,
    required this.mainCharacter,
    required this.characters,
    required this.author,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      image: List<String>.from(json['image'] ?? []),
      verse: json['verse'] ?? 'Unknown',
      mainCharacter: json['main_character'] ?? 'Unknown',
      characters: List<String>.from(json['characters'] ?? []),
      author: json['author'] ?? 'Unknown',
    );
  }
}
class Titles {
  final String title;
  final String description;

  Titles({
    required this.title,
    required this.description,
  });

  factory Titles.fromJson(Map<String, dynamic> json) {
    return Titles(
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
    );
  }
}
class Universe {
  final String name;
  final String description;
  final List<String> image;
  final String multiverse;
  final int age;
  final String creator;
  final List<String> laws;

  Universe({
    required this.name,
    required this.description,
    required this.image,
    required this.multiverse,
    required this.age,
    required this.creator,
    required this.laws,
  });

  factory Universe.fromJson(Map<String, dynamic> json) {
    return Universe(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      image: (json['image'] is List) ? List<String>.from(json['image']) : [],
      multiverse: json['multiverse'] ?? 'Unknown',
      age: json['age'] ?? 0,
      creator: json['creator']['name'] ?? 'Unknown',
      laws: List<String>.from(json['laws'] ?? []),
    );
  }
}
class Weapon {
  final String name;
  final List<String> image;
  final String type;
  final String tier;
  final String creator;
  final List<String> materials;
  final List<Ability> abilities;
  final String currentOwner;
  final String description;

  Weapon({
    required this.name,
    required this.image,
    required this.type,
    required this.tier,
    required this.creator,
    required this.materials,
    required this.abilities,
    required this.currentOwner,
    required this.description,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      name: json['name'] ?? 'Unknown',
      image: List<String>.from(json['image'] ?? []),
      type: json['type'] ?? 'Unknown',
      tier: json['tier'] ?? 'Unknown',
      creator: json['creator'] ?? 'Unknown',
      materials: List<String>.from(json['materials'] ?? []),
      abilities: (json['abilities'] as List).map((ability) => Ability.fromJson(ability)).toList(),
      currentOwner: json['current_owner'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
    );
  }
}
