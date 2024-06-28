// home_desktop_content.dart
import 'package:flutter/material.dart';
import '../../data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class HomeDesktopContent extends StatelessWidget {
  HomeDesktopContent({Key? key}) : super(key: key);
  int _itemPerRows = 0;
  double _childAspectRatio = 0;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      _itemPerRows = 3;
      _childAspectRatio = 0.8;
    } else {
      _itemPerRows = 2;
      _childAspectRatio = 0.7;
    }
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('World Builder'),
        backgroundColor: Color.fromARGB(255, 214, 214, 214),
      ),
      body: FutureBuilder(
        future: Future.wait([
          loadStoriesHome(),
          loadUniversesHome(),
          loadMultiversesHome(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<HomeStory> stories = snapshot.data![0];
            final List<HomeUniverse> universes = snapshot.data![1];
            final List<HomeMultiverse> multiverses = snapshot.data![2];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Stories'),
                  _buildStoriesSection(stories),
                  SizedBox(height: 20),
                  _buildSectionTitle('Universes'),
                  _buildUniversesSection(universes),
                  SizedBox(height: 20),
                  _buildSectionTitle('Multiverses'),
                  _buildMultiversesSection(multiverses),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStoriesSection(List<HomeStory> stories) {
    return _buildGridSection<HomeStory>(
      items: stories,
      itemBuilder: (story) => _buildGridItem(
        title: story.name,
        description: story.description,
        imageUrl: story.image.isNotEmpty ? story.image[0] : 'assets/images/unknown_icon.png',
      ),
    );
  }

  Widget _buildUniversesSection(List<HomeUniverse> universes) {
    return _buildGridSection<HomeUniverse>(
      items: universes,
      itemBuilder: (universe) => _buildGridItem(
        title: universe.name,
        description: universe.description,
        imageUrl: universe.image.isNotEmpty ? universe.image[0] : '',
      ),
    );
  }

  Widget _buildMultiversesSection(List<HomeMultiverse> multiverses) {
    return _buildGridSection<HomeMultiverse>(
      items: multiverses,
      itemBuilder: (multiverse) => _buildGridItem(
        title: multiverse.name,
        description: multiverse.description,
        imageUrl: multiverse.image.isNotEmpty ? multiverse.image[0] : '',
      ),
    );
  }

  Widget _buildGridSection<T>({
    required List<T> items,
    required Widget Function(T) itemBuilder,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _itemPerRows,
        childAspectRatio: _childAspectRatio,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index]);
      },
    );
  }

  Widget _buildGridItem({
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Card(
      color: Color(0xFF34495e),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: imageUrl.isNotEmpty   // Check if imageUrl is not empty
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: TextStyle(color: Colors.white70),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}