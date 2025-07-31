import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method_sl.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/transaction_money/domain/models/withdraw_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_ps.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sl.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hosomobile/common/widgets/custom_pin_code_field_widget.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:hosomobile/common/widgets/demo_otp_hint_widget.dart';
import 'package:hosomobile/features/transaction_money/widgets/preview_amount_widget.dart';

import '../widgets/bottom_sheet_with_slider.dart';
import '../widgets/for_person_widget.dart';

class PaidAtSchoolTransactionConfirmationScreen extends StatefulWidget {
  final double? inputBalance;
  final String? phoneNumber;
  final int? productId;
  final List<bool>? isChecked;
  final String? productName;
  final String className;
  final String schoolName;
  final int? schoolId;
  final double? price;
  final String? transactionType;
  final String? purpose;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final Function? callBack;
  final WithdrawalMethod? withdrawMethod;
  final List<SchoolLists>? dataList;
  final String studentName;
  final String studentCode;
  final int studentId;
  final int? productIndex;
  final List<StudentModel>? studentInfo;
  final String? edubox_service;
  final int? serviceIndex;
  final int? screenId;

  const PaidAtSchoolTransactionConfirmationScreen(
      {super.key,
      required this.inputBalance,
      required this.transactionType,
      this.purpose,
      this.screenId,
      this.isChecked,
      required this.studentName,
      required this.studentCode,
      required this.studentId,
      this.schoolId,
      this.productName,
      this.phoneNumber,
      required this.className,
      required this.schoolName,
      this.productId,
      this.contactModel,
      this.contactModelMtn,
      this.callBack,
      this.withdrawMethod,
      this.dataList,
      this.productIndex,
      this.studentInfo,
      this.serviceIndex,
      this.edubox_service,
      this.price});

  @override
  State<PaidAtSchoolTransactionConfirmationScreen> createState() =>
      _TransactionConfirmationScreenState();
}

