import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/components/explosion.dart';
import 'package:flame_game/components/player_component.dart';
import 'package:flame_game/main.dart';

import 'bullet_component.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );

  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet || other is Player) {
      removeFromParent();
      other.removeFromParent();
      game.score.increaseScore();
      game.add(Explosion(position: position));
      if (other is Player) {
        game.onGameEnd();
      }
    }
  }
}
