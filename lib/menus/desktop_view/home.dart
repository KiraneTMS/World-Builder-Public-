// home_desktop_content.dart
import 'package:flutter/material.dart';
import '../../data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class HomeDesktopContent extends StatelessWidget {
  const HomeDesktopContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2c3e50),
      appBar: AppBar(
        title: Text('World Builder'),
        backgroundColor: Color(0xFF34495e),
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
            final List<Story> stories = snapshot.data![0];
            final List<Universe> universes = snapshot.data![1];
            final List<Multiverse> multiverses = snapshot.data![2];

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

  Widget _buildStoriesSection(List<Story> stories) {
    return _buildGridSection<Story>(
      items: stories,
      itemBuilder: (story) => _buildGridItem(
        title: story.name,
        description: story.description,
        imageUrl: story.image.isNotEmpty ? story.image[0] : 'assets/images/unknown_icon.png',
      ),
    );
  }

  Widget _buildUniversesSection(List<Universe> universes) {
    return _buildGridSection<Universe>(
      items: universes,
      itemBuilder: (universe) => _buildGridItem(
        title: universe.name,
        description: universe.description,
        imageUrl: universe.image,
      ),
    );
  }

  Widget _buildMultiversesSection(List<Multiverse> multiverses) {
    return _buildGridSection<Multiverse>(
      items: multiverses,
      itemBuilder: (multiverse) => _buildGridItem(
        title: multiverse.name,
        description: multiverse.description,
        imageUrl: multiverse.image,
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
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
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
              ? Image.asset(
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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