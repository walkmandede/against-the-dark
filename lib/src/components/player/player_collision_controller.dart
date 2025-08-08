import 'package:flame/components.dart';
import 'package:pixel_adventure/src/components/collisions/collision_platform.dart';
import 'package:pixel_adventure/src/components/collisions/collision_step.dart';
import 'package:pixel_adventure/src/components/obstacles/spinning_blade.dart';
import 'package:pixel_adventure/src/components/others/torch.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/components/player/player.dart';
import 'package:pixel_adventure/utils/app_enums.dart';
import 'package:pixel_adventure/utils/collision_helper.dart';
import 'package:pixel_adventure/utils/logger.dart';

class PlayerCollisionController {
  static void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other, Player player) {
    if (other is CollisionPlatform) {
      PlayerCollisionController.onCollideWithPlatform(
        player: player,
        other: other,
        intersectionPoints: intersectionPoints,
      );
    } else if (other is CollisionStep) {
      PlayerCollisionController.onCollideWithStep(
        player: player,
        other: other,
        intersectionPoints: intersectionPoints,
      );
    } else if (other is SpinningBlade) {
      PlayerCollisionController.onCollideWithObstacle(
        player: player,
        other: other,
        intersectionPoints: intersectionPoints,
      );
    } else if (other is Torch) {
      PlayerCollisionController.onCollideWithTorch(
        player: player,
        other: other,
        intersectionPoints: intersectionPoints,
      );
    }
  }

  static void onCollideWithPlatform({
    required Player player,
    required PositionComponent other,
    required Set<Vector2> intersectionPoints,
  }) {
    final collisionType = CollisionHelper.getCollisionTypeFromPoints(
      target: other,
      intersectionPoints: intersectionPoints,
    );

    final spriteHalfHeight = player.size.y / 2;
    final spriteHalfWidth = player.size.x / 2;
    final hitBoxHalfWidth = player.playerHitBox.size.x / 2;
    superPrint(collisionType);
    switch (collisionType) {
      case EnumCollisionType.left:
        if (player.velocity.x > 0) {
          player.position.x = other.position.x -
              (player.playerHitBox.position.x + player.playerHitBox.size.x) +
              player.size.x / 2;
          player.velocity.x = 0;
        }
        break;
      case EnumCollisionType.right:
        if (player.velocity.x < 0) {
          player.position.x = other.position.x +
              other.size.x -
              (hitBoxHalfWidth - spriteHalfWidth);

          player.velocity.x = 0;
        }

        break;

      case EnumCollisionType.top:
        if (player.velocity.y > 0) {
          // Align player's bottom edge with block's top edge
          player.position.y = other.position.y - spriteHalfHeight;
          player.velocity.y = 0;
          player.isOnGround = true;
          player.playerAbilitiesHandler.onPlayerLanded();
        }
        break;

      case EnumCollisionType.bot:
        if (player.velocity.y < 0) {
          // Align player's top edge with block's bottom edge
          player.position.y =
              other.position.y + other.size.y + spriteHalfHeight;
          player.velocity.y = 0;
        }
        break;
    }
  }

  static void onCollideWithStep({
    required Player player,
    required PositionComponent other,
    required Set<Vector2> intersectionPoints,
  }) {
    final collisionType = CollisionHelper.getCollisionTypeFromPoints(
      target: other,
      intersectionPoints: intersectionPoints,
    );

    final spriteHalfHeight = player.size.y / 2;
    final spriteHalfWidth = player.size.x / 2;
    final hitBoxHalfWidth = player.playerHitBox.size.x / 2;

    switch (collisionType) {
      case EnumCollisionType.left:
        if (player.velocity.x > 0) {
          player.position.x = other.position.x -
              (player.playerHitBox.position.x + player.playerHitBox.size.x) +
              player.size.x / 2;
          player.velocity.x = 0;
        }
        break;
      case EnumCollisionType.right:
        if (player.velocity.x < 0) {
          player.position.x = other.position.x +
              other.size.x -
              (hitBoxHalfWidth - spriteHalfWidth);

          player.velocity.x = 0;
        }

        break;

      case EnumCollisionType.top:
        if (player.velocity.y > 0) {
          // Align player's bottom edge with block's top edge
          player.position.y = other.position.y - spriteHalfHeight;
          player.velocity.y = 0;
          player.isOnGround = true;
          player.playerAbilitiesHandler.onPlayerLanded();
        }
        break;

      case EnumCollisionType.bot:
        break;
    }
  }

  static void onCollideWithTorch({
    required Player player,
    required PositionComponent other,
    required Set<Vector2> intersectionPoints,
  }) {
    if (player.currentCharacter.value != EnumPlayerCharacter.maskDude) {
      return;
    }

    final torch = other as Torch;
    torch.litUp();
  }

  static void onCollideWithObstacle({
    required Player player,
    required PositionComponent other,
    required Set<Vector2> intersectionPoints,
  }) {
    player.position = player.game.levelWorld.checkpoint.position.xy;
  }
}
