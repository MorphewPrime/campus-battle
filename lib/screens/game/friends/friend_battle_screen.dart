/* 
* filename: frend_battle_screen.dart
* author: Logan Anderson
* date created: 11/29/22
* brief: designs the multiplayer battle screen
*/

import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FriendBattleScreen extends StatefulWidget {
  const FriendBattleScreen({super.key});

  @override
  State<FriendBattleScreen> createState() => _FriendBattleScreenState();
}

class _FriendBattleScreenState extends State<FriendBattleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              //back button
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(
                          color1: mainColor,
                          color2: accentColor,
                          color3: lightAccentColor,
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
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
