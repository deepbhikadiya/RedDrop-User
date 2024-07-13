import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, required this.image,this.width,this.height,this.borderRadius,this.padding});

  final String image;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?? 75,
      width: width?? 75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??200)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius??200),
          child: Padding(
            padding: EdgeInsets.all(padding??0),
            child: Image.asset(image,fit: BoxFit.cover,),
          )),
    );
  }
}
