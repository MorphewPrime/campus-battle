/* 
@filename: mathgame_screen.dart
@author: Logan Anderson
@date: 2-24-23
@brief: This file contains the main screen of the math minigame
 */

//idea of game: math equations with choices that float from the bottom of
//the screen to the top, rewards more points if gotten quicker

import 'package:flutter/material.dart';
import 'dart:math';

import 'mathscorescreen.dart';

final random = Random();

class MathQuestion {
  final String question;
  final int answer;

  MathQuestion(this.question, this.answer);
}

//big list of possible math equations
final List<MathQuestion> mathQuestions = [
  MathQuestion("2 + 2", 4),
  MathQuestion("5 - 3", 2),
  MathQuestion("4 * 3", 12),
  MathQuestion("10 / 2", 5),
  MathQuestion("14 + 9", 23),
  MathQuestion("6 - 1", 5),
  MathQuestion("12 * 3", 36),
  MathQuestion("14 * 4", 56),
  MathQuestion("61 + 21", 82),
  MathQuestion("18 - 12", 6),
  MathQuestion("16 * 2", 32),
  MathQuestion("25 / 5", 5),
  MathQuestion("24 + 36", 60),
  MathQuestion("24 - 17", 7),
  MathQuestion("10 * 11", 110),
  MathQuestion("13 + 4 + 1", 18),
];

class MathGame extends StatefulWidget {
  const MathGame({Key? key}) : super(key: key);

  @override
  State<MathGame> createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  int _currentRound = 0;
  int _score = 0;
  List<int> _usedQuestions = [];

  void _generateQuestion() {
    int index = random.nextInt(mathQuestions.length);
    while (_usedQuestions.contains(index)) {
      //don't reuse questions
      index = random.nextInt(mathQuestions.length);
    }
    _usedQuestions.add(index);
    _currentQuestion = mathQuestions[index];

    // Generate a list of answer options that includes the correct answer
    List<int> answerOptions = [_currentQuestion!.answer];

    // Add two random integers close to the correct answer to the answer options list
    int diff1 = random.nextInt(3) + 1;
    int diff2 = random.nextInt(3) + 1;
    answerOptions.add(_currentQuestion!.answer + diff1);
    answerOptions.add(_currentQuestion!.answer - diff2);

    // Shuffle the answer options list
    answerOptions.shuffle();

    // Set the answer options for the buttons
    _answerOption1 = answerOptions[0];
    _answerOption2 = answerOptions[1];
    _answerOption3 = answerOptions[2];
  }

  MathQuestion? _currentQuestion;
  int _answerOption1 = 0;
  int _answerOption2 = 0;
  int _answerOption3 = 0;

  void _checkAnswer(int answer) {
    // if (_currentQuestion != null && answer == _currentQuestion!.answer) {
    setState(() {
      if (_currentQuestion != null && answer == _currentQuestion!.answer) {
        _score += 10;
      }
      _currentRound++;
      if (_currentRound >= 10) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MathScoreScreen(score: _score),
        ));
      } else {
        _generateQuestion();
      }
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade900,
      appBar: AppBar(
        title: const Text("Math Game"),
        backgroundColor: Colors.tealAccent.shade400,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //round
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Round ${_currentRound + 1}",
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            //score
            const SizedBox(height: 20.0),
            Text(
              "Score: $_score",
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                _currentQuestion!.question,
                style: const TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _checkAnswer(_answerOption1);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.tealAccent.shade400,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    _answerOption1.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _checkAnswer(_answerOption2);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.tealAccent.shade400,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    _answerOption2.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _checkAnswer(_answerOption3);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.tealAccent.shade400,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(
                    _answerOption3.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
