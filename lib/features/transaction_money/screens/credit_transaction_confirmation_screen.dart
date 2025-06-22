import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/history/domain/models/transaction_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';
import 'package:hosomobile/features/map/screens/map_screen.dart';
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

class CreditTransactionConfirmationScreen extends StatefulWidget {
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
  final List<EduboxMaterialModel>? dataList;
  final Student? student;
  final int? productIndex;
  final List<StudentModel>? studentInfo;
  final String? edubox_service;
  final String? serviceValue;
  final int? serviceIndex;
  final int? studentIndex;
  final String? parent;


  const CreditTransactionConfirmationScreen(
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
  State<CreditTransactionConfirmationScreen> createState() =>
      _TransactionConfirmationScreenState();
}

class _TransactionConfirmationScreenState
    extends State<CreditTransactionConfirmationScreen> {
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

bool isHomeDelivery=false;


  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
  }



homeDeliveryAction() {
    setState(() {
      isHomeDelivery = !isHomeDelivery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomSliderController = Get.find<BottomSliderController>();
    final totalAmount = AppConstants.calculateTotal(double.parse('${widget.inputBalance}')).toStringAsFixed(2);
    final  EduboxMaterialModel product = widget.dataList![widget.productIndex!];
    final double convenienceFee= AppConstants.calculateConvenienceFee( double.parse('${product.price}')); 
    final vat =AppConstants.calculateVAT(double.parse('${product.price}')) ;
    final availableBalance= AppConstants.availableBalance(amount: double.parse('${widget.inputBalance}'), balance: double.parse(widget.availableBalance!)).toStringAsFixed(2);

    String phoneNumber = widget.contactModel!.phoneNumber!.replaceAll('+', '');
    int randomNumber = random.nextInt(90000000) + 10000000;
    final StudentModel student = widget.studentInfo![widget.studentIndex!]; 
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
                            'Code: ${student.code!}\nName: ${student.name}'),
                  ]),
                  sizedBox10,
                  Text(
                      'Product: ${widget.serviceValue}. Class: N1'),//${widget.studentInfo![widget.studentIndex!].studentClass}
                  sizedBox05h,
                  DropDownEduboxMaterial(
                      onChanged: (value) {
                        setState(() {
                         product.name = value!;
                        });
                      },
                      itemLists: widget.dataList!,
                      title:
                          '${product.name!}-${product.price!}RWF',
                      isExpanded: true),
                  sizedBox15,
                  PreviewAmountWidget(
                      amountText: widget.inputBalance?.toStringAsFixed(2) ?? "",
                      onTap: widget.callBack),
                  Container(
                    height: Dimensions.dividerSizeMedium,
                    color: Theme.of(context).dividerColor,
                  ),
                                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Delivery Options',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      sizedBox15,
                      DefaultButton2(
                        color1: kamber300Color,
                        color2: kyellowColor,
                        onPress: () => _captureInformation(
                          studentCode: student.code!,
                          studentName: student.name!,
                           calculatedTotal: totalAmount,
                            context,
                            randomNumber: randomNumber,
                            totalAmount: totalAmount,
                            className: student.studentClass!,
                            schoolName: student.school!,
                            orderId: '1234',
                            productName: widget.dataList![widget.productIndex!].name!
                            
                            ),
                        // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                        title: 'SCHOOL',
                        iconData: Icons.arrow_forward_outlined,
                      ),
                      sizedBox15,
                      isHomeDelivery == false
                          ? DefaultButton2(
                              color1: kamber300Color,
                              color2: kyellowColor,
                              onPress: () => homeDeliveryAction(),
                              // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                              title: 'HOME',
                              iconData: Icons.arrow_forward_outlined,
                            )
                          : DeliveryMapScreen(
                            
                              isShop: 0,
                              deliveryCost: AppConstants.deliveryCost,
                              schoolId: student.schoolId!,
                              classId: student.classId!,
                              className: student.studentClass!,
                              schoolName: student.school!,
                              studentCode: student.name!,
                              studentId: student.id!,
                              studentName: student.name!,
                              screenId: 0,
                              calculatedTotal: double.parse(totalAmount),
                              contactModel: widget.contactModel!,
                              eduboxService: widget.edubox_service??'',
                              dataList: widget.dataList??[],
                              shipper: 'widget.shipper',
                              destination: 'widget.destination',
                              homePhone: 'widget.homePhone',
                              productId: widget.productId??0,
                              pinCodeFieldController:
                                  _pinCodeFieldController.text,
                              transactionType: widget.transactionType??'',
                              calculatedTotalWithServices:double.parse(totalAmount),
                              productIndex: widget.productIndex??0,
                              purpose: widget.purpose??'',
                              calculateServiceCharge:convenienceFee,
                              calculateVAT: vat,
                              productName: product.name??'',
                              randomNumber: randomNumber,
                              serviceIndex: widget.serviceIndex??0,
                              totalAmount: double.parse(totalAmount),
                              vatPercentage: AppConstants.vatPercentage),
                    ],
                  ),
                  sizedBox10,

                  Text(
                      'Amount to be Paid: ${product.price} RWF'),
                  Text(
                      'Now Paying: ${widget.inputBalance!.toStringAsFixed(2)} RWF'),
                  Text(
                      'VAT (${AppConstants.vatPercentage.toStringAsFixed(1)}%): $vat RWF'),
                  Text(
                      'Convenience Fee: $convenienceFee RWF'),
                  const Divider(),
                  Text(
                    'Total Amount paid now: $totalAmount RWF',
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
                  '$availableBalance RWF',
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

            ],
          ),
        ),
      ),
    );
  }

   void _captureInformation(context,
      {required int randomNumber,
      required String totalAmount,
      required String schoolName,
      required String className,
      required String productName,
      required String orderId,
      required String calculatedTotal,
      required String studentName,
      required String studentCode
      }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your School materials will be delivered at;'),
              Text('School Name: $schoolName'),
              Text('Class: $className'),
              Text('Customer Product: $productName'),
              Text('Order ID: $orderId'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                final configModel = Get.find<SplashController>().configModel;
                // if (!Get.find<BottomSliderController>()
                //     .isPinCompleted) {
                //   showCustomSnackBarHelper(
                //       'please_input_4_digit_pin'.tr);
                // }
                // else {
                // Get.find<TransactionMoneyController>()
                //     .pinVerify(
                //   pin: _pinCodeFieldController.text,
                // )
                //     .then((isCorrect) {
                  // if (isCorrect) {
                    if (widget.transactionType ==
                        TransactionType.withdrawRequest) {
                      _placeWithdrawRequest();
                    } else {
                     Get.to(PaymentMethod(
                              amountTotal: calculatedTotal.toString(),
                              parent: widget.contactModel!.name,
                              studentName: studentName,
                              studentCode:studentCode,
                              schoolName: schoolName,
                              className: className,
                              product: widget.edubox_service,
                              material: widget.dataList,
                            ));
                        
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
                          //             'You have paid for ${widget.edubox_service} VAT Inc, ${calculateServiceCharge(double.parse('$calculatedTotal')).toInt()} RWF Service Charge',
                          //         phoneNumber: phoneNumber)
                          //     .then((value) async {
                          //     String? status =
                          //         await mtnMomoApiClient
                          //             .getPaymentStatus();

                          //     // Ensure the reference ID is available
                          //     if (status == '202') {
            
                      // } else {
                      //   print('payment not done $status');
                      // }
                      // });
                    }
                  // }
                  // _pinCodeFieldController.clear();
                // });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
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
