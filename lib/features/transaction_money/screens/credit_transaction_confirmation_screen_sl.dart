import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/history/domain/models/transaction_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sl.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/widgets/student_widget.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/transaction_money/domain/enums/suggest_type_enum.dart';
import 'package:hosomobile/features/transaction_money/domain/models/withdraw_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_p.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hosomobile/common/widgets/custom_pin_code_field_widget.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:hosomobile/common/widgets/demo_otp_hint_widget.dart';
import 'package:hosomobile/features/transaction_money/widgets/preview_amount_widget.dart';

import '../widgets/bottom_sheet_with_slider.dart';
import '../widgets/for_person_widget.dart';

class CreditTransactionConfirmationScreenSL extends StatefulWidget {
  final double? inputBalance;
  final String? phoneNumber;
  final int? productId;
  final String? availableBalance;
  final double? price;
  final String? transactionType;
  final String? purpose;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final Function? callBack;
  final WithdrawalMethod? withdrawMethod;
  final List<SchoolLists>? dataList;
  final Student? student;
  final int? productIndex;
  final List<StudentModel>? studentInfo;
  final String? edubox_service;
  final String? serviceValue;
  final int? serviceIndex;
  final int? studentIndex;
  final String? parent;


  const CreditTransactionConfirmationScreenSL(
      {super.key,
      required this.inputBalance,
      required this.transactionType,
      this.purpose,
      this.parent,
      this.student,
      this.availableBalance,
      this.phoneNumber,
      this.productId,
      this.contactModel,
      this.contactModelMtn,
      this.callBack,
      this.withdrawMethod,
      this.dataList,
      this.productIndex,
      this.studentInfo,
      this.serviceIndex,
      this.serviceValue,
      this.studentIndex,
      this.edubox_service,
      this.price});

  @override
  State<CreditTransactionConfirmationScreenSL> createState() =>
      _TransactionConfirmationScreenState();
}

