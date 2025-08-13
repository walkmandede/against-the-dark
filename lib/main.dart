import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/src/app/hud/game_hud.dart';
import 'package:pixel_adventure/src/app/screens/home_page.dart';
import 'package:pixel_adventure/src/controllers/data_controller.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/app_enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ValueNotifier<bool> xLoading = ValueNotifier(true);

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  initLoad() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      dataController.deviceSize =
          Vector2(context.size?.width ?? 300, context.size?.height ?? 300);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
      await Future.delayed(const Duration(milliseconds: 100));
      xLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _body,
    );
  }

  Widget get _body {
    return ValueListenableBuilder(
      valueListenable: xLoading,
      builder: (context, xLoadingValue, child) {
        if (xLoadingValue) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return const HomePage();
        }
      },
    );
  }
}
