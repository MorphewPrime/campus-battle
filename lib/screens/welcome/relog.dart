// this file is for if a custom screen is needed to handle in between relogs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../main.dart';

class relog extends StatelessWidget {
  const relog({super.key});

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
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim());
    Navigator.pushNamed(context, '/gameMap');
  }

  /*
    REFACTOR TODO:
    IMPLEMENT THIS

    This doesn't need to be anything fancy, just an intermediate screen that
    calls signIn
  */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
