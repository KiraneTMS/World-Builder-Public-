import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class WeaponsDesktopPage extends StatefulWidget {
  @override
  _WeaponsDesktopPageState createState() => _WeaponsDesktopPageState();
}

class _WeaponsDesktopPageState extends State<WeaponsDesktopPage> {
  late Future<List<Weapon>> _weaponsFuture;
  List<Weapon> _weapons = [];
  List<Weapon> _filteredWeapons = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _weaponsFuture = loadWeapons();
    _weaponsFuture.then((weapons) {
      setState(() {
        _weapons = weapons;
        _filteredWeapons = weapons;
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
        title: Text('Weapon List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Weapon>>(
                future: _weaponsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading weapons: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No weapons found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildWeaponGrid()),
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
          hintText: 'Enter weapon name...',
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
        _filteredWeapons = _weapons.where((weapon) => weapon.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredWeapons = _weapons;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredWeapons.length ? _filteredWeapons.length : endIndex;
    setState(() {
      _filteredWeapons = _filteredWeapons.sublist(startIndex, endIndex);
    });
  }

  Widget _buildWeaponGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredWeapons.length ? _filteredWeapons.length : endIndex;
    List<Weapon> currentWeapons = _filteredWeapons.sublist(startIndex, endIndex);

    if (_filteredWeapons.isNotEmpty && startIndex >= _filteredWeapons.length) {
      _currentPage = (_filteredWeapons.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredWeapons.length ? _filteredWeapons.length : endIndex;
      currentWeapons = _filteredWeapons.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentWeapons.length,
      itemBuilder: (context, index) {
        Weapon weapon = currentWeapons[index];
        return _buildWeaponCard(weapon);
      },
    );
  }

  Widget _buildWeaponCard(Weapon weapon) {
    String imageUrl = weapon.image.isNotEmpty ? weapon.image[0] : '';

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
              weapon.name,
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
            Text('Type: ${weapon.type}', style: TextStyle(color: Colors.white)),
            Text('Tier: ${weapon.tier}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredWeapons.length / _itemsPerPage).ceil();
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