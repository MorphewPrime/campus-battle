// Filename: engGame.dart
// Creation Date: 4/9/23
// Author: Logan Anderson
// Brief: This file creates the engineering game
// The grid idea and a couple other aspects
// of this game were taken from a youtube video
// about a space invaders game
// -> Link: https://www.youtube.com/watch?v=8OSxUlwRDoM&list=PLlvRDpXh1Se6kipeBLiF1xByAEmxYie6J&index=11

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
  //dialogue stuff
  bool _showDialog = true;
  void _onBeginGamePressed() {
    setState(() {
      _showDialog = false;
      startGame();
    });
    startGame();
  }

  //initializing variables
  static int charPos = 530;
  static int enemyPos = 10;
  int numOfSquares = 540;

  //may use these
  static bool enemyGotHit = false;
  static bool playerGotHit = false;

  //deal with targets to capture
  static var randomNum = Random();
  int target = randomNum.nextInt(400) + 100;

  static List<int> playerLoc = [
    charPos,
  ];

  void generateNewTarget() {
    target = randomNum.nextInt(400) + 100;
  }

  //everything that should happen upon start
  void startGame() {
    charPos = 530;
    const duration = const Duration(milliseconds: 700);
    Timer.periodic(duration, (timer) {
      enemyMoves();
    });
  }

  //movement of characters code
  String direction = 'left';
  void enemyMoves() {
    setState(() {
      if ((enemyPos - 1) % 20 == 0) {
        direction = 'right';
      } else if ((enemyPos + 2) % 20 == 0) {
        direction = 'left';
      }

      if (direction == 'right') {
        enemyPos += 1;
      } else {
        enemyPos -= 1;
      }
    });
  }

  void moveLeft() {
    setState(() {
      charPos -= 1;
    });
  }

  void moveRight() {
    setState(() {
      charPos += 1;
    });
  }

  void moveUp() {
    setState(() {
      charPos -= 20;
    });
  }

  void moveDown() {
    setState(() {
      charPos += 20;
    });
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you ready?'),
      elevation: 1,
      content: const Text('Get 5 green squares to win'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _onBeginGamePressed,
          child: const Text('Begin'),
        ),
      ],
    );
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
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            if (_showDialog) _buildDialog(context),
            Flexible(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: numOfSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20),
                itemBuilder: (BuildContext context, int index) {
                  if (index == charPos) {
                    //if the player square, color white
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  if (index == enemyPos) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(color: Colors.red),
                      ),
                    );
                  } else if (index == target) {
                    //if its the target square
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.green)),
                    );
                  } else {
                    //if its just a square
                    return Container(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(color: Colors.grey[900])),
                    );
                  }
                },
              ),
            ),
            //controls
            Container(
              height: 150,
              color: Colors.grey[800],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          // Handle up arrow button press
                          moveUp();
                        },
                        icon: Icon(Icons.arrow_drop_up),
                        iconSize: 50,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          // Handle left arrow button press
                          moveLeft();
                        },
                        icon: Icon(Icons.arrow_left),
                        iconSize: 50,
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle down arrow button press
                          moveDown();
                        },
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 50,
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle right arrow button press
                          moveRight();
                        },
                        icon: Icon(Icons.arrow_right),
                        iconSize: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
