import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGImageLoader extends StatelessWidget {
  final String asset;
  final BoxFit fit;
  final double? height, width;

  const SVGImageLoader(
      {super.key,
      required this.asset,
      required this.fit,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      fit: fit,
      height: height,
      width: width,
    );
  }
}
