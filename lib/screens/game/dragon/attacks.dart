import 'dart:math';
import 'definitions.dart';

int _gen_start() {
  int attack = 0;
  var rng = Random();
  int n = rng.nextInt(5);
  if (n < 1) {
    attack = attack | DRAGON_SMALL_FIRE | DRAGON_LARGE_FIRE;
  } else if (n < 3) {
    attack = attack | DRAGON_SMALL_FIRE | DRAGON_DOUBLE_FIRE;
  } else {
    attack = attack | DRAGON_DOUBLE_FIRE | DRAGON_LARGE_FIRE;
  }
  return attack;
}

int generate_attack_pattern(int turn, int hp) {
  if (turn == 1) {
    return _gen_start();
  }
  return -1;
}
