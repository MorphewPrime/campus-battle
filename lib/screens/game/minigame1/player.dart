import 'package:flutter/material.dart';
import 'dart:math';

class MyPlayer extends StatelessWidget {
  final int robotSpriteCount;
  final String robotDirection;

  MyPlayer({required this.robotSpriteCount, required this.robotDirection});

  @override
  Widget build(BuildContext context) {
    if (robotDirection == 'right') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 100,
        width: 100,
        child: Image.asset(
            'assets/images/robotSprite/Run ($robotSpriteCount).png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center, //rotates the robot
        transform: Matrix4.rotationY(pi),
        child: Container(
            alignment: Alignment.bottomCenter,
            height: 100,
            width: 100,
            child: Image.asset(
                'assets/images/robotSprite/Run ($robotSpriteCount).png')),
      );
    }
  }
}
