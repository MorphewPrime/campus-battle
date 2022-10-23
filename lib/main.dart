/* 
* filename: main.dart
* author: Logan Anderson
* date created: 09/24/22
* brief: main file - runs the project

* modified: 10/13/22
* By: Peter Gessler
* brief: added Firebase functionality to the app
*/

import 'package:campusbattle/constants.dart';
import 'package:campusbattle/screens/game/map_main.dart';
import 'package:campusbattle/screens/tour/tour_panorama.dart';
import 'package:campusbattle/screens/welcome/create_account_screen.dart';
import 'package:campusbattle/screens/welcome/welcome_screen.dart';
import 'package:campusbattle/screens/game/enemy_battle_1.dart';
import 'package:flutter/material.dart';
import 'package:campusbattle/screens/welcome/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

//main() runs MyApp which builds the application
void main() async {
  // ensure firebase gets setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // build the app
  runApp(MyApp());
}

//MyApp builds the root of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //runs a widget that builds the app
    return MaterialApp(
      //MaterialApp is the main widget that holds other widgets
      debugShowCheckedModeBanner: false,
      title: 'Campus Battle',
      theme: ThemeData(
        primaryColor: cPrimaryColor,
        scaffoldBackgroundColor: const Color(0xFFFFFDE9),
      ),
      initialRoute:
          '/welcScreen', //tells program which screen to start with on launch
      routes: {
        '/welcScreen': (context) => const WelcomeScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/createAccount': (context) => const CreateAccount(),
        '/gameMap': (context) => const GameMap(),
        '/tourView': (context) => const TourPanorama(),
        '/battle1': (context) => EnemyBattle1(),
      },
    );
  }
}
