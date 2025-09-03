import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/home_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<ProfileController>(builder: (controller)=> controller.userInfo != null
            ? Text(
          '${'hi'.tr} ${controller.userInfo?.fName ?? ''} ${controller.userInfo?.lName ?? ''}',
          textAlign: TextAlign.start, maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: rubikLight.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Colors.white.withOpacity(0.5),
          ),
        )
            : Text('hi_user'.tr,style: rubikLight.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Colors.white.withOpacity(0.5))),
        ),

        GetBuilder<HomeController>(builder: (controller){
          return Text(
            controller.greetingMessage(), style: rubikRegular.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white,
          ),
          );
        }),
      ],
    );
  }
}