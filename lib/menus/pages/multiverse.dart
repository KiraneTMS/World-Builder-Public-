import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_builder/data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class MultiverseDesktopPage extends StatefulWidget {
  @override
  _MultiverseDesktopPageState createState() => _MultiverseDesktopPageState();
}

class _MultiverseDesktopPageState extends State<MultiverseDesktopPage> {
  late Future<List<Multiverse>> _multiversesFuture;
  List<Multiverse> _multiverses = [];
  List<Multiverse> _filteredMultiverses = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;

  @override
  void initState() {
    super.initState();
    _multiversesFuture = loadMultiverses(); // Initialize the future here
    _multiversesFuture.then((multiverses) {
      setState(() {
        _multiverses = multiverses;
        _filteredMultiverses = List.from(_multiverses); // Initialize filtered list with all multiverses
      });
    }).catchError((error) {
      print('Error loading multiverses: $error');
      // Handle error loading multiverses
    });
    _searchController.addListener(_performSearch);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      _itemsPerPage = 6;
    } else {
      _itemsPerPage = 3;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('Multiverses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Multiverse>>(
                future: _multiversesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading multiverses: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No multiverses found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildMultiverseList()),
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
          hintText: 'Enter multiverse name...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  void _performSearch() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isNotEmpty) {
        _filteredMultiverses = _multiverses.where((multiverse) => multiverse.name.toLowerCase().contains(query)).toList();
      } else {
        _filteredMultiverses = List.from(_multiverses); // Reset to all multiverses when search is empty
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredMultiverses.length ? _filteredMultiverses.length : endIndex;
    setState(() {
      _filteredMultiverses = _filteredMultiverses.sublist(startIndex, endIndex);
    });
  }

  Widget _buildMultiverseList() {
    return ListView.builder(
      itemCount: _filteredMultiverses.length,
      itemBuilder: (context, index) {
        Multiverse multiverse = _filteredMultiverses[index];
        return _buildMultiverseCard(multiverse);
      },
    );
  }

  Widget _buildMultiverseCard(Multiverse multiverse) {
  String imageUrl = multiverse.image.isNotEmpty ? multiverse.image[0] : '';

  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: Color(0xFF34495e),
    child: SizedBox(
      height: 300, // Set a fixed height for the Card widget (adjust as needed)
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              multiverse.name ?? 'Unknown',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100, // Set a fixed height for the image (adjust as needed)
                    )
                  : Image.asset(
                      'assets/images/unknown_icon.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100, // Set a fixed height for the image (adjust as needed)
                    ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Creator: ${multiverse.creator != null ? multiverse.creator.name ?? 'Unknown' : 'Unknown'}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildPagination() {
    int totalPages = (_filteredMultiverses.length / _itemsPerPage).ceil();
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