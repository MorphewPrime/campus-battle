//@author: Logan Anderson
//@date: 2-24-23
//@brief: Screen that appears at the end of the math game

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'mathgame_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//created gthe highscore widget to display and update the highscore
// Author: Peter Gessler
class HighScore extends StatelessWidget {
  HighScore(this.score);

  final int score;

  //gets the game's highscore from database
  Future getHighScore(score) async {
    final document = await FirebaseFirestore.instance
        .collection("high_scores")
        .doc("math")
        .get();
    final highscore = document['highscore'];
    if (score > highscore) {
      FirebaseFirestore.instance
          .collection("high_scores")
          .doc("math")
          .update({"score": score});
      return score;
    }
    return highscore;
  }

  // TODO
  // updates the game's highscore in database, if needed
  // Future updateHighScore() async {
  //   final scoreRef =
  //       FirebaseFirestore.instance.collection("high_scores").doc("math");
  //   scoreRef.update({"score": score});
  // }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('High Scores'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              if (score > data) {}
              return Center(
                child: Text(
                  '$data',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getHighScore(score),
      ),
    ));
  }
}

class MathScoreScreen extends StatelessWidget {
  final int score;

  //ITEMS?
  //if score is >= 70: give item
  //if not dont

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
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => HighScore(score),
                                )),
                            child: Text('Highscores')),
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
