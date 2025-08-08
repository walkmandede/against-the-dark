/*
 Steps to impelemts (by Eddie)

 1. Add update of AbilityCooldown in PlayerAbilitiesHandler
 2. When user try to use the ability, call the function startCooldwon().
    it will return a boolean value if the ability can be used.
  
  e.g.
  final xStarted = checkPointAbilityCooldown.startCooldown();
  print(xStarted);
  if (!xStarted) {
    return;
  }
 */

import 'package:flutter/foundation.dart';

class AbilityCooldown {
  double cooldownInSecond;
  ValueNotifier<double> remainingCooldown;

  AbilityCooldown({
    required this.cooldownInSecond,
    ValueNotifier<double>? remainingCooldown,
  }) : remainingCooldown = remainingCooldown ?? ValueNotifier(0);

  bool xReadyToUse() {
    return remainingCooldown.value <= 0;
  }

  AbilityCooldown copyWith({required double? remainingCooldown}) {
    return AbilityCooldown(
      cooldownInSecond: cooldownInSecond,
      remainingCooldown: ValueNotifier(
        remainingCooldown ?? this.remainingCooldown.value,
      ),
    );
  }

  update({required double dt}) {
    if (xInCooldown()) {
      remainingCooldown.value -= dt;
      if (remainingCooldown.value < 0) {
        remainingCooldown.value = 0;
      }
    }
  }

  bool xInCooldown() => remainingCooldown.value > 0;

  bool startCooldown() {
    if (xInCooldown()) {
      return false;
    } else {
      remainingCooldown.value = cooldownInSecond;
      return true;
    }
  }
}
