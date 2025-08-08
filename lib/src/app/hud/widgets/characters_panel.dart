import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class CharactersPanel extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const CharactersPanel({super.key, required this.pixelAdventure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: dataController.deviceSize.x * 0.1,
      child: LayoutBuilder(
        builder: (a1, c1) {
          return ValueListenableBuilder(
              valueListenable:
                  pixelAdventure.levelWorld.player.currentCharacter,
              builder: (_, currentCharacter, __) {
                return ValueListenableBuilder(
                    valueListenable: pixelAdventure
                        .levelWorld
                        .player
                        .playerAbilitiesHandler
                        .playerSwitchCooldown
                        .remainingCooldown,
                    builder: (_, remainingCooldown, __) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...EnumPlayerCharacter.values.map((each) {
                            int index =
                                EnumPlayerCharacter.values.indexOf(each);
                            bool xSelectd = currentCharacter == each;
                            return GestureDetector(
                              onTap: () {
                                pixelAdventure.levelWorld.player.changePlayer(
                                  enumPlayer: each,
                                );
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(c1.maxHeight * 0.1),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: xSelectd
                                            ? Colors.orange
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Image.asset(
                                            each.thumbnail,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: c1.maxHeight * 0.05,
                                              vertical: c1.maxHeight * 0.025,
                                            ),
                                            child: Text("${index + 1}"),
                                          ),
                                        ),
                                        if (remainingCooldown > 0)
                                          SizedBox.expand(
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black
                                                    .withOpacity(0.85),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "${remainingCooldown.ceil()}",
                                                      style: const TextStyle(
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.orange,
                                                      value: remainingCooldown /
                                                          pixelAdventure
                                                              .levelWorld
                                                              .player
                                                              .playerAbilitiesHandler
                                                              .playerSwitchCooldown
                                                              .cooldownInSecond,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      );
                    });
              });
        },
      ),
    );
  }
}
