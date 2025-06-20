import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/map/screens/map_screen.dart';
import 'package:hosomobile/features/map/screens/map_screen_sl.dart';
import 'package:hosomobile/helper/currency_text_input_formatter_helper.dart';
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
import 'package:hosomobile/features/student/screens/student_screen.dart';
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

class TransactionConfirmationScreen extends StatefulWidget {
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

  const TransactionConfirmationScreen(
      {super.key,
      required this.inputBalance,
      required this.transactionType,
      this.purpose,
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
  State<TransactionConfirmationScreen> createState() =>
      _TransactionConfirmationScreenState();
}

class _TransactionConfirmationScreenState
    extends State<TransactionConfirmationScreen> {
  final _pinCodeFieldController = TextEditingController(text: "1234");
  final TextEditingController _inputAmountController = TextEditingController();
  final ContactController contactController = Get.find<ContactController>();
  final TransactionMoneyController transactionMoneyController =
      Get.find<TransactionMoneyController>();
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  String? transactionId;
  final double vatPercentage = 18.0; // Example VAT percentage
  final double serviceChargePercentage =
      4.0; // Example service charge percentage
  Random random = Random();

bool isHomeDelivery =false;
 double totalPrice = 0.0;
  double deliveryCost = 3000.0;
  double subTotalPrice = 0.0;
  double calculatedTotal = 0.0;
  int checkedProducts = 0;

  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
  TextEditingController mapDestinationEditingController =
      TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  String deliveryOptionsValue = 'Choose Delivery Company';
  String? _deliveryOptionError;

  homeDeliveryAction() {
    setState(() {
      isHomeDelivery = !isHomeDelivery;
    });
  }



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

  final FocusNode _inputAmountFocusNode = FocusNode();

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }

  double calculateVAT(double amount) {
    return (amount * vatPercentage) / 100;
  }

  double calculateServiceCharge(double amount) {
    return (amount * serviceChargePercentage) / 100;
  }

  double calculateOriginalAmaount(double amount) {
    return amount -
        calculateVAT(double.parse('${widget.inputBalance}')) -
        calculateServiceCharge(double.parse('${widget.inputBalance}'));
  }

  double calculateOriginalVat(double amount) {
    return ((amount - calculateVAT(double.parse('${widget.inputBalance}'))) *
            vatPercentage) /
        100;
  }

  double calculateTotalWithService(double amount) {
    double serviceCharge = calculateServiceCharge(amount);
    return amount + serviceCharge;
  }

  double calculateTotal(double amount) {
    double vat = calculateVAT(amount);
    double serviceCharge = calculateServiceCharge(amount);
    double originalAmount = calculateOriginalAmaount(amount);
    return originalAmount + vat + serviceCharge;
  }

  double calculateServiceCharge0fPrice() {
    return widget.price! * serviceChargePercentage / 100;
  }

  double remainingAmount(double amount) {
    double serviceCharge = calculateServiceCharge0fPrice();

    return double.parse('${widget.price}') - amount;
  }

  double availableBalance({required double amount, required double balance}) {
    return balance - amount;
  }

  @override
  Widget build(BuildContext context) {
    final bottomSliderController = Get.find<BottomSliderController>();
    final String totalAmount =
        calculateTotal(double.parse('${widget.inputBalance}'))
            .toStringAsFixed(2);
    String phoneNumber = widget.contactModel!.phoneNumber!.replaceAll('+', '');
    int randomNumber = random.nextInt(90000000) + 10000000;
    final student = widget.studentInfo![widget.studentIndex!];
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
                      'Product: ${widget.serviceValue}. Class: ${widget.studentInfo![widget.studentIndex!].studentClass}'),
                  sizedBox05h,

                  // ********************************** Dropdown that has button **************************
                  DropDownEduboxMaterial(
                      onChanged: (value) {
                        setState(() {
                          widget.dataList![widget.productIndex!].name = value!;
                        });
                      },
                      itemLists: widget.dataList!,
                      title:
                          '${widget.dataList![widget.productIndex!].name}-${widget.dataList![widget.productIndex!].price}RWF',
                      isExpanded: true),
                  sizedBox15,
     Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Delivery Options',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ) ?? TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
    sizedBox15,
    DefaultButton2(
      color1: kamber300Color,
      color2: kyellowColor,
      onPress: () => _captureInformation(
        context,
        randomNumber: randomNumber,
        totalAmount: totalAmount,
        className: student.studentClass ?? 'Unknown Class',
        schoolName: student.school ?? 'Unknown School',
        orderId: '1234',
        productName: widget.edubox_service ?? 'Unknown Service',
      ),
      title: 'SCHOOL',
      iconData: Icons.arrow_forward_outlined,
    ),
    sizedBox15,
    isHomeDelivery == false
        ? DefaultButton2(
            color1: kamber300Color,
            color2: kyellowColor,
            onPress: () => homeDeliveryAction(),
            title: 'HOME',
            iconData: Icons.arrow_forward_outlined,
          )
        : DeliveryMapScreen(
            isShop: 0,
            deliveryCost: deliveryCost ,
            schoolId: student.schoolId ?? 0,
            classId: student.classId ?? 0,
            className: student.studentClass ?? 'Unknown Class',
            schoolName: student.school ?? 'Unknown School',
            studentCode: student.code ?? '',
            studentId: student.id ?? 0,
            studentName: student.name ?? 'Unknown Student',
            screenId: 0,
            calculatedTotal: calculatedTotal ?? 0,
            contactModel: widget.contactModel ?? ContactModel(
              phoneNumber: '',
              name: '',
              avatarImage: '',
            ),
            eduboxService: widget.edubox_service ?? '',
            dataList: widget.dataList ?? [],
            shipper: 'widget.shipper',
            destination: 'widget.destination' ,
            homePhone: 'widget.homePhone',
            productId: widget.productId ?? 0,
            pinCodeFieldController: _pinCodeFieldController.text,
            transactionType: widget.transactionType!,
            calculatedTotalWithServices: calculateTotalWithService(
              double.tryParse(calculatedTotal?.toString() ?? '0') ?? 0,
            ),
            productIndex: widget.productIndex ?? 0,
            purpose: widget.purpose ?? '',
            calculateServiceCharge: calculateServiceCharge(
              double.tryParse(calculatedTotal?.toString() ?? '0') ?? 0,
            ),
            calculateVAT: calculateVAT(
              double.tryParse(calculatedTotal?.toString() ?? '0') ?? 0,
            ),
            productName: widget.edubox_service ?? '',
            randomNumber: randomNumber,
            serviceIndex: widget.serviceIndex ?? 0,
            totalAmount: double.tryParse(totalAmount ?? '0') ?? 0,
            vatPercentage: vatPercentage,
          ),
  ],
),
sizedBox10,
                  Container(
                    height: Dimensions.dividerSizeMedium,
                    color: Theme.of(context).dividerColor,
                  ),
                  sizedBox10,
                  Text(
                      'Amount to be Paid: ${calculateTotalWithService(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} RWF'),
                  Text(
                      'Now Paying: ${widget.inputBalance!.toStringAsFixed(2)} RWF'),
                  Text(
                      'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} RWF'),
                  Text(
                      'Service Charge (${serviceChargePercentage.toStringAsFixed(1)}%): ${calculateServiceCharge(double.parse('${widget.inputBalance}')).toStringAsFixed(2)} RWF'),
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
                  '${availableBalance(amount: double.parse('${widget.inputBalance}'), balance: double.parse(widget.availableBalance!)).toStringAsFixed(2)}RWF',
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
              if (widget.transactionType == TransactionType.withdrawRequest)
                PreviewAmountWidget(
                    amountText: PriceConverterHelper.balanceWithCharge(
                      widget.inputBalance,
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

    void _captureInformation(context,
      {required int randomNumber,
      required String totalAmount,
      required String schoolName,
      required String className,
      required String productName,
      required String orderId}) {
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
    Get.find<TransactionMoneyController>()
        .pinVerify(
      pin: _pinCodeFieldController.text,
    )
        .then((isCorrect) {
      if (isCorrect) {
        if (widget.transactionType == TransactionType.withdrawRequest) {
          _placeWithdrawRequest();
        } else {
          // Safely access student info
          final student = widget.studentInfo != null && 
                         widget.studentIndex != null &&
                         widget.studentInfo!.length > widget.studentIndex!
                       ? widget.studentInfo![widget.studentIndex!]
                       : null;

          // Safe numerical conversions
          final inputBalance = widget.inputBalance ?? 0.0;
          final availableBalance = widget.availableBalance != null 
                                 ? double.tryParse(widget.availableBalance!) ?? 0.0
                                 : 0.0;

          showModalBottomSheet(
            isScrollControlled: true,
            context: Get.context!,
            isDismissible: false,
            enableDrag: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusSizeLarge),
              ),
            ),
            builder: (context) {
              return BottomSheetWithSliderP(
                schoolName: student?.school ?? 'Unknown School',
                className: student?.studentClass ?? 'Unknown Class',
                shipper: '',
                studentCode: student?.code ?? '',
                studentName: student?.name ?? 'Unknown Student',
                homePhone: '',
                destination: '',
                randomNumber: 00000000,
                studentId: student?.id ?? 0,
                amount: inputBalance.toString(),
                availableBalance: availableBalance.toStringAsFixed(2),
                contactModel: widget.contactModel ?? ContactModel(
                  phoneNumber: '',
                  name: '',
                  avatarImage: '',
                ),
                contactModelMtn: widget.contactModelMtn ?? ContactModelMtn(
                  phoneNumber: '',
                  name: '',
                ),
                pinCode: _pinCodeFieldController.text,
                transactionType: widget.transactionType ?? TransactionType.sendMoney,
                purpose: widget.purpose ?? '',
                inputBalance: inputBalance,
                dataList: widget.dataList ?? [],
                productIndex: widget.productIndex ?? 0,
                edubox_service: widget.edubox_service ?? '',
                amountToPay: 'Amount to be Paid: ${calculateTotalWithService(inputBalance).toStringAsFixed(2)} RWF',
                nowPaid: 'Now Paid: ${inputBalance.toStringAsFixed(2)} RWF',
                vat: 'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateOriginalVat(inputBalance).toStringAsFixed(2)} RWF',
                serviceCharge: calculateServiceCharge(inputBalance).toStringAsFixed(2),
                totalNowPaid: 'Total Amount paid now: $totalAmount RWF',
              );
            },
          );
        }
      }
    });
  },
  child: const Text('OK'),
),
          ],
        );
      },
    );
  }
}

TextFormField buildFormField(
    String labelText,
    TextEditingController editingController,
    TextInputType textInputType,
    String hint,
    List<TextInputFormatter>? formatter,
    FocusNode? focusNode) {
  return TextFormField(
    textAlign: TextAlign.start,
    controller: editingController,
    keyboardType: textInputType,
    style: kInputTextStyle,
    inputFormatters: formatter,
    focusNode: focusNode,
    decoration: InputDecoration(
      isCollapsed: true,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 15), //Change this value to custom as you like
      isDense: true,
      focusedBorder: OutlineInputBorder(
        ////<-- SEE HERE
        borderSide: const BorderSide(width: 1, color: kamber300Color),
        borderRadius: BorderRadius.circular(20.0),
      ),

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: kTextLightColor),
        borderRadius: BorderRadius.circular(20.0),
      ),

      errorBorder: OutlineInputBorder(
        //<-- SEE HERE
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
        borderRadius: BorderRadius.circular(20.0),
        //<-- SEE HERE
      ),

      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    },
  );
}

class _MethodFieldWidget extends StatelessWidget {
  final String type;
  final String value;

  const _MethodFieldWidget({required this.type, required this.value});

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
