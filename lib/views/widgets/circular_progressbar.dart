import 'package:flutter/material.dart';

class CircularProgressbar extends StatelessWidget {
  final Color color;
  final double height, width;

  const CircularProgressbar({
    super.key,
    required this.color,
    this.height = 30,
    this.width = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
