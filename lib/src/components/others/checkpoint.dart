import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class Checkpoint extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure> {
  Checkpoint({required super.position}) : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    _setAnimation();
    return super.onLoad();
  }

  void _setAnimation() {
    const path =
        "Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png";
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: 26,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
      ),
    );
  }
}
