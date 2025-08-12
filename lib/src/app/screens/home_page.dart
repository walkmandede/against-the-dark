import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/app/hud/game_hud.dart';
import 'package:pixel_adventure/src/app/hud/pause_menu.dart';
import 'package:pixel_adventure/src/app/hud/victory_dialog.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.black,
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (a1, c1) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: c1.maxWidth * 0.05,
              vertical: c1.maxHeight * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aginst the dark",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.yellow,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: c1.smallest.shortestSide * 0.05,
                ),
                Flexible(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: EnumLevels.values.length,
                    itemBuilder: (context, index) {
                      final eachLevel = EnumLevels.values[index];
                      return GestureDetector(
                        onTap: () {
                          if (eachLevel.xPlayable) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return _gameWidget(
                                  levelName: eachLevel.levelName,
                                );
                              },
                            ));
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            16,
                          )),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    eachLevel.thumbnail,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Text(
                                          "Comming Soon",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(16),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (a2, c2) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                eachLevel.label,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: c1.smallest.shortestSide * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.yellow,
                      ),
                      label: const Text("How to play"),
                      icon: const Icon(Icons.help_rounded),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _gameWidget({required String levelName}) {
    return PopScope(
      canPop: false,
      child: GameWidget.controlled(
        gameFactory: () {
          return PixelAdventure(
            levelName: levelName,
            onQuitGame: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            },
          );
        },
        overlayBuilderMap: {
          EnumOverlayRouter.hud.name: (context, game) {
            return GameHud(pixelAdventure: game as PixelAdventure);
          },
          EnumOverlayRouter.pauseMenu.name: (context, game) {
            return PauseMenu(pixelAdventure: game as PixelAdventure);
          },
          EnumOverlayRouter.victory.name: (context, game) {
            return VictoryDialog(pixelAdventure: game as PixelAdventure);
          },
        },
        loadingBuilder: (p0) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
