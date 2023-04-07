//UI element of item information
//USED IN: inventory_screen.dart

//
// modified: 4/07/2023
// By: Logan Anderson
// brief: changed UI to match other screens UI
//

import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:campusbattle/screens/game/profile/neu_box.dart';

class UserItemTile extends StatelessWidget {
  final String itemName;
  final int itemQuantity;
  //list of item images?
  final String itemDesc;

  UserItemTile({
    super.key,
    required this.itemName,
    required this.itemQuantity,
    required this.itemDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: NeuBox(
        color1: mainColor,
        color2: accentColor,
        color3: lightAccentColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                //"item image"
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sword_example_item.png'),
                    ),
                    // border: Border.all(color: Colors.lightBlue),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //"Item Name"
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          itemName,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      //"Item Description"
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          itemDesc,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'x${itemQuantity}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 227, 227, 227),
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
