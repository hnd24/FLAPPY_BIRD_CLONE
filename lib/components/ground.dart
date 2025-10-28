import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:game_flappy_bird/utils/config.dart';

class GroupComponent extends ParallaxComponent with CollisionCallbacks {
  GroupComponent() : super() {
    debugMode = true;
  }

  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [ParallaxImageData('base.png')],
      baseVelocity: Vector2(Config.gameSpeed, 00),
      fill: LayerFill.none,
      alignment: Alignment.bottomCenter,
    );
    add(
      RectangleHitbox(
        size: Vector2(game.size.x, Config.highGround),
        position: Vector2(0, game.size.y - Config.highGround),
      ),
    );
    return super.onLoad();
  }
}
