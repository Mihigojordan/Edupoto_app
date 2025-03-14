import 'package:hosomobile/features/auth/screens/number_formating.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/controllers/create_account_controller.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_country_code_widget.dart';
import 'package:hosomobile/common/widgets/custom_logo_widget.dart';
import 'package:hosomobile/common/widgets/custom_large_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController numberFieldController = TextEditingController();
  final NumberFormatting numberFormating =NumberFormatting();
  String countryCode = '+250'; // Default country code (Replace with your actual country code)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppbarWidget(title: 'login_registration'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.paddingSizeExtraExtraLarge),
                  const CustomLogoWidget(height: 70.0, width: 70.0),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                    child: Text(
                      '${'create'.tr} ${AppConstants.appName} ${'account_with_your'.tr}',
                      style: rubikRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                  GetBuilder<CreateAccountController>(builder: (controller) {
                    return Container(
                      height: 52,
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Center(
                        child: TextField(
                          controller: numberFieldController,
                          keyboardType: TextInputType.phone,
                          cursorColor: Theme.of(context).textTheme.titleLarge!.color,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                              borderSide: BorderSide(
                                color: Theme.of(context).textTheme.titleLarge!.color!,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                              borderSide: BorderSide(
                                color: ColorResources.textFieldBorderColor,
                                width: 1,
                              ),
                            ),
                            prefixIcon: CustomCountryCodeWidget(
                              onChanged: (selectedCountry) {
                                setState(() {
                                  countryCode = selectedCountry.dialCode!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (controller) {
            return SizedBox(
              height: 110,
              child: !controller.isLoading
                  ? CustomLargeButtonWidget(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      text: 'verify_number'.tr,
                      onTap: () async {
                        String inputNumber = numberFieldController.text.trim();
                        String formattedNumber = numberFormating.validateAndFormatNumber(input:inputNumber,countryCode: countryCode);

                        if (formattedNumber.isEmpty) {
                          showCustomSnackBarHelper('please_input_your_valid_number'.tr, isError: true);
                          return;
                        }

                        Get.find<CreateAccountController>().sendOtpResponse(number: formattedNumber);
                      },
                    )
                  : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
            );
          }),
        ],
      ),
    );
  }


}
