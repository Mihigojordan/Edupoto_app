import 'package:flutter/foundation.dart';
import 'package:hosomobile/common/controllers/share_controller_sl.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/features/transaction_money/widgets/payment_methods/ps_payment_method_selector.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';

class BottomSheetWithSliderPS extends StatefulWidget {
  final String amount;
  final String? pinCode;
  final String? transactionType;
  final String availableBalance;
  final int? productId;
  final String? purpose;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final int studentId;
  final double? inputBalance;
  final List<SchoolLists>? dataList;
  final int? productIndex;
  final String? edubox_service;
  final int? studentIndex;
  final String? amountToPay;
  final String? nowPaid;
  final String? vat;
  final String? serviceCharge;
  final String? totalNowPaid;
  final String? serviceValue;
  final int? serviceIndex;
  final String studentName;
  final String studentCode;
  final String className;
  final String schoolName;
  final int randomNumber;

  const BottomSheetWithSliderPS({
    super.key,
    this.amountToPay,
    required this.randomNumber,
    required this.studentName,
    required this.studentCode,
    required this.className,
    required this.schoolName,
    this.nowPaid,
    this.studentIndex,
    this.productId,
    required this.availableBalance,
    this.vat,
    this.serviceCharge,
    this.totalNowPaid,
    required this.amount,
    this.pinCode,
    this.transactionType,
    this.purpose,
    this.contactModel,
    this.contactModelMtn,
    required this.studentId,
    this.inputBalance,
    this.productIndex,
    this.dataList,
    this.edubox_service,
    this.serviceIndex,
    this.serviceValue,
  });

  @override
  State<BottomSheetWithSliderPS> createState() => _BottomSheetWithSliderState();
}

class _BottomSheetWithSliderState extends State<BottomSheetWithSliderPS> {
  String? transactionId;
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  List<Districts>? allSchoolList;
  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.transactionType == 'send_money'
        ? 'send_money'.tr
        : widget.transactionType == 'cash_out'
            ? 'cash_out'.tr
            : 'request_money'.tr;
    double cashOutCharge = double.parse(widget.amount) *
        (double.parse(Get.find<SplashController>()
                .configModel!
                .cashOutChargePercent
                .toString()) /
            100);
    String customerImage =
        '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${widget.contactModel!.avatarImage}';
    String agentImage =
        '${Get.find<SplashController>().configModel!.baseUrls!.agentImageUrl}/${widget.contactModel!.avatarImage}';

    final ContactController contactController = Get.find<ContactController>();

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => Get.offAllNamed(RouteHelper.getNavBarRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.getBackgroundColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusSizeLarge),
            topRight: Radius.circular(Dimensions.radiusSizeLarge),
          ),
        ),
        child: GetBuilder<TransactionMoneyController>(
            builder: (transactionMoneyController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(
                          color: ColorResources.getLightGray().withOpacity(0.8),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(Dimensions.radiusSizeLarge)),
                        ),
                        child: Text(
                          '${'confirm_to'.tr} $type',
                          style: rubikSemiBold.copyWith(),
                        ),
                      ),
                      !transactionMoneyController.isLoading
                          ? Visibility(
                              visible:
                                  !transactionMoneyController.isNextBottomSheet,
                              child: Positioned(
                                top: Dimensions.paddingSizeSmall,
                                right: 8.0,
                                child: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorResources
                                                .getGreyBaseGray6()),
                                        child: const Icon(
                                          Icons.clear,
                                          size: Dimensions.paddingSizeDefault,
                                        ))),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  //********************* Student is Problem Here */
                  // transactionMoneyController.isNextBottomSheet
                  //     ? Column(
                  //         children: [
                  //           transactionMoneyController.isNextBottomSheet
                  //               ? Lottie.asset(
                  //                   Images.successAnimation,
                  //                   width: 120.0,
                  //                   fit: BoxFit.contain,
                  //                   alignment: Alignment.center,
                  //                 )
                  //               : Padding(
                  //                   padding: const EdgeInsets.all(
                  //                       Dimensions.paddingSizeSmall),
                  //                   child: Lottie.asset(
                  //                     Images.failedAnimation,
                  //                     width: 80.0,
                  //                     fit: BoxFit.contain,
                  //                     alignment: Alignment.center,
                  //                   ),
                  //                 ),
                  //         ],
                  //       )
                  //     : Column(children: [
                  //         ForStudentWidget(studentInfo: 'Code: ${widget.studentInfo![widget.studentIndex!].code!}\nName: ${widget.studentInfo![widget.studentIndex!].name}'),
                  //       ]),
                  Container(
                    color: ColorResources.getBackgroundColor(),
                    child: Column(
                      children: [
                        transactionMoneyController.isNextBottomSheet
                            ? Text(
                                widget.transactionType == 'send_money'
                                    ? 'send_money_successful'.tr
                                    : widget.transactionType == 'request_money'
                                        ? 'request_send_successful'.tr
                                        : 'cash_out_successful'.tr,
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color))
                            : const SizedBox(),
                        transactionMoneyController.isNextBottomSheet
                            ? Column(children: [
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    transactionId != null
                                        ? Text(
                                            'Receipt No:$transactionId',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          )
                                        : const SizedBox(),
                                    sizedBox10,
                                    //********************* Student is Problem Here */
                                    Column(children: [
                                      ForStudentWidget(
                                          studentInfo:
                                              'Code: ${widget.studentCode}\nName: ${widget.studentName}'),
                                    ]),
                                    sizedBox15,
                                    Text(
                                        'Product: ${widget.edubox_service}, Contains:${'${widget.dataList!.length} ${widget.edubox_service}, '}'), //${widget.studentInfo![widget.studentIndex!].studentClass}
                                    sizedBox15,
                                    Container(
                                      height: Dimensions.dividerSizeMedium,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    sizedBox10,

                                    Text(
                                        'Amount to be Paid: ${widget.amountToPay!} RWF'),

                                    // Text('Now Paid: ${widget.nowPaid!} RWF'),
                                    Text(widget.vat!),

                                    Text(
                                        'Service Charge (${widget.serviceCharge!} RWF'),
                                    const Divider(),
                                    Text(
                                      widget.totalNowPaid!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                sizedBox10,
                                // Text('Pending/Remaing Amount to be paid',
                                //     style: rubikSemiBold.copyWith(
                                //         fontSize: Dimensions.fontSizeLarge,
                                //         color:
                                //             ColorResources.getGreyBaseGray1())),
                                Text(widget.availableBalance,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        )),
                                const SizedBox(height: 15),
                              ])
                            : const SizedBox(),
                        transactionMoneyController.isNextBottomSheet
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Text(
                                      PriceConverterHelper.balanceWithSymbol(
                                          balance: widget.amount),
                                      style:
                                          rubikMedium.copyWith(fontSize: 34.0)),
                                  sizedBox10,
                                  // ************************ Payment Method*******************/

                                  PsPaymentMethodSelector(
                                    product_list: widget.dataList!,
                                    product_name: widget.edubox_service!,
                                    randomNumber: widget.randomNumber,
                                    edubox_service: widget.edubox_service ??
                                        'No Edubox Service',
                                    service_charge: widget.serviceCharge ??
                                        'No Service Charge',
                                    transactionMoneyController:
                                        transactionMoneyController,
                                    transactionId: transactionId ??
                                        '', // Provide empty string if null
                                    studentId: widget.studentId,
                                    amountToPay: widget.amountToPay ??
                                        '0', // Default to '0' if null
                                    productId: widget.productId ??
                                        0, // Default to 0 if null
                                    availableBalance:
                                        widget.availableBalance ?? '0',
                                    serviceCharge: widget.serviceCharge ?? '0',
                                    contactController: contactController,
                                    amount: widget.amount ?? '0',
                                    purpose: widget.purpose ??
                                        'Payment', // Default purpose
                                    pinCode: widget.pinCode ??
                                        '', // Empty string if null
                                    contactModel: widget.contactModel ??
                                        ContactModel(), // Default empty model
                                    mtnMomoApiClient: mtnMomoApiClient,
                                    transactionType: widget.transactionType ??
                                        'payment', // Default type
                                    onPaymentMethodSelected:
                                        (method, details, provider) {
                                      debugPrint(
                                          'Selected $method via $provider with details: $details');
                                    },
                                    initialAmount: widget.amount ?? '0',
                                  )
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeDefault,
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              transactionMoneyController.isNextBottomSheet
                                  ? transactionId != null
                                      ? Text(
                                          'TrxID: $transactionId',
                                          style: rubikLight.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault),
                                        )
                                      : const SizedBox()
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  transactionMoneyController.isNextBottomSheet
                      ? Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.paddingSizeDefault / 1.7),
                              child:
                                  Divider(height: Dimensions.dividerSizeSmall),
                            ),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                         CustomInkWellWidget(
  onTap: () async {
    try {
      final shareController = Get.find<ShareControllerSl>();
      await shareController.statementScreenShootFunction(
        amount: widget.amount,
        transactionType: widget.transactionType,
        contactModel: widget.contactModel,
        charge: widget.transactionType == 'send_money'
            ? Get.find<SplashController>()
                .configModel!
                .sendMoneyChargeFlat
                .toString()
            : cashOutCharge.toString(),
        trxId: transactionId,
        eduboxService: widget.edubox_service,
        studentInfo: 'Code: ${widget.studentCode}\nName: ${widget.studentName}',
        inputBalance: widget.inputBalance,
        dataList: widget.dataList,
        productIndex: widget.productIndex,
        amountToPay: widget.amountToPay,
        nowPaid: widget.nowPaid,
        remainingAmount: widget.availableBalance,
        vat: widget.vat,
        serviceCharge: widget.serviceCharge,
        totalNowPaid: widget.totalNowPaid,
        serviceValue: widget.serviceValue,
        serviceIndex: widget.serviceIndex,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint('Error sharing statement: $e');
    }
  },
  child: Text(
    'share_statement'.tr,
    style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
  ),
),
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                          ],
                        )
                      : const SizedBox(),
                  transactionMoneyController.isNextBottomSheet
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  Dimensions.paddingSizeExtraExtraLarge),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSizeSmall),
                            ),
                            child: CustomInkWellWidget(
                              onTap: () {
                                if (!kIsWeb) {
                                  Get.find<BottomSliderController>()
                                      .goBackButton();
                                } else {
                                        Get.find<BottomSliderController>()
                                      .goBackButton();
                                //   Get.offAll(const MzaziScreen(isShop: false));
                                //   Get.put(AllSchoolController(
                                //           allSchoolRepo: Get.find()))
                                //       .getSchoolList(false)
                                //       .then((_) {
                                //     allSchoolList =
                                //         Get.find<AllSchoolController>()
                                //             .schoolList;
                                //   });
                           }
                              },
                              radius: Dimensions.radiusSizeSmall,
                              highlightColor: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .color!
                                  .withOpacity(0.1),
                              child: SizedBox(
                                height: 50.0,
                                child: Center(
                                    child: Text(
                                  'back_to_home'.tr,
                                  style: rubikMedium.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                )),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
