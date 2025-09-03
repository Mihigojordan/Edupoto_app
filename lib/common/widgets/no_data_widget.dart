import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/shop/screen/shop_screen.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/util/styles.dart';
class NoDataFoundWidget extends StatelessWidget {
  final bool? fromHome;
  const  NoDataFoundWidget({super.key, this.fromHome = false});

  @override
  Widget build(BuildContext context) {
    return fromHome! ?  noDataWidget(context) : SizedBox(height: MediaQuery.of(context).size.height * 0.6, child: noDataWidget(context));
  }

  Padding noDataWidget(BuildContext context) {
    return Padding(
    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset( Images.noData, width: 150, height: 150),

          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
             'babyeyi_school_is_being_prepared'.tr, textAlign: TextAlign.center, style: rubikRegular,
          ),
          const SizedBox(height: 40),
         DefaultButtonWidth(onPress: ()=>Get.to(const ShoppingScreen()), title: 'continue_shopping'.tr, color1: kyellow800Color, color2: kamber300Color, width: 250,fontSize: 16,)
        ],
      ),
    ),
  );
  }
}
