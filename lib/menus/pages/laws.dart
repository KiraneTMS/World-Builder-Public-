import 'dart:async';
import 'package:flutter/material.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class LawDesktopPage extends StatefulWidget {
  @override
  _LawDesktopPageState createState() => _LawDesktopPageState();
}

class _LawDesktopPageState extends State<LawDesktopPage> {
  late Future<List<Law>> _lawsFuture;
  List<Law> _laws = [];
  List<Law> _filteredLaws = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;

  @override
  void initState() {
    super.initState();
    _lawsFuture = loadLaws();
    _lawsFuture.then((laws) {
      setState(() {
        _laws = laws;
        _filteredLaws = laws; // Initialize _filteredLaws with all laws
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      _itemsPerPage = 12;
    } else {
      _itemsPerPage = 6;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('Laws'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Law>>(
                future: _lawsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading laws: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No laws found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildLawList()),
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
          hintText: 'Enter law name...',
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
        _filteredLaws = _laws.where((law) => law.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredLaws = _laws;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    // This method is used to update the displayed laws based on the current filters and pagination
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLaws.length ? _filteredLaws.length : endIndex;
    setState(() {
      _filteredLaws = _filteredLaws.sublist(startIndex, endIndex);
    });
  }

  Widget _buildLawList() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLaws.length ? _filteredLaws.length : endIndex;
    List<Law> currentLaws = _filteredLaws.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredLaws.isNotEmpty && startIndex >= _filteredLaws.length) {
      _currentPage = (_filteredLaws.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredLaws.length ? _filteredLaws.length : endIndex;
      currentLaws = _filteredLaws.sublist(startIndex, endIndex);
    }

    return ListView.builder(
      itemCount: currentLaws.length,
      itemBuilder: (context, index) {
        Law law = currentLaws[index];
        return _buildLawCard(law);
      },
    );
  }

  Widget _buildLawCard(Law law) {
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
              law.name,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8.0),
            Text('Category: ${law.category}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredLaws.length / _itemsPerPage).ceil();
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