import 'package:flame/components.dart';
import 'package:pixel_adventure/src/components/others/light_orb.dart';

import 'package:pixel_adventure/src/components/player/enum_players.dart';
import 'package:pixel_adventure/src/game/darkness.dart';
import 'package:pixel_adventure/src/game/my_game.dart';
import 'package:pixel_adventure/utils/config.dart';

import 'ability_cooldown_model.dart';

class PlayerAbilitiesHandler extends Component {
  final PixelAdventure game;
  PlayerAbilitiesHandler({required this.game});

  int _jumpsUsed = 0;

  AbilityCooldown playerSwitchCooldown = AbilityCooldown(
    cooldownInSecond: 3,
  );
  AbilityCooldown checkPointAbilityCooldown = AbilityCooldown(
    cooldownInSecond: 60,
  );
  AbilityCooldown blinkAbilityCooldown = AbilityCooldown(
    cooldownInSecond: 10,
  );

  AbilityCooldown lightOrbAbilityCooldown = AbilityCooldown(
    cooldownInSecond: 5,
  );

  LightOrb? hLightOrb;
  LightOrb? vLightOrb;

  @override
  void update(double dt) {
    //add cooldowns
    checkPointAbilityCooldown.update(dt: dt);
    playerSwitchCooldown.update(dt: dt);
    blinkAbilityCooldown.update(dt: dt);
    lightOrbAbilityCooldown.update(dt: dt);

    //light orb animation
    _hLightOrbHandler(dt: dt);
    _vLightOrbHandler(dt: dt);
    super.update(dt);
  }

  //start of jump
  void jump() {
    final player = game.levelWorld.player;

    // Decide allowed jumps based on the character type
    final int maxJumps =
        (player.currentCharacter.value == EnumPlayerCharacter.ninjaFrog)
            ? 2 // ninjaFrog can double jump
            : 1; // others only single jump

    // Only jump if we still have jumps available
    if (_jumpsUsed < maxJumps) {
      // Optional: make extra jumps weaker
      double force =
          (_jumpsUsed == 0) ? player.jumpForce : player.jumpForce * 0.9;

      player.velocity.y = force;
      player.isOnGround = false;
      _jumpsUsed++;
    }
  }
  //end of jump

  // Call when the player lands back on the ground
  void onPlayerLanded() {
    _jumpsUsed = 0;
  }

  //start of checkpoint
  void setCheckPoint() {
    final player = game.levelWorld.player;

    if (player.currentCharacter.value == EnumPlayerCharacter.pinkMan) {
      final xStarted = checkPointAbilityCooldown.startCooldown();
      if (!xStarted) {
        return;
      }
      if (player.isOnGround) {
        player.setCheckPoint(
          point: Vector2(
            player.position.x,
            player.position.y - (game.levelWorld.checkpoint.size.y * 0.25),
          ),
        );
      }
    }
  }
  //end of checkpoint

  //start of blink
  void blink() {
    final player = game.levelWorld.player;

    if (player.currentCharacter.value == EnumPlayerCharacter.ninjaFrog) {
      final xStarted = blinkAbilityCooldown.startCooldown();
      if (!xStarted) {
        return;
      }

      player.movementX = player.isFlippedHorizontally ? -8 : 8;
      Future.delayed(const Duration(milliseconds: 500)).then(
        (value) {
          player.movementX = 0;
        },
      );
    }
  }
  //end of blink

  //start of Light Orb

  void emitHLightOrb() async {
    final player = game.levelWorld.player;

    if (player.currentCharacter.value == EnumPlayerCharacter.maskDude) {
      final xStarted = lightOrbAbilityCooldown.startCooldown();
      if (!xStarted) {
        return;
      }

      //start
      final bool xFaceLeft = player.isFlippedHorizontally;
      Vector2 moveSpeed = Vector2(
        xFaceLeft
            ? -(AppConfig.lighrOrbSize).x * 5
            : (AppConfig.lighrOrbSize).x * 5,
        0,
      );
      hLightOrb = LightOrb(
        position: Vector2(
          player.position.x + player.size.x * 0.5,
          player.position.y - player.size.y * 0.5 + 16,
        ),
        velocity: moveSpeed,
      );
      player.game.levelWorld.add(hLightOrb!);
      await Future.delayed(const Duration(milliseconds: 3000));
      _clearLightOrb();
    }
  }

  void emitVLightOrb({required bool xUp}) async {
    final player = game.levelWorld.player;

    if (player.currentCharacter.value == EnumPlayerCharacter.maskDude) {
      final xStarted = lightOrbAbilityCooldown.startCooldown();
      if (!xStarted) {
        return;
      }

      //start

      Vector2 moveSpeed = Vector2(
        0,
        xUp ? -(AppConfig.lighrOrbSize).y * 5 : (AppConfig.lighrOrbSize).y * 5,
      );
      vLightOrb = LightOrb(
        position: Vector2(
          player.position.x,
          player.position.y - player.size.y * 0.5 + 16,
        ),
        velocity: moveSpeed,
      );
      player.game.levelWorld.add(vLightOrb!);
      await Future.delayed(const Duration(milliseconds: 3000));
      _clearLightOrb();
    }
  }

  void _clearLightOrb() {
    final player = game.levelWorld.player;

    if (hLightOrb != null) {
      hLightOrb!.finishAbitily();
      hLightOrb = null;
    }
    if (vLightOrb != null) {
      vLightOrb!.finishAbitily();
      vLightOrb = null;
    }
  }

  void _hLightOrbHandler({required double dt}) {
    if (hLightOrb == null) {
      return;
    }
    final player = game.levelWorld.player;

    hLightOrb!.position += hLightOrb!.velocity * dt;
    game.cam.follow(hLightOrb!);
    final world = game.levelWorld;
    world.darkness.lightAreas.add(
      LightArea(
        "LightOrb",
        EnumLightAreaType.lightOrb,
        hLightOrb!.position,
        hLightOrb!.size.x * 3,
      ),
    );
  }

  void _vLightOrbHandler({required double dt}) {
    if (vLightOrb == null) {
      return;
    }
    final player = game.levelWorld.player;

    vLightOrb!.position += vLightOrb!.velocity * dt;
    game.cam.follow(vLightOrb!);
    final world = game.levelWorld;
    world.darkness.lightAreas.add(
      LightArea(
        "LightOrb",
        EnumLightAreaType.lightOrb,
        vLightOrb!.position,
        vLightOrb!.size.x * 3,
      ),
    );
  }

  //end of Light Orb
}
