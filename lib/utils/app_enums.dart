enum EnumControllerMode { touch, keyboard }

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

enum EnumOverlayRouter { controller, hud, pauseMenu, initialMenu, victory }

enum EnumLevels {
  blackCastle(
    label: "Black Castle",
    levelName: "black-castle",
    thumbnail: "assets/images/thumbnails/dark_castle_tb.png",
    xPlayable: true,
  ),
  cursedJungle(
    label: "Cursed Jungle",
    levelName: "cursed_jungle",
    thumbnail: "assets/images/thumbnails/cursed_jungle_tb.png",
    xPlayable: true,
  ),
  outerSpace(
    label: "Outer Space",
    levelName: "outer_space",
    thumbnail: "",
    xPlayable: false,
  ),
  lavaMaze(
    label: "Lava Maze",
    levelName: "lava_maze",
    thumbnail: "",
    xPlayable: false,
  ),
  underwater(
    label: "Under Water",
    levelName: "under_water",
    thumbnail: "",
    xPlayable: false,
  ),
  ;

  final String label;
  final String levelName;
  final String thumbnail;
  final bool xPlayable;
  const EnumLevels({
    required this.label,
    required this.levelName,
    required this.thumbnail,
    required this.xPlayable,
  });
}
