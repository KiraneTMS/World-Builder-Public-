import 'package:flutter/material.dart';
import '../../data_manager/models.dart';
import '../../data_manager/data_loader.dart';

class HomePhoneContent extends StatelessWidget {
  const HomePhoneContent({Key? key}) : super(key: key);

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
                  SizedBox(height: 10),
                  _buildStoriesSection(stories),
                  SizedBox(height: 20),
                  _buildSectionTitle('Universes'),
                  SizedBox(height: 10),
                  _buildUniversesSection(universes),
                  SizedBox(height: 20),
                  _buildSectionTitle('Multiverses'),
                  SizedBox(height: 10),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStoriesSection(List<Story> stories) {
    return Column(
      children: stories.map((story) {
        return _buildListItem(
          title: story.name,
          description: story.description,
          imageUrl: story.image.isNotEmpty ? story.image[0] : 'assets/images/unknown_icon.png',
        );
      }).toList(),
    );
  }

  Widget _buildUniversesSection(List<Universe> universes) {
    return Column(
      children: universes.map((universe) {
        return _buildListItem(
          title: universe.name,
          description: universe.description,
          imageUrl: universe.image,
        );
      }).toList(),
    );
  }

  Widget _buildMultiversesSection(List<Multiverse> multiverses) {
    return Column(
      children: multiverses.map((multiverse) {
        return _buildListItem(
          title: multiverse.name,
          description: multiverse.description,
          imageUrl: multiverse.image,
        );
      }).toList(),
    );
  }

  Widget _buildListItem({
    required String title,
    required String description,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        color: Color(0xFF34495e),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageUrl.isNotEmpty
                      ? AssetImage(imageUrl)
                      : AssetImage('assets/images/unknown_icon.png'),
                  fit: BoxFit.cover,
                ),
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
      ),
    );
  }
}