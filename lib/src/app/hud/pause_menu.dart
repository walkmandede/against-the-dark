import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/app/hud/widgets/abilities_panel.dart';
import 'package:pixel_adventure/src/app/hud/widgets/action_panel.dart';
import 'package:pixel_adventure/src/app/hud/widgets/characters_panel.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class PauseMenu extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const PauseMenu({super.key, required this.pixelAdventure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: Center(
            child: LayoutBuilder(
              builder: (a1, c1) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(
                      min(c1.maxHeight, c1.maxWidth) * 0.05,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("The game is paused"),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pixelAdventure.resumeGame();
                          },
                          child: Text("Resume"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pixelAdventure.quitGame();
                          },
                          child: Text("Quit"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
