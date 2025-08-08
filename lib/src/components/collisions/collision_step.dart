import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/collision_helper.dart';

class CollisionStep extends PositionComponent with HasGameRef<PixelAdventure> {
  final String id;
  CollisionStep({
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
    return super.onLoad();
  }
}
