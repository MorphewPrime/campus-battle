// Filename: engGame.dart
// Creation Date: 4/9/23
// Author: Logan Anderson
// Brief: This file creates the engineering game

import 'dart:async';
import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

class EngGame extends StatelessWidget {
  const EngGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyEngGame(),
    );
  }
}

class MyEngGame extends StatefulWidget {
  const MyEngGame({Key? key}) : super(key: key);

  @override
  State<MyEngGame> createState() => _MyEngGameState();
}

class _MyEngGameState extends State<MyEngGame> {
  int _score = 0; // Initialize score to zero

  //increases the user's score
  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Engineering'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 26, 44, 61),
      ),
      backgroundColor: Color.fromARGB(255, 29, 28, 28),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Get 10 to win!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Score: $_score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
