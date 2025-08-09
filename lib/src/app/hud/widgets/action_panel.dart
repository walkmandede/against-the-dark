import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';

class ActionPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const ActionPanel({super.key, required this.pixelAdventure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: dataController.deviceSize.x * 0.1,
      child: LayoutBuilder(
        builder: (a1, c1) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(min(c1.maxWidth, c1.maxHeight) * 0.05),
                child: GestureDetector(
                  onTap: () {
                    pixelAdventure.pauseGame();
                  },
                  child: Card(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                            min(c1.maxWidth, c1.maxHeight) * 0.05),
                        child: const Icon(Icons.pause),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
