//This is a temporary file - just learning

import 'dart:async';

import 'package:campusbattle/screens/game/minigame1/button.dart';
import 'package:campusbattle/screens/game/minigame1/player.dart';
import 'package:flutter/material.dart';

class EnemyBattle1 extends StatelessWidget {
  const EnemyBattle1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  //robot Sprite
  int robotSpriteCount = 1;
  double robotPosX = 0.0;
  double robotPosY = 1.0;
  String robotDirection = 'left';
  bool isJumping = false;

  void gravity() {
    //if bottom of sprite is not on ground or platform, then fall down
    var ran = 0;
    Timer.periodic(Duration(milliseconds: 50), (gravtimer) {
      if (spriteOnGround() || spriteOnPlatform()) {
        gravtimer.cancel();
      } else {
        setState(() {
          ran += 1;
          if (ran < 3) {
            robotPosY += 0.01;
          } else if (ran < 5) {
            robotPosY += 0.02;
          } else if (ran < 8) {
            robotPosY += 0.04;
          } else {
            robotPosY += 0.06;
          }
        });
      }
    });
  }

  bool spriteOnGround() {
    if (robotPosY > 0.998) {
      return true;
    } else {
      return false;
    }
  }

  bool spriteOnPlatform() {
    return false;
  }

  bool gameWon() {
    return false;
  }

  bool gameLost() {
    return false;
  }

  void jump() {
    setState(() {
      isJumping = true;
    });
    Timer(const Duration(milliseconds: 900), () {
      setState(() {
        isJumping = false;
      });
    });
    var ran = 0;
    Timer.periodic(const Duration(milliseconds: 25), (jumptimer) {
      setState(() {
        ran += 1;
        if (ran < 3) {
          robotPosY -= 0.01;
        } else if (ran < 5) {
          robotPosY -= 0.015;
        } else if (ran < 8) {
          robotPosY -= 0.02;
        } else if (ran < 11) {
          robotPosY -= 0.02;
        } else if (ran < 14) {
          robotPosY -= 0.015;
        } else if (ran < 17) {
          robotPosY -= 0.01;
        } else {
          gravity();
          jumptimer.cancel();
        }
      });
    });
  }

  void moveLeft() {
    var temp = 0;
    Timer.periodic(const Duration(milliseconds: 25), (leftTimer) {
      temp += 1;
      setState(() {
        if (temp > 5) {
          leftTimer.cancel();
        }
        robotSpriteCount++; //changes pic to next frame
        robotDirection = 'left';
        robotPosX -= 0.03;

        if (robotSpriteCount == 5) {
          robotSpriteCount = 1;
        }
      });
    });
  }

  void moveRight() {
    var temp = 0;
    Timer.periodic(const Duration(milliseconds: 25), (leftTimer) {
      temp += 1;
      setState(() {
        if (temp > 5) {
          leftTimer.cancel();
        }
        robotSpriteCount++; //changes pic to next frame
        robotDirection = 'right';
        robotPosX += 0.03;

        if (robotSpriteCount == 5) {
          robotSpriteCount = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('minigame example'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff0051ba),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/spaceBackground.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(robotPosX, robotPosY),
                    child: MyPlayer(
                      robotDirection: robotDirection,
                      robotSpriteCount: robotSpriteCount,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              color: Colors.red[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: MyButton(
                      function: () {
                        moveLeft();
                      },
                      text: 'LEFT',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: MyButton(
                      function: () {
                        if (!isJumping) {
                          jump();
                        }
                      },
                      text: 'JUMP',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: MyButton(
                      function: () {
                        moveRight();
                      },
                      text: 'RIGHT',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
