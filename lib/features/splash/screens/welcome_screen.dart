import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/main.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/custom_logo_widget.dart';

class WelcomeScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  final String? password;

  const WelcomeScreen({
    super.key,
    this.phoneNumber,
    this.countryCode,
    this.password,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override

  void initState() {
     if (!kIsWeb) {
         Get.find<AuthController>()
        .authenticateWithBiometric(false, widget.password)
        .then((value) {
      Get.offAllNamed(RouteHelper.getLoginRoute(
        countryCode: widget.countryCode,
        phoneNumber: widget.phoneNumber,
      ));
    });
    
     }else{
  
  Get.offAllNamed(RouteHelper.getRestart());

     }
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraExtraLarge),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
            bottomRight: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomLogoWidget(
              height: 90,
              width: 90,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Text(
              '${'welcome_to'.tr} ${AppConstants.appName} !',
              textAlign: TextAlign.center,
              style: rubikMedium.copyWith(
                color: Theme.of(context).textTheme.titleLarge!.color,
                fontSize: Dimensions.fontSizeOverOverLarge,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeOverLarge,
            ),
            Text(
              'A new parenting experience!'.tr,
              textAlign: TextAlign.center,
              style: rubikLight.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeLarge,
            ),
        //     DefaultButtonWidth(
        //         onPress: () =>   Get.offNamed(RouteHelper.getLoginRoute(
        //   countryCode: userData.countryCode,
        //   phoneNumber: userData.phone,
        // )),
        //         title: 'title',
        //         color1: kamber300Color,
        //         color2: kyellowColor,
        //         width: 150)
          ],
        ),
      ),
    );
  }
}
