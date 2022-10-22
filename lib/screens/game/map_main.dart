/* 
* filename: map_main.dart
* author: Logan Anderson/Jackson Morphew
* date created: 09/28/22
* brief: main file for the map screen of the game

* modified: 10/19/22
* By: Jackson Morphew
* brief: added 3 state toggle switch and 3 buttons to map view.
*/

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  late BitmapDescriptor pinLocationIcon;

  final LatLng _center = const LatLng(38.957111, -95.254387);
  final double toggleWidth = 45.0;
  final double toggleHeight = 35.0;
  int initialToggleIndex = 2;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // mapController.mapId = '';
    String mapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(mapStyle);
  }

  void _zoomToCurrentLocation() async {
    // final GoogleMapController controller = await controller.future;
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(value.latitude, value.longitude),
          zoom: 18.0,
        ),
      ));
    });
  }

  final List<Marker> _tour_markers = <Marker>[];
  final List<Marker> _game_markers = <Marker>[];

  List<Marker> _markers = <Marker>[];

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
  void initState() {
    setIcons().then((onValue) {
      initialPinTests(); // temp funtion to test setting pins initially. eventually DB will populate.
    });
  }

  Future<void> setIcons() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/icon_test_128.png')
        .then((onValue) {
      setState((() {
        pinLocationIcon = onValue;
      }));
    });
  }

  void initialPinTests() {
    _game_markers.add(Marker(
      markerId: MarkerId("0"),
      position: LatLng(38.957111, -95.254397),
      icon: pinLocationIcon,
      infoWindow: InfoWindow(
        title: 'My Current Location',
      ),
      // onTap: () {
      //   Navigator.pushNamed(context, '/tourView');
      // },
    ));

    _tour_markers.addAll([
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(38.957115, -95.254360),
        // icon: pinLocationIcon,
        // infoWindow: InfoWindow(
        //   title: 'My Current Location',
        // ),
        onTap: () {
          Navigator.pushNamed(context, '/tourView');
        },
      ),
      Marker(
        markerId: MarkerId("2"),
        position: LatLng(38.957119, -95.254319),
        // icon: pinLocationIcon,
        // infoWindow: InfoWindow(
        //   title: 'My Current Location',
        // ),
        onTap: () {
          Navigator.pushNamed(context, '/tourView');
        },
      ),
    ]);

    _markers = _tour_markers + _game_markers;
  }

  void filterMarkers(index) {
    List<Marker> temp;
    if (index == 0) {
      temp = _game_markers;
    } else if (index == 2) {
      temp = _tour_markers;
    } else {
      temp = _game_markers + _tour_markers;
    }
    setState(() {
      _markers = temp;
      initialToggleIndex = index;
    });
  }

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
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 18,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height + 45, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/loginScreen'); // for testing
                  },
                  child: Icon(FontAwesomeIcons.plus),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height + 45, right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.right,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ToggleSwitch(
                      minWidth: toggleWidth,
                      minHeight: toggleHeight,
                      initialLabelIndex: initialToggleIndex,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 3,
                      icons: [
                        FontAwesomeIcons.feather,
                        FontAwesomeIcons.circleDot,
                        FontAwesomeIcons.binoculars,
                      ],
                      iconSize: 30.0,
                      borderWidth: 2.0,
                      borderColor: [Colors.blueGrey],
                      activeBgColors: [
                        [Colors.redAccent],
                        [Colors.green],
                        [Colors.blueAccent]
                      ],
                      // changeOnTap: true,
                      onToggle: (index) {
                        print('switched to: $index');
                        filterMarkers(index);
                      },
                    ),
                    FloatingActionButton(
                      onPressed: _zoomToCurrentLocation,
                      child: Icon(FontAwesomeIcons.locationCrosshairs),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: () async {
                    getUserCurrentLocation().then((value) async {
                      print(value.latitude.toString() +
                          " " +
                          value.longitude.toString());

                      // marker added for current users location
                      setState(() {
                        _game_markers.add(Marker(
                          markerId: MarkerId(value.latitude.toString()),
                          position: LatLng(value.latitude, value.longitude),
                          icon: pinLocationIcon,
                          infoWindow: InfoWindow(
                            title: 'My Current Location',
                          ),
                          // onTap: () {
                          //   Navigator.pushNamed(context, '/tourView');
                          // },
                        ));

                        // _tour_markers.addAll([
                        //   Marker(
                        //     markerId: MarkerId("2"),
                        //     position: LatLng(38.957115, -95.254390),
                        //     // icon: pinLocationIcon,
                        //     // infoWindow: InfoWindow(
                        //     //   title: 'My Current Location',
                        //     // ),
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/tourView');
                        //     },
                        //   ),
                        //   Marker(
                        //     markerId: MarkerId("2"),
                        //     position: LatLng(38.957115, -95.254390),
                        //     // icon: pinLocationIcon,
                        //     // infoWindow: InfoWindow(
                        //     //   title: 'My Current Location',
                        //     // ),
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/tourView');
                        //     },
                        //   ),
                        // ]);

                        _markers += _game_markers;
                        // _markers = _markers +
                        //     [
                        //       Marker(
                        //         markerId: MarkerId(value.latitude.toString()),
                        //         position:
                        //             LatLng(value.latitude, value.longitude),
                        //         icon: pinLocationIcon,
                        //         // infoWindow: InfoWindow(
                        //         //   title: 'My Current Location',
                        //         // ),
                        //         onTap: () {
                        //           Navigator.pushNamed(context, '/tourView');
                        //         },
                        //       )
                        //     ];
                      }); // setState
                    });
                  },
                  child: Icon(FontAwesomeIcons.userLarge),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _zoomToCurrentLocation,
                  child: Icon(FontAwesomeIcons.bagShopping),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
