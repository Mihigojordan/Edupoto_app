import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/screens/number_formating.dart';
import 'package:hosomobile/features/home/controllers/banner_controller.dart';
import 'package:hosomobile/features/home/controllers/bilboard_controller.dart';
import 'package:hosomobile/features/home/controllers/menu_controller.dart';
import 'package:hosomobile/features/home/domain/models/banner_model.dart';
import 'package:hosomobile/features/home/widgets/banner_widget.dart';
import 'package:hosomobile/features/home/widgets/bilboard_widget.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/show_install_dialogue.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/appbar_header_widget.dart';
import 'package:hosomobile/common/widgets/custom_country_code_widget.dart';
import 'package:hosomobile/common/widgets/custom_password_field_widget.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;

  const LoginScreen({super.key, this.phoneNumber, this.countryCode});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  NumberFormatting numberFormatted=NumberFormatting();
  TextEditingController passwordController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  final String _heroQrTag = 'hero-qr-tag';
  String? _countryCode;
  UserShortDataModel? userData;
  StreamSubscription<FGBGType>? subscription;
  bool rememberPin = false;
  List<BannerModel>? banners;

  void setCountryCode(String code) {
    _countryCode = code;
  }

  void setInitialCountryCode(String? code) {
    _countryCode = code;
  }

  @override
  void initState() {
    super.initState();
   // Use a post-frame callback to ensure the context is valid
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showInstallPrompt(context);
    // });
//Load Bilboard
   Get.find<BilboardController>().getBilboardList(true,type:2,application: 3).then((_) {
  banners = Get.find<BilboardController>().bannerList;
 
});

    userData = Get.find<AuthController>().getUserData();
    if (widget.phoneNumber != userData?.phone) {
      Get.find<AuthController>().removeUserData();
      userData = null;
    }

    // Load stored PIN
    _loadPin().then((storedPin) {
      if (storedPin != null) {
        passwordController.text = storedPin;
      }
    });

    Get.find<AuthController>().authenticateWithBiometric(true, null);
    setInitialCountryCode(widget.countryCode);
    phoneController.text = widget.phoneNumber ?? '';
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (authController) => AbsorbPointer(
          absorbing: authController.isLoading,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(color: Theme.of(context).primaryColor),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(color: Theme.of(context).cardColor),
                  ),
                ],
              ),
              const Positioned(
                top: Dimensions.paddingSizeOverLarge,
                left: 0,
                right: 0,
                child: AppBarHeaderWidget(),
              ),
              Positioned(
                top: 135,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge,
                    vertical: Dimensions.paddingSizeExtraExtraLarge,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
                      topRight: Radius.circular(Dimensions.radiusSizeExtraExtraLarge),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GetBuilder<AuthController>(builder: (controller) {
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'welcome_back'.tr,
                                    style: rubikLight.copyWith(
                                      color: Theme.of(context).textTheme.titleLarge!.color,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                  userData?.name != null
                                      ? SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            userData?.name ?? '',
                                            style: rubikMedium.copyWith(
                                              color: Theme.of(context).textTheme.titleLarge!.color,
                                              fontSize: Dimensions.fontSizeExtraOverLarge,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'user'.tr,
                                          style: rubikMedium.copyWith(
                                            color: Theme.of(context).textTheme.titleLarge!.color,
                                            fontSize: Dimensions.fontSizeExtraOverLarge,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Row(
                          children: [
                            Text(
                              'account'.tr,
                              style: rubikLight.copyWith(
                                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.9),
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: phoneController,
                                focusNode: phoneFocus,
                                onSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(passFocus);
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(top: 14),
                                  prefixIcon: CustomCountryCodeWidget(
                                    initSelect: widget.countryCode,
                                    onChanged: (countryCode) => setCountryCode(countryCode.dialCode!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  //       Divider(
                  //         color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.4),
                  //         height: 0.5,
                  //       ),
                  //       const SizedBox(height: Dimensions.paddingSizeExtraExtraLarge),
                  //       CustomPasswordFieldWidget(
                  //         hint: '＊＊＊＊',
                  //         controller: passwordController,
                  //         focusNode: passFocus,
                  //         isShowSuffixIcon: true,
                  //         isPassword: true,
                  //         isIcon: false,
                  //         textAlign: TextAlign.center,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //         const  SizedBox(width: 30,),
                  //           InkWell(
                  //             onTap: () => Get.toNamed(
                  //               RouteHelper.getForgetPassRoute(
                  //                 countryCode: _countryCode,
                  //                 phoneNumber: phoneController.text.trim(),
                  //               ),
                  //             ),
                  //             child: Text(
                  //               '${'forget_pin'.tr}?',
                  //               style: rubikRegular.copyWith(
                  //                 color: Theme.of(context).colorScheme.error.withOpacity(0.7),
                  //                 fontSize: Dimensions.fontSizeLarge,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       CheckboxListTile(
                  //   title:const Text('Remember PIN'),
                  //   value: rememberPin,
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       rememberPin = newValue!;
                  //     });
                  //   },
                  //    controlAffinity: ListTileControlAffinity.leading, // Places checkbox at the start
                  // ),   
            const     BilboardWidget()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return FloatingActionButton(
              onPressed: () {
                _login(context);
              },
              elevation: 0,
              backgroundColor: const Color(0xfffed114),
              child: controller.isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    )
                  : Icon(Icons.arrow_forward, color: ColorResources.blackColor, size: 28),
            );
          },
        ),
      ),
    );
  }

// Function to save PIN in SharedPreferences
Future<void> _savePin(String pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_pin', pin);
}

// Function to load PIN from SharedPreferences
Future<String?> _loadPin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_pin');
}

Future<void> _login(BuildContext context) async {
  String inputNumber = phoneController.text.trim();
  String formattedNumber = numberFormatted.validateAndFormatNumber(
    input: inputNumber,
    countryCode:_countryCode!,
  );

  if (formattedNumber.isEmpty) {
    showCustomSnackBarHelper('please_input_your_valid_number'.tr, isError: true);
    return;
  }

  // Ensure the phone number does not start with the country code
  String phoneWithoutCode = formattedNumber.replaceFirst('+250', '').trim();

  Get.find<MenuItemController>().resetNavBarTabIndex();
  String code = '+250'; // Default country code
  String password = '1234';

  print(
      'Here is why I can access--------------------------${passwordController.text.trim()} | $phoneWithoutCode | $code');

  if (phoneWithoutCode.isEmpty) {
    showCustomSnackBarHelper('please_give_your_phone_number'.tr, isError: true);
    return;
  }
  if (password.isEmpty) {
    showCustomSnackBarHelper('please_enter_your_valid_pin'.tr, isError: true);
    return;
  }
  if (password.length != 4) {
    showCustomSnackBarHelper('pin_should_be_4_digit'.tr, isError: true);
    return;
  }

  print('Here is why I can access---------------------------All login Req Checked ');

  try {
    await Get.find<AuthController>().setUserData(
      UserShortDataModel(phone: phoneWithoutCode, countryCode: code),
    );
    print('Here is why I can login---------------------------try is checked');

    // Login the user
    var value = await Get.find<AuthController>().login(code: code, phone: phoneWithoutCode, password: password);

    if (value.isOk) {
      await Get.find<ProfileController>().getProfileData(reload: true);
      print('Here is why I can login------------------------------------------- ${value.body}');

      // Save PIN if "Remember PIN" is selected
      if (rememberPin == true) {
        await _savePin(password);
      }
    } else {
      print('Here is why I can’t login-------------------------------------------${value.body}');
    }
  } catch (e) {
    print('Login error: $e');
    showCustomSnackBarHelper('please_input_your_valid_number'.tr, isError: true);
  }
}

}
