/* 
* filename: welcome_screen.dart
* author: Logan Anderson
* date created: 10/4/22
* brief: designs the welcome screen - first screen on launch
*/

import 'package:flutter/material.dart';
import 'dart:async';

//main class for welcome screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

// Defines the body of the screen - cotinued in _BodyState
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

// Defines the body of the screen
class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    //set timer to go to the login screen after a couple seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        Navigator.pushNamed(context, '/loginScreen');
      });
    });
  }

  // Defines the actual screen
  @override
  Widget build(BuildContext context) {
    // Load image onto the welcome screen
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/spartan-mask-logo1.png',
                semanticLabel: 'Spartan Mask Logo',
                height: 400,
                width: 400,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// onPressed: () {
//                 Navigator.pushNamed(context, '/loginScreen');
//               },

