import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_builder/menus/detail_pages/character.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class CharacterPage extends StatefulWidget {
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late Future<List<Character>> _charactersFuture;
  List<Character> _characters = [];
  List<Character> _filteredCharacters = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _charactersFuture = loadCharacters();
    _charactersFuture.then((characters) {
      setState(() {
        _characters = characters;
        _filteredCharacters = characters; // Initialize _filteredCharacters with all characters
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
        title: Text('Character List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Character>>(
                future: _charactersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading characters: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No characters found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildCharacterGrid()),
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
          hintText: 'Enter character name...',
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
        _filteredCharacters = _characters.where((character) => character.name.toLowerCase().contains(query.toLowerCase())).toList();
        print('Search query: $query');
        print('Filtered characters count: ${_filteredCharacters.length}');
      } else {
        _filteredCharacters = _characters;
        print('Search query is empty, displaying all characters.');
      }
      _currentPage = 0; // Reset to first page when search query changes
      print('Current page reset to $_currentPage');
    });
  }

  Widget _buildCharacterGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredCharacters.length ? _filteredCharacters.length : endIndex;
    List<Character> currentCharacters = _filteredCharacters.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredCharacters.isNotEmpty && startIndex >= _filteredCharacters.length) {
      _currentPage = (_filteredCharacters.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredCharacters.length ? _filteredCharacters.length : endIndex;
      currentCharacters = _filteredCharacters.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentCharacters.length,
      itemBuilder: (context, index) {
        Character character = currentCharacters[index];
        return _buildCharacterCard(character);
      },
    );
  }

  Widget _buildCharacterCard(Character character) {
    // Use the first image in the array, if any. Otherwise, use a default image.
    String imageUrl = character.image.isNotEmpty ? character.image[0] : '';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CharacterDetailPage(character: character),
            //   ),
            // );
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
                  character.name,
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
                Text('Title: ${character.title.isNotEmpty ? character.title[0] : '???'}',
                  style: TextStyle(color: Colors.white),),
                Text('Race: ${character.race.join(', ')}',
                  style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredCharacters.length / _itemsPerPage).ceil();
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