// ignore_for_file: prefer_const_constructors

/* 
* filename: add_frends_screen.dart
* author: Logan Anderson
* date created: 11/28/22
* brief: designs the adding friends screen
*/

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../profile/neu_box.dart';
import 'add_friend_card.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

// Test class with friend data
class _AddFriendScreenState extends State<AddFriendScreen> {
  List addFriendsList = [
    ["Allen Iverson", 25],
    ["Dennis Rodman", 100],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
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
                ),
                const Expanded(
                  //add friend text
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                    child: Text(
                      "A D D    F R I E N D S",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: NeuBox(
                color1: mainColor,
                color2: accentColor,
                color3: lightAccentColor,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search By Email",
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
            ),
            //list view of found friends
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: addFriendsList.length,
                itemBuilder: (context, index) {
                  return AddFriendCard(
                    color1: mainColor,
                    color2: accentColor,
                    color3: lightAccentColor,
                    friendName: addFriendsList[index][0],
                    friendLvl: addFriendsList[index][1],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
