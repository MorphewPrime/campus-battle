//UI element of item information
//USED IN: inventory_screen.dart

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:campusbattle/screens/game/profile/neu_box.dart';
import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final String chalDesc;
  final int chalXP;
  //list of item images?
  final int chalTotal;
  final int chalComplete;
  final bool isClaimable;
  final color1;
  final color2;
  final color3;
  AchievementCard({
    super.key,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.chalDesc,
    required this.chalXP,
    required this.chalTotal,
    required this.chalComplete,
    this.isClaimable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: NeuBox(
        color1: color1,
        color2: color2,
        color3: color3,
        child: Container(
          height: 65,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: color1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              //chalDesc
              Expanded(
                child: Container(
                    child: Text(
                  chalDesc,
                  textAlign: TextAlign.left,
                )),
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${chalXP}xp",
                    ),
                    Text("${chalComplete}/${chalTotal}"),
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
