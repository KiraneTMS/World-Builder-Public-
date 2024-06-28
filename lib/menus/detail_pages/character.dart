// import 'package:flutter/material.dart';
// import 'package:world_builder/data_manager/models.dart';

// class CharacterDetailPage extends StatelessWidget {
//   final Character character; // Assume you pass the Character object to this screen

//   CharacterDetailPage({required this.character});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Character Detail: ${character.name}'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Powers:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             _buildPowersByType(character.powers),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPowersByType(List<Power> powers) {
//     Map<String, List<Power>> powersByType = {};

//     // Group powers by type
//     powers.forEach((power) {
//       // Print the entire Power object
//       print("Power Object: $power");

//       // Check for missing type property (Optional)
//       if (power.type != null) {
//         print("Power Type: ${power.type}");
//       } else {
//         print("Power Missing Type!");
//       }

//       if (!powersByType.containsKey(power.type)) {
//         powersByType[power.type] = [];
//       }
//       powersByType[power.type]!.add(power);
//     });

//     // Build widgets for each type
//     List<Widget> typeWidgets = [];

//     powersByType.forEach((type, powerList) {
//       typeWidgets.add(Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$type:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 5),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: powerList.map((power) => _buildPowerItem(power)).toList(),
//           ),
//           SizedBox(height: 10),
//         ],
//       ));
//     });

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: typeWidgets,
//     );
//   }

//   Widget _buildPowerItem(Power power) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '- ${power.name}',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5),
//         Text(power.description),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }