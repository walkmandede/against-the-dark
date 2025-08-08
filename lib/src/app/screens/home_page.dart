import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/src/app/hud/game_hud.dart';
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
                ...EnumLevels.values.map((e) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) {
                          return _gameWidget(levelName: e.levelName);
                        },
                      ));
                    },
                    child: Text(e.name),
                  );
                })
              ],
            ),
          );
        },
      ),
    );
  }

  _gameWidget({required String levelName}) {
    return GameWidget.controlled(
      gameFactory: () {
        return PixelAdventure(levelName: levelName);
      },
      overlayBuilderMap: {
        EnumOverlayRouter.hud.name: (context, game) {
          return GameHud(pixelAdventure: game as PixelAdventure);
        }
      },
      loadingBuilder: (p0) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
