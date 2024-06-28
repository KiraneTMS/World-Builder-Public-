import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class SolarSystemDesktopPage extends StatefulWidget {
  @override
  _SolarSystemDesktopPageState createState() => _SolarSystemDesktopPageState();
}

class _SolarSystemDesktopPageState extends State<SolarSystemDesktopPage> {
  late Future<List<SolarSystem>> _solarSystemsFuture;
  List<SolarSystem> _solarSystems = [];
  List<SolarSystem> _filteredSolarSystems = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _solarSystemsFuture = loadSolarSystems();
    _solarSystemsFuture.then((solarSystems) {
      setState(() {
        _solarSystems = solarSystems;
        _filteredSolarSystems = solarSystems;
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
        title: Text('Solar System List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<SolarSystem>>(
                future: _solarSystemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading solar systems: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No solar systems found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildSolarSystemGrid()),
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
          hintText: 'Enter solar system name...',
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
        _filteredSolarSystems = _solarSystems.where((solarSystem) => solarSystem.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredSolarSystems = _solarSystems;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredSolarSystems.length ? _filteredSolarSystems.length : endIndex;
    setState(() {
      _filteredSolarSystems = _filteredSolarSystems.sublist(startIndex, endIndex);
    });
  }

  Widget _buildSolarSystemGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredSolarSystems.length ? _filteredSolarSystems.length : endIndex;
    List<SolarSystem> currentSolarSystems = _filteredSolarSystems.sublist(startIndex, endIndex);

    if (_filteredSolarSystems.isNotEmpty && startIndex >= _filteredSolarSystems.length) {
      _currentPage = (_filteredSolarSystems.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredSolarSystems.length ? _filteredSolarSystems.length : endIndex;
      currentSolarSystems = _filteredSolarSystems.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentSolarSystems.length,
      itemBuilder: (context, index) {
        SolarSystem solarSystem = currentSolarSystems[index];
        return _buildSolarSystemCard(solarSystem);
      },
    );
  }

  Widget _buildSolarSystemCard(SolarSystem solarSystem) {
    String imageUrl = solarSystem.images.isNotEmpty ? solarSystem.images[0] : '';

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
              solarSystem.name,
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
                      'assets/images/unknown_icon.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
            SizedBox(height: 8.0),
            Text('Star: ${solarSystem.star.map((s) => s.name).join(", ")}', style: TextStyle(color: Colors.white)),
            Text('Planets: ${solarSystem.planets.join(", ")}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredSolarSystems.length / _itemsPerPage).ceil();
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
