import 'package:flutter/material.dart';
import 'menus/desktop_view/home.dart';
import 'menus/mobile_view/home.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 11, 11, 43),
        toolbarHeight: 50,
      ),
      drawer: MediaQuery.of(context).size.width <= 600
          ? Drawer(
              child: Container(
                color: const Color.fromARGB(255, 54, 83, 112), // Set background color
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 11, 11, 43),
                      ),
                      child: const Image(
                        image: AssetImage('images/logo.png'), // Replace with your image path
                        height: 80, // Adjust the height as needed
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.white), // Change icon color to white for visibility
                      title: const Text('Home', style: TextStyle(color: Colors.white)), // Change text color to white for visibility
                      onTap: () {
                        // Handle Home tap
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.category, color: Colors.white),
                      title: const Text('Armors', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Armors tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.group, color: Colors.white),
                      title: const Text('Characters', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Characters tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.location_city, color: Colors.white),
                      title: const Text('Cities', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Cities tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.school, color: Colors.white),
                      title: const Text('Classes', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Classes tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.public, color: Colors.white),
                      title: const Text('Continents', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Continents tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.flag, color: Colors.white),
                      title: const Text('Countries', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Countries tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.supervisor_account, color: Colors.white),
                      title: const Text('Entities', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Entities tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.event, color: Colors.white),
                      title: const Text('Events', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Events tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.white),
                      title: const Text('Galaxies', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Galaxies tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.inventory, color: Colors.white),
                      title: const Text('Items', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Items tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.language, color: Colors.white),
                      title: const Text('Languages', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Languages tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.terrain, color: Colors.white),
                      title: const Text('Landforms', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Landforms tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.gavel, color: Colors.white),
                      title: const Text('Laws', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Laws tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.open_in_browser, color: Colors.white),
                      title: const Text('Multiverses', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Multiverses tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.place, color: Colors.white),
                      title: const Text('Places', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Places tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.landscape, color: Colors.white),
                      title: const Text('Planets', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Planets tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.flash_on, color: Colors.white),
                      title: const Text('Powers', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Powers tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.people, color: Colors.white),
                      title: const Text('Races', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Races tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.timeline, color: Colors.white),
                      title: const Text('Solar Systems', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Solar Systems tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.stars, color: Colors.white),
                      title: const Text('Stars', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Stars tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.book, color: Colors.white),
                      title: const Text('Stories', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Stories tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.title, color: Colors.white),
                      title: const Text('Titles', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Titles tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.public_off, color: Colors.white),
                      title: const Text('Universes', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Universes tap
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.explore, color: Colors.white),
                      title: const Text('Weapons', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle Weapons tap
                        Navigator.pop(context);
                      },
                    ),
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
                      maxHeight: MediaQuery.of(context).size.height*2.5,
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
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          icon: Icon(Icons.home, color: Colors.white),
                          selectedIcon: Icon(Icons.home, color: Color(0xFF2c3e50)),
                          label: Text('Home', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.shield, color: Colors.white),
                          selectedIcon: Icon(Icons.category, color: Color(0xFF2c3e50)),
                          label: Text('Armors', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.group, color: Colors.white),
                          selectedIcon: Icon(Icons.group, color: Color(0xFF2c3e50)),
                          label: Text('Characters', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.location_city, color: Colors.white),
                          selectedIcon: Icon(Icons.location_city, color: Color(0xFF2c3e50)),
                          label: Text('Cities', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.school, color: Colors.white),
                          selectedIcon: Icon(Icons.school, color: Color(0xFF2c3e50)),
                          label: Text('Classes', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.public, color: Colors.white),
                          selectedIcon: Icon(Icons.public, color: Color(0xFF2c3e50)),
                          label: Text('Continents', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.flag, color: Colors.white),
                          selectedIcon: Icon(Icons.flag, color: Color(0xFF2c3e50)),
                          label: Text('Countries', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.supervisor_account, color: Colors.white),
                          selectedIcon: Icon(Icons.supervisor_account, color: Color(0xFF2c3e50)),
                          label: Text('Entities', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.event, color: Colors.white),
                          selectedIcon: Icon(Icons.event, color: Color(0xFF2c3e50)),
                          label: Text('Events', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.star, color: Colors.white),
                          selectedIcon: Icon(Icons.star, color: Color(0xFF2c3e50)),
                          label: Text('Galaxies', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.inventory, color: Colors.white),
                          selectedIcon: Icon(Icons.inventory, color: Color(0xFF2c3e50)),
                          label: Text('Items', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.language, color: Colors.white),
                          selectedIcon: Icon(Icons.language, color: Color(0xFF2c3e50)),
                          label: Text('Languages', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.terrain, color: Colors.white),
                          selectedIcon: Icon(Icons.terrain, color: Color(0xFF2c3e50)),
                          label: Text('Landforms', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.gavel, color: Colors.white),
                          selectedIcon: Icon(Icons.gavel, color: Color(0xFF2c3e50)),
                          label: Text('Laws', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.open_in_browser, color: Colors.white),
                          selectedIcon: Icon(Icons.open_in_browser, color: Color(0xFF2c3e50)),
                          label: Text('Multiverses', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.place, color: Colors.white),
                          selectedIcon: Icon(Icons.place, color: Color(0xFF2c3e50)),
                          label: Text('Places', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.landscape, color: Colors.white),
                          selectedIcon: Icon(Icons.landscape, color: Color(0xFF2c3e50)),
                          label: Text('Planets', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.flash_on, color: Colors.white),
                          selectedIcon: Icon(Icons.flash_on, color: Color(0xFF2c3e50)),
                          label: Text('Powers', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.people, color: Colors.white),
                          selectedIcon: Icon(Icons.people, color: Color(0xFF2c3e50)),
                          label: Text('Races', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.insights, color: Colors.white),
                          selectedIcon: Icon(Icons.timeline, color: Color(0xFF2c3e50)),
                          label: Text('Solar Systems', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.stars, color: Colors.white),
                          selectedIcon: Icon(Icons.stars, color: Color(0xFF2c3e50)),
                          label: Text('Stars', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.book, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Color(0xFF2c3e50)),
                          label: Text('Stories', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.title, color: Colors.white),
                          selectedIcon: Icon(Icons.title, color: Color(0xFF2c3e50)),
                          label: Text('Titles', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.public_off, color: Colors.white),
                          selectedIcon: Icon(Icons.public_off, color: Color(0xFF2c3e50)),
                          label: Text('Universes', style: TextStyle(color: Colors.white)),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.colorize, color: Colors.white),
                          selectedIcon: Icon(Icons.explore, color: Color(0xFF2c3e50)),
                          label: Text('Weapons', style: TextStyle(color: Colors.white)),
                        ),
                        // Add more NavigationRailDestination items as needed
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: const HomeDesktopContent(), // Replace with your content widget
                ),
              ],
            );
          } else {
            return Center(
              child: HomePhoneContent(),
            );
          }
        },
      ),
    );
  }
}