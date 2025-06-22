import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/introduction/widget/custom_help_widget.dart';
import 'package:hosomobile/features/introduction/widget/custom_share_widget.dart';
import 'package:hosomobile/features/introduction/widget/custom_user_guider_widget.dart';
import 'package:hosomobile/features/language/controllers/localization_controller.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/common/widgets/custom_logo_widget.dart';
import 'package:hosomobile/common/widgets/rounded_button_widget.dart';
import 'package:hosomobile/util/show_install_dialogue.dart';

class AppBarHeaderWidget extends StatelessWidget {
  const AppBarHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String languageText = AppConstants.languages[Get.find<LocalizationController>().selectedIndex].languageName!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => showInstallPrompt(context),
            child: Column(
              children: [
                const CustomLogoWidget(height: 50.0, width: 50.0,borderRadius: 5.0),
                sizedBox5,
                Text('Install', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black))
              ],
            ),
          ),
          InkWell(
            onTap: playYoutubeVideo,
            child: Column(
              children: [
                 const CustomUserGuideWidget(height: 50.0, width: 50.0),
                sizedBox5,
                Text('Guide', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black))
              ],
            ),
          ),
          InkWell(
            onTap: showHelpOptions,
            child: Column(
              children: [
            const CustomHelpWidget(height: 50.0, width: 50.0),
                sizedBox5,
                Text('Help', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black))
              ],
            ),
          ),
          InkWell(
            onTap: shareApp,
            child: Column(
              children: [
                 const CustomShareWidget(height: 50.0, width: 50.0),
                sizedBox5,
                Text('Share', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black))
              ],
            ),
          ),
     
        ],
      ),
    );
  }
}