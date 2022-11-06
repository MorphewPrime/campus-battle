
import 'package:flutter/material.dart';

class EnemyBattle1 extends StatelessWidget {
  const EnemyBattle1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('minigame example'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff0051ba),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: style,
                onPressed: () {
                  //end game, give item
                },
                child: const Text('Win'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  //end game, no item
                },
                child: const Text('Lose'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
