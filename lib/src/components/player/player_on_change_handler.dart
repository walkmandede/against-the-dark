import 'package:flame/components.dart';
import 'package:pixel_adventure/src/components/obstacles/obstacle.dart';
import 'package:pixel_adventure/src/components/obstacles/spinning_blade.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/game/darkness.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/config.dart';

class PlayerOnChangeHandler {
  final PixelAdventure game;
  const PlayerOnChangeHandler(this.game);

  onChangePlayer({required EnumPlayerCharacter enumCharacter}) {
    final levelWorld = game.levelWorld;
    final player = levelWorld.player;

    if (enumCharacter == player.currentCharacter.value) {
      return;
    }

    final xCanUse =
        player.playerAbilitiesHandler.playerSwitchCooldown.startCooldown();
    if (!xCanUse) {
      return;
    }

    player.currentCharacter.value = enumCharacter;
    player.updateAnimations();

    //
    _setDefaultValues();

    if (enumCharacter == EnumPlayerCharacter.virtualGuy) {
      _virtualGuyHandler();
    } else if (enumCharacter == EnumPlayerCharacter.maskDude) {
      _maskDudeHandler();
    } else if (enumCharacter == EnumPlayerCharacter.ninjaFrog) {
      _ninjaFrogHandler();
    } else if (enumCharacter == EnumPlayerCharacter.pinkMan) {
      _pinkManHandler();
    } else {}
  }

  void _virtualGuyHandler() async {
    await Future.delayed(const Duration(milliseconds: 100));
    game.cam.viewfinder.zoom = AppConfig.virtualGuyZoomLevel;

    final levelWorld = game.levelWorld;
    final player = levelWorld.player;

    levelWorld.darkness.lightAreas.removeWhere(
      (element) {
        return element.enumLightAreaType == EnumLightAreaType.player;
      },
    );
    levelWorld.darkness.lightAreas.add(
      LightArea(
        "player",
        EnumLightAreaType.player,
        player.position,
        player.size.y * AppConfig.virtualGuyLightRadius,
      ),
    );
  }

  void _maskDudeHandler() {
    final levelWorld = game.levelWorld;
    final player = levelWorld.player;
  }

  void _pinkManHandler() {
    final levelWorld = game.levelWorld;
    final player = levelWorld.player;
    final obstacles = levelWorld.children.whereType<Obstacle>();
    game.levelWorld.darkness.lightAreas.addAll([
      ...obstacles.map((e) {
        final obstacle = e as SpriteAnimationComponent;
        return LightArea(
          "",
          EnumLightAreaType.obstacles,
          obstacle.position,
          obstacle.size.x,
        );
      })
    ]);
  }

  void _ninjaFrogHandler() {}

  _setDefaultValues() {
    //setting default zoom
    game.cam.viewfinder.zoom = AppConfig.defaultZoomLevel;
    //clearing extra lightareas
    game.levelWorld.darkness.lightAreas.removeWhere((e) {
      return e.enumLightAreaType != EnumLightAreaType.player &&
          e.enumLightAreaType != EnumLightAreaType.torch;
    });
    game.levelWorld.darkness.lightAreas.firstWhere((e) {
      return e.enumLightAreaType == EnumLightAreaType.player;
    }).radius =
        game.levelWorld.player.size.x * AppConfig.defaultPlayerLightRadius;
  }
}
