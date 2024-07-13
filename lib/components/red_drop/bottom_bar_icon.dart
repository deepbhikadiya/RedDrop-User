import 'package:flutter/material.dart';

class CommonAppIcon extends StatelessWidget {
  const CommonAppIcon({super.key, required this.image,this.width,this.height});

  final String image;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height??24,
      width: width??24,
      fit: BoxFit.contain,
    );
  }
}
