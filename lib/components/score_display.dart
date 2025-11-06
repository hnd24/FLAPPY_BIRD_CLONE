import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class ScoreDisplayComponent extends PositionComponent with HasGameReference {
  int currentScore = -1;
  final double spriteWidth = 24.0;
  final double spriteHeight = 36.0;

  static const List<String> digitNames = [
    'zero.png',
    'one.png',
    'two.png',
    'three.png',
    'four.png',
    'five.png',
    'six.png',
    'seven.png',
    'eight.png',
    'nine.png',
  ];

  ScoreDisplayComponent() : super(priority: 100);

  @override
  FutureOr<void> onLoad() async {
    final assetPaths = List.generate(10, (i) => '${digitNames[i]}');

    await Flame.images.loadAll(assetPaths);

    position = Vector2(game.size.x / 2, 50);
    anchor = Anchor.topCenter;

    updateScore(0);

    return super.onLoad();
  }

  void updateScore(int newScore) {
    if (newScore == currentScore && children.isNotEmpty) {
      return;
    }
    currentScore = newScore;

    removeAll(children);

    final scoreString = newScore.toString();
    double totalWidth = 0;

    for (int i = 0; i < scoreString.length; i++) {
      final digit = int.parse(scoreString[i]);

      final assetNameInCache = '${digitNames[digit]}';

      final digitSprite = SpriteComponent(
        sprite: Sprite(
          Flame.images.fromCache(assetNameInCache),
          srcSize: Vector2(spriteWidth, spriteHeight),
        ),
        size: Vector2(spriteWidth, spriteHeight),
        anchor: Anchor.center,
      );

      digitSprite.position.x = totalWidth + spriteWidth / 2;
      totalWidth += spriteWidth + 2;

      add(digitSprite);
    }

    final offset = totalWidth / 2 - spriteWidth / 2;
    for (var child in children) {
      if (child is PositionComponent) {
        child.position.x -= offset;
      }
    }
  }
}
