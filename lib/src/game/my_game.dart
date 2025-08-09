import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/darkness.dart';
import 'package:pixel_adventure/src/game/level_world.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/config.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapDetector,
        WidgetsBindingObserver {
  late LevelWorld levelWorld;
  late CameraComponent cam;
  late JoystickComponent joystick;
  bool xShouldShowJoystick = false;

  final String levelName;
  final Function() onQuitGame;
  PixelAdventure({
    required this.levelName,
    required this.onQuitGame,
  });

  @override
  Color backgroundColor() {
    return const Color(0xff110e17);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      pauseGame();
    } else if (state == AppLifecycleState.resumed) {}
  }

  void pauseGame() {
    overlays.add(EnumOverlayRouter.pauseMenu.name);
    pauseEngine();
  }

  void resumeGame() {
    overlays.remove(EnumOverlayRouter.pauseMenu.name);
    resumeEngine();
  }

  void quitGame() {
    onQuitGame();
  }

  @override
  void onTap() {
    super.onTap();
  }

  @override
  void onDispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onDispose();
  }

  @override
  FutureOr<void> onLoad() async {
    WidgetsBinding.instance.addObserver(this);
    await images.loadAllImages();
    debugMode = false;
    levelWorld = LevelWorld(levelName: levelName, player: Player());
    cam = CameraComponent.withFixedResolution(
        world: levelWorld,
        width: dataController.deviceSize.x,
        height: dataController.deviceSize.y);
    // cam.viewfinder.anchor = Anchor.topLeft;
    cam.viewfinder.anchor = Anchor.center;
    cam.viewfinder.zoom = AppConfig.defaultZoomLevel;
    await addAll([
      cam,
      levelWorld,
    ]);
    addJoyStick();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    handleJoystick();

    super.update(dt);
  }

  handleJoystick() {
    if (!xShouldShowJoystick) {
      return;
    }
    final player = levelWorld.player;
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.joystickHandler(
          enumPlayerMoveDirection: EnumPlayerMoveDirection.left,
        );
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.joystickHandler(
          enumPlayerMoveDirection: EnumPlayerMoveDirection.right,
        );
      case JoystickDirection.up:
      case JoystickDirection.down:
      case JoystickDirection.idle:
        player.joystickHandler(
          enumPlayerMoveDirection: EnumPlayerMoveDirection.none,
        );
      default:
    }
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      background: CircleComponent(
        radius: dataController.deviceSize.y * 0.1,
        paint: Paint()..color = Colors.black.withOpacity(0.4),
      ),
      knob: CircleComponent(
        radius: dataController.deviceSize.y * 0.06,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      // position: Vector2(dataController.deviceSize.x * 0.1, dataController.deviceSize.x * 0.1),
      margin: EdgeInsets.only(
        bottom: dataController.deviceSize.y * 0.05,
        left: dataController.deviceSize.x * 0.025,
      ),
    );
    if (kIsWeb) {
      if (!kDebugMode) {
        xShouldShowJoystick = true;
        cam.viewport.add(joystick);
      } else {
        xShouldShowJoystick = false;
      }
      return;
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        cam.viewport.add(joystick);
        xShouldShowJoystick = true;
      }
    }
  }
}
