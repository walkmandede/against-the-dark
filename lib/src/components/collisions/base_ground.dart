import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/collision_helper.dart';

class BaseGround extends SpriteComponent with HasGameRef<PixelAdventure> {
  final String id;
  BaseGround({
    required this.id,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          children: [
            RectangleHitbox(),
          ],
          anchor: Anchor.topLeft,
        );

  @override
  FutureOr<void> onLoad() {
    final image = game.images.fromCache('Terrain/Terrain (16x16).png');

    // Create the sprite from the sprite sheet
    sprite = Sprite(
      image,
      srcPosition: Vector2(8 * 12, 8 * 16), // where it starts in the sheet
      srcSize: Vector2(8 * 6, 8 * 6), // size of the block
    );
    debugMode = false;
    debugColor = Colors.teal;
    return super.onLoad();
  }
}
