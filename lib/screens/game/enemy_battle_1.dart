import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'package:campusbattle/minigames/spriteSamplegame.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sprite examples'),
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gameMap');
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GameWidget(game: SpriteSample()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
