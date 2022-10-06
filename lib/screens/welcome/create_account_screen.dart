/* 
* filename: create_account_screen.dart
* author: Logan Anderson
* date created: 09/28/22
* brief: designs the create account screen
*/

import 'package:flutter/material.dart';

//main class for create account screen
class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
  TextEditingController userController = TextEditingController(); //not sure what these do yet
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(     //Padding widget helps spacing of child widgets
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(    //widget for logo
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Image.asset(
                'assets/images/campus-battle-logo1.png',
                semanticLabel: 'Campus Battle Logo',
                width: 315,
                fit: BoxFit.contain,
              )
          ),
          Container(    //widget for Create Account text
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: const Text(
              'Create Account',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(      //widget for username input box
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: TextField(
              controller: userController, //not sure what this does yet
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
              controller: passController, //not sure what this does yet
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(  //widget for create account button
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextButton(
                child: const Text(
                  'Have Account? Log In',
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: () {
                  //go to login screen
                  Navigator.pushNamed(context, '/loginScreen');
                },
              )),
          Container(    //widget for Sign Up button
            height: 50,
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: ElevatedButton(
              onPressed: () {
                //create user account
                //temporary - just goes to game map
                Navigator.pushNamed(context, '/gameMap');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                //height should be same as user and pass height
              ),
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
