/* 
* filename: map_main.dart
* author: Logan Anderson/Jackson Morphew
* date created: 09/28/22
* brief: main file for the map screen of the game
*/

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

//state of the game map page
//created by Jackson Morphew
//revised by Logan Anderson
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

  final List<Marker> _markers = <Marker>[];

  // method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            //back button that may be temporary
            onPressed: () {
              Navigator.pushNamed(context, '/loginScreen');
            },
          ),
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          markers: Set<Marker>.of(_markers),
          onMapCreated: _onMapCreated,
          rotateGesturesEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            getUserCurrentLocation().then((value) async {
              print(
                  value.latitude.toString() + " " + value.longitude.toString());

              // marker added for current users location
              _markers.add(Marker(
                markerId: MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ));
            });
          },
          child: Icon(Icons.local_activity),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
