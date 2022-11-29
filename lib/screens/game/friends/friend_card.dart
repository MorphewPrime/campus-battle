/* 
* filename: frend_card.dart
* author: Logan Anderson
* date created: 11/28/22
* brief: designs the friend card
*/
//UI element of friend screen
//USED IN: friends_screen.dart

// ignore_for_file: unnecessary_brace_in_string_interps

//still needs to be done:
//remove friend functionality within database?
//battle screen

import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String friendName;
  final int friendLvl;
  //list of prof images?
  final color1;
  final color2;
  final color3;
  FriendCard({
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
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: NeuBox(
        color1: color1,
        color2: color2,
        color3: color3,
        child: Container(
          height: 65,
          padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
          decoration: BoxDecoration(
            // color: color1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        friendName,
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Level $friendLvl",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              //battle and remove
              SizedBox(
                height: 70,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: InkWell(
                          onTap: () {
                            //battle screen
                            Navigator.pushNamed(context, '/friendBattle');
                          },
                          child: SizedBox(
                            height: 20,
                            width: 60,
                            child: Center(
                              child: Text(
                                "Battle",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                        // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: InkWell(
                          onTap: () {
                            //remove friend
                          },
                          child: SizedBox(
                            height: 20,
                            width: 60,
                            child: Center(
                              child: Text(
                                "Remove",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
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
      ),
    );
  }
}
