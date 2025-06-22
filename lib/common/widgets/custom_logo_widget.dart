import 'package:flutter/material.dart';
import 'package:hosomobile/util/images.dart';

class CustomLogoWidget extends StatelessWidget {
  final double? height, width;
  final double borderRadius;
  const CustomLogoWidget({super.key, this.height, this.width, this.borderRadius=5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.transparent, // Ensures background doesn't cover image
      ),
      child: Image.asset(Images.logo),
    );
  }
}
