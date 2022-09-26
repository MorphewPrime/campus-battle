/* 
* filename: welcome_screen.dart
* author: Logan Anderson
* date created: 09/24/22
* brief: designs the welcome screen (sign in page) 
*/

import 'package:flutter/material.dart';

//main class for welcome screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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

/*
* name: _BodyState
* author: Logan Anderson
* created: 09/24/22
* brief: Designs the body of the welcome screen, which includes
* username and password input boxes, place to create account/login, and
* game logo.
*/
class _BodyState extends State<Body> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(     //Padding widget helps spacing of child widgets
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(    //This is where the logo will be eventually
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 150, 10, 10),
            child: const Text(
              'Put Campus Battle Logo here',
              style: TextStyle(   //designs the text
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
          Container(    //widget for sign in text
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(      //widget for username input box
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: TextField(
              controller: userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(    //widget for password input box
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: TextField(
              obscureText: true,    
              controller: passController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          //Put TextButton for forgot password here?
          Container(  //widget for create account button
              padding: const EdgeInsets.fromLTRB(0, 0, 155, 0),
              child: TextButton(
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //create account screen
                },
              )),
          Container(    //widget for Login button
            height: 50,
            padding: const EdgeInsets.fromLTRB(220, 0, 40, 0),
            child: ElevatedButton(
              onPressed: () {
                //go through user authentication process
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                //height should be same as user and pass height
              ),
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
