import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final bool fadeIn;
  final Widget child;
  final Duration duration;

  const FadeAnimation(
      {super.key,
        this.fadeIn = true,
      required this.child,
      this.duration = const Duration(milliseconds: 500)});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: fadeIn ? 1 : 0,
      curve: Curves.easeIn,
      duration: duration,
      child: child,
    );
  }
}
