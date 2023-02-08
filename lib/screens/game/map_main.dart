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
*

* modified: 02/7/23
* By: Logan Anderson
* brief: Added more zones for different enemies.
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
  late BitmapDescriptor bananaIcon;
  late BitmapDescriptor virusIcon;
  late BitmapDescriptor bballIcon;
  late BitmapDescriptor brainIcon;
  late BitmapDescriptor calcIcon;
  late BitmapDescriptor robotIcon;
  late BitmapDescriptor fballIcon;

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

  //list of areas on campus to be mapped out
  List<LatLng> eng_points = [
    LatLng(38.958443842713194, -95.25499396950453),
    LatLng(38.957098806254166, -95.25498218000577),
    LatLng(38.95712717950423, -95.25219515938127),
    LatLng(38.95847971505341, -95.25226494148477),
  ];
  List<LatLng> bio_points = [
    LatLng(38.95533900578628, -95.249199601207),
    LatLng(38.956029247753726, -95.24917494510379),
    LatLng(38.95605481214193, -95.24732573736269),
    LatLng(38.955364570423484, -95.24732573736269),
  ];
  List<LatLng> fball_points = [
    LatLng(38.964226721442074, -95.24801970341801),
    LatLng(38.96182661104339, -95.24806882945164),
    LatLng(38.9618520768325, -95.24490838795441),
    LatLng(38.96426491882824, -95.24484288657622),
  ];
  List<LatLng> psych_points = [
    LatLng(38.95745221945791, -95.2442657581175),
    LatLng(38.95639531589266, -95.24391368820979),
    LatLng(38.95644625136576, -95.24308673331026),
    LatLng(38.957433118930936, -95.24307854563799),
    LatLng(38.957796028063086, -95.24361893200798),
  ];
  List<LatLng> bball_points = [
    LatLng(38.9548547544638, -95.2537929541689),
    LatLng(38.954829741193464, -95.25143950855737),
    LatLng(38.95356655956163, -95.25142342578553),
    LatLng(38.953529038970835, -95.25376078862524),
  ];
  List<LatLng> math_points = [
    LatLng(38.95839856272383, -95.24893146629574),
    LatLng(38.95882855452792, -95.24870184202882),
    LatLng(38.95905448137928, -95.24949381143924),
    LatLng(38.9587010148582, -95.24978435643006),
  ];
  List<LatLng> memunion_points = [
    LatLng(38.95883219852143, -95.24318617303469),
    LatLng(38.960140377812834, -95.24288625562482),
    LatLng(38.96021325617177, -95.24375320438773),
    LatLng(38.95897066989578, -95.24405780800711),
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

  //mapping imgs to pins
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
    //banana
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/banana-enemy.png')
        .then((onValue) {
      setState((() {
        bananaIcon = onValue;
      }));
    });
    //virus
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/virus-enemy.png')
        .then((onValue) {
      setState((() {
        virusIcon = onValue;
      }));
    });
    //bball
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/basketball-enemy.png')
        .then((onValue) {
      setState((() {
        bballIcon = onValue;
      }));
    });
    //brain
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/brain-enemy.png')
        .then((onValue) {
      setState((() {
        brainIcon = onValue;
      }));
    });
    //calc
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/calculator-enemy.png')
        .then((onValue) {
      setState((() {
        calcIcon = onValue;
      }));
    });
    //robot warrior
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/robot-warrior-enemy.png')
        .then((onValue) {
      setState((() {
        robotIcon = onValue;
      }));
    });
    //football enemy
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2.0, 2.0)),
            'assets/images/football-enemy.png')
        .then((onValue) {
      setState((() {
        fballIcon = onValue;
      }));
    });
  }

  void initialPinTests() {
    // polygons here for now
    _game_polygons.addAll([
      //engineering - robot char?
      Polygon(
        polygonId: PolygonId("p1"),
        points: eng_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //biology - virus character
      Polygon(
        polygonId: PolygonId("p2"),
        points: bio_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //football
      Polygon(
        polygonId: PolygonId("p3"),
        points: fball_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //psychology - brain character
      Polygon(
        polygonId: PolygonId("p4"),
        points: psych_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //bball
      Polygon(
        polygonId: PolygonId("p5"),
        points: bball_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //math
      Polygon(
        polygonId: PolygonId("p6"),
        points: math_points,
        strokeWidth: 1,
        strokeColor: Colors.black,
        fillColor: Colors.black.withOpacity(0.05),
      ),
      //food - union
      Polygon(
        polygonId: PolygonId("p7"),
        points: memunion_points,
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

    //game character pins
    _game_markers.addAll([
      Marker(
        markerId: MarkerId("Dragon"),
        position: LatLng(38.95791, -95.25358),
        icon: firePinIcon,
        onTap: () {
          Navigator.pushNamed(context, "/dragon");
        },
      ),
      //engineering character
      // Marker(
      //   markerId: MarkerId("Virus1"),
      //   position: LatLng(38.955619794191556, -95.24877858315892),
      //   icon: firePinIcon,
      //   onTap: () {
      //     Navigator.pushNamed(context, "/virus");
      //   },
      // ),
      Marker(
        markerId: const MarkerId("Minigame1"),
        position: const LatLng(38.95736666517465, -95.25335608680122),
        icon: robotIcon,
        onTap: () {
          Navigator.pushNamed(
              context, "/minigame1"); //this game is just placeholder
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
      ),

      //banana character
      Marker(
        markerId: MarkerId("Banana"),
        position: LatLng(38.95956598498723, -95.24342139484858),
        icon: bananaIcon,
        onTap: () {
          // Navigator.pushNamed(context, "/foodgame");
        },
      ),

      //virus character
      Marker(
        markerId: MarkerId("Virus"),
        position: LatLng(38.955519531910404, -95.24829149126616),
        icon: virusIcon,
        onTap: () {
          Navigator.pushNamed(context, "/virus");
        },
      ),

      //basketball character
      Marker(
        markerId: MarkerId("Basketball"),
        position: LatLng(38.95433532277486, -95.25273841585633),
        icon: bballIcon,
        onTap: () {
          // Navigator.pushNamed(context, "/bballgame");
        },
      ),

      //brain character
      Marker(
        markerId: MarkerId("Brain"),
        position: LatLng(38.95724922989544, -95.24356653149819),
        icon: brainIcon,
        onTap: () {
          // Navigator.pushNamed(context, "/psychgame");
        },
      ),

      //calc character
      Marker(
        markerId: MarkerId("Calc"),
        position: LatLng(38.95858706606061, -95.24919921612755),
        icon: calcIcon,
        onTap: () {
          // Navigator.pushNamed(context, "/mathgame");
        },
      ),

      //robot is up top

      //football character
      Marker(
        markerId: MarkerId("Football"),
        position: LatLng(38.96266119764685, -95.24633459833956),
        icon: fballIcon,
        onTap: () {
          Navigator.pushNamed(context, "/football");
        },
      ),
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
                          //context, '/loginScreen'); // for testing
                          context,
                          '/friends');
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
                            icon: firePinIcon,
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
                          //     // icon: firePinIcon,
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
                          //     // icon: firePinIcon,
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
                          //         icon: firePinIcon,
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
