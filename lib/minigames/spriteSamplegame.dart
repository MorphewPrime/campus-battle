import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class SpriteSample extends FlameGame {
  SpriteComponent mask = SpriteComponent();
  SpriteComponent robot = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  var characterSize = 200.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    const textBoxHeight = 100;


    //load a background
    add(background
      ..sprite = await loadSprite('tempBackground.png')
      ..size = size);

    //loads sprite
    mask 
      ..sprite = await loadSprite('spartan-mask-logo1.png')
      ..size = Vector2(150, 150)
      ..y = screenHeight - characterSize - textBoxHeight;

    //loads sprite
    robot
      ..sprite = await loadSprite('robot.png')
      ..size = Vector2(150,150)
      ..y = screenHeight - characterSize - textBoxHeight
      ..x = screenWidth - characterSize;

    add(mask);
    add(robot);
  }
}