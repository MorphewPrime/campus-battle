import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class Danger extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;
  int damage = 10;
  Vector2 dir = Vector2(0, -10);
  bool colliding = false;
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.add(dir * dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}

class Player extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.white;

  int hp = 100;

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  void move(Vector2 move) {
    position.add(move);
  }

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

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Danger) {
      other.colliding = false;
    }
  }
}

class Dragon extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player()
      ..position = size / 2
      ..width = 25
      ..height = 25
      ..anchor = Anchor.center;
    add(player);
    add(ScreenHitbox());
  }

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

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}

class DragonW extends StatelessWidget {
  const DragonW({super.key});

  @override
  Widget build(BuildContext context) {
    runApp(GameWidget(game: Dragon()));
    return const Scaffold();
  }
}
