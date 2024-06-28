import 'dart:convert';
import 'package:flutter/services.dart';
import 'models.dart';

Future<List<HomeStory>> loadStoriesHome() async {
  final String response = await rootBundle.loadString('jsons/stories.json');
  final data = json.decode(response);
  
  // Retrieve stories and limit to 3 items, sorted by the last item first
  List<dynamic> stories = data['stories'];
  stories = stories.take(3).toList(); // Limit to 3 items
  
  return stories.map((json) => HomeStory.fromJson(json)).toList();
}

Future<List<HomeUniverse>> loadUniversesHome() async {
  final String response = await rootBundle.loadString('jsons/universes.json');
  final data = json.decode(response);
  
  // Retrieve universes and limit to 3 items, sorted by the last item first
  List<dynamic> universes = data['universes'];
  universes = universes.take(3).toList(); // Limit to 3 items
  
  return universes.map((json) => HomeUniverse.fromJson(json)).toList();
}

Future<List<HomeMultiverse>> loadMultiversesHome() async {
  final String response = await rootBundle.loadString('jsons/multiverses.json');
  final data = json.decode(response);
  
  // Retrieve multiverses and limit to 3 items, sorted by the last item first
  List<dynamic> multiverses = data['multiverses'];
  multiverses = multiverses.take(3).toList(); // Limit to 3 items
  
  return multiverses.map((json) => HomeMultiverse.fromJson(json)).toList();
}

Future<List<Armor>> loadArmors() async {
  final String response = await rootBundle.loadString('jsons/armors.json');
  final data = json.decode(response);

  List<dynamic> armorsData = data['armors'];
  
  return armorsData.map((json) => Armor.fromJson(json)).toList();
}

Future<List<Character>> loadCharacters() async {
  final String response = await rootBundle.loadString('jsons/characters.json');
  final data = json.decode(response);

  List<dynamic> charactersJson = data['characters'];
  return charactersJson.map((json) => Character.fromJson(json)).toList();
}

Future<List<City>> loadCities() async {
  final String response = await rootBundle.loadString('jsons/cities.json');
  final data = json.decode(response);

  List<dynamic> citiesJson = data['cities'];
  return citiesJson.map((json) => City.fromJson(json)).toList();
}

Future<List<ClassModel>> loadClasses() async {
  final String response = await rootBundle.loadString('jsons/classes.json');
  final data = json.decode(response);

  List<dynamic> classesJson = data['classes'];
  return classesJson.map((json) => ClassModel.fromJson(json)).toList();
}

Future<List<Continent>> loadContinents() async {
  final String response = await rootBundle.loadString('jsons/continents.json');
  final data = await json.decode(response);
  List<dynamic> continentList = data['continents'];
  return continentList.map((json) => Continent.fromJson(json)).toList();
}

Future<List<Country>> loadCountries() async {
  final String response = await rootBundle.loadString('jsons/countries.json');
  final data = await json.decode(response);
  List<dynamic> countryList = data['countries'];
  return countryList.map((json) => Country.fromJson(json)).toList();
}

Future<List<Entity>> loadEntities() async {
  final String response = await rootBundle.loadString('jsons/entities.json');
  final data = await json.decode(response);
  List<dynamic> entityList = data['entities'];
  return entityList.map((json) => Entity.fromJson(json)).toList();
}

Future<List<Event>> loadEvents() async {
  final String response = await rootBundle.loadString('jsons/events.json');
  final data = await json.decode(response);
  List<dynamic> eventList = data['events'];
  return eventList.map((json) => Event.fromJson(json)).toList();
}

Future<List<Galaxy>> loadGalaxies() async {
  final String response = await rootBundle.loadString('jsons/galaxies.json');
  final data = await json.decode(response);
  List<dynamic> galaxyList = data['galaxies'];
  return galaxyList.map((json) => Galaxy.fromJson(json)).toList();
}

Future<List<Item>> loadItems() async {
  final String response = await rootBundle.loadString('jsons/items.json');
  final data = await json.decode(response);
  List<dynamic> itemList = data['items'];
  return itemList.map((json) => Item.fromJson(json)).toList();
}

