import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/src/components/collisions/collision_platform.dart';
import 'package:pixel_adventure/src/components/collisions/collision_step.dart';
import 'package:pixel_adventure/src/components/obstacles/spinning_blade.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/components/player/player_abilities_handler.dart';
import 'package:pixel_adventure/src/components/player/player_collision_controller.dart';
import 'package:pixel_adventure/src/components/player/player_on_change_handler.dart';
import 'package:pixel_adventure/src/components/player/player_user_input_handler.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/collision_helper.dart';

class PlayerHitBox {
  final Vector2 position;
  final Vector2 size;

  PlayerHitBox({
    required this.position,
    required this.size,
  });
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler, CollisionCallbacks {
  Player() : super();

  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;

  final PlayerHitBox playerHitBox = PlayerHitBox(
    position: Vector2(10, 4),
    size: Vector2(14, 28),
  );

  EnumPlayerState currentPlayerState = EnumPlayerState.idle;

  double moveSpeedX = 100;
  double gravity = 800; // pixels per second squared
  double jumpForce = -300; // negative because up
  bool isOnGround = false;

  Vector2 velocity = Vector2.zero();
  double movementX = 0;

  ValueNotifier<EnumPlayerCharacter> currentCharacter =
      ValueNotifier(EnumPlayerCharacter.virtualGuy);
  //controllers and handlers
  late PlayerOnChangeHandler playerOnChangeHandler;
  late PlayerAbilitiesHandler playerAbilitiesHandler;

  @override
  FutureOr<void> onLoad() async {
    //setting handlers

    playerOnChangeHandler = PlayerOnChangeHandler(game);
    playerAbilitiesHandler = PlayerAbilitiesHandler(game: game);
    game.levelWorld.add(playerAbilitiesHandler);
    anchor = Anchor.center;
    add(
      RectangleHitbox(
        size: playerHitBox.size,
        position: playerHitBox.position,
        isSolid: true,
      ),
    );
    updateAnimations();
    return super.onLoad();
  }

  changePlayer({required EnumPlayerCharacter enumPlayer}) {
    playerOnChangeHandler.onChangePlayer(enumCharacter: enumPlayer);
  }

  void setCheckPoint({required Vector2 point}) {
    game.levelWorld.checkpoint.position = point.xy;
  }

  @override
  void update(double dt) {
    super.update(dt);

    updatePlayerMovement(dt);
    updatePlayerState();
  }

  void updatePlayerMovement(double dt) {
    // Horizontal movement
    velocity.x = movementX * moveSpeedX;

    // Gravity
    velocity.y += gravity * dt;

    // Apply velocity to position
    position += velocity * dt;

    // Reset ground flag each frame
    isOnGround = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    PlayerCollisionController.onCollision(intersectionPoints, other, this);
    super.onCollision(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    PlayerUserInputHandler.onKeyEvent(event, keysPressed, this);
    return super.onKeyEvent(event, keysPressed);
  }

  void joystickHandler({
    required EnumPlayerMoveDirection enumPlayerMoveDirection,
  }) {
    if (enumPlayerMoveDirection == EnumPlayerMoveDirection.left) {
      movementX = -1;
    } else if (enumPlayerMoveDirection == EnumPlayerMoveDirection.right) {
      movementX = 1;
    } else {
      movementX = 0;
    }
  }

  void updatePlayerState() {
    // Flip sprite
    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Set animation state
    currentPlayerState =
        velocity.x != 0 ? EnumPlayerState.run : EnumPlayerState.idle;
    current = currentPlayerState;
  }

  void updateAnimations() {
    idleAnimation = setThisAnimation(
      name: currentCharacter.value.name,
      amount: 11,
      enumPlayerState: EnumPlayerState.idle,
    );

    runAnimation = setThisAnimation(
      name: currentCharacter.value.name,
      amount: 12,
      enumPlayerState: EnumPlayerState.run,
    );

    animations = {
      EnumPlayerState.idle: idleAnimation,
      EnumPlayerState.run: runAnimation,
    };

    current = EnumPlayerState.idle;
  }

  SpriteAnimation setThisAnimation({
    required String name,
    required int amount,
    required EnumPlayerState enumPlayerState,
  }) {
    final path = "Main Characters/$name/${enumPlayerState.path}";
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(path),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