class _TransactionConfirmationScreenState
    extends State<PaidAtSchoolTransactionConfirmationScreen> {
  final _pinCodeFieldController = TextEditingController(text: "1234");
  final ContactController contactController = Get.find<ContactController>();
  final TransactionMoneyController transactionMoneyController =
      Get.find<TransactionMoneyController>();
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  String? transactionId;

  Random random = Random();
  double totalPrice = 0.0;
  double calculatedTotal = 0.0;

  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    calculateTotalPrice(); // Recalculate total price
    super.initState();
  }

  // Method to calculate the total price
  void calculateTotalPrice() {
    // Reset calculatedTotal to avoid adding multiple times
    calculatedTotal = 0.0;

    for (int i = 0; i < widget.dataList!.length; i++) {
      if (widget.isChecked![i]) {
        calculatedTotal +=
            widget.dataList![i].amount ?? 0.0; // Ensure price is not null
      }
    }

    setState(() {
      totalPrice = calculatedTotal;
    });
  }



  @override
  Widget build(BuildContext context) {
    final bottomSliderController = Get.find<BottomSliderController>();
   final totalAmount = AppConstants.calculateTotal(double.parse('${widget.inputBalance}')).toStringAsFixed(2);
    final  SchoolLists product = widget.dataList![widget.productIndex!];
    final double convenienceFee= AppConstants.calculateConvenienceFee( double.parse('${widget.inputBalance}')); 
    final vat =AppConstants.calculateVAT(double.parse('${widget.inputBalance}')) ;
    final availableBalance= AppConstants.availableBalance(amount: double.parse('${widget.inputBalance}'), balance: double.parse('${widget.inputBalance}')).toStringAsFixed(2);
      int randomNumber = random.nextInt(90000000) + 10000000;
    //   bottomSliderController.setIsPinCompleted(isCompleted: false, isNotify: false);

    return Scaffold(
      // appBar: CustomAppbarWidget(
      //   title:  widget.transactionType!.tr,
      //   onTap: () => Get.back(),
      // ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              if (widget.transactionType != TransactionType.withdrawRequest)
                ForPersonWidget(contactModel: widget.contactModel),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'invoice_no'.tr}:$randomNumber',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  sizedBox15,
                  Column(children: [
                    ForStudentWidget(
                        studentInfo:
                            '${'code'.tr}: ${widget.studentName}\n${'name'.tr}: ${widget.studentCode}'),
                  ]),
                  sizedBox10,
                  Text(
                      '${'product'.tr}:${widget.edubox_service} \n ${'school'.tr}:${widget.schoolName}. ${'class'.tr}:${widget.className}'),
                  sizedBox05h,
                  Container(
                    // height: MediaQuery.of(context).size.height / 5,

                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        child: ListView.builder(
                          itemCount: widget.dataList!.length,
                          itemBuilder: (context, selectedIndex) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: widget.isChecked![selectedIndex],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        widget.isChecked![selectedIndex] =
                                            value!;
                                      });
                                      calculateTotalPrice(); // Recalculate total price
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${widget.dataList![selectedIndex].transactionId!} ${widget.dataList![selectedIndex].amount!} ${AppConstants.currency}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Display Total Price
                  Text(
                    '${'total_price'.tr}: ${totalPrice.toStringAsFixed(2)} ${AppConstants.currency}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  sizedBox15,
                  // PreviewAmountWidget(
                  //     amountText: calculatedTotal.toStringAsFixed(2) ?? "",
                  //     onTap: widget.callBack),
                  // Container(
                  //   height: Dimensions.dividerSizeMedium,
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  // sizedBox10,
                  // Text(
                  //     '${'amount_to_be_paid'.tr}: $totalPrice ${AppConstants.currency}'),
                  // Text('Now Paying: ${calculatedTotal.toStringAsFixed(2)} ${AppConstants.currency}'),
                  // Text(
                  //     '${'vat'.tr} : $vat ${AppConstants.currency}'),
                  // Text(
                  //     '${'convenience_fee'.tr} : $convenienceFee ${AppConstants.currency}'),
                  // const Divider(),
                  // Text(
                  //   '${'total_amount_paid_now'.tr}: $totalAmount ${AppConstants.currency}',
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  // ),
                ],
              ),
              // sizedBox10,
              if (widget.transactionType == TransactionType.withdrawRequest)
                PreviewAmountWidget(
                  amountText:
                      '${PriceConverterHelper.calculation(calculatedTotal, Get.find<SplashController>().configModel!.withdrawChargePercent, 'percent')?.toStringAsFixed(2)}',
                  title: 'charge'.tr,
                ),
              if (widget.transactionType == TransactionType.withdrawRequest)
                PreviewAmountWidget(
                    amountText: PriceConverterHelper.balanceWithCharge(
                      calculatedTotal,
                      Get.find<SplashController>()
                          .configModel!
                          .withdrawChargePercent,
                      true,
                    ).toStringAsFixed(2),
                    title: 'total_amount'.tr),
              if (widget.transactionType != TransactionType.withdrawRequest)
                Container(
                  height: Dimensions.dividerSizeMedium,
                  color: Theme.of(context).dividerColor,
                ),
              if (widget.transactionType == TransactionType.withdrawRequest)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeSmall,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(children: [
                      _MethodFieldWidget(
                        type: 'withdraw_method'.tr,
                        value: widget.withdrawMethod!.methodName!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: widget.withdrawMethod!.methodFields
                            .map(
                              (method) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: _MethodFieldWidget(
                                  type: method.inputName!
                                      .replaceAll('_', ' ')
                                      .capitalizeFirst!,
                                  value: method.inputValue!,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ]),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: Dimensions.paddingSizeExtraExtraLarge,
                    //     bottom: Dimensions.paddingSizeDefault,
                    //   ),
                    //   child: Text('4digit_pin'.tr,
                    //       style: rubikMedium.copyWith(
                    //         fontSize: Dimensions.fontSizeLarge,
                    //       )),
                    // ),
                    sizedBox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
//                         Expanded(
//                           child: Container(
//   alignment: Alignment.center,
//   height: 50,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(27.0),
//     color: ColorResources.getGreyBaseGray6(),
//   ),
//   child: PinCodeTextField(
//     controller: _pinCodeFieldController,
//     length: 4,
//     appContext: context,
//     enabled: false, // Disables editing
//     onChanged: (value) => bottomSliderController.updatePinCompleteStatus(value),
//     keyboardType: TextInputType.none, // Prevents keyboard from appearing
//     inputFormatters: <TextInputFormatter>[
//       FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
//     ],
//     obscureText: true,
//     hintCharacter: '•',
//     hintStyle: rubikMedium.copyWith(
//       color: ColorResources.getGreyBaseGray4(),
//     ),
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     cursorColor: Theme.of(context).highlightColor,
//     pinTheme: PinTheme.defaults(
//       shape: PinCodeFieldShape.circle,
//       activeColor: ColorResources.getGreyBaseGray6(),
//       activeFillColor: Colors.red,
//       selectedColor: ColorResources.getGreyBaseGray6(),
//       borderWidth: 0,
//       inactiveColor: ColorResources.getGreyBaseGray6(),
//     ),
//   ),
// ),
//                         ),
                        // const SizedBox(width: Dimensions.paddingSizeDefault),
                        GestureDetector(
                          onTap: () {
                            final configModel =
                                Get.find<SplashController>().configModel;
                            // if (!Get.find<BottomSliderController>()
                            //     .isPinCompleted) {
                            //   showCustomSnackBarHelper(
                            //       'please_input_4_digit_pin'.tr);
                            // }
                            // else {
                            Get.find<TransactionMoneyController>()
                                .pinVerify(
                              pin: _pinCodeFieldController.text,
                            )
                                .then((isCorrect) {
                              if (isCorrect) {
                                if (widget.transactionType ==
                                    TransactionType.withdrawRequest) {
                                  _placeWithdrawRequest();
                                } else {
                                  // showModalBottomSheet(
                                  //       isScrollControlled: true,
                                  //       context: Get.context!,
                                  //       isDismissible: false,
                                  //       enableDrag: false,
                                  //       shape: const RoundedRectangleBorder(
                                  //           borderRadius:
                                  //               BorderRadius.vertical(
                                  //         top: Radius.circular(
                                  //             Dimensions.radiusSizeLarge),
                                  //       )),
                                  //       builder: (context) {
                                  //         return BottomSheetWithSliderSl(
                                  //             availableBalance:'0.00',

                                  //             amount:
                                  //                 calculatedTotal.toString(),
                                  //             productId: widget.productId!,
                                  //             contactModel: widget.contactModel,
                                  //             pinCode: _pinCodeFieldController.text,
                                  //             transactionType: widget.transactionType,
                                  //             purpose: widget.purpose,
                                  //             studentInfo: widget.studentInfo,
                                  //             inputBalance: calculatedTotal,
                                  //             dataList: widget.dataList,
                                  //             productIndex: widget.productIndex,
                                  //             edubox_service: widget.edubox_service!,
                                  //             amountToPay: calculateTotalWithService(double.parse('$calculatedTotal')).toStringAsFixed(2),
                                  //             nowPaid: calculatedTotal.toStringAsFixed(2),
                                  //             vat: 'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(double.parse('$calculatedTotal')).toStringAsFixed(2)} ${AppConstants.currency}',
                                  //             serviceCharge: calculateServiceCharge(double.parse('$calculatedTotal')).toStringAsFixed(2),
                                  //             totalNowPaid: 'Total Amount paid now: $totalAmount ${AppConstants.currency}',
                                  //             serviceValue: widget.productName,
                                  //             serviceIndex: widget.serviceIndex,
                                  //             classDetails: widget.classDetails,
                                  //             schoolId: widget.schoolId,
                                  //             student: widget.student);
                                  //       });
                                  widget.screenId == 1
                                      ? Get.to(PaymentMethodSl(
                                          amountTotal:
                                              calculatedTotal.toString(),
                                          parent: widget.contactModel!.name,
                                          studentName: widget.studentName,
                                          studentCode: widget.studentCode,
                                          schoolName: widget.schoolName,
                                          className: widget.className,
                                          product: widget.productName,
                                          material:widget.dataList,
                                          
                                          )
                                          )
                                      : 
                                      // mtnMomoApiClient
                                      //     .postMtnMomo(
                                      //         transactionId:
                                      //             randomNumber.toString(),
                                      //         amount: calculateTotalWithService(
                                      //                 double.parse(
                                      //                     '$calculatedTotal'))
                                      //             .toInt()
                                      //             .toString(),
                                      //         message:
                                      //             'You have paid for ${widget.edubox_service} VAT Inc, ${calculateServiceCharge(double.parse('$calculatedTotal')).toInt()} ${AppConstants.currency} Convenience Fee',
                                      //         phoneNumber: phoneNumber)
                                      //     .then((value) async {
                                      //     String? status =
                                      //         await mtnMomoApiClient
                                      //             .getPaymentStatus();

                                      //     // Ensure the reference ID is available
                                      //     if (status == '202') {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: Get.context!,
                                                isDismissible: false,
                                                enableDrag: false,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                  top: Radius.circular(
                                                      Dimensions
                                                          .radiusSizeLarge),
                                                )),
                                                builder: (context) {
                                                  //**************** Bottom Sheet with slider */
                                                  return BottomSheetWithSliderPS(

                                                    randomNumber: randomNumber,
                                                      availableBalance: '0.00',
                                                      amount: calculatedTotal
                                                          .toString(),
                                                      productId:
                                                          widget.productId!,
                                                      contactModel:
                                                          widget.contactModel,
                                                      pinCode:
                                                          _pinCodeFieldController
                                                              .text,
                                                      transactionType: widget
                                                          .transactionType,
                                                      purpose: widget.purpose,
                                                      studentId: widget.studentId,
                                                      inputBalance:
                                                          calculatedTotal,
                                                      dataList: widget.dataList,
                                                      productIndex:
                                                          widget.productIndex,
                                                      edubox_service: widget
                                                          .edubox_service!,
                                                      amountToPay: totalPrice
                                                          .toStringAsFixed(2),
                                                      nowPaid: calculatedTotal
                                                          .toStringAsFixed(2),
                                                      vat:
                                                          '${'vat'.tr}: $vat ${AppConstants.currency}',
                                                      serviceCharge:convenienceFee.toStringAsFixed(2),
                                                      totalNowPaid:
                                                          '${'total_amount_paid_now'}: $totalAmount ${AppConstants.currency}',
                                                      serviceValue:
                                                          widget.productName,
                                                      serviceIndex:
                                                          widget.serviceIndex,
                                                   
                                                      studentName:widget.studentName,
                                                      studentCode: widget.studentCode,
                                                      className: widget.className,
                                                      schoolName: widget.schoolName);
                                                });
                                          // } else {
                                          //   print('payment not done $status');
                                          // }
                                        // });
                                }
                              }
                              // _pinCodeFieldController.clear();
                            });
                            // }
                          },
                          child: GetBuilder<AuthController>(
                            builder: (otpCheckController) {
                              return GetBuilder<TransactionMoneyController>(
                                builder: (pinVerify) {
                                  return pinVerify.isLoading ||
                                          otpCheckController.isLoading
                                      ? SizedBox(
                                          width: Dimensions.radiusSizeOverLarge,
                                          height:
                                              Dimensions.radiusSizeOverLarge,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        )
                                      : Container(
                                          width: Dimensions.radiusSizeOverLarge,
                                          height:
                                              Dimensions.radiusSizeOverLarge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: Theme.of(context)
                                                .secondaryHeaderColor,
                                          ),
                                          child: Icon(Icons.arrow_forward,
                                              color: ColorResources.blackColor),
                                        );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    sizedBox
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _placeWithdrawRequest() {
    Map<String, String> withdrawalMethodField = {};

    for (var method in widget.withdrawMethod!.methodFields) {
      withdrawalMethodField
          .addAll({'${method.inputName}': '${method.inputValue}'});
    }

    List<Map<String, String>> withdrawalMethodFieldList = [];
    withdrawalMethodFieldList.add(withdrawalMethodField);

    Map<String, String?> withdrawRequestBody = {};
    withdrawRequestBody = {
      'pin': _pinCodeFieldController.text,
      'amount': '$calculatedTotal',
      'withdrawal_method_id': '${widget.withdrawMethod!.id}',
      'withdrawal_method_fields':
          base64Url.encode(utf8.encode(jsonEncode(withdrawalMethodFieldList))),
    };

    Get.find<TransactionMoneyController>()
        .withDrawRequest(placeBody: withdrawRequestBody);
  }

  Widget invoiceLists(
      {required List<String> dataList, required BuildContext context}) {
    // Split the text into paragraphs
    // List<String> paragraphs = data.split('\n');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dataList.map((paragraph) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radial icon
              Container(
                margin: const EdgeInsets.only(right: 8, top: 6),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              // Text
              Expanded(
                child: Text(
                  paragraph.trim(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MethodFieldWidget extends StatelessWidget {
  final String type;
  final String value;

  const _MethodFieldWidget(
      {required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: rubikLight.copyWith(fontSize: Dimensions.fontSizeDefault),
        ),
        Text(value),
      ],
    );
  }
}
