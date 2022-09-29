/* 
* filename: map_main.dart
* author: Logan Anderson
* date created: 09/28/22
* brief: main file for the map screen of the game
*/

import 'package:flutter/material.dart';

//main class for game map screen 
//right now it just has back button
class GameMap extends StatelessWidget {
  const GameMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/loginScreen');
          }, 
          child: const Text('Back'),
        ),
      )
    );
  }
}