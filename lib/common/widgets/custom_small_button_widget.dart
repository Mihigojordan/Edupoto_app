
import 'package:flutter/material.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';

class CustomSmallButtonWidget extends StatelessWidget {
  final String? text;
  final Function onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double textSize;
  const CustomSmallButtonWidget({super.key,
    this.backgroundColor,
    required this.onTap,
    this.text,
    required this.textColor,
    this.textSize = Dimensions.fontSizeLarge,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
        ),
      ),
      child:  Text(
        text!,
        style: rubikRegular.copyWith(
          color: textColor,
          fontSize: textSize,
        ),
      ),
    );
  }
  //Dimensions.FONT_SIZE_EXTRA_LARGE
}
