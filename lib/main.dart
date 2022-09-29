/* 
* filename: main.dart
* author: Logan Anderson
* date created: 09/24/22
* brief: main file - runs the project
*/

import 'package:campusbattle/constants.dart';
import 'package:campusbattle/screens/game/map_main.dart';
import 'package:campusbattle/screens/welcome/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:campusbattle/screens/welcome/login_screen.dart';

//main() runs MyApp which builds the application
void main() {
  runApp(const MyApp());
}

//MyApp builds the root of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {    //runs a widget that builds the app
    return MaterialApp(     //MaterialApp is the main widget that holds other widgets
      debugShowCheckedModeBanner: false,
      title: 'Campus Battle',
      theme: ThemeData(
        primaryColor: cPrimaryColor,
        scaffoldBackgroundColor: const Color(0xFFFFFDE9),   
      ),
      //home: const LoginScreen(),     //tells program what screen shows up on app launch
      initialRoute: '/loginScreen',
      routes: {
        '/loginScreen': (context) => const LoginScreen(),
        '/createAccount': (context) => const CreateAccount(),
        '/gameMap': (context) => const GameMap(),
      },
    );
  }
}
