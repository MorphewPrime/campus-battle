//@author: Logan Anderson
//@date: 2-24-23
//@brief: Screen that appears at the end of the math game

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'mathgame_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MathScoreScreen extends StatelessWidget {
  final int score;
  int highscore;

  //ITEMS?
  //if score is >= 70: give item
  //if not dont

  //@author: Peter Gessler
  //@brief: gets the game's highscore from database
  Future getHighScore() async {
    final document = await FirebaseFirestore.instance
        .collection("high_scores")
        .doc("math")
        .get();

    return document['highscore'];
  }

  // TODO
  //@author: Peter Gessler
  //@brief: updates the game's highscore in database, if needed
  Future updateHighScore() async {
    final scoreRef =
        FirebaseFirestore.instance.collection("high_scores").doc("math");
    scoreRef.update({"score": score});
  }

  MathScoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      appBar: AppBar(
        title: Text("Math Game"),
        backgroundColor: Colors.tealAccent.shade400,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Color.fromARGB(255, 1, 34, 22),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Final Score",
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "$score / 100",
                          style: TextStyle(
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          score >= 70 ? "You won!" : "You Lost!",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Back to Map",
                          ),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 24),
                            backgroundColor: Colors.tealAccent.shade400,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
