import 'dart:math';

import 'package:campusbattle/screens/game/dragon/attacks.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'items.dart';
import 'definitions.dart';
import '../../../main.dart';

// Game skeleton file
int items = 1;
int act = 0;

// Button to end game
class Back extends PositionComponent with Tappable {
  static final _paint = Paint()..color = Colors.orange;

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

// Going to make buttons for acting
class Action extends PositionComponent with Tappable {
  static final _paint = Paint()..color = Colors.lightBlue;
  late int type;
  Action(int n) {
    type = n;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (act == PLAYER_TURN) {
      act = type;
    }
    return true;
  }

  @override
  void render(Canvas canvas) {
    if (act == PLAYER_TURN) {
      canvas.drawRect(size.toRect(), _paint);
    }
  }
}

// Class defines the borders of the playable area on screen
class Border extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.white;
  late int loc;
  Border(int n) {
    loc = n;
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  int getLoc() {
    return loc;
  }
}

// Class details a hazard, replace with spritecomponent once we have sprites
class Danger extends PositionComponent with CollisionCallbacks {
  static final _paint = Paint()..color = Colors.red;
  int damage = 10;
  Vector2 dir = Vector2(0, -10);
  bool colliding = false;
  double life = 0;

  // add a hitbox
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  // the flamegame class calls this every frame
  @override
  void update(double dt) {
    life += dt;
    position.add(dir * dt);
    if (life >= 10) {
      removeFromParent();
    }
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
  bool top = false;
  bool bot = false;
  bool right = false;
  bool left = false;
  bool active = false;

  // these are placeholder default values
  int attack_min = 75;
  int attack_max = 125;

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

  // toggle active status
  void toggle() {
    active = !active;
  }

  // print to screen
  @override
  void render(Canvas canvas) {
    if (active) {
      canvas.drawRect(size.toRect(), _paint);
    }
  }

  // generates damage number when called
  int attack() {
    var rng = Random();
    int bonus = rng.nextInt(attack_max - attack_min);
    return attack_min + bonus;
  }

  // handle movement when function is called
  void move(Vector2 move) {
    if (active) {
      if (top) {
        if (move.y < 0) {
          move.y = 0;
        }
      }
      if (bot) {
        if (move.y > 0) {
          move.y = 0;
        }
      }
      if (right) {
        if (move.x > 0) {
          move.x = 0;
        }
      }
      if (left) {
        if (move.x < 0) {
          move.x = 0;
        }
      }
      position.add(move);
    }
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
    if (other is Border) {
      int n = other.getLoc();
      if (n == 1) {
        top = true;
      } else if (n == 2) {
        right = true;
      } else if (n == 3) {
        bot = true;
      } else if (n == 4) {
        left = true;
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
    if (other is Border) {
      int n = other.getLoc();
      if (n == 1) {
        top = false;
      } else if (n == 2) {
        right = false;
      } else if (n == 3) {
        bot = false;
      } else if (n == 4) {
        left = false;
      }
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
  int dragonHP = 1000;
  Dragon(BuildContext con, int i) {
    c = con;
    items = i;
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    act = PLAYER_TURN;

    player = Player(items)
      ..position = size / 2
      ..width = 25
      ..height = 25
      ..anchor = Anchor.center;
    add(player);
    add(ScreenHitbox());
    back = Back()
      ..position = Vector2(100, 100)
      ..width = 40
      ..height = 40
      ..anchor = Anchor.center;
    add(back);
    Border top = Border(1)
      ..position = Vector2(211, 250)
      ..width = 350
      ..height = 10
      ..anchor = Anchor.center;
    add(top);
    Border bot = Border(3)
      ..position = Vector2(211, 700)
      ..width = 350
      ..height = 10
      ..anchor = Anchor.center;
    add(bot);
    Border right = Border(2)
      ..position = Vector2(386, 475)
      ..width = 10
      ..height = 460
      ..anchor = Anchor.center;
    add(right);
    Border left = Border(4)
      ..position = Vector2(36, 475)
      ..width = 10
      ..height = 460
      ..anchor = Anchor.center;
    add(left);
    Action atk = Action(PLAYER_ATTACK)
      ..position = Vector2(211, 362)
      ..width = 100
      ..height = 50
      ..anchor = Anchor.center;
    add(atk);
  }

  // this function manages dragon attacks
  // reads the attack from move based on definitions in 'definitions.dart'
  // generates all components of the attack and adds them to the game
  void dragon_attack(int move) {}

  // handles all frame updates
  int turn = 0;
  double time = 0;
  @override
  void update(double dt) {
    super.update(dt);
    if (act == PLAYER_TURN) {
    } else if (act == PLAYER_ATTACK) {
      turn++;
      dragonHP -= player.attack();
      act = PLAYER_WAITING;
    } else if (act == PLAYER_WAITING) {
      time += dt;
      if (time >= 2) {
        dragon_attack(generate_attack_pattern(turn, dragonHP));
        act = PLAYER_GETTING_ATTACKED;
        player.toggle();
        time = 0;
      }
    }
    if (player.hp <= 0) {
      runApp(MyApp2(1));
    }
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
