enum EnumPlayerState {
  idle(path: "Idle (32x32).png"),
  run(path: "Run (32x32).png");

  final String path;
  const EnumPlayerState({required this.path});
}

enum EnumPlayerMoveDirection {
  left,
  right,
  none,
}

enum EnumCollisionType { top, left, right, bot }

enum EnumOverlayRouter { controller, hud, pauseMenu, initialMenu }

enum EnumLevels {
  blackCastle(label: "Black Castle", levelName: "black-castle"),
  greenJungle(label: "Green Jungle", levelName: "level-1"),
  ;

  final String label;
  final String levelName;
  const EnumLevels({
    required this.label,
    required this.levelName,
  });
}
