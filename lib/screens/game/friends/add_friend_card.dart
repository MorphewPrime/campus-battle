/* 
* filename: add_frend_card.dart
* author: Logan Anderson
* date created: 11/29/22
* brief: designs the add friend card
*/
//UI element of add friend screen
//USED IN: add_friends_screen.dart

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AddFriendCard extends StatelessWidget {
  final String friendName;
  final int friendLvl;
  //list of prof images?
  final color1;
  final color2;
  final color3;
  AddFriendCard({
    super.key,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.friendName,
    required this.friendLvl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: NeuBox(
        color1: mainColor,
        color2: accentColor,
        color3: lightAccentColor,
        child: ListTile(
          title: Text(
            friendName,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            'Level $friendLvl',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              //add friend to database
            },
            child: SizedBox(
              height: 50,
              width: 50,
              child: NeuBox(
                color1: mainColor,
                color2: accentColor,
                color3: lightAccentColor,
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
