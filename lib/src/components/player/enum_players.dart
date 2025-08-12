import 'package:flutter/foundation.dart';
import 'package:pixel_adventure/src/components/player/ability_cooldown_model.dart';

enum EnumPlayerCharacter {
  maskDude(
      name: "Mask Dude",
      imagePath: "Mask Dude",
      thumbnail: "assets/images/Main Characters/Mask Dude/Fall (32x32).png",
      passive: EnumAbilities.litTorch,
      abilities: [
        EnumAbilities.forwardLightOrb,
        EnumAbilities.upLightOrb,
        EnumAbilities.downLightOrb,
      ]),
  ninjaFrog(
      name: "Ninja Frog",
      imagePath: "Ninja Frog",
      thumbnail: "assets/images/Main Characters/Ninja Frog/Fall (32x32).png",
      passive: EnumAbilities.doubleJump,
      abilities: [
        EnumAbilities.defyGravity,
      ]),
  pinkMan(
    name: "Pink Man",
    imagePath: "Pink Man",
    thumbnail: "assets/images/Main Characters/Pink Man/Fall (32x32).png",
    abilities: [
      EnumAbilities.setCheckPoint,
    ],
    passive: EnumAbilities.noRisk,
  ),
  virtualGuy(
    name: "Virtual Guy",
    imagePath: "Virtual Guy",
    thumbnail: "assets/images/Main Characters/Virtual Guy/Fall (32x32).png",
    passive: EnumAbilities.megaLamp,
    abilities: [],
  ),
  ;

  final String name;
  final String imagePath;
  final String thumbnail;
  final EnumAbilities passive;
  final List<EnumAbilities> abilities;
  const EnumPlayerCharacter({
    required this.name,
    required this.imagePath,
    required this.thumbnail,
    required this.passive,
    required this.abilities,
  });
}

enum EnumAbilities {
  litTorch(
    name: "Lit Torch",
    desc: "Can lit the torch to generate light",
    shortKey: "",
  ),
  noRisk(
    name: "No Risk",
    desc: "Can see obstacles",
    shortKey: "",
  ),
  megaLamp(
    name: "Mega Lamp",
    desc: "More light area around the character",
    shortKey: "",
  ),
  doubleJump(
    name: "Double Jump",
    desc: "Can jump once more on air",
    shortKey: "",
  ),
  defyGravity(
    name: "Defy Gravity",
    desc: "Reduce gravity force for a moment",
    shortKey: "J",
  ),
  upLightOrb(
    name: "Upward Light Orb",
    desc: "Emit a light orb upward",
    shortKey: "K",
  ),
  downLightOrb(
    name: "Downward Light Orb",
    desc: "Emit a light orb downward",
    shortKey: "L",
  ),
  forwardLightOrb(
    name: "Forward Light Orb",
    desc: "Emit a light orb forward",
    shortKey: "J",
  ),
  setCheckPoint(
    name: "Set Check Point",
    desc: "Set a check point while on ground",
    shortKey: "J",
  ),
  ;

  final String name;
  final String desc;
  final String shortKey;
  const EnumAbilities({
    required this.name,
    required this.desc,
    required this.shortKey,
  });
}