class _TransactionConfirmationScreenState
    extends State<CreditTransactionConfirmationScreenSL> {
  final _pinCodeFieldController = TextEditingController();
  final ContactController contactController = Get.find<ContactController>();
  final TransactionMoneyController transactionMoneyController =
      Get.find<TransactionMoneyController>();
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  String? transactionId;

  Random random = Random();
  final String data =
      'Amafaranga y’ishuri ,Minerval/School fees ni 65.500 Frw/ku gihembwe.\n'
      'Aya ni amafaranga y’ishuri akubiyemo ( Ramede papier ( Impapuro)),\n'
      'Indangamanota, Umukoro wo mu kiruhuko, Impapuro z’isuku ( Toilet papers)\n'
      'Ntamubyeyi zongera kubibazwa.\n'
      'Amafaranga y’ifunguro rya saa sita ni 13.000 Frw /ku kwezi.';

  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final bottomSliderController = Get.find<BottomSliderController>();
     final totalAmount = AppConstants.calculateTotal(double.parse('${widget.inputBalance}')).toStringAsFixed(2);
    final  SchoolLists product = widget.dataList![widget.productIndex!];
    final double convenienceFee= AppConstants.calculateConvenienceFee( double.parse('${widget.inputBalance}')); 
    final vat =AppConstants.calculateVAT(double.parse('${widget.inputBalance}')) ;
    final availableBalance= AppConstants.availableBalance(amount: double.parse('${widget.inputBalance}'), balance: double.parse(widget.availableBalance!)).toStringAsFixed(2);


    String phoneNumber = widget.contactModel!.phoneNumber!.replaceAll('+', '');
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
                 const  CustomBackButton(),
              if (widget.transactionType != TransactionType.withdrawRequest)
                ForPersonWidget(contactModel: widget.contactModel),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice No: $randomNumber',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  sizedBox15,
                  Column(children: [
                    ForStudentWidget(
                        studentInfo:
                            'Code: ${widget.studentInfo![widget.studentIndex!].code!}\nName: ${widget.studentInfo![widget.studentIndex!].name}'),
                  ]),
                  sizedBox10,
                  Text(
                      'Product: ${widget.serviceValue}. Class: N1'),//${widget.studentInfo![widget.studentIndex!].studentClass}
                  sizedBox05h,
                  // DropDownEduboxMaterial(
                  //     onChanged: (value) {
                  //       setState(() {
                  //         widget.dataList![widget.productIndex!].name = value!;
                  //       });
                  //     },
                  //     itemLists: widget.dataList!,
                  //     title:
                  //         '${widget.dataList![widget.productIndex!].name!}-${widget.dataList![widget.productIndex!].price!}${AppConstants.currency}',
                  //     isExpanded: true),
                  sizedBox15,
                  PreviewAmountWidget(
                      amountText: widget.inputBalance?.toStringAsFixed(2) ?? "",
                      onTap: widget.callBack),
                  Container(
                    height: Dimensions.dividerSizeMedium,
                    color: Theme.of(context).dividerColor,
                  ),
                  sizedBox10,
                  Text(
                      'Amount to be Paid: ${widget.price}${AppConstants.currency}'),
                  Text(
                      'Now Paying: ${widget.inputBalance!.toStringAsFixed(2)} ${AppConstants.currency}'),
                  Text(
                      'VAT (${AppConstants.vatPercentage.toStringAsFixed(1)}%): $vat ${AppConstants.currency}'),
                  Text(
                      'Convenience Fee: $convenienceFee ${AppConstants.currency}'),
                  const Divider(),
                  Text(
                    'Total Amount paid now: $totalAmount ${AppConstants.currency}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              sizedBox10,
              Text('Pending/Remaing Amount to be paid',
                  style: rubikSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.getGreyBaseGray1())),
              Text(
                  '$availableBalance ${AppConstants.currency}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
              const SizedBox(height: 15),
              if (widget.transactionType == TransactionType.withdrawRequest)
                PreviewAmountWidget(
                  amountText:
                      '${PriceConverterHelper.calculation(widget.inputBalance, Get.find<SplashController>().configModel!.withdrawChargePercent, 'percent')?.toStringAsFixed(2)}',
                  title: 'charge'.tr,
                ),
//               if (widget.transactionType == TransactionType.withdrawRequest)
//                 PreviewAmountWidget(
//                     amountText: PriceConverterHelper.balanceWithCharge(
//                       widget.inputBalance,
//                       Get.find<SplashController>()
//                           .configModel!
//                           .withdrawChargePercent,
//                       true,
//                     ).toStringAsFixed(2),
//                     title: 'total_amount'.tr),
//               if (widget.transactionType != TransactionType.withdrawRequest)
//                 Container(
//                   height: Dimensions.dividerSizeMedium,
//                   color: Theme.of(context).dividerColor,
//                 ),
//               if (widget.transactionType == TransactionType.withdrawRequest)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: Dimensions.paddingSizeDefault,
//                     vertical: Dimensions.paddingSizeSmall,
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10))),
//                     child: Column(children: [
//                       _MethodFieldWidget(
//                         type: 'withdraw_method'.tr,
//                         value: widget.withdrawMethod!.methodName!,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Column(
//                         children: widget.withdrawMethod!.methodFields
//                             .map(
//                               (method) => Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: _MethodFieldWidget(
//                                   type: method.inputName!
//                                       .replaceAll('_', ' ')
//                                       .capitalizeFirst!,
//                                   value: method.inputValue!,
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ]),
//                   ),
//                 ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: Dimensions.paddingSizeLarge),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: Dimensions.paddingSizeExtraExtraLarge,
//                         bottom: Dimensions.paddingSizeDefault,
//                       ),
//                       child: Text('4digit_pin'.tr,
//                           style: rubikMedium.copyWith(
//                             fontSize: Dimensions.fontSizeLarge,
//                           )),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(27.0),
//                               color: ColorResources.getGreyBaseGray6(),
//                             ),
//                             child: //Text('Next', style: rubikMedium.copyWith(color: ColorResources.getGreyBaseGray4()),)
//                                 PinCodeTextField(
//                               controller: _pinCodeFieldController,
//                               length: 4,
//                               appContext: context,
//                               onChanged: (value) => bottomSliderController
//                                   .updatePinCompleteStatus(value),
//                               keyboardType: TextInputType.number,
//                               inputFormatters: <TextInputFormatter>[
//                                 FilteringTextInputFormatter.allow(
//                                     RegExp(r'[0-9]'))
//                               ],
//                               obscureText: true,
//                               hintCharacter: '•',
//                               hintStyle: rubikMedium.copyWith(
//                                   color: ColorResources.getGreyBaseGray4()),
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               cursorColor: Theme.of(context).highlightColor,
//                               pinTheme: PinTheme.defaults(
//                                 shape: PinCodeFieldShape.circle,
//                                 activeColor: ColorResources.getGreyBaseGray6(),
//                                 activeFillColor: Colors.red,
//                                 selectedColor:
//                                     ColorResources.getGreyBaseGray6(),
//                                 borderWidth: 0,
//                                 inactiveColor:
//                                     ColorResources.getGreyBaseGray6(),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: Dimensions.paddingSizeDefault),
//                         GestureDetector(
//                           onTap: () {
//                             final configModel =
//                                 Get.find<SplashController>().configModel;
//                             if (!Get.find<BottomSliderController>()
//                                 .isPinCompleted) {
//                               showCustomSnackBarHelper(
//                                   'please_input_4_digit_pin'.tr);
//                             } else {
//                               Get.find<TransactionMoneyController>()
//                                   .pinVerify(
//                                 pin: _pinCodeFieldController.text,
//                               )
//                                   .then((isCorrect) {
//                                 if (isCorrect) {
//                                   if (widget.transactionType ==
//                                       TransactionType.withdrawRequest) {
//                                     _placeWithdrawRequest();
//                                   } else if (configModel!.twoFactor! &&
//                                       Get.find<ProfileController>()
//                                           .userInfo!
//                                           .twoFactor!) {
//                                     Get.find<AuthController>()
//                                         .checkOtp()
//                                         .then((value) => value.isOk
//                                             ? Get.defaultDialog(
//                                                 barrierDismissible: false,
//                                                 title: 'otp_verification'.tr,
//                                                 content: Column(
//                                                   children: [
//                                                     CustomPinCodeFieldWidget(
//                                                       onCompleted: (pin) =>
//                                                           Get.find<
//                                                                   AuthController>()
//                                                               .verifyOtp(pin)
//                                                               .then((value) {
//                                                         if (value.isOk) {
//                                                           showModalBottomSheet(
//                                                             isScrollControlled:
//                                                                 true,
//                                                             context:
//                                                                 Get.context!,
//                                                             isDismissible:
//                                                                 false,
//                                                             enableDrag: false,
//                                                             shape:
//                                                                 const RoundedRectangleBorder(
//                                                               borderRadius: BorderRadius.vertical(
//                                                                   top: Radius.circular(
//                                                                       Dimensions
//                                                                           .radiusSizeLarge)),
//                                                             ),
//                                                             builder: (context) =>
//                                                                 BottomSheetWithSliderSl(
//                                                               amount: widget
//                                                                   .inputBalance
//                                                                   .toString(),
//                                                               availableBalance: availableBalance(
//                                                                       amount: double
//                                                                           .parse(
//                                                                               '${widget.inputBalance}'),
//                                                                       balance: double
//                                                                           .parse(widget
//                                                                               .availableBalance!))
//                                                                   .toStringAsFixed(
//                                                                       2),
//                                                               contactModel: widget
//                                                                   .contactModel,
//                                                               contactModelMtn:
//                                                                   widget
//                                                                       .contactModelMtn,
//                                                               pinCode: Get.find<
//                                                                       BottomSliderController>()
//                                                                   .pin,
//                                                               transactionType:
//                                                                   widget
//                                                                       .transactionType,
//                                                               purpose: widget
//                                                                   .purpose,
//                                                               inputBalance: widget
//                                                                   .inputBalance,
//                                                               dataList: widget
//                                                                   .dataList,
//                                                               productIndex: widget
//                                                                   .productIndex,
//                                                               edubox_service: widget
//                                                                   .edubox_service!,
//                                                               amountToPay:
//                                                                   'Amount to be Paid: ${calculateTotalWithService(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} ${AppConstants.currency}',
//                                                               nowPaid:
//                                                                   'Now Paid: ${widget.inputBalance!.toStringAsFixed(2)} ${AppConstants.currency}',
//                                                               vat:
//                                                                   'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} ${AppConstants.currency}',
//                                                               serviceCharge:
//                                                                   'Convenience Fee (${AppConstants.serviceChargePercentage.toStringAsFixed(1)}%): ${calculateServiceCharge(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} ${AppConstants.currency}',
//                                                               totalNowPaid:
//                                                                   'Total Amount paid now: $totalAmount ${AppConstants.currency}',
//                                                             ),
//                                                           );
//                                                         }
//                                                       }),
//                                                     ),
//                                                     const DemoOtpHintWidget(),
//                                                     GetBuilder<AuthController>(
//                                                       builder: (verifyController) =>
//                                                           verifyController
//                                                                   .isVerifying
//                                                               ? CircularProgressIndicator(
//                                                                   color: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .titleLarge!
//                                                                       .color,
//                                                                 )
//                                                               : const SizedBox
//                                                                   .shrink(),
//                                                     )
//                                                   ],
//                                                 ),
//                                               )
//                                             : null);
//                                   } else {
//                                     // Generate a random integer between 10000000 and 99999999
//                                     int randomNumber =
//                                         random.nextInt(90000000) + 10000000;

