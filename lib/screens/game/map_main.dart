/* 
* filename: map_main.dart
* author: Logan Anderson/Jackson Morphew
* date created: 09/28/22
* brief: main file for the map screen of the game
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//main class for game map screen
class GameMap extends StatelessWidget {
  const GameMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyGameMap(),
    );
  }
}

class MyGameMap extends StatefulWidget {
  const MyGameMap({Key? key}) : super(key: key);

  @override
  State<MyGameMap> createState() => _MyGameMapState();
}

class _MyGameMapState extends State<MyGameMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(38.957111, -95.254387);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // mapController.mapId = '';
    String mapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
                Navigator.pushNamed(context, '/loginScreen');
              },
          ),
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          rotateGesturesEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18,
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //         Navigator.pushNamed(context, '/loginScreen');
        //       },
        //   tooltip: 'back button',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}