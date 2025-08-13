import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class AbilitiesPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const AbilitiesPanel({
    super.key,
    required this.pixelAdventure,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (a1, c1) {
      final minSide = min(c1.maxWidth, c1.maxHeight);
      return Padding(
        padding: EdgeInsets.all(minSide * 0.025),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder(
              valueListenable:
                  pixelAdventure.levelWorld.player.currentCharacter,
              builder: (context, currentCharacter, child) {
                return _eachPlayerAbilityWidget(
                  currentCharacter: currentCharacter,
                  minSide: minSide,
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _eachPlayerAbilityWidget(
      {required EnumPlayerCharacter currentCharacter,
      required double minSide}) {
    return Card(
      color: Colors.white.withOpacity(0.3),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white)),
      child: Padding(
        padding: EdgeInsets.all(minSide * 0.025),
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
                      currentCharacter.name,
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
                      "Passive : ${currentCharacter.passive.name}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
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
                      currentCharacter.passive.desc,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: minSide * 0.0125,
            ),
            ...currentCharacter.abilities.map(
              (ability) {
                return SizedBox(
                  height: minSide * 0.05,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: minSide * 0.015),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: FittedBox(
                                    child: Text(ability.shortKey),
                                  ),
                                ),
                              ),
                              if (pixelAdventure
                                      .levelWorld
                                      .player
                                      .playerAbilitiesHandler
                                      .abilitiesCooldownMap[ability] !=
                                  null)
                                ValueListenableBuilder(
                                  valueListenable: pixelAdventure
                                      .levelWorld
                                      .player
                                      .playerAbilitiesHandler
                                      .abilitiesCooldownMap[ability]!
                                      .remainingCooldown,
                                  builder: (context, remainingCooldown, child) {
                                    if (remainingCooldown > 0) {
                                      return CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.8),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              remainingCooldown
                                                  .ceil()
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              if (pixelAdventure
                                      .levelWorld
                                      .player
                                      .playerAbilitiesHandler
                                      .abilitiesCooldownMap[ability] !=
                                  null)
                                ValueListenableBuilder(
                                  valueListenable: pixelAdventure
                                      .levelWorld
                                      .player
                                      .playerAbilitiesHandler
                                      .abilitiesCooldownMap[ability]!
                                      .remainingCooldown,
                                  builder: (context, remainingCooldown, child) {
                                    return CircularProgressIndicator(
                                      color: Colors.yellow,
                                      value: remainingCooldown /
                                          pixelAdventure
                                              .levelWorld
                                              .player
                                              .playerAbilitiesHandler
                                              .abilitiesCooldownMap[ability]!
                                              .cooldownInSecond,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: minSide * 0.0125,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  ability.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  ability.desc,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
