import 'package:flutter/material.dart';

class ShakeAnimation extends StatelessWidget {
  final Widget child;
  final AnimationController controller;

  ShakeAnimation({required this.child, required this.controller})
      : shake = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.05, 0),
        ).chain(CurveTween(curve: Curves.elasticIn)).animate(controller);

  final Animation<Offset> shake;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shake.value.dx * 20, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
