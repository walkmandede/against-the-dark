import 'package:flame/components.dart';
import 'package:pixel_adventure/utils/app_enums.dart';

class CollisionHelper {
  static EnumCollisionType getCollisionTypeFromPoints({
    required PositionComponent target,
    required Set<Vector2> intersectionPoints,
    double tolerance = 2.0,
    Vector2? playerVelocity,
  }) {
    int topHits = 0;
    int bottomHits = 0;
    int leftHits = 0;
    int rightHits = 0;

    final top = target.position.y;
    final bottom = target.position.y + target.size.y;
    final left = target.position.x;
    final right = target.position.x + target.size.x;

    for (final point in intersectionPoints) {
      if ((point.y - top).abs() < tolerance) topHits++;
      if ((point.y - bottom).abs() < tolerance) bottomHits++;
      if ((point.x - left).abs() < tolerance) leftHits++;
      if ((point.x - right).abs() < tolerance) rightHits++;
    }

    // If player is falling and there's a top collision, prioritize it
    if (playerVelocity != null && playerVelocity.y > 0 && topHits > 0) {
      return EnumCollisionType.top;
    }

    final sideHits = {
      EnumCollisionType.top: topHits,
      EnumCollisionType.bot: bottomHits,
      EnumCollisionType.left: leftHits,
      EnumCollisionType.right: rightHits,
    };

    // Get the side with the most hits
    return sideHits.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }
}
