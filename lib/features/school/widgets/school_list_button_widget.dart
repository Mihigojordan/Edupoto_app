import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';

class SchoolListButtonWidget extends StatelessWidget {
  final String text;
  final int index;
  final List<SchoolLists> schoolList;

  const SchoolListButtonWidget({super.key, required this.text, required this.index, required this.schoolList});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Get.find<SchoolListController>().schoolListIndex == index ? Theme.of(context).secondaryHeaderColor :  Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
          border: Border.all(width: .5,color: ColorResources.getGreyColor())
      ),
      child: CustomInkWellWidget(
        onTap: () => Get.find<SchoolListController>().setIndex(index),
        radius: Dimensions.radiusSizeLarge,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
          child: Text(text,
              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Get.find<SchoolListController>().schoolListIndex == index
                  ? ColorResources.blackColor : Theme.of(context).textTheme.titleLarge!.color)),
        ),
      ),
    );
  }
}
