import 'dart:async';
import 'package:flutter/material.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class LandformDesktopPage extends StatefulWidget {
  @override
  _LandformDesktopPageState createState() => _LandformDesktopPageState();
}

class _LandformDesktopPageState extends State<LandformDesktopPage> {
  late Future<List<Landform>> _landformsFuture;
  List<Landform> _landforms = [];
  List<Landform> _filteredLandforms = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _landformsFuture = loadLandforms();
    _landformsFuture.then((landforms) {
      setState(() {
        _landforms = landforms;
        _filteredLandforms = landforms; // Initialize _filteredLandforms with all landforms
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
        title: Text('Landform List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Landform>>(
                future: _landformsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading landforms: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No landforms found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildLandformGrid()),
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
          hintText: 'Enter landform name...',
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
        _filteredLandforms = _landforms.where((landform) => landform.name.toLowerCase().contains(query.toLowerCase())).toList();
        print('Search query: $query');
        print('Filtered landforms count: ${_filteredLandforms.length}');
      } else {
        _filteredLandforms = _landforms;
        print('Search query is empty, displaying all landforms.');
      }
      _currentPage = 0; // Reset to first page when search query changes
      print('Current page reset to $_currentPage');
      _applyFilters();
    });
  }

  void _applyFilters() {
    // This method is used to update the displayed landforms based on the current filters and pagination
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLandforms.length ? _filteredLandforms.length : endIndex;
    setState(() {
      _filteredLandforms = _filteredLandforms.sublist(startIndex, endIndex);
    });
  }

  Widget _buildLandformGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLandforms.length ? _filteredLandforms.length : endIndex;
    List<Landform> currentLandforms = _filteredLandforms.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredLandforms.isNotEmpty && startIndex >= _filteredLandforms.length) {
      _currentPage = (_filteredLandforms.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredLandforms.length ? _filteredLandforms.length : endIndex;
      currentLandforms = _filteredLandforms.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentLandforms.length,
      itemBuilder: (context, index) {
        Landform landform = currentLandforms[index];
        return _buildLandformCard(landform);
      },
    );
  }

  Widget _buildLandformCard(Landform landform) {
    // Use the image if provided, otherwise use a default image
    String imageUrl = landform.image.isNotEmpty ? landform.image[0] : 'assets/images/unknown_icon.png';

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
              landform.name,
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
            Text('Type: ${landform.type}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Continents: ${landform.continents.join(', ')}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredLandforms.length / _itemsPerPage).ceil();
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