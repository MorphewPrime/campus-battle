/* 
* filename: Verify.dart
* author: Peter Gessler
* date created: 10/13/22
* brief: verify if a user is in the database, and return to right screen
*/

import 'package:campusbattle/screens/game/map_main.dart';
import 'package:campusbattle/screens/welcome/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // async check for a user sign in instance
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GameMap(); // if user is in database, send to gamemap
          } else {
            return LoginScreen(); // is user is not in database, keep on Login Screen
          }
        },
      ),
    );
  }
}
