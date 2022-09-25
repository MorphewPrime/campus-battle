import 'package:campusbattle/constants.dart';
import 'package:flutter/material.dart';
import 'package:campusbattle/screens/welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

//root of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Battle',
      theme: ThemeData(
        primaryColor: cPrimaryColor,
        scaffoldBackgroundColor: const Color(0xFFFFFDE9),
      ),
      home: const WelcomeScreen(),
    );
  }
}