//                                     // mtnMomoApiClient
//                                     //     .postMtnMomo(
//                                     //         transactionId:
//                                     //             randomNumber.toString(),
//                                     //         amount: calculateTotalWithService(
//                                     //                 double.parse(
//                                     //                     '${widget.inputBalance}'))
//                                     //             .toInt()
//                                     //             .toString(),
//                                     //         message:
//                                     //             'You have paid for ${widget.edubox_service} VAT Inc, ${calculateServiceCharge(double.parse('${widget.inputBalance}')).toInt()} ${AppConstants.currency} Convenience Fee',
//                                     //         phoneNumber: phoneNumber)
//                                     //     .then((value) async {
//                                     //   String? status = await mtnMomoApiClient
//                                     //       .getPaymentStatus();

//                                       // Ensure the reference ID is available
//                                       // if (status == '202') {
//                                         // showModalBottomSheet(
//                                         //     isScrollControlled: true,
//                                         //     context: Get.context!,
//                                         //     isDismissible: false,
//                                         //     enableDrag: false,
//                                         //     shape: const RoundedRectangleBorder(
//                                         //         borderRadius:
//                                         //             BorderRadius.vertical(
//                                         //       top: Radius.circular(
//                                         //           Dimensions.radiusSizeLarge),
//                                         //     )),
//                                         //     builder: (context) {
//                                         //       return BottomSheetWithSliderP(
//                                         //         availableBalance: availableBalance(
//                                         //                 amount: double.parse(
//                                         //                     '${widget.inputBalance}'),
//                                         //                 balance: double.parse(widget.availableBalance!))
//                                         //             .toStringAsFixed(2),
//                                         //         amount: widget.inputBalance
//                                         //             .toString(),
//                                         //         productId: widget.productId!,
//                                         //         contactModel:
//                                         //             widget.contactModel,
//                                         //         studentIndex:
//                                         //             widget.studentIndex,
//                                         //         pinCode: Get.find<
//                                         //                 BottomSliderController>()
//                                         //             .pin,
//                                         //         transactionType:
//                                         //             widget.transactionType,
//                                         //         purpose: widget.purpose,
//                                         //         studentInfo: widget.studentInfo,
//                                         //         inputBalance:
//                                         //             widget.inputBalance,
//                                         //         dataList: widget.dataList,
//                                         //         productIndex:
//                                         //             widget.productIndex,
//                                         //         edubox_service:
//                                         //             widget.edubox_service!,
//                                         //         amountToPay:
//                                         //             calculateTotalWithService(
//                                         //                     double.parse(
//                                         //                         '${widget.inputBalance}'))
//                                         //                 .toStringAsFixed(2),
//                                         //         nowPaid: widget.inputBalance!
//                                         //             .toStringAsFixed(2),
//                                         //         vat:
//                                         //             'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} ${AppConstants.currency}',
//                                         //         serviceCharge:
//                                         //             calculateServiceCharge(
//                                         //                     double.parse(
//                                         //                         '${widget.inputBalance}'))
//                                         //                 .toStringAsFixed(2),
//                                         //         totalNowPaid:
//                                         //             'Total Amount paid now: $totalAmount ${AppConstants.currency}',
//                                         //         serviceValue:
//                                         //             widget.serviceValue,
//                                         //         serviceIndex:
//                                         //             widget.serviceIndex,
//                                         //       );
//                                         //     });
//                                       // } else {
//                                       //   print('payment not done $status');
//                                       // }
// Get.to(PaymentMethod(amountTotal: widget.availableBalance!,parent: widget.parent,student: widget.studentInfo![widget.studentIndex!].name,product:widget.serviceValue ,material:'${widget.dataList![widget.productIndex!].transactionId!}-${widget.dataList![widget.productIndex!].amount!}${AppConstants.currency}' ,classes: widget.studentInfo![widget.studentIndex!].studentClass,));