Future<List<Landform>> loadLandforms() async {
  final String response = await rootBundle.loadString('jsons/landforms.json');
  final data = await json.decode(response);
  List<dynamic> landformList = data['landforms'];
  return landformList.map((json) => Landform.fromJson(json)).toList();
}

Future<List<Language>> loadLanguages() async {
  final String response = await rootBundle.loadString('jsons/languages.json');
  final data = await json.decode(response);
  List<dynamic> languageList = data['languages'];
  return languageList.map((json) => Language.fromJson(json)).toList();
}

Future<List<Law>> loadLaws() async {
  final String response = await rootBundle.loadString('jsons/laws.json');  // Make sure to adjust the path
  final data = await json.decode(response);
  List<dynamic> lawList = data['laws'];
  return lawList.map((json) => Law.fromJson(json)).toList();
}

Future<List<Multiverse>> loadMultiverses() async {
  final String response = await rootBundle.loadString('jsons/multiverses.json');  // Make sure to adjust the path
  final data = await json.decode(response);
  List<dynamic> multiverseList = data['multiverses'];
  return multiverseList.map((json) => Multiverse.fromJson(json)).toList();
}

Future<List<Place>> loadPlaces() async {
  final String response = await rootBundle.loadString('jsons/places.json'); // Adjust path to your JSON file
  final data = await json.decode(response);
  List<dynamic> placeList = data['places'];
  return placeList.map((json) => Place.fromJson(json)).toList();
}

Future<List<Planet>> loadPlanets() async {
  final String response = await rootBundle.loadString('assets/jsons/planets.json'); // Adjust path to your JSON file
  final data = await json.decode(response);
  List<dynamic> planetList = data['planets'];
  return planetList.map((json) => Planet.fromJson(json)).toList();
}

Future<List<Power>> loadPowers() async {
  final String response = await rootBundle.loadString('assets/jsons/powers.json'); // Adjust path to your JSON file
  final data = await json.decode(response);
  List<dynamic> powerList = data['powers'];
  return powerList.map((json) => Power.fromJson(json)).toList();
}

Future<List<Race>> loadRaces() async {
  final String response = await rootBundle.loadString('assets/jsons/races.json'); // Adjust path to your JSON file
  final data = await json.decode(response);
  List<dynamic> raceList = data['races'];
  return raceList.map((json) => Race.fromJson(json)).toList();
}

Future<List<SolarSystem>> loadSolarSystems() async {
  final data = await rootBundle.loadString('jsons/solar_systems.json');
  final List<dynamic> jsonResult = json.decode(data)['solar_systems'];
  return jsonResult.map((json) => SolarSystem.fromJson(json)).toList();
}

Future<List<Star>> loadStars() async {
  final data = await rootBundle.loadString('assets/jsons/stars.json');
  final List<dynamic> jsonResult = json.decode(data)['stars'];
  return jsonResult.map((json) => Star.fromJson(json)).toList();
}

Future<List<Story>> loadStories() async {
  final data = await rootBundle.loadString('assets/jsons/stories.json');
  final List<dynamic> jsonResult = json.decode(data)['stories'];
  return jsonResult.map((json) => Story.fromJson(json)).toList();
}

Future<List<Titles>> loadTitles() async {
  final data = await rootBundle.loadString('assets/jsons/titles.json');
  final List<dynamic> jsonResult = json.decode(data)['titles'];
  return jsonResult.map((json) => Titles.fromJson(json)).toList();
}

Future<List<Universe>> loadUniverses() async {
  final data = await rootBundle.loadString('assets/jsons/universes.json');
  final List<dynamic> jsonResult = json.decode(data)['universes'];
  return jsonResult.map((json) => Universe.fromJson(json)).toList();
}

Future<List<Weapon>> loadWeapons() async {
  final data = await rootBundle.loadString('assets/jsons/weapons.json');
  final List<dynamic> jsonResult = json.decode(data)['weapons'];
  return jsonResult.map((json) => Weapon.fromJson(json)).toList();
}