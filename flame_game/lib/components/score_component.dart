import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_game/main.dart';
import 'package:flutter/material.dart';

class ScoreComponent extends TextComponent with HasGameRef<SpaceShooterGame> {
  int _score = 0;
  final TextPaint _paint;

  ScoreComponent()
      : _paint = TextPaint(
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    position = Vector2(game.size.x / 2, gameRef.size.y * 0.1);
    text = "$_score";
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    _paint.render(canvas, '$_score', Vector2.zero());
  }

  void increaseScore() {
    _score++;
  }

  void resetScore() {
    _score = 0;
  }
}