//                                             //                       showModalBottomSheet(
//                                             // isScrollControlled: true,
//                                             // context: Get.context!,
//                                             // isDismissible: false,
//                                             // enableDrag: false,
//                                             // shape: const RoundedRectangleBorder(
//                                             //     borderRadius:
//                                             //         BorderRadius.vertical(
//                                             //   top: Radius.circular(
//                                             //       Dimensions.radiusSizeLarge),
//                                             // )),
//                                             // builder: (context) {
//                                             //   return BottomSheetWithSliderP(
//                                             //     availableBalance: availableBalance(
//                                             //             amount: double.parse(
//                                             //                 '${widget.inputBalance}'),
//                                             //             balance: double.parse(widget.availableBalance!))
//                                             //         .toStringAsFixed(2),
//                                             //     amount: widget.inputBalance
//                                             //         .toString(),
//                                             //     productId: widget.productId!,
//                                             //     contactModel:
//                                             //         widget.contactModel,
//                                             //     studentIndex:
//                                             //         widget.studentIndex,
//                                             //     pinCode: Get.find<
//                                             //             BottomSliderController>()
//                                             //         .pin,
//                                             //     transactionType:
//                                             //         widget.transactionType,
//                                             //     purpose: widget.purpose,
//                                             //     studentInfo: widget.studentInfo,
//                                             //     inputBalance:
//                                             //         widget.inputBalance,
//                                             //     dataList: widget.dataList,
//                                             //     productIndex:
//                                             //         widget.productIndex,
//                                             //     edubox_service:
//                                             //         widget.edubox_service!,
//                                             //     amountToPay:
//                                             //         calculateTotalWithService(
//                                             //                 double.parse(
//                                             //                     '${widget.inputBalance}'))
//                                             //             .toStringAsFixed(2),
//                                             //     nowPaid: widget.inputBalance!
//                                             //         .toStringAsFixed(2),
//                                             //     vat:
//                                             //         'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} ${AppConstants.currency}',
//                                             //     serviceCharge:
//                                             //         calculateServiceCharge(
//                                             //                 double.parse(
//                                             //                     '${widget.inputBalance}'))
//                                             //             .toStringAsFixed(2),
//                                             //     totalNowPaid:
//                                             //         'Total Amount paid now: $totalAmount ${AppConstants.currency}',
//                                             //     serviceValue:
//                                             //         widget.serviceValue,
//                                             //     serviceIndex:
//                                             //         widget.serviceIndex,
//                                             //   );
//                                             // });
//                                     // });
//                                   }
//                                 }
//                                 _pinCodeFieldController.clear();
//                               });
//                             }
//                           },
//                           child: GetBuilder<AuthController>(
//                             builder: (otpCheckController) {
//                               return GetBuilder<TransactionMoneyController>(
//                                 builder: (pinVerify) {
//                                   return pinVerify.isLoading ||
//                                           otpCheckController.isLoading
//                                       ? SizedBox(
//                                           width: Dimensions.radiusSizeOverLarge,
//                                           height:
//                                               Dimensions.radiusSizeOverLarge,
//                                           child: Center(
//                                             child: CircularProgressIndicator(
//                                                 color: Theme.of(context)
//                                                     .primaryColor),
//                                           ),
//                                         )
//                                       : Container(
//                                           width: Dimensions.radiusSizeOverLarge,
//                                           height:
//                                               Dimensions.radiusSizeOverLarge,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(25),
//                                             color: Theme.of(context)
//                                                 .secondaryHeaderColor,
//                                           ),
//                                           child: Icon(Icons.arrow_forward,
//                                               color: ColorResources.blackColor),
//                                         );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )
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
      'pin': Get.find<BottomSliderController>().pin,
      'amount': '${widget.inputBalance}',
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

  const _MethodFieldWidget({super.key, required this.type, required this.value});

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
