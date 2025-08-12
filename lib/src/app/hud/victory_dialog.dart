import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/app/hud/widgets/abilities_panel.dart';
import 'package:pixel_adventure/src/app/hud/widgets/action_panel.dart';
import 'package:pixel_adventure/src/app/hud/widgets/characters_panel.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class VictoryDialog extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const VictoryDialog({super.key, required this.pixelAdventure});

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
                    child: ValueListenableBuilder(
                      valueListenable: pixelAdventure.levelWorld.failCount,
                      builder: (context, failCount, child) {
                        return ValueListenableBuilder(
                          valueListenable: pixelAdventure.levelWorld.totalTime,
                          builder: (context, totalTime, child) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Victory"),
                                Text("Failed Count : $failCount"),
                                Text("Time : ${totalTime.round()} seconds"),
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
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
