import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'items.dart';
import 'dart:math';
import 'dart:convert';
import '../../main.dart';

// Game skeleton file
int items = 1;

// Button to end game
class Back extends PositionComponent with Tappable {
  static final _paint = Paint()..color = Colors.orange;
  late BuildContext c;
  Back(BuildContext con) {
    c = con;
  }

  // Pressable button
  @override
  bool onTapDown(TapDownInfo info) {
    //Navigator.pushNamed(c, "/gameMap");
    //Navigator.pop(c);
    //SystemNavigator.pop();

    // Returns to old app, need to add a status to the return so it knows
    // what's going on
    runApp(MyApp2(1));
    return true;
  }

  // print to screen
  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}

// Class details a hazard, replace with spritecomponent once we have sprites
class Danger extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.green;
  int damage = 10;
  int health = 100;
  Vector2 screenD = Vector2(0, 0);
  Vector2 dest = Vector2(0, 0);
  Vector2 dir = Vector2(((Random().nextDouble() * 100) - 50),
      ((Random().nextDouble() * 100) - 50));

  // Vector2 dest = Vector2(Random().nextDouble() * screen,
  //     ((Random().nextDouble() * 100) - 50));

  double accel = 0;
  bool colliding = false;

  // add a hitbox
  @override
  Future<void> onLoad() async {
    dest = Vector2((screenD.x / 2), (screenD.y / 2));
    print(dest);
    add(RectangleHitbox());
  }

  // the flamegame class calls this every frame
  @override
  void update(double dt) {
    if (accel < 800) {
      accel += 50;
    } else {
      accel = 200;
    }

    // Vector2 dir2 = Vector2(
    //     (dir.x + ((Random().nextDouble() * 100) - 50) * accel),
    //     (dir.y + ((Random().nextDouble() * 100) - 50) * accel));
    // dest = Vector2(
    //     Random().nextDouble() * screenD.x, Random().nextDouble() * screenD.y);
    Vector2 dir2 = Vector2(position.x - dest.x, position.y - dest.y);
    // Vector2 dir = Vector2(dest.x, dest.y);

    // print(dir2 == dest);
    // print(dir2);
    // print(dest);

    // Vector2 dir2 = dir;
    // print("dest");
    // print(dest);
    // print("der2");
    // print(dir2);

    double xDiff = (position.x - (dest.x)).abs();
    double yDiff = (position.y - (dest.y)).abs();

    // print("diffs");
    // print(xDiff);
    // print(yDiff);

    if (xDiff > 20 && yDiff > 20) {
      double x = dir2.x.abs();
      double y = dir2.y.abs();

      // Create a ratio
      double ratio = 1 / max(x, y);
      ratio = ratio * (1.29289 - (x + y) * ratio * 0.29289);

      dir2.x = dir2.x * ratio;
      dir2.y = dir2.y * ratio;
    } else {
      dir2 = Vector2(0, 0);
      dest = Vector2(
          Random().nextDouble() * screenD.x, Random().nextDouble() * screenD.y);

      // dest = Vector2(0, 0);
    }
    // print(dir2);

    position.add(-dir2 * accel * dt);
    // print("data");
    // print(position);
    // print(dir2);
    // position.setValues(position.x + dir.x, y + dir.y);
  }

  // print to screen
  @override
  void render(Canvas canvas) {
    // canvas.drawRect(size.toRect(), _paint);
    Paint test = Paint()
      ..color = Color.lerp(Colors.red, Colors.green, health / 100)!;
    canvas.drawCircle(size.toOffset(), size.x, test);
  }
}

// this class is the player, update to spritecomponent when we have a sprite
class Player extends PositionComponent with CollisionCallbacks {
  int items = 0;
  int enemiesKilled = 0;
  void gameEnd;
  Paint _paint = Paint()..color = Colors.white;
  Player(int i) {
    items = i;
    if (items == 1) {
      _paint = Paint()..color = Colors.blue;
    } else {
      _paint = Paint()..color = Colors.white;
    }
  }

  int hp = 100;

  // add a hitbox
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  // print to screen
  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  // handle movement when function is called
  void move(Vector2 move) {
    // print(size);
    position.add(move);
  }

  // this function handles hit detection, for now the only event is taking damage
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      hp = 0;
    } else {
      if (other is Danger) {
        if (other.colliding == false) {
          other.colliding = true;
          other.health -= 5;
          hp -= other.damage;
        }
        if (other.health <= 0) {
          // print()
          other.removeFromParent();
          if (++enemiesKilled == 5) {
            _paint = Paint()..color = Colors.purple;
          }
        }
      }
    }
  }

  // this handles ending collisions, useful for preventing constant collision triggers
  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Danger) {
      other.colliding = false;
    }
  }
}

// this class represents the game itself
class Virus extends FlameGame
    with PanDetector, HasCollisionDetection, HasTappables {
  late Player player;
  late Back back;
  late BuildContext c;
  late int items;

  int enemyCount = 0;
  Virus(BuildContext con, int i) {
    c = con;
    items = i;
  }
  @override
  void endGame() {
    print("game ended");
  }

  Future<void> onLoad() async {
    await super.onLoad();
    // print(size);

    player = Player(items)
      ..position = size / 2
      ..width = 25
      ..height = 25
      ..anchor = Anchor.center
      ..gameEnd = endGame();
    add(player);
    add(ScreenHitbox());
    back = Back(c)
      ..position = Vector2(100, 100)
      ..width = 40
      ..height = 40
      ..anchor = Anchor.center;
    add(back);
  }

  // spawns dangers every 2 seconds
  // since the super class handles these, we dont need to keep track of them here
  double time = 0;
  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    if (time >= 2 && enemyCount < 5) {
      time = 0;
      add(
        Danger()
          ..position = size / 4
          ..width = 25
          ..height = 25
          ..screenD = size
          ..anchor = Anchor.center,
      );
      enemyCount++;
      print(player.hp);
    }
    if (player.hp == 0) {}
  }

  // gets inputs
  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}

// widget to be directed to from the game map
class VirusW extends StatelessWidget {
  const VirusW({super.key});

  @override
  Widget build(BuildContext context) {
    runApp(GameWidget(game: Virus(context, item)));
    return const Scaffold();
  }
}
