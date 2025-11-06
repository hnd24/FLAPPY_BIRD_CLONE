import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_flappy_bird/components/background.dart';
import 'package:game_flappy_bird/components/ground.dart';
import 'package:game_flappy_bird/components/group_pipe.dart';
import 'package:game_flappy_bird/components/overlays/over_game.dart';
import 'package:game_flappy_bird/components/overlays/start_game.dart';
import 'package:game_flappy_bird/components/player.dart';
import 'package:game_flappy_bird/components/score_display.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
      overlayBuilderMap: {
        "StartGame": (BuildContext context, MyGame game) {
          return StartGameOverlay(game: game);
        },
        "OverGame": (BuildContext context, MyGame game) {
          return OverGameOverlay(game: game);
        },
      },
      initialActiveOverlays: const ["StartGame"],
    ),
  );
}

class MyGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  late PlayerComponent player;
  // late TextComponent scoreText;
  late ScoreDisplayComponent scoreDisplay;
  double alapseTimePipe = 0.0;
  bool gameStarted = false;
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    add(BackgroundComponent());
    add(GroupComponent());
    player = PlayerComponent();
    await add(player);
    // add(scoreText = createScoreText());
    scoreDisplay = ScoreDisplayComponent();
    await add(scoreDisplay);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (alapseTimePipe > 1.5) {
      add(GroupPipeComponent());
      alapseTimePipe = 0.0;
    } else {
      alapseTimePipe += dt;
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.addFly();
    super.onTapDown(event);
  }

  void startGame() {
    score = 0;
    // scoreText.text = 'Score: 0';
    scoreDisplay.updateScore(score);
    alapseTimePipe = 0.0;
    gameStarted = true;

    removePipe();

    player.reset();

    overlays.remove('StartGame');
    overlays.remove('OverGame');
    resumeEngine();
  }

  void gameOver() {
    pauseEngine();
    overlays.add('OverGame');
    gameStarted = false;
  }

  // TextComponent createScoreText() {
  //   scoreText = TextComponent(
  //     text: 'Score: $score',
  //     position: Vector2(10, 10),
  //     anchor: Anchor.topLeft,
  //     priority: 100,
  //     textRenderer: TextPaint(
  //       style: const TextStyle(
  //         fontSize: 24,
  //         color: Colors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  //   return scoreText;
  // }

  void increaseScore() {
    score++;
    // scoreText.text = 'Score: $score';
    scoreDisplay.updateScore(score);
    print('Score: $score');
  }

  void resetScore() {
    score = 0;
    // scoreText.text = 'Score: $score';
    scoreDisplay.updateScore(score);
  }

  void removePipe() {
    for (var node in children) {
      if (node is GroupPipeComponent) {
        node.removeFromParent();
      }
    }
  }
}
