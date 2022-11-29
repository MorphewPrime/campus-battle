/* 
* filename: profile_screen.dart
* author: Logan Anderson
* date created: 11/9/22
* brief: designs the profile screen
*/

import 'dart:math';

import 'package:campusbattle/screens/game/profile/achievement_card.dart';
import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants.dart';

// import 'package:flutter_neumorphic/flutter_neumorphic.dart'; //may use this

//main class for profile screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //List of profile information - Will need to be replaced with user data from FireBase
  //itemList[0] = profile pic
  //[1] = xp level
  //[2] = username
  //these 2 lists are temporary
  List profList = [
    ['assets/images/profileIcons/dwight.jpg', 40, "Dwight"],
  ];
  List challengeList = [
    ["This is a challenge that needs to be done to get xp", 25],
    ["This is a challenge that needs to be done to get xp", 100],
    ["This is a challenge that needs to be done to get xp", 50],
    ["This is a challenge that needs to be done to get xp", 1000],
  ];
  //THESE COMMENTS CAN BE DELETED, BUT FORMULA TO GET LEVEL IS xpLvl IF YOU WANT TO USE IT
  // int xpAmount = 1000; //temp
  // var xpLvl = 1;
  // xpLvl = (0.09 * sqrt(xpAmount)).round(); //formula to get a level
  // amountUntilNextLevel = pow((xpLvl / 0.09), 2).round();
  // percentUntilNextLevel =
  // amountUntilNextLevel / (pow(((xpLvl + 1) / 0.09), 2));
  // var mainColor = Color.fromARGB(255, 99, 164, 255);
  // var accentColor = const Color.fromARGB(255, 10, 38, 154);
  // var lightAccentColor = Color.fromARGB(255, 146, 215, 255);

  // var mainColor = const Color.fromARGB(255, 224, 223, 217);
  // var accentColor = const Color.fromARGB(255, 151, 150, 131);
  // var lightAccentColor = const Color.fromARGB(255, 255, 255, 255);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            //back button and profile text
            Padding(
              //back button
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
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
                    //profile text
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                      child: Text(
                        "P R O F I L E",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //profile card
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeuBox(
                    //image
                    color1: mainColor,
                    color2: accentColor,
                    color3: lightAccentColor,
                    isCircular: true,
                    neuWidth: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.asset(
                          'assets/images/profileIcons/dwight.jpg', //need to get this from user image
                          height: 150,
                          width: 150),
                    ),
                  ),
                  Text(
                    profList[0][2],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),

            //xp bar
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Text('LVL ${profList[0][1]}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
                  child: NeuBox(
                    color1: mainColor,
                    color2: accentColor,
                    color3: lightAccentColor,
                    child: LinearPercentIndicator(
                      lineHeight: 10,
                      percent: 0.5, //will be variable depending on user xp
                      progressColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            //achievement list
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 1,
              indent: 25,
              endIndent: 25,
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Text("A C H I E V E M E N T S"),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: challengeList.length,
                      itemBuilder: (context, index) {
                        return AchievementCard(
                          color1: mainColor,
                          color2: accentColor,
                          color3: lightAccentColor,
                          chalDesc: challengeList[index][0],
                          chalXP: challengeList[index][1],
                          chalComplete: 4,
                          chalTotal: 5,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
