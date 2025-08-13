import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:pixel_adventure/utils/app_enums.dart';

DataController dataController = DataController();

class DataController {
  Vector2 deviceSize = Vector2(1200, 1200);
  ValueNotifier<EnumControllerMode> enumControllerMode =
      ValueNotifier(EnumControllerMode.keyboard);
}
