import 'package:flutter/material.dart';
import 'package:world_builder/menus/pages/Places.dart';
import 'package:world_builder/menus/pages/armors.dart';
import 'package:world_builder/menus/pages/characters.dart';
import 'package:world_builder/menus/pages/cities.dart';
import 'package:world_builder/menus/pages/classes.dart';
import 'package:world_builder/menus/pages/continents.dart';
import 'package:world_builder/menus/pages/countries.dart';
import 'package:world_builder/menus/pages/entities.dart';
import 'package:world_builder/menus/pages/events.dart';
import 'package:world_builder/menus/pages/galaxies.dart';
import 'package:world_builder/menus/pages/home.dart';
import 'package:world_builder/menus/pages/items.dart';
import 'package:world_builder/menus/pages/landforms.dart';
import 'package:world_builder/menus/pages/languages.dart';
import 'package:world_builder/menus/pages/laws.dart';
import 'package:world_builder/menus/pages/multiverse.dart';
import 'package:world_builder/menus/pages/planets.dart';
import 'package:world_builder/menus/pages/powers.dart';
import 'package:world_builder/menus/pages/races.dart';
import 'package:world_builder/menus/pages/solar_systems.dart';
import 'package:world_builder/menus/pages/stars.dart';
import 'package:world_builder/menus/pages/stories.dart';
import 'package:world_builder/menus/pages/titles.dart';
import 'package:world_builder/menus/pages/universes.dart';
import 'package:world_builder/menus/pages/weapons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scripterra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2c3e50)),
        useMaterial3: true,
      ),
      home: const MenuLoader(),
    );
  }
}

class MenuLoader extends StatefulWidget {
  const MenuLoader({super.key});

  @override
  State<MenuLoader> createState() => _MenuLoaderState();
}

class _MenuLoaderState extends State<MenuLoader> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navigationItems = [
    {'icon': Icons.shield, 'label': 'Armors', 'function':ArmorPage()},
    {'icon': Icons.group, 'label': 'Characters'},
    {'icon': Icons.location_city, 'label': 'Cities'},
    {'icon': Icons.category, 'label': 'Classes'},
    {'icon': Icons.public, 'label': 'Continents'},
    {'icon': Icons.flag, 'label': 'Countries'},
    {'icon': Icons.supervisor_account, 'label': 'Entities'},
    {'icon': Icons.event, 'label': 'Events'},
    {'icon': Icons.insights, 'label': 'Galaxies'},
    {'icon': Icons.inventory, 'label': 'Items'},
    {'icon': Icons.terrain, 'label': 'Landforms'},
    {'icon': Icons.language, 'label': 'Languages'},
    {'icon': Icons.gavel, 'label': 'Laws'},
    {'icon': Icons.open_in_browser, 'label': 'Multiverses'},
    {'icon': Icons.place, 'label': 'Places'},
    {'icon': Icons.public, 'label': 'Planets'},
    {'icon': Icons.flash_on, 'label': 'Powers'},
    {'icon': Icons.people, 'label': 'Races'},
    {'icon': Icons.insights, 'label': 'Solar Systems'},
    {'icon': Icons.stars, 'label': 'Stars'},
    {'icon': Icons.book, 'label': 'Stories'},
    {'icon': Icons.title, 'label': 'Titles'},
    {'icon': Icons.public, 'label': 'Universes'},
    {'icon': Icons.colorize, 'label': 'Weapons'},
  ];


  Widget _buildContentForIndex(int index) {
    switch (index) {
      case 0:
        return HomeDesktopContent();
      case 1:
        return ArmorPage();
      case 2:
        return CharacterPage();
      case 3:
        return CityDesktopPage();
      case 4:
        return ClassDesktopPage();
      case 5:
        return ContinentDesktopPage();
      case 6:
        return CountryDesktopPage();
      case 7:
        return EntityDesktopPage();
      case 8:
        return EventDesktopPage();
      case 9:
        return GalaxyDesktopPage();
      case 10:
        return ItemDesktopPage();
      case 11:
        return LandformDesktopPage();
      case 12:
        return LanguageDesktopPage();
      case 13:
        return LawDesktopPage();
      case 14:
        return MultiverseDesktopPage();
      case 15:
        return PlaceDesktopPage();
      case 16:
        return PlanetDesktopPage();
      case 17:
        return PowerDesktopPage();
      case 18:
        return RaceDesktopPage();
      case 19:
        return SolarSystemDesktopPage();
      case 20:
        return StarsDesktopPage();
      case 21:
        return StoriesDesktopPage();
      case 22:
        return TitlesDesktopPage();
      case 23:
        return UniversesDesktopPage();
      case 24:
        return WeaponsDesktopPage();
      default:
        return const SizedBox();
    }
  }

  List<Widget> _buildNavigationItems() {
    // Create a static "Home" item
    final homeItem = ListTile(
      leading: const Icon(Icons.home, color: Colors.white),
      title: const Text('Home', style: TextStyle(color: Colors.white)),
      onTap: () {
          setState(() {
            _selectedIndex = 0; // Adjust index since "Home" is at index 0
          });
      },
    );

    // Sort remaining navigation items
    final sortedItems = _navigationItems.toList()..sort((a, b) => a['label'].toLowerCase().compareTo(b['label'].toLowerCase()));

    // Combine static "Home" item with sorted items
    final allItems = [homeItem, ...sortedItems.asMap().entries.map((entry) {
      int index = entry.key;
      var item = entry.value;
      return ListTile(
        leading: Icon(item['icon'], color: Colors.white),
        title: Text(item['label'], style: const TextStyle(color: Colors.white)),
        onTap: () {
          setState(() {
            _selectedIndex = index + 1; // Adjust index since "Home" is at index 0
          });
        },
      );
    }).toList()];

    return allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color.fromARGB(255, 11, 11, 43),
              toolbarHeight: 50,
            )
          : null,
      drawer: MediaQuery.of(context).size.width <= 600
          ? Drawer(
              child: Container(
                color: const Color.fromARGB(255, 54, 83, 112),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 11, 11, 43),
                      ),
                      child: const Image(
                        image: AssetImage('images/logo.png'), // Replace with your image path
                        height: 80, // Adjust the height as needed
                      ),
                    ),
                    ..._buildNavigationItems(),
                  ],
                ),
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: <Widget>[
                // Wrap NavigationRail with SingleChildScrollView and ConstrainedBox
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                      maxHeight: MediaQuery.of(context).size.height * 2.5,
                    ),
                    child: NavigationRail(
                      backgroundColor: const Color.fromARGB(255, 54, 83, 112),
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        NavigationRailDestination(
                            icon: Icon(Icons.home, color: Colors.white),
                            selectedIcon: Icon(Icons.home, color: const Color(0xFF2c3e50)),
                            label: Text("Home", style: const TextStyle(color: Colors.white)),
                          ),
                        for (final item in _navigationItems.toList()..sort((a, b) => a['label'].toLowerCase().compareTo(b['label'].toLowerCase()))) // Sort by label (case-insensitive)
                          NavigationRailDestination(
                            icon: Icon(item['icon'], color: Colors.white),
                            selectedIcon: Icon(item['icon'], color: const Color(0xFF2c3e50)),
                            label: Text(item['label'], style: const TextStyle(color: Colors.white)),
                          ),
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _buildContentForIndex(_selectedIndex), // Use the selected content
                ),
              ],
            );
          } else {
            return _buildContentForIndex(_selectedIndex); // Use the selected content for mobile
          }
        },
      ),
    );
  }
}
