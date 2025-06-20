import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:hosomobile/common/controllers/share_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/custom_logo_widget.dart';

class ShareStatementWidgetSl extends StatefulWidget {
  final String? amount;
  final String? transactionType;
  final ContactModel? contactModel;
  final String? charge;
  final String? trxId;
  final String? studentInfo;
  final double? inputBalance;
  final List<SchoolLists>? dataList;
  final int? productIndex;
  final String? edubox_service;
  final String? amountToPay;
  final String? nowPaid;
  final String? remainingAmount;
  final String? vat;
  final String? serviceCharge;
  final String? totalNowPaid;
  final String? serviceValue;
  final int? serviceIndex;
  final int? studentIndex;
  final String destination;

  const ShareStatementWidgetSl(
      {super.key,
      this.amountToPay,
      this.nowPaid,
      this.remainingAmount,
      this.vat,
      this.serviceCharge,
      this.totalNowPaid,
      required this.amount,
      required this.transactionType,
      required this.contactModel,
      required this.charge,
      required this.trxId,
      required this.destination,
      this.studentInfo,
      this.inputBalance,
      this.productIndex,
      this.dataList,
      this.edubox_service,
      this.serviceIndex,
      this.serviceValue,
      this.studentIndex
      });

  @override
  State<ShareStatementWidgetSl> createState() => ShareStatementWidgetState();
}

class ShareStatementWidgetState extends State<ShareStatementWidgetSl> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final splashController = Get.find<SplashController>();
    return Screenshot(
      key: widget.key,
      controller: Get.find<ShareController>().statementController,
      child: Scaffold(
        backgroundColor: ColorResources.backgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: size.height,
              width: size.width,
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration:
                  BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
                BoxShadow(
                  color: ColorResources.blackColor.withOpacity(0.25),
                  blurRadius: 6,
                )
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(Images.successIcon)),
                  Center(
                      child: Text('successful'.tr,
                          style: rubikRegular.copyWith(
                              fontSize: Dimensions.fontSizeOverOverLarge,
                              color: Theme.of(context).primaryColor))),
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Receipt No:${widget.trxId}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          sizedBox10,
                          Column(children: [
                            ForStudentWidget(studentInfo: widget.studentInfo!),
                          ]),
                          sizedBox15,
                          Text(
                              '${widget.edubox_service}: ${widget.serviceIndex==1?'':  '${widget.dataList![widget.productIndex!].transactionId}, ${widget.dataList![widget.productIndex!].amount}'}'),
                          sizedBox15,
                          Container(
                            height: Dimensions.dividerSizeMedium,
                            color: Theme.of(context).dividerColor,
                          ),
                          sizedBox10,
                          Text(widget.amountToPay!),
                          Text(widget.nowPaid!),
                          Text(widget.vat!),
                          Text(widget.serviceCharge!),
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
                      Text('Pending/Remaing Amount to be paid',
                          style: rubikSemiBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: ColorResources.getGreyBaseGray1())),
                      Text(widget.remainingAmount!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                      const SizedBox(height: 15),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Divider(height: Dimensions.dividerSizeSmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault,
                      horizontal: Dimensions.paddingSizeDefault,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'TrxID: ${widget.trxId}',
                          style: rubikLight.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomLogoWidget(width: 67, height: 67),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Text(
                            '${splashController.configModel!.companyName}',
                            style: rubikMedium.copyWith(
                                fontSize: Dimensions.fontSizeOverOverLarge,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
