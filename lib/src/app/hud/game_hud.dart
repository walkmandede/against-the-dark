import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/app/hud/widgets/abilities_panel.dart';
import 'package:pixel_adventure/src/app/hud/widgets/characters_panel.dart';
import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';

class GameHud extends StatelessWidget {
  final PixelAdventure pixelAdventure;
  const GameHud({super.key, required this.pixelAdventure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CharactersPanel(pixelAdventure: pixelAdventure),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AbilitiesPanel(
                  pixelAdventure: pixelAdventure,
                ),
              ),
            ],
          ),
        ));
  }
}
