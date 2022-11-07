//UI element of item information
//USED IN: inventory_screen.dart

import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xff0051ba),
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
                        color: Color.fromARGB(255, 227, 227, 227),
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
                        color: Color.fromARGB(255, 227, 227, 227),
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
    );
  }
}
