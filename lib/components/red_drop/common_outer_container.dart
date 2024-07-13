import 'package:flutter/material.dart';

import '../../res/color_schema.dart';

class CommonOuterContainer extends StatelessWidget {
  const CommonOuterContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.topLeftCorner,
    this.topRightCorner,
    this.bottomLeftCorner,
    this.bottomRightCorner,
    this.padding,
    this.onTap,
    this.color
  });

  final Widget child;
  final double? height;
  final double? width;
  final double? topLeftCorner;
  final double? topRightCorner;
  final double? bottomLeftCorner;
  final double? bottomRightCorner;
  final Color? color;
  final EdgeInsets? padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){},
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height,
        width: width,
        padding: padding??EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRightCorner??10),
              topLeft: Radius.circular(topLeftCorner??10),
              bottomLeft: Radius.circular(bottomLeftCorner??10),
              bottomRight: Radius.circular(bottomRightCorner??10),
            ),
            border: Border.all(
                color: AppColor.secondaryTextColor,
                width: 2
            )
        ),
        child: child,
      ),
    );
  }
}
