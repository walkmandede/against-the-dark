import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/obstacles/obstacle.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/collision_helper.dart';

class SpinningBlade extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, Obstacle {
  final String id;
  final bool xHAxis;
  final double axisAmount;
  final double speedFactor;
  SpinningBlade({
    required this.id,
    required Vector2 position,
    required Vector2 size,
    this.xHAxis = true,
    this.axisAmount = 1,
    this.speedFactor = 1,
  }) : super(
          position: position,
          size: size,
          children: [
            RectangleHitbox(),
          ],
          anchor: Anchor.center,
        );

  late SpriteAnimation runAnimation;
  late Vector2 originalPosition;

  bool xDown = true;
  bool xRight = true;

  @override
  FutureOr<void> onLoad() {
    //adjusting for anchor
    position = position.xy + Vector2.all(size.x / 2);
    originalPosition = position.xy;
    //
    debugMode = false;
    debugColor = Colors.teal;
    _setAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (xHAxis) {
      //hAxis
      if (position.x > originalPosition.x + (size.x * axisAmount)) {
        xRight = false;
      } else if (position.x < originalPosition.x - (size.x * axisAmount)) {
        xRight = true;
      }

      if (xRight) {
        position.x += size.x * speedFactor * dt;
      } else {
        position.x -= size.x * speedFactor * dt;
      }
    } else {
      //VAxis

      if (position.y > originalPosition.y + (size.y * axisAmount)) {
        xDown = false;
      } else if (position.y < originalPosition.y - (size.y * axisAmount)) {
        xDown = true;
      }

      if (xDown) {
        position.y += size.y * speedFactor * dt;
      } else {
        position.y -= size.y * speedFactor * dt;
      }
    }
    super.update(dt);
  }

  void _setAnimation() {
    const path = "Traps/Saw/On (38x38).png";
    runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.05,
        textureSize: Vector2.all(38),
      ),
    );
    animation = runAnimation;
  }
}
