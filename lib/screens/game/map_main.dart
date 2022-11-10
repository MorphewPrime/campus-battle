/* 
* filename: map_main.dart
* author: Logan Anderson/Jackson Morphew
* date created: 09/28/22
* brief: main file for the map screen of the game

* modified: 10/19/22
* By: Jackson Morphew
* brief: added 3 state toggle switch and 3 buttons to map view.

* modified: 10/21/22
* By: Jackson Morphew
* brief: implementd marker fliter toggle switch.
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
  late BitmapDescriptor firePinIcon;
  late BitmapDescriptor enemy_sprite_1;
  late BitmapDescriptor tourPinIcon;

  final LatLng _center = const LatLng(38.95753752147627, -95.25334374853665);
  final double toggleWidth = 45.0;
  final double toggleHeight = 35.0;
  int initialToggleIndex = 1;

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
  final List<Circle> _game_circles = <Circle>[];
  final List<Polygon> _game_polygons = <Polygon>[];

  List<Marker> _markers = <Marker>[];
  List<Circle> _circles = <Circle>[];
  List<Polygon> _polygons = <Polygon>[];

  List<LatLng> eng_points = [
    LatLng(38.958443842713194, -95.25499396950453),
    LatLng(38.957098806254166, -95.25498218000577),
    LatLng(38.95712717950423, -95.25219515938127),
    LatLng(38.95847971505341, -95.25226494148477),
  ];

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
        firePinIcon = onValue;
      }));
    });

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(1.0, 1.0)),
            'assets/images/KnightSampleSprite.png')
        .then((onValue) {
      setState((() {
        enemy_sprite_1 = onValue;
      }));
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/tour_icon_test_128.png')
        .then((onValue) {
      setState((() {
        tourPinIcon = onValue;
      }));
    });
  }

  void initialPinTests() {
    // polygons here for now
    _game_polygons.addAll([
      Polygon(
        polygonId: PolygonId("p1"),
        points: eng_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
    ]);
    // circles here for now
    _game_circles.addAll([
      Circle(
        circleId: CircleId("c1"),
        center: LatLng(38.95775992604587, -95.25366028493514),
        radius: 20,
        strokeWidth: 2,
        strokeColor: Colors.purple,
        fillColor: Colors.purple.withOpacity(0.10),
      ),
      Circle(
        circleId: CircleId("hello"),
        center: LatLng(38.95769192604987, -95.25396028413514),
        radius: 20,
        strokeWidth: 2,
        strokeColor: Colors.purple,
        fillColor: Colors.purple.withOpacity(0.10),
      ),
    ]);

    _game_markers.addAll([
      Marker(
        markerId: MarkerId("Dragon"),
        position: LatLng(38.95791, -95.25358),
        icon: firePinIcon,
        onTap: () {
          Navigator.pushNamed(context, "/dragon");
        },
      ),
      Marker(
        markerId: const MarkerId("Minigame1"),
        position: const LatLng(38.9576, -95.25358),
        icon: enemy_sprite_1,
        onTap: () {
          Navigator.pushNamed(context, "/minigame1");
        },
      ),
      Marker(
        markerId: MarkerId("0"),
        position: LatLng(38.95740934721012, -95.25396526603686),
        icon: firePinIcon,
        infoWindow: InfoWindow(
          title: 'My Current Location',
        ),
        // onTap: () {
        //   Navigator.pushNamed(context, '/tourView');
        // },
      )
    ]);

    _tour_markers.addAll([
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(38.957748500041866, -95.25377502156772),
        icon: tourPinIcon,
        onTap: () {
          Navigator.pushNamed(context, '/tourView');
        },
      ),
      Marker(
        markerId: MarkerId("2"),
        position: LatLng(38.957514603816435, -95.25270779228276),
        icon: tourPinIcon,
        onTap: () {
          Navigator.pushNamed(context, '/tourView');
        },
      ),
    ]);

    _markers = _tour_markers + _game_markers;
    _circles = _game_circles;
    _polygons = _game_polygons;
  }

  void filterMarkers(index) {
    List<Marker> temp_marker = [];
    List<Circle> temp_circle = [];
    List<Polygon> temp_polygon = [];
    if (index == 0) {
      temp_marker = _game_markers;
      temp_circle = _game_circles;
      temp_polygon = _game_polygons;
    } else if (index == 2) {
      temp_marker = _tour_markers;
    } else {
      temp_marker = _game_markers + _tour_markers;
      temp_circle = _game_circles;
      temp_polygon = _game_polygons;
    }
    setState(() {
      _markers = temp_marker;
      _circles = temp_circle;
      _polygons = temp_polygon;
      initialToggleIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              //back button that may be temporary
              onPressed: () {
                Navigator.pushNamed(context, '/loginScreen');
              },
            ),
            title: const Text('Maps Sample App'),
            backgroundColor: Color(0xff0051ba),
          ),
          body: GoogleMap(
            markers: Set<Marker>.of(_markers),
            circles: Set<Circle>.of(_circles),
            polygons: Set<Polygon>.of(_polygons),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height + 20, left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff0051ba),
                    onPressed: () async {
                      Navigator.pushNamed(
                          context, '/loginScreen'); // for testing
                    },
                    child: Icon(FontAwesomeIcons.plus),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height + 20, right: 10),
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
                        borderColor: [Color(0xff0051ba)],
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
                        backgroundColor: Color(0xff0051ba),
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
                    backgroundColor: Color(0xff0051ba),
                    onPressed: () {
                      //Didn't want to mess with this: - Just left commented for now - working profile code is below
                      // getUserCurrentLocation().then((value) async {
                      //   print(value.latitude.toString() +
                      //       " " +
                      //       value.longitude.toString());

                      //   // marker added for current users location
                      //   setState(() {
                      //     _game_markers.add(Marker(
                      //       markerId: MarkerId(value.latitude.toString()),
                      //       position: LatLng(value.latitude, value.longitude),
                      //       icon: firePinIcon,
                      //       infoWindow: InfoWindow(
                      //         title: 'My Current Location',
                      //       ),
                      //       // onTap: () {
                      //       //   Navigator.pushNamed(context, '/tourView');
                      //       // },
                      //     ));

                      //     // _tour_markers.addAll([
                      //     //   Marker(
                      //     //     markerId: MarkerId("2"),
                      //     //     position: LatLng(38.957115, -95.254390),
                      //     //     // icon: firePinIcon,
                      //     //     // infoWindow: InfoWindow(
                      //     //     //   title: 'My Current Location',
                      //     //     // ),
                      //     //     onTap: () {
                      //     //       Navigator.pushNamed(context, '/tourView');
                      //     //     },
                      //     //   ),
                      //     //   Marker(
                      //     //     markerId: MarkerId("2"),
                      //     //     position: LatLng(38.957115, -95.254390),
                      //     //     // icon: firePinIcon,
                      //     //     // infoWindow: InfoWindow(
                      //     //     //   title: 'My Current Location',
                      //     //     // ),
                      //     //     onTap: () {
                      //     //       Navigator.pushNamed(context, '/tourView');
                      //     //     },
                      //     //   ),
                      //     // ]);

                      //     _markers += _game_markers;
                      //     // _markers = _markers +
                      //     //     [
                      //     //       Marker(
                      //     //         markerId: MarkerId(value.latitude.toString()),
                      //     //         position:
                      //     //             LatLng(value.latitude, value.longitude),
                      //     //         icon: firePinIcon,
                      //     //         // infoWindow: InfoWindow(
                      //     //         //   title: 'My Current Location',
                      //     //         // ),
                      //     //         onTap: () {
                      //     //           Navigator.pushNamed(context, '/tourView');
                      //     //         },
                      //     //       )
                      //     //     ];
                      //   }); // setState
                      // });
                      Navigator.pushNamed(context, '/profile');
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
                    backgroundColor: Color(0xff0051ba),
                    onPressed: () {
                      Navigator.pushNamed(context, '/inventory');
                    },
                    child: const Icon(FontAwesomeIcons.bagShopping),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
