import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_flappy_bird/components/pipe.dart';
import 'package:game_flappy_bird/main.dart';
import 'package:game_flappy_bird/utils/config.dart';

class GroupPipeComponent extends PositionComponent
    with HasGameReference<MyGame> {
  GroupPipeComponent() : super() {
    debugMode = false;
  }

  bool alreadyScored = false;
  final random = Random();

  @override
  FutureOr<void> onLoad() async {
    await FlameAudio.audioCache.load('point.wav');
    position.x = game.size.x;

    const double gapSize = 120;

    final double minCenterY = 100 + gapSize / 2;
    final double maxCenterY =
        game.size.y - Config.highGround - gapSize / 2 - 30;

    final double centerY =
        minCenterY + random.nextDouble() * (maxCenterY - minCenterY);
    // lerpDouble(a,b,t) = a + (b-a)*t
    final double topPipeHeight = centerY - gapSize / 2;
    final double bottomPipeHeight =
        (game.size.y - Config.highGround) - (centerY + gapSize / 2);

    final PipeComponent topPipe = PipeComponent(
      isTop: true,
      pipeHeight: topPipeHeight,
    );

    final PipeComponent bottomPipe = PipeComponent(
      isTop: false,
      pipeHeight: bottomPipeHeight,
    );

    // SpaceComponent spaceComponent = SpaceComponent(
    //   mSize: Vector2(PipeComponent.pipeWidth, gapSize),
    // );
    // // position space between two pipes
    // spaceComponent.position.y = topPipeHeight;

    addAll([topPipe, bottomPipe]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= Config.gameSpeed * dt;
    if (position.x < -52) {
      removeFromParent();
    }

    // Logic to check if the pipe has been passed for scoring can be added here
    if (!alreadyScored &&
        (position.x + PipeComponent.pipeWidth) < game.player.position.x) {
      game.increaseScore();
      FlameAudio.play('point.wav');
      alreadyScored = true;
    }
    super.update(dt);
  }
}
