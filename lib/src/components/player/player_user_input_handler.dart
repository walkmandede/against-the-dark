import 'package:flutter/services.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/utils/logger.dart';

import 'enum_players.dart';

class PlayerUserInputHandler {
  static onKeyEvent(
      KeyEvent? event, Set<LogicalKeyboardKey> keysPressed, Player player) {
    player.movementX = 0;

    final moveLeft = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final moveRight = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final moveUp = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);
    final keyJ = keysPressed.contains(LogicalKeyboardKey.keyJ);
    final keyK = keysPressed.contains(LogicalKeyboardKey.keyK);
    final keyL = keysPressed.contains(LogicalKeyboardKey.keyL);

    if (moveLeft) player.movementX = -1;
    if (moveRight) player.movementX = 1;

    if (moveUp) {
      player.playerAbilitiesHandler.jump();
    }

    if (keysPressed.contains(LogicalKeyboardKey.digit1)) {
      player.changePlayer(enumPlayer: EnumPlayerCharacter.values[0]);
    }
    if (keysPressed.contains(LogicalKeyboardKey.digit2)) {
      player.changePlayer(enumPlayer: EnumPlayerCharacter.values[1]);
    }
    if (keysPressed.contains(LogicalKeyboardKey.digit3)) {
      player.changePlayer(enumPlayer: EnumPlayerCharacter.values[2]);
    }
    if (keysPressed.contains(LogicalKeyboardKey.digit4)) {
      player.changePlayer(enumPlayer: EnumPlayerCharacter.values[3]);
    }

    //ability 1
    if (keyJ) {
      abilityJHandler(player: player);
    }
    if (keyK) {
      abilityKHandler(player: player);
    }
    if (keyL) {
      abilityLHandler(player: player);
    }
  }

  static void abilityJHandler({required Player player}) {
    switch (player.currentCharacter.value) {
      case EnumPlayerCharacter.maskDude:
        player.playerAbilitiesHandler.emitHLightOrb();
      case EnumPlayerCharacter.ninjaFrog:
        player.playerAbilitiesHandler.dash();

      case EnumPlayerCharacter.pinkMan:
        player.playerAbilitiesHandler.setCheckPoint();
        break;
      case EnumPlayerCharacter.virtualGuy:
      // TODO: Handle this case.
    }
  }

  static void abilityKHandler({required Player player}) {
    switch (player.currentCharacter.value) {
      case EnumPlayerCharacter.maskDude:
        player.playerAbilitiesHandler.emitVLightOrb(xUp: true);
      case EnumPlayerCharacter.ninjaFrog:
      case EnumPlayerCharacter.pinkMan:
        break;
      case EnumPlayerCharacter.virtualGuy:
      // TODO: Handle this case.
    }
  }

  static void abilityLHandler({required Player player}) {
    switch (player.currentCharacter.value) {
      case EnumPlayerCharacter.maskDude:
        player.playerAbilitiesHandler.emitVLightOrb(xUp: false);
      case EnumPlayerCharacter.ninjaFrog:
      case EnumPlayerCharacter.pinkMan:
        break;
      case EnumPlayerCharacter.virtualGuy:
      // TODO: Handle this case.
    }
  }
}
