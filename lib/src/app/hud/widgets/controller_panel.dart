import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/components/player/player_user_input_handler.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/logger.dart';

class ControllerPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const ControllerPanel({
    super.key,
    required this.pixelAdventure,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (a1, c1) {
      final minSide = min(c1.maxWidth, c1.maxHeight);
      return Padding(
          padding: EdgeInsets.all(minSide * 0.025),
          child: Row(
            children: [
              //left
              GestureDetector(
                onTapUp: (_) {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {},
                    pixelAdventure.levelWorld.player,
                  );
                },
                onTapCancel: () {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {},
                    pixelAdventure.levelWorld.player,
                  );
                },
                onTapDown: (details) {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {LogicalKeyboardKey.keyA},
                    pixelAdventure.levelWorld.player,
                  );
                },
                child: Card(
                  shape: const CircleBorder(),
                  color: Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.all(minSide * 0.05),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTapUp: (_) {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {},
                    pixelAdventure.levelWorld.player,
                  );
                },
                onTapCancel: () {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {},
                    pixelAdventure.levelWorld.player,
                  );
                },
                onTapDown: (details) {
                  PlayerUserInputHandler.onKeyEvent(
                    null,
                    {LogicalKeyboardKey.keyD},
                    pixelAdventure.levelWorld.player,
                  );
                },
                child: Card(
                  shape: const CircleBorder(),
                  color: Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.all(minSide * 0.05),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  pixelAdventure.levelWorld.player.playerAbilitiesHandler
                      .jump();
                },
                child: Card(
                  shape: const CircleBorder(),
                  color: Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: EdgeInsets.all(minSide * 0.05),
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
