import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_flappy_bird/components/ground.dart';
import 'package:game_flappy_bird/components/pipe.dart';
import 'package:game_flappy_bird/main.dart';
import 'package:game_flappy_bird/utils/config.dart';

class PlayerComponent extends SpriteAnimationComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  PlayerComponent() : super() {
    debugMode = true;
  }

  // velocity Y (px/s)
  double velocityBird = 0.0;
  bool isFirstClick = false;

  @override
  Future<void> onLoad() async {
    final frames = [
      await Sprite.load('yellowbird-downflap.png'),
      await Sprite.load('yellowbird-midflap.png'),
      await Sprite.load('yellowbird-upflap.png'),
    ];

    final anim = SpriteAnimation.spriteList(frames, stepTime: 0.12);

    size = Vector2(34, 24);

    position = Vector2(70, game.size.y / 2);

    // set anchor to center for rotation
    anchor = Anchor.center;

    animation = anim;

    // add circular hitbox for collision detection
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    if (isFirstClick) {
      _applyGravity(dt);
      _clampToScreen(dt);
    }
    super.update(dt);
  }

  // apply gravity, update position and tilt
  void _applyGravity(double dt) {
    velocityBird += Config.gravity * dt;
    final newY = position.y + velocityBird * dt;
    position = Vector2(position.x, newY);

    // tilt bird according to velocity
    final alpha = clampDouble(velocityBird / 1800, -pi * 0.25, pi * 0.25);
    angle = alpha;
  }

  void addFly() {
    velocityBird = Config.flyVelocity;
    if (!isFirstClick) {
      isFirstClick = true;
    }
  }

  // clamp bird inside screen bounds/ground
  void _clampToScreen(double dt) {
    // --------- upper limit ----------

    final double halfHeight = size.y / 2;
    final double minYTop = halfHeight;

    if (position.y < minYTop) {
      position.y = minYTop;

      // if bird is moving up, stop it
      if (velocityBird < 0) {
        velocityBird = 0;
      }
    }

    // --------- lower limit ----------
    // final double groundTopY = game.size.y - Config.highGround;
    // final double maxYBottom = groundTopY - halfHeight;

    // if (position.y > maxYBottom) {
    //   position.y = maxYBottom;

    //   velocityBird = 0;

    //   gameOver();
    // }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is GroupComponent || other is PipeComponent) {
      gameOver();
    }
    //chạm đất sẽ nhảy lên
    // if (other is GroupComponent) {
    //   velocityBird = -350;
    // }
    super.onCollisionStart(intersectionPoints, other);
  }

  void gameOver() {
    game.gameOver();
    isFirstClick = false;
  }

  void reset() {
    position = Vector2(70, game.size.y / 2);
    velocityBird = 0.0;
    angle = 0.0;
    isFirstClick = false;
  }
}
