import 'package:flutter/material.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';
import 'package:share_plus/share_plus.dart';

class CustomShareWidget extends StatelessWidget {
  final double? height, width;
  final double borderRadius; // New parameter for customization
  final BoxFit? fit; // Optional image fit control

  const CustomShareWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 5.0, // Default value
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent, // Ensures background doesn't cover image
        ),
        child: Image.asset(
          Images.share,
          fit: fit, // Controls how image fills the space
        ),
      ),
    );
  }
}

  void shareApp() {
    Share.share(
      'Check out this awesome app: ${AppConstants.appShareLink}',
      subject: 'App Recommendation',
    );
  }