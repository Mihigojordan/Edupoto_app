import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';

class ForStudentWidget extends StatelessWidget {
  final String? studentInfo;
  const ForStudentWidget({super.key, this.studentInfo, });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5),
      child: Card(
        color: ColorResources.getBackgroundColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text('for_student'.tr, style: rubikSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: ColorResources.getGreyBaseGray1())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(studentInfo!)),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
