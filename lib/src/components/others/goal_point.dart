import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class GoalPoint extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure> {
  GoalPoint({required super.position, required super.size})
      : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() {
    position = position.xy + Vector2(size.x / 2, size.y / 2);
    _setAnimation();
    return super.onLoad();
  }

  void _setAnimation() {
    const path = "Items/Checkpoints/End/End (Pressed) (64x64).png";
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
      ),
    );
  }
}
