import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class GameStatsPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const GameStatsPanel({
    super.key,
    required this.pixelAdventure,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (a1, c1) {
      final maxSide = max(c1.maxWidth, c1.maxHeight);
      final minSide = min(c1.maxWidth, c1.maxHeight);
      return Padding(
        padding: EdgeInsets.all(minSide * 0.025),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder(
                valueListenable: pixelAdventure.levelWorld.failCount,
                builder: (context, failCount, child) {
                  return ValueListenableBuilder(
                    valueListenable: pixelAdventure.levelWorld.totalTime,
                    builder: (context, totalTime, child) {
                      return Card(
                        color: Colors.white.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: EdgeInsets.all(minSide * 0.01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: minSide * 0.025,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        "Time:  ${totalTime.ceil()} seconds",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: minSide * 0.025,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        "Respwan: $failCount",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      );
    });
  }
}
