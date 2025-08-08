import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/src/game/darkness.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class Torch extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {
  bool xLittedUp;
  Torch({
    required super.position,
    this.xLittedUp = false,
  }) : super(
          anchor: Anchor.center,
          children: [
            RectangleHitbox(),
          ],
        );

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    position = position.xy;
    _setAnimation();
    return super.onLoad();
  }

  void _setAnimation() {
    const path = "Items/Boxes/Box1/Idle.png";
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2(28, 24),
      ),
    );
  }

  void litUp() {
    if (!xLittedUp) {
      xLittedUp = true;
      const path = "Items/Torch/pixel_torch_spritesheet.png";
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(path),
        SpriteAnimationData.sequenced(
          amount: 30,
          stepTime: 0.05,
          textureSize: Vector2(64, 64),
        ),
      );
      position.y -= size.y * 0.25;

      //
      game.levelWorld.darkness.lightAreas.add(
        LightArea("", EnumLightAreaType.torch, center, size.y * 3),
      );
    }
  }
}
