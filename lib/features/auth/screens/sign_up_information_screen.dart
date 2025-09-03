import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_country_code_widget.dart';
import 'package:hosomobile/common/widgets/custom_dialog_widget.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/controllers/create_account_controller.dart';
import 'package:hosomobile/features/onboarding/controllers/on_boarding_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/camera_verification/controllers/camera_screen_controller.dart';
import 'package:hosomobile/common/models/signup_body_model.dart';
import 'package:hosomobile/features/verification/controllers/verification_controller.dart';
import 'package:hosomobile/helper/dialog_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_large_widget.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:hosomobile/features/auth/widgets/gender_field_widget.dart';
import 'package:hosomobile/features/auth/widgets/sign_up_input_widget.dart';

class SignUpInformationScreen extends StatefulWidget {
  const SignUpInformationScreen({super.key});

  @override
  State<SignUpInformationScreen> createState() =>
      _SignUpInformationScreenState();
}

class _SignUpInformationScreenState extends State<SignUpInformationScreen> {
  TextEditingController occupationTextController = TextEditingController();
  TextEditingController fNameTextController = TextEditingController();
  TextEditingController lNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => _onWillPop(context),
      child: Scaffold(
        appBar: CustomAppbarWidget(
            title: 'information'.tr, onTap: () => _onWillPop(context)),
        body: Column(children: [
          Expanded(
              flex: 10,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GenderFieldWidget(),
                  const SizedBox(height: Dimensions.paddingSizeLarge),
                  SignUpInputWidget(
                    occupationController: occupationTextController,
                    fNameController: fNameTextController,
                    lNameController: lNameTextController,
                    emailController: emailTextController,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),
                ],
              ))),
          GetBuilder<ProfileController>(builder: (getController) {
            return SizedBox(
                height: 110,
                child: CustomLargeButtonWidget(
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  text: 'proceed'.tr,
                  onTap: () {
                    if (fNameTextController.text == '' ||
                        lNameTextController.text == '') {
                      showCustomSnackBarHelper('first_name_or_last_name'.tr);
                    } else {
                      String password = '1234'; //passController.text.trim();
                      String confirmPassword = '1234'; //confirmPassController.text.trim();

                      if (password.isEmpty || confirmPassword.isEmpty) {
                        showCustomSnackBarHelper('enter_your_pin'.tr);
                      } else if (password.length < 4) {
                        showCustomSnackBarHelper('pin_should_be_4_digit'.tr);
                      } else if (password != confirmPassword) {
                        showCustomSnackBarHelper('pin_not_matched'.tr);
                      } else {
                        String gender = Get.find<ProfileController>().gender;
                        String countryCode =
                            CustomCountryCodeWidget.getCountryCode(
                                Get.find<CreateAccountController>()
                                    .phoneNumber)!;
                        String phoneNumber = Get.find<CreateAccountController>()
                            .phoneNumber!
                            .replaceAll(countryCode, '');
                        File? image =
                            Get.find<CameraScreenController>().getImage;
                        String? otp = Get.find<VerificationController>().otp;

                        SignUpBodyModel signUpBody = SignUpBodyModel(
                            fName: fNameTextController.text,
                            lName: lNameTextController.text,
                            gender: gender,
                            occupation: 'parent',
                            email: emailTextController.text,
                            phone: phoneNumber,
                            otp: otp,
                            password: password,
                            dialCountryCode: countryCode);

                        MultipartBody multipartBody =
                            MultipartBody('image', image);
                        Get.find<AuthController>()
                            .registration(signUpBody, [multipartBody]);
                        // Get.toNamed(RouteHelper.getPinSetRoute(
                        //   signUpBody: SignUpBodyModel(
                        //     fName: fNameTextController.text,
                        //     lName: lNameTextController.text,
                        //     email: emailTextController.text,
                        //     occupation: 'parent',
                        //   ),
                        // ));
                      }
                    }
                  },
                ));
          })
        ]),
      ),
    );
  }

  Future _onWillPop(BuildContext context) async {
    DialogHelper.showAnimatedDialog(
      context,
      CustomDialogWidget(
          icon: Icons.clear,
          title: 'alert'.tr,
          description: 'your_information_will_remove'.tr,
          isFailed: true,
          onTapFalseText: 'no'.tr,
          onTapTrueText: 'yes'.tr,
          onTapFalse: () => Get.back(),
          onTapTrue: () {
            Get.find<CameraScreenController>().removeImage();
            Get.find<OnBoardingController>().updatePageIndex(0);
            return Get.offAllNamed(RouteHelper.getSplashRoute());
          }),
      dismissible: false,
      isFlip: true,
    );
  }
}
