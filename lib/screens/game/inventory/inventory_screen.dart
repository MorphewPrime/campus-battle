/* 
* filename: inventory_screen.dart
* author: Logan Anderson
* date created: 11/5/22
* brief: designs the inventory screen

* modified: 11/07/22
* By: Jackson Morphew
* brief: added ability to pull itmes to display from the Firestore database.
*/

import 'package:campusbattle/screens/game/inventory/user_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  Future loadItems() async {
    // QuerySnapshot<Map<String, dynamic>> test = await FirebaseFirestore.instance
    //     .collection("user_items")
    //     .where("user_ref", isEqualTo: "5u4ixGmerHeSxmK6AEtKDm4pXfV2")
    //     .get();
    // print(test.);
    // return test;
    return await FirebaseFirestore.instance
        .collection("items")
        // .where("rarity", isEqualTo: "4")
        .get();
  }

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
      body: FutureBuilder(
        future: loadItems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                // here only return is missing
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data.docs[index];
                    return UserItemTile(
                      itemName: document['name'],
                      itemQuantity: document['quantity'],
                      itemDesc: document['description'],
                    );
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Text('no data');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
