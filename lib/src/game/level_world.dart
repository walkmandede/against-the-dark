import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/src/components/collisions/collision_platform.dart';
import 'package:pixel_adventure/src/components/collisions/collision_step.dart';
import 'package:pixel_adventure/src/components/obstacles/spinning_blade.dart';
import 'package:pixel_adventure/src/components/others/checkpoint.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/src/game/darkness.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/config.dart';

import '../components/others/torch.dart';

class LevelWorld extends World with HasGameRef<PixelAdventure> {
  final String levelName;
  final Player player;
  LevelWorld({required this.levelName, required this.player});

  late TiledComponent level;
  late Darkness darkness;
  late Checkpoint checkpoint;

  @override
  FutureOr<void> onLoad() async {
    game.overlays.add(EnumOverlayRouter.hud.name);
    checkpoint = Checkpoint(position: Vector2(0, 0));
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);
    add(player);
    add(checkpoint);
    game.cam.follow(player);

    //adding spwanpoints
    final spawnpointsLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpoints");
    for (final TiledObject each in (spawnpointsLayer?.objects ?? [])) {
      switch (each.class_) {
        case "Player":
          player.position = Vector2(each.x, each.y);
          player.setCheckPoint(point: player.position.xy);
          break;
        case "SpinningBlade":
          final _hAxis = each.properties.byName["hAxis"];
          final _axisAmount = each.properties.byName["axisAmount"];
          bool? xHAxis;
          double? axisAmount;
          if (_hAxis != null) {
            if (_hAxis.type == PropertyType.bool) {
              xHAxis = _hAxis.value as bool;
            }
          }

          if (_axisAmount != null) {
            if (_axisAmount.type == PropertyType.float) {
              axisAmount = double.tryParse((_axisAmount.value.toString()));
            }
          }
          final spinningBlade = SpinningBlade(
            id: each.name,
            position: Vector2(each.x, each.y),
            size: each.size,
            customProperties: each.properties,
            xHAxis: xHAxis ?? false,
            axisAmount: axisAmount ?? 1,
          );
          add(spinningBlade);
      }
    }

    //add collisions
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>("Collisions");
    for (final TiledObject each in (collisionsLayer?.objects ?? [])) {
      switch (each.class_) {
        case "Platform":
          final platform = CollisionPlatform(
            id: each.name,
            position: Vector2(each.x, each.y),
            size: each.size,
          );
          add(platform);
          break;
        case "Step":
          final step = CollisionStep(
            id: each.name,
            position: Vector2(each.x, each.y),
            size: each.size,
          );
          add(step);
          break;
        case "Torch":
          final torch = Torch(
            position: Vector2(each.x, each.y),
          );
          add(torch);
          break;
        default:
          break;
      }
    }

    //setDarkness
    _setDefaultDarkness();

    //setInitialCharacter
    player.playerOnChangeHandler
        .onChangePlayer(enumCharacter: EnumPlayerCharacter.maskDude);

    return super.onLoad();
  }

  void _setDefaultDarkness() {
    darkness = Darkness(
      size: level.size,
      lightAreas: [],
      opacity: AppConfig.darknessLevel,
    );
    add(darkness);

    darkness.lightAreas.add(
      LightArea(
        "player",
        EnumLightAreaType.player,
        player.position,
        player.size.x * 2,
      ),
    );
  }
}
