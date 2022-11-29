/* 
* filename: frends_screen.dart
* author: Logan Anderson
* date created: 11/28/22
* brief: designs the friends/community screen
*/

//still needs to be done:
// search bar?
//database integration

import 'package:campusbattle/screens/game/friends/friend_card.dart';
import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List friendsList = [
    ["Spud Webb", 25],
    ["Jason Williams", 100],
    ["Charles Barkley", 50],
    ["Scottie Pippen", 25],
    ["John Stockton", 100],
    ["Penny Hardaway", 50],
  ];

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
                  const Expanded(
                    //friend text
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 55, 0),
                      child: Text(
                        "F R I E N D S",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //add friend button
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),
                      // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: InkWell(
                        onTap: () {
                          //add friend screen
                          Navigator.pushNamed(context, '/addFriend');
                        },
                        child: Center(
                          child: Text(
                            "Add Friend",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //list view of friends
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: friendsList.length,
                      itemBuilder: (context, index) {
                        return FriendCard(
                          color1: mainColor,
                          color2: accentColor,
                          color3: lightAccentColor,
                          friendName: friendsList[index][0],
                          friendLvl: friendsList[index][1],
                        );
                      },
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
