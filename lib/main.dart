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
import 'package:campusbattle/screens/game/dragon.dart';
import 'package:campusbattle/screens/game/virus.dart';
import 'package:campusbattle/screens/game/football.dart';
import 'package:campusbattle/screens/game/friends/add_friends_screen.dart';
import 'package:campusbattle/screens/game/friends/friend_battle_screen.dart';
import 'package:campusbattle/screens/game/inventory/inventory_screen.dart';
import 'package:campusbattle/screens/game/map_main.dart';
import 'package:campusbattle/screens/game/mathgame/mathgame_screen.dart';
import 'package:campusbattle/screens/game/minigame1/minigame_1_screen.dart';
import 'package:campusbattle/screens/tour/tour_panorama.dart';
import 'package:campusbattle/screens/welcome/create_account_screen.dart';
import 'package:campusbattle/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:campusbattle/screens/welcome/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:flame/game.dart';

import 'screens/game/friends/friends_screen.dart';
import 'screens/game/profile/profile_screen.dart';

//main() runs MyApp which builds the application
void main() async {
  // ensure firebase gets setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffe8000d),
      systemNavigationBarDividerColor: Color(0xffffc82d)));

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
        '/dragon': (context) => const DragonW(),
        '/virus': (context) => const VirusW(),
        '/football': (context) => const FootballW(),
        '/inventory': (context) => const InventoryScreen(),
        '/minigame1': (context) => const EnemyBattle1(),
        '/profile': (context) => const ProfileScreen(),
        '/friends': (context) => const FriendsScreen(),
        '/addFriend': (context) => const AddFriendScreen(),
        '/friendBattle': (context) => const FriendBattleScreen(),
        '/mathgame': (context) => const MathGame(),
      },
    );
  }
}

//MyApp2 shortcuts to the game map screen for returning from the game view
class MyApp2 extends StatelessWidget {
  MyApp2(int status, {super.key}) {
    if (status == 1) {}
  }

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
          '/gameMap', //tells program which screen to start with on launch
      routes: {
        '/welcScreen': (context) => const WelcomeScreen(),
        '/loginScreen': (context) => const LoginScreen(),
        '/createAccount': (context) => const CreateAccount(),
        '/gameMap': (context) => const GameMap(),
        '/tourView': (context) => const TourPanorama(),
        '/dragon': (context) => const DragonW(),
        '/virus': (context) => const VirusW(),
        '/football': (context) => const FootballW(),
        '/minigame1': (context) => const EnemyBattle1(),
        '/profile': (context) => const ProfileScreen(),
        '/friends': (context) => const FriendsScreen(),
        '/addFriend': (context) => const AddFriendScreen(),
        '/friendBattle': (context) => const FriendBattleScreen(),
      },
    );
  }
}
