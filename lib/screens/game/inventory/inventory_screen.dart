/* 
* filename: inventory_screen.dart
* author: Logan Anderson
* date created: 11/5/22
* brief: designs the inventory screen
*/

import 'package:campusbattle/screens/game/inventory/user_item_tile.dart';
import 'package:flutter/material.dart';


//main class for Inventory screen
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

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

  //List of Items - Will need to be replaced with user Item data from FireBase
  List itemList = [
    ["Sword", "Attacks Enemies - Does 2 Damage Per Hit", 3],
    ["Better Sword", "Attacks Enemies - Does 4 Damage Per Hit", 1],
    ["Another Sword", "Attacks", 5],
    ["Another Sword", "Attacks", 5],
    ["Another Sword", "Attacks", 5],
    ["Another Sword", "Attacks", 5],
    ["Another Sword", "Attacks", 5],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 88, 153, 239),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inventory"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xff0051ba),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder:(context, index) {
          return UserItemTile(
            itemName: itemList[index][0],
            itemQuantity: itemList[index][2], 
            itemDesc: itemList[index][1],
          );
        },
      ),
    );
  }
}
