import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class CharactersPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const CharactersPanel({super.key, required this.pixelAdventure});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (a1, c1) {
        return ValueListenableBuilder(
            valueListenable: pixelAdventure.levelWorld.player.currentCharacter,
            builder: (_, currentCharacter, __) {
              return ValueListenableBuilder(
                  valueListenable: pixelAdventure
                      .levelWorld
                      .player
                      .playerAbilitiesHandler
                      .playerSwitchCooldown
                      .remainingCooldown,
                  builder: (_, remainingCooldown, __) {
                    final minSide = min(c1.maxWidth, c1.maxHeight);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: EdgeInsets.all(
                            minSide * 0.025,
                          ),
                          color: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.all(
                              minSide * 0.025,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...EnumPlayerCharacter.values.map((each) {
                                  bool xSelected = currentCharacter == each;
                                  final xLast =
                                      EnumPlayerCharacter.values.last == each;
                                  return GestureDetector(
                                    onTap: () {
                                      pixelAdventure.levelWorld.player
                                          .changePlayer(enumPlayer: each);
                                    },
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: minSide * 0.075,
                                                height: minSide * 0.075,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  fit: StackFit.expand,
                                                  children: [
                                                    DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: xSelected
                                                            ? Colors.yellow
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1000),
                                                        image: DecorationImage(
                                                          image: Image.asset(
                                                                  each.thumbnail)
                                                              .image,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    if (remainingCooldown > 0)
                                                      CircleAvatar(
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.8),
                                                      ),
                                                    if (remainingCooldown > 0)
                                                      Center(
                                                        child: FittedBox(
                                                          child: Text(
                                                            "${remainingCooldown.ceil()}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (remainingCooldown > 0)
                                                      CircularProgressIndicator(
                                                        color: Colors.yellow,
                                                        value: remainingCooldown /
                                                            pixelAdventure
                                                                .levelWorld
                                                                .player
                                                                .playerAbilitiesHandler
                                                                .playerSwitchCooldown
                                                                .cooldownInSecond,
                                                      )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: minSide * 0.015,
                                              ),
                                              SizedBox(
                                                // width: minSide * 0.05,
                                                height: minSide * 0.05,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          FittedBox(
                                                            child: Text(
                                                              each.name,
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: minSide * 0.005,
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          children: [
                                                            ...each.abilities
                                                                .map((ability) {
                                                              return Padding(
                                                                padding: EdgeInsets.only(
                                                                    right: minSide *
                                                                        0.005),
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      1,
                                                                  child: SizedBox
                                                                      .expand(
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                FittedBox(
                                                                              child: Text(ability.shortKey),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (pixelAdventure.levelWorld.player.playerAbilitiesHandler.abilitiesCooldownMap[ability] !=
                                                                            null)
                                                                          ValueListenableBuilder(
                                                                            valueListenable:
                                                                                pixelAdventure.levelWorld.player.playerAbilitiesHandler.abilitiesCooldownMap[ability]!.remainingCooldown,
                                                                            builder: (context,
                                                                                remainingCooldown,
                                                                                child) {
                                                                              if (remainingCooldown > 0) {
                                                                                return CircleAvatar(
                                                                                  backgroundColor: Colors.black.withOpacity(0.8),
                                                                                  child: Center(
                                                                                    child: FittedBox(
                                                                                      child: Text(
                                                                                        remainingCooldown.ceil().toString(),
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
                                                                        if (pixelAdventure.levelWorld.player.playerAbilitiesHandler.abilitiesCooldownMap[ability] !=
                                                                            null)
                                                                          ValueListenableBuilder(
                                                                            valueListenable:
                                                                                pixelAdventure.levelWorld.player.playerAbilitiesHandler.abilitiesCooldownMap[ability]!.remainingCooldown,
                                                                            builder: (context,
                                                                                remainingCooldown,
                                                                                child) {
                                                                              return CircularProgressIndicator(
                                                                                color: Colors.yellow,
                                                                                value: remainingCooldown / pixelAdventure.levelWorld.player.playerAbilitiesHandler.abilitiesCooldownMap[ability]!.cooldownInSecond,
                                                                              );
                                                                            },
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          if (!xLast)
                                            SizedBox(
                                              height: minSide * 0.025,
                                            )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            });
      },
    );
  }
}
