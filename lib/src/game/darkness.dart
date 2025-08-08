import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/config.dart';

enum EnumLightAreaType {
  player,
  lightOrb,
  obstacles,
  torch,
}

class LightArea {
  String id;
  EnumLightAreaType enumLightAreaType;
  Vector2 center;
  double radius;

  LightArea(this.id, this.enumLightAreaType, this.center, this.radius);
}

class Darkness extends PositionComponent with HasGameRef<PixelAdventure> {
  List<LightArea> lightAreas;
  double opacity;

  Darkness({required this.lightAreas, this.opacity = 0.9, required super.size});

  @override
  FutureOr<void> onLoad() {
    // size = dataController.deviceSize;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // Create a layer so BlendMode.clear works properly
    final paintLayer = Paint();
    canvas.saveLayer((size).toRect(), paintLayer);

    // Draw full darkness
    final paint = Paint()..color = Colors.black.withOpacity(opacity);
    canvas.drawRect((size).toRect(), paint);

    // Clear light areas with BlendMode.clear (cut holes)
    final clearPaint = Paint()..blendMode = BlendMode.clear;
    for (final light in lightAreas) {
      canvas.drawCircle(light.center.toOffset(), light.radius, clearPaint);
    }

    canvas.restore(); // restore layer and apply transparency properly
  }

  @override
  bool get isOpaque => false;
}
