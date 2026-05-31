import 'package:flutter/material.dart';

class ScannerCorner extends StatelessWidget {
  final Color color;

  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  const ScannerCorner({
    super.key,
    required this.color,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft:
              topLeft ? const Radius.circular(18) : Radius.zero,
          topRight:
              topRight ? const Radius.circular(18) : Radius.zero,
          bottomLeft:
              bottomLeft ? const Radius.circular(18) : Radius.zero,
          bottomRight:
              bottomRight ? const Radius.circular(18) : Radius.zero,
        ),
        border: Border(
          top: topLeft || topRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          left: topLeft || bottomLeft
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          right: topRight || bottomRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
          bottom: bottomLeft || bottomRight
              ? BorderSide(color: color, width: 4)
              : BorderSide.none,
        ),
      ),
    );
  }
}