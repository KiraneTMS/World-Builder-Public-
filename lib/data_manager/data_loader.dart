import 'dart:convert';
import 'package:flutter/services.dart';
import 'models.dart';

Future<List<Story>> loadStoriesHome() async {
  final String response = await rootBundle.loadString('jsons/stories.json');
  final data = json.decode(response);
  
  // Retrieve stories and limit to 3 items, sorted by the last item first
  List<dynamic> stories = data['stories'];
  stories = stories.take(3).toList(); // Limit to 3 items
  
  return stories.map((json) => Story.fromJson(json)).toList();
}

Future<List<Universe>> loadUniversesHome() async {
  final String response = await rootBundle.loadString('jsons/universes.json');
  final data = json.decode(response);
  
  // Retrieve universes and limit to 3 items, sorted by the last item first
  List<dynamic> universes = data['universes'];
  universes = universes.take(3).toList(); // Limit to 3 items
  
  return universes.map((json) => Universe.fromJson(json)).toList();
}

Future<List<Multiverse>> loadMultiversesHome() async {
  final String response = await rootBundle.loadString('jsons/multiverses.json');
  final data = json.decode(response);
  
  // Retrieve multiverses and limit to 3 items, sorted by the last item first
  List<dynamic> multiverses = data['multiverses'];
  multiverses = multiverses.take(3).toList(); // Limit to 3 items
  
  return multiverses.map((json) => Multiverse.fromJson(json)).toList();
}
