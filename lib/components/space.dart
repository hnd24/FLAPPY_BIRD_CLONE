// import 'dart:async';

// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:game_flappy_bird/components/player.dart';

// class SpaceComponent extends PositionComponent with CollisionCallbacks {
//   Vector2 mSize;

//   bool isScored = false;

//   SpaceComponent({required this.mSize}) : super(size: mSize) {
//     debugMode = true;
//   }

//   @override
//   FutureOr<void> onLoad() {
//     add(RectangleHitbox(size: size));
//     return super.onLoad();
//   }

//   @override
//   void onCollisionEnd(PositionComponent other) {
//     if (other is PlayerComponent) {
//       if (isScored) {
//         other.score++;
//         print('Score: ${other.score}');
//         isScored = false;
//       } else {
//         isScored = true;
//       }
//     }
//     super.onCollisionEnd(other);
//   }
// }
