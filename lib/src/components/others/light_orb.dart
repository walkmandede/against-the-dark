import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/config.dart';

class LightOrb extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure> {
  final Vector2 velocity;
  LightOrb({
    required super.position,
    required this.velocity,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    size = AppConfig.lighrOrbSize;
    _setAnimation();

    return super.onLoad();
  }

  void _setAnimation() {
    const path = "Main Characters/Appearing (96x96).png";
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.05,
        textureSize: Vector2.all(96),
      ),
    );
  }

  void finishAbitily() {
    game.cam.follow(
      game.levelWorld.player,
    );
    game.levelWorld.darkness.lightAreas.removeWhere(
      (element) {
        return element.id == "LightOrb";
      },
    );
    removeFromParent();
  }
}
