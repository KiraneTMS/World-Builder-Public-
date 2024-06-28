import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/menus/detail_pages/armor.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class ArmorPage extends StatefulWidget {
  @override
  _ArmorPageState createState() => _ArmorPageState();
}

class _ArmorPageState extends State<ArmorPage> {
  late Future<List<Armor>> _armorsFuture;
  List<Armor> _armors = [];
  List<Armor> _filteredArmors = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _armorsFuture = loadArmors();
    _armorsFuture.then((armors) {
      setState(() {
        _armors = armors;
        _filteredArmors = armors; // Initialize _filteredArmors with all armors
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
        title: Text('Armor List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Armor>>(
                future: _armorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading armors: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No armors found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildArmorGrid()),
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
          hintText: 'Enter armor name...',
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
        _filteredArmors = _armors.where((armor) => armor.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredArmors = _armors;
      }
      _currentPage = 0; // Reset to first page when search query changes
    });
  }

  Widget _buildArmorGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredArmors.length ? _filteredArmors.length : endIndex;
    List<Armor> currentArmors = _filteredArmors.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredArmors.isNotEmpty && startIndex >= _filteredArmors.length) {
      _currentPage = (_filteredArmors.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredArmors.length ? _filteredArmors.length : endIndex;
      currentArmors = _filteredArmors.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentArmors.length,
      itemBuilder: (context, index) {
        Armor armor = currentArmors[index];
        return _buildArmorCard(context, armor);
      },
    );
  }

  Widget _buildArmorCard(BuildContext context, Armor armor) {
    String imageUrl = armor.image.isNotEmpty ? armor.image[0] : '';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArmorDetailPage(armor: armor),
            ),
          );
        },
        child: Card(
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
                  armor.name,
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
                Text(
                  'Type: ${armor.type}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Slot: ${armor.slot}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredArmors.length / _itemsPerPage).ceil();
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
                  });
                },
        ),
        Text('Page ${_currentPage + 1} of $totalPages'),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: _currentPage + 1 == totalPages
              ? null
              : () {
                  setState(() {
                    _currentPage++;
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