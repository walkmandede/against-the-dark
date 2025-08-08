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
    return Card(
      color: Colors.white.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.yellow,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dataController.deviceSize.x * 0.025,
          vertical: dataController.deviceSize.y * 0.015,
        ),
        child: ValueListenableBuilder(
          valueListenable: pixelAdventure.levelWorld.player.currentCharacter,
          builder: (context, currentCharcter, child) {
            switch (currentCharcter) {
              case EnumPlayerCharacter.maskDude:
                return _maskDudeAbilities();
              case EnumPlayerCharacter.ninjaFrog:
                return _ninjaFrogAbilities();
              case EnumPlayerCharacter.pinkMan:
                return _pinkManAbilities();
              case EnumPlayerCharacter.virtualGuy:
                return _virtualGuyAbilities();
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _ninjaFrogAbilities() {
    final abilityHandler =
        pixelAdventure.levelWorld.player.playerAbilitiesHandler;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Ninja Frog, the Ninja"),
        const Text(
          """
+ can double jump
""",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        ValueListenableBuilder(
          valueListenable:
              abilityHandler.blinkAbilityCooldown.remainingCooldown,
          builder: (context, remainingCooldown, child) {
            return GestureDetector(
              onTap: () {
                abilityHandler.blink();
              },
              child: Column(
                children: [
                  Card(
                    shape: const CircleBorder(),
                    child: SizedBox(
                      width: dataController.deviceSize.x * 0.075,
                      height: dataController.deviceSize.x * 0.075,
                      child: Stack(
                        children: [
                          const Center(child: Icon(Icons.abc_outlined)),
                          if (remainingCooldown > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: SizedBox.expand(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ),
                            ),
                          Center(
                            child: CircularProgressIndicator(
                              value: remainingCooldown /
                                  abilityHandler
                                      .blinkAbilityCooldown.cooldownInSecond,
                              color: Colors.yellow,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text("J")
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _maskDudeAbilities() {
    final abilityHandler =
        pixelAdventure.levelWorld.player.playerAbilitiesHandler;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Mask Dude, the Scout"),
        const Text(
          """
+ can lit the torch by hitting
""",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable:
                  abilityHandler.lightOrbAbilityCooldown.remainingCooldown,
              builder: (context, remainingCooldown, child) {
                return GestureDetector(
                  onTap: () {
                    abilityHandler.emitHLightOrb();
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: const CircleBorder(),
                        child: SizedBox(
                          width: dataController.deviceSize.x * 0.075,
                          height: dataController.deviceSize.x * 0.075,
                          child: Stack(
                            children: [
                              const Center(child: Icon(Icons.abc_outlined)),
                              if (remainingCooldown > 0)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: SizedBox.expand(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              Center(
                                child: CircularProgressIndicator(
                                  value: remainingCooldown /
                                      abilityHandler.lightOrbAbilityCooldown
                                          .cooldownInSecond,
                                  color: Colors.yellow,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Text("J")
                    ],
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable:
                  abilityHandler.lightOrbAbilityCooldown.remainingCooldown,
              builder: (context, remainingCooldown, child) {
                return GestureDetector(
                  onTap: () {
                    abilityHandler.emitVLightOrb(xUp: true);
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: const CircleBorder(),
                        child: SizedBox(
                          width: dataController.deviceSize.x * 0.075,
                          height: dataController.deviceSize.x * 0.075,
                          child: Stack(
                            children: [
                              const Center(child: Icon(Icons.abc_outlined)),
                              if (remainingCooldown > 0)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: SizedBox.expand(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              Center(
                                child: CircularProgressIndicator(
                                  value: remainingCooldown /
                                      abilityHandler.lightOrbAbilityCooldown
                                          .cooldownInSecond,
                                  color: Colors.yellow,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Text("K")
                    ],
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable:
                  abilityHandler.lightOrbAbilityCooldown.remainingCooldown,
              builder: (context, remainingCooldown, child) {
                return GestureDetector(
                  onTap: () {
                    abilityHandler.emitVLightOrb(xUp: false);
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: const CircleBorder(),
                        child: SizedBox(
                          width: dataController.deviceSize.x * 0.075,
                          height: dataController.deviceSize.x * 0.075,
                          child: Stack(
                            children: [
                              const Center(child: Icon(Icons.abc_outlined)),
                              if (remainingCooldown > 0)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: SizedBox.expand(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              Center(
                                child: CircularProgressIndicator(
                                  value: remainingCooldown /
                                      abilityHandler.lightOrbAbilityCooldown
                                          .cooldownInSecond,
                                  color: Colors.yellow,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Text("L")
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _pinkManAbilities() {
    final abilityHandler =
        pixelAdventure.levelWorld.player.playerAbilitiesHandler;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Pink Man, the Saver"),
        const Text(
          "+ can double jump",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ValueListenableBuilder(
          valueListenable:
              abilityHandler.checkPointAbilityCooldown.remainingCooldown,
          builder: (context, remainingCooldown, child) {
            return GestureDetector(
              onTap: () {
                abilityHandler.setCheckPoint();
              },
              child: Column(
                children: [
                  Card(
                    shape: const CircleBorder(),
                    child: SizedBox(
                      width: dataController.deviceSize.x * 0.075,
                      height: dataController.deviceSize.x * 0.075,
                      child: Stack(
                        children: [
                          const Center(child: Icon(Icons.abc_outlined)),
                          if (remainingCooldown > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: SizedBox.expand(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ),
                            ),
                          Center(
                            child: CircularProgressIndicator(
                              value: remainingCooldown /
                                  abilityHandler.checkPointAbilityCooldown
                                      .cooldownInSecond,
                              color: Colors.yellow,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text("J")
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _virtualGuyAbilities() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Virtual Guy, the Light Master"),
        const Text(
          """
+ 3x light area
""",
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("J - Blink"))
      ],
    );
  }
}
