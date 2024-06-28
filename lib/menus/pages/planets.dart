import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class PlanetDesktopPage extends StatefulWidget {
  @override
  _PlanetDesktopPageState createState() => _PlanetDesktopPageState();
}

class _PlanetDesktopPageState extends State<PlanetDesktopPage> {
  late Future<List<Planet>> _planetsFuture;
  List<Planet> _planets = [];
  List<Planet> _filteredPlanets = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _planetsFuture = loadPlanets();
    _planetsFuture.then((planets) {
      setState(() {
        _planets = planets;
        _filteredPlanets = planets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      _itemsPerPage = 9;
      _itemPerRows = 3;
      _childAspectRatio = 0.8;
    } else {
      _itemsPerPage = 6;
      _itemPerRows = 2;
      _childAspectRatio = 0.7;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('Planet List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Planet>>(
                future: _planetsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading planets: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No planets found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildPlanetGrid()),
                        _buildPagination(),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Enter planet name...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: _performSearch,
      ),
    );
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _filteredPlanets = _planets.where((planet) => planet.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredPlanets = _planets;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    // This method is used to update the displayed planets based on the current filters and pagination
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredPlanets.length ? _filteredPlanets.length : endIndex;
    setState(() {
      _filteredPlanets = _filteredPlanets.sublist(startIndex, endIndex);
    });
  }

  Widget _buildPlanetGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredPlanets.length ? _filteredPlanets.length : endIndex;
    List<Planet> currentPlanets = _filteredPlanets.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredPlanets.isNotEmpty && startIndex >= _filteredPlanets.length) {
      _currentPage = (_filteredPlanets.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredPlanets.length ? _filteredPlanets.length : endIndex;
      currentPlanets = _filteredPlanets.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentPlanets.length,
      itemBuilder: (context, index) {
        Planet planet = currentPlanets[index];
        return _buildPlanetCard(planet);
      },
    );
  }

  Widget _buildPlanetCard(Planet planet) {
    // Use the first image in the array, if any. Otherwise, use a default image.
    String imageUrl = planet.image.isNotEmpty ? planet.image[0] : '';

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Color(0xFF34495e),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planet.name,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset(
                      'assets/images/unknown_icon.png', // Default image path
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
            SizedBox(height: 8.0),
            Text('Type: ${planet.type}', style: TextStyle(color: Colors.white)),
            Text('Radius: ${planet.radius} km', style: TextStyle(color: Colors.white)),
            Text('Mass: ${planet.mass} kg', style: TextStyle(color: Colors.white)),
            if (planet.habitable) Text('Habitable: Yes', style: TextStyle(color: Colors.greenAccent)),
            if (!planet.habitable) Text('Habitable: No', style: TextStyle(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredPlanets.length / _itemsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _currentPage == 0
              ? null
              : () {
                  setState(() {
                    _currentPage--;
                    _applyFilters();
                  });
                },
        ),
        Text('Page ${_currentPage + 1} of $totalPages', style: TextStyle(color: Colors.white)),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: _currentPage + 1 == totalPages
              ? null
              : () {
                  setState(() {
                    _currentPage++;
                    _applyFilters();
                  });
                },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}