import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_game/components/enemy_component.dart';
import 'package:flame_game/components/score_component.dart';
import 'package:flutter/material.dart';

import 'components/player_component.dart';

void main() {
  runApp(
    GameWidget(
      game: SpaceShooterGame(),
      overlayBuilderMap: const {
        'GameOver': _gameOverMenuBuilder,
      },
    ),
  );
}

Widget _gameOverMenuBuilder(BuildContext buildContext, SpaceShooterGame game) {
  return const Center(
    child: Text(
      'Game Over',
      style: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white),
    ),
  );
}

class SpaceShooterGame extends FlameGame
    with PanDetector, TapDetector, HasCollisionDetection {
  late Player player;
  late ScoreComponent score;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    player = Player();
    add(player);

    score = ScoreComponent();
    add(score);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }

  void onGameEnd() {
    pauseEngine();
    overlays.add("GameOver");
  }

  @override
  void onTap() {
    if (!overlays.isActive("GameOver")) {
      return;
    }

    overlays.remove("GameOver");
    resumeEngine();
    player = Player();
    add(player);
    score.resetScore();
  }
}
