import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:world_builder/data_manager/models.dart';
import 'package:world_builder/utils/ImageUtils.dart';

class ArmorDetailPage extends StatelessWidget {
  final Armor armor;

  ArmorDetailPage({required this.armor});

  Widget buildShortDivider() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 100,
        height: 1,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(armor.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  // Armor name
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      armor.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  buildShortDivider(),

                  // Armor description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      armor.description,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                  buildShortDivider(),

                  // Armor materials
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Materials:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
                        for (var material in armor.materials) Text('- $material', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                      ],
                    ),
                  ),
                  buildShortDivider(),

                  // Armor abilities
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Abilities:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
                        for (var ability in armor.abilities)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text('- ${ability.name}', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 5),
                              Text('${ability.description}', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right side
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  // Character image carousel
                  armor.image.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 3,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                      ),
                      items: armor.image.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return FutureBuilder(
                              future: ImageUtils.getImageSize(imageUrl), // Using the function from ImageUtils
                              builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                  Size imageSize = snapshot.data!;
                                  double aspectRatio = imageSize.width / imageSize.height;

                                  return AspectRatio(
                                    aspectRatio: aspectRatio,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            );
                          },
                        );
                      }).toList(),
                    )
                      : Image.asset(
                          'assets/images/unknown_icon.png', // Default image path
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                  Divider(color: Colors.white, thickness: 1),

                  // Armor details in table format with borders
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Table(
                      border: null,
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Name:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.name, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Current Owner:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.currentOwner, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Type:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.type, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Slot:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.slot, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Tier:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.tier, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Creator:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(armor.creator, style: TextStyle(fontSize: 16.0, color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF34495e),
    );
  }
}