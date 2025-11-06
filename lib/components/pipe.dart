import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game_flappy_bird/utils/config.dart';

class PipeComponent extends PositionComponent
    with HasGameReference, CollisionCallbacks {
  final bool isTop;
  final double pipeHeight;

  static const double pipeWidth = 52;
  static const double headHeight = 32;

  PipeComponent({required this.isTop, required this.pipeHeight}) : super() {
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() async {
    final headPipeImage = await Flame.images.load('head-pipe.png');
    final bodyPipeImage = await Flame.images.load('body-pipe.png');

    size = Vector2(pipeWidth, pipeHeight);

    final double bodyHeight = pipeHeight - headHeight;

    final bodyComponent = SpriteComponent(
      sprite: Sprite(bodyPipeImage),
      size: Vector2(pipeWidth, bodyHeight),
    );

    final headComponent = SpriteComponent(
      sprite: Sprite(headPipeImage),
      size: Vector2(pipeWidth, headHeight),
    );

    if (isTop) {
      position.y = 0;
      // position of head pipe at top
      headComponent.position.y = pipeHeight - headHeight;
      // position of body pipe just below head pipe
      bodyComponent.position.y = 0;

      // Flip both components vertically for top pipe
      headComponent.flipVerticallyAroundCenter();
      // bodyComponent.flipVerticallyAroundCenter();
    } else {
      position.y = game.size.y - Config.highGround - pipeHeight;

      // In the case of the bottom pipe, the head pipe must be at the top of the pipe
      // and the body pipe is below, connecting to the head.
      headComponent.position.y = 0;
      bodyComponent.position.y = headHeight;
    }

    addAll([bodyComponent, headComponent]);

    add(RectangleHitbox());

    return super.onLoad();
  }
}
