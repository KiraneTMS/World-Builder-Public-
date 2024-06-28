import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class TitlesDesktopPage extends StatefulWidget {
  @override
  _TitlesDesktopPageState createState() => _TitlesDesktopPageState();
}

class _TitlesDesktopPageState extends State<TitlesDesktopPage> {
  late Future<List<Titles>> _titlesFuture;
  List<Titles> _titles = [];
  List<Titles> _filteredTitles = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _titlesFuture = loadTitles();
    _titlesFuture.then((titles) {
      setState(() {
        _titles = titles;
        _filteredTitles = titles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      _itemsPerPage = 12;
      _itemPerRows = 3;
      _childAspectRatio = 3;
    } else {
      _itemsPerPage = 6;
      _itemPerRows = 1;
      _childAspectRatio = 3;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('Titles List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Titles>>(
                future: _titlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading titles: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No titles found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildTitleGrid()),
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
          hintText: 'Enter title...',
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
        _filteredTitles = _titles.where((title) => title.title.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredTitles = _titles;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredTitles.length ? _filteredTitles.length : endIndex;
    setState(() {
      _filteredTitles = _filteredTitles.sublist(startIndex, endIndex);
    });
  }

  Widget _buildTitleGrid() {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = _applyPagination(startIndex);
    final currentTitles = _filteredTitles.sublist(startIndex, endIndex);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentTitles.length,
      itemBuilder: (context, index) => _buildTitleCard(currentTitles[index]),
    );
  }

  int _applyPagination(int startIndex) {
    final endIndex = startIndex + _itemsPerPage;
    return endIndex > _filteredTitles.length ? _filteredTitles.length : endIndex;
  }

  Widget _buildTitleCard(Titles title) => Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    color: const Color(0xFF34495e),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8.0),
          Expanded(child: Text(title.description, style: const TextStyle(color: Colors.white))),
        ],
      ),
    ),
  );


  Widget _buildPagination() {
    int totalPages = (_filteredTitles.length / _itemsPerPage).ceil();
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
