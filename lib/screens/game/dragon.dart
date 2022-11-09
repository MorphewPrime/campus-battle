import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'items.dart';
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
    runApp(MyApp2(0));
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
  static final _paint = Paint()..color = Colors.red;
  int damage = 10;
  Vector2 dir = Vector2(0, -10);
  bool colliding = false;

  // add a hitbox
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  // the flamegame class calls this every frame
  @override
  void update(double dt) {
    position.add(dir * dt);
  }

  // print to screen
  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}

// this class is the player, update to spritecomponent when we have a sprite
class Player extends PositionComponent with CollisionCallbacks {
  int items = 0;
  late final _paint;
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
          hp -= other.damage;
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
class Dragon extends FlameGame
    with PanDetector, HasCollisionDetection, HasTappables {
  late Player player;
  late Back back;
  late BuildContext c;
  late int items;
  Dragon(BuildContext con, int i) {
    c = con;
    items = i;
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player(items)
      ..position = size / 2
      ..width = 25
      ..height = 25
      ..anchor = Anchor.center;
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
    if (time >= 2) {
      time = 0;
      add(
        Danger()
          ..position = size / 2
          ..width = 10
          ..height = 10,
      );
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
class DragonW extends StatelessWidget {
  const DragonW({super.key});

  @override
  Widget build(BuildContext context) {
    runApp(GameWidget(game: Dragon(context, item)));
    return const Scaffold();
  }
}
