import 'dart:async';
import 'package:flutter/material.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class LanguageDesktopPage extends StatefulWidget {
  @override
  _LanguageDesktopPageState createState() => _LanguageDesktopPageState();
}

class _LanguageDesktopPageState extends State<LanguageDesktopPage> {
  late Future<List<Language>> _languagesFuture;
  List<Language> _languages = [];
  List<Language> _filteredLanguages = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _languagesFuture = loadLanguages();
    _languagesFuture.then((languages) {
      setState(() {
        _languages = languages;
        _filteredLanguages = languages;
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
        title: Text('Language List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Language>>(
                future: _languagesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading languages: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No languages found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildLanguageGrid()),
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
          hintText: 'Enter language name...',
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
        _filteredLanguages = _languages.where((language) => language.name.toLowerCase().contains(query.toLowerCase())).toList();
      } else {
        _filteredLanguages = _languages;
      }
      _currentPage = 0; // Reset to first page when search query changes
      _applyFilters();
    });
  }

  void _applyFilters() {
    // This method is used to update the displayed languages based on the current filters and pagination
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLanguages.length ? _filteredLanguages.length : endIndex;
    setState(() {
      _filteredLanguages = _filteredLanguages.sublist(startIndex, endIndex);
    });
  }

  Widget _buildLanguageGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredLanguages.length ? _filteredLanguages.length : endIndex;
    List<Language> currentLanguages = _filteredLanguages.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredLanguages.isNotEmpty && startIndex >= _filteredLanguages.length) {
      _currentPage = (_filteredLanguages.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredLanguages.length ? _filteredLanguages.length : endIndex;
      currentLanguages = _filteredLanguages.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentLanguages.length,
      itemBuilder: (context, index) {
        Language language = currentLanguages[index];
        return _buildLanguageCard(language);
      },
    );
  }

  Widget _buildLanguageCard(Language language) {
    // Use the first image in the array, if any. Otherwise, use a default image.
    String imageUrl = language.image.isNotEmpty ? language.image[0] : '';

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
              language.name,
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
            Text('Language Family: ${language.languageFamily}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredLanguages.length / _itemsPerPage).ceil();
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