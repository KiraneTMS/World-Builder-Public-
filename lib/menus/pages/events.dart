import 'dart:async';
import 'package:flutter/material.dart';
import '../../data_manager/data_loader.dart';
import '../../data_manager/models.dart';

class EventDesktopPage extends StatefulWidget {
  @override
  _EventDesktopPageState createState() => _EventDesktopPageState();
}

class _EventDesktopPageState extends State<EventDesktopPage> {
  late Future<List<Event>> _eventsFuture;
  List<Event> _events = [];
  List<Event> _filteredEvents = [];
  TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;
  int _itemsPerPage = 0;
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  void initState() {
    super.initState();
    _eventsFuture = loadEvents();
    _eventsFuture.then((events) {
      setState(() {
        _events = events;
        _filteredEvents = events; // Initialize _filteredEvents with all events
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
        title: Text('Event List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Event>>(
                future: _eventsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading events: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No events found.'));
                  } else {
                    return Column(
                      children: [
                        Expanded(child: _buildEventGrid()),
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
          hintText: 'Enter event name...',
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
        _filteredEvents = _events.where((event) => event.name.toLowerCase().contains(query.toLowerCase())).toList();
        print('Search query: $query');
        print('Filtered events count: ${_filteredEvents.length}');
      } else {
        _filteredEvents = _events;
        print('Search query is empty, displaying all events.');
      }
      _currentPage = 0; // Reset to first page when search query changes
      print('Current page reset to $_currentPage');
      _applyFilters();
    });
  }

  void _applyFilters() {
    // This method is used to update the displayed events based on the current filters and pagination
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredEvents.length ? _filteredEvents.length : endIndex;
    setState(() {
      _filteredEvents = _filteredEvents.sublist(startIndex, endIndex);
    });
  }

  Widget _buildEventGrid() {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    endIndex = endIndex > _filteredEvents.length ? _filteredEvents.length : endIndex;
    List<Event> currentEvents = _filteredEvents.sublist(startIndex, endIndex);

    // Handle case where the current page might be out of bounds after filtering
    if (_filteredEvents.isNotEmpty && startIndex >= _filteredEvents.length) {
      _currentPage = (_filteredEvents.length / _itemsPerPage).ceil() - 1;
      startIndex = _currentPage * _itemsPerPage;
      endIndex = startIndex + _itemsPerPage;
      endIndex = endIndex > _filteredEvents.length ? _filteredEvents.length : endIndex;
      currentEvents = _filteredEvents.sublist(startIndex, endIndex);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: _childAspectRatio,
      ),
      itemCount: currentEvents.length,
      itemBuilder: (context, index) {
        Event event = currentEvents[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(Event event) {
    // Use the first image in the array, if any. Otherwise, use a default image.
    String imageUrl = event.image.isNotEmpty ? event.image[0] : '';

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
              event.name,
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
            Text('Date: ${event.date}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Participants: ${event.participants.join(', ')}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (_filteredEvents.length / _itemsPerPage).ceil();
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