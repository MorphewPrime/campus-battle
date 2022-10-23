/* 
* filename: tour_panorama.dart
* author: Jackson Morphew
* date created: 10/21/22
* brief: 360 panorama view for tour mode.
*/

import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sprung/sprung.dart';
import 'dart:async';

//main class
class TourPanorama extends StatelessWidget {
  const TourPanorama({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _lon = 0;
  double _lat = 0;
  double _tilt = 0;
  int _panoId = 0;
  bool infoWindowOpen = false;

  List<Image> panoImages = [
    Image.asset('assets/images/panoramas/test_pan.jpeg'),
  ];

  void onViewChanged(longitude, latitude, tilt) {
    setState(() {
      _lon = longitude * 25;
      _lat = latitude * 25;
      _tilt = tilt * 25;
    });
  }

  Widget hotspotButton(
      {String? text, IconData? icon, VoidCallback? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        text != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(text)),
              )
            : Container(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(children: <Widget>[
          Panorama(
            // sensorControl: SensorControl.Orientation,
            onViewChanged: onViewChanged,
            sensitivity: 2,
            onTap: (longitude, latitude, tilt) {
              print('onTap: $longitude, $latitude, $tilt');
              setState(() {
                infoWindowOpen = false;
              });
            },
            onLongPressStart: (longitude, latitude, tilt) =>
                print('onLongPressStart: $longitude, $latitude, $tilt'),
            onLongPressMoveUpdate: (longitude, latitude, tilt) =>
                print('onLongPressMoveUpdate: $longitude, $latitude, $tilt'),
            onLongPressEnd: (longitude, latitude, tilt) =>
                print('onLongPressEnd: $longitude, $latitude, $tilt'),
            child: Image.asset('assets/images/panoramas/test_pan.jpeg'),
            hotspots: [
              Hotspot(
                latitude: -15.0,
                longitude: -129.0,
                width: 90,
                height: 75,
                widget: hotspotButton(
                    text: "Next scene",
                    icon: Icons.open_in_browser,
                    onPressed: () => setState(() => _panoId++)),
              ),
              Hotspot(
                latitude: -42.0,
                longitude: -46.0,
                width: 60.0,
                height: 60.0,
                widget: hotspotButton(
                    icon: Icons.search,
                    onPressed: () => setState(() => _panoId = 2)),
              ),
              Hotspot(
                latitude: -33.0,
                longitude: 123.0,
                width: 60.0,
                height: 60.0,
                widget:
                    hotspotButton(icon: Icons.arrow_upward, onPressed: () {}),
              ),
            ],
          ),
          Visibility(
            visible: infoWindowOpen,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                // alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  // color: Colors.white,
                  curve: Sprung.criticallyDamped,
                  duration: Duration(milliseconds: 750),
                  alignment:
                      infoWindowOpen ? Alignment.topCenter : Alignment(0, 2),
                  // margin: EdgeInsets.symmetric(vertical: 50),
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    constraints: BoxConstraints.expand(),
                    child: Text("Ellooo"),
                  ),
                  // child: IntrinsicHeight(
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: <Widget>[
                  //       Container(
                  //         width: ,
                  //         color: Colors.white,
                  //       )
                  //     ],
                  //   ),
                  // )),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !infoWindowOpen,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  backgroundColor: Color(0xff0051ba),
                  onPressed: () {
                    setState(
                      () {
                        infoWindowOpen = true;
                      },
                    );
                  },
                  child: Icon(FontAwesomeIcons.info),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                backgroundColor: Color(0xff0051ba),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(FontAwesomeIcons.arrowLeft),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
