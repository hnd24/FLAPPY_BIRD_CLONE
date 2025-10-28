import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class BackgroundComponent extends ParallaxComponent {
  BackgroundComponent();
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax([
      ParallaxImageData('background-day.png'),
    ], baseVelocity: Vector2(10, 00));

    return super.onLoad();
  }
}
