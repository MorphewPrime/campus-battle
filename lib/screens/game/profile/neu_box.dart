import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final child;
  final color1;
  final color2;
  final color3;
  final bool isCircular;
  final double neuWidth;
  const NeuBox(
      {super.key,
      required this.child,
      required this.color1,
      required this.color2,
      required this.color3,
      this.isCircular = false,
      this.neuWidth = 500});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: neuWidth + 16,
      padding: EdgeInsets.all(8),
      child: Center(child: child),
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(isCircular ? 500 : 12),
        boxShadow: [
          BoxShadow(
            color: color2,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: color3,
            blurRadius: 13,
            offset: const Offset(-5, -5),
          )
        ],
      ),
    );
  }
}
