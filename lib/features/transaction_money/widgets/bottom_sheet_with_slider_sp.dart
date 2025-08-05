import 'package:flutter/foundation.dart';
import 'package:hosomobile/common/controllers/share_controller_sp.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/models/customer_model.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/screen/shop_order_screen.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/transaction_money/widgets/payment_methods/payment_method_selector.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';

class BottomSheetWithSliderSp extends StatefulWidget {
  final String amount;
  final String? pinCode;
  final String? transactionType;
  final String availableBalance;
  final int? productId;
  final String? purpose;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final List<StudentModel>? studentInfo;
  final double? inputBalance;
  Product product;
  int quantity;
  final int productIndex;
  final String? edubox_service;
  final int? studentIndex;
  final String? amountToPay;
  final String? nowPaid;
  final String? vat;
  final String? serviceCharge;
  final String? totalNowPaid;
  final String? serviceValue;
  final int? serviceIndex;
  final Map<Product, int> selectedProducts;
  final int randomNumber;
  final int studentId;
  final String homePhone;
  final double deliveryCost;
  final String materialCost;
  final String customerNote;
  final String shippingAddress1;
  final String shippingAddress2;
  final String shippingCompany;
  final String shippingCity;
  final String shippingCountry;

  BottomSheetWithSliderSp({
    super.key,
    required this.randomNumber,
    required this.studentId,
    required this.homePhone,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingCity,
    required this.shippingCompany,
    required this.shippingCountry,
    this.amountToPay,
    this.nowPaid,
    this.studentIndex,
    this.productId,
    required this.availableBalance,
    required this.selectedProducts,
    this.vat,
    this.serviceCharge,
    this.totalNowPaid,
    required this.amount,
    this.pinCode,
    this.transactionType,
    this.purpose,
    this.contactModel,
    this.contactModelMtn,
    this.studentInfo,
    this.inputBalance,
    required this.productIndex,
    required this.product,
    required this.quantity,
    required this.deliveryCost,
    required this.materialCost,
    required this.customerNote,
    this.edubox_service,
    this.serviceIndex,
    this.serviceValue,
  });

  @override
  State<BottomSheetWithSliderSp> createState() => _BottomSheetWithSliderState();
}

class _BottomSheetWithSliderState extends State<BottomSheetWithSliderSp> {
  String? transactionId;
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  List<Districts>? allSchoolList;
  final ShopController _shopController = Get.find<ShopController>();
  final AuthController _authController = Get.find<AuthController>();
  int? customerId;

  @override
  void initState() {
    Get.find<TransactionMoneyController>().changeTrueFalse();
    super.initState();
    _fetchCustomer();
  }

    Future<void> _fetchCustomer() async {
    try {
      // First check if we already have a customer ID stored locally
     customerId = _shopController.getCustomerId();
      
      if (customerId == null ) {
        // If no customer ID exists, try to find or create one
        final userId = _authController.getUserId();
        final userData = _authController.getUserData();
        final name = userData?.name ?? 'User$userId';
        final String nameWithoutSpaces = name.replaceAll(' ', '');
        final String email = '$nameWithoutSpaces$userId@gmail.com';

        // Fetch customer list from API
        await _shopController.getCustomerData(reload: true);

        // Try to find existing customer by email
        CustomerModel? existingCustomer;
        try {
          existingCustomer = _shopController.customerList?.firstWhere(
            (customer) => customer.email?.toLowerCase() == email.toLowerCase(),
          );
        } catch (e) {
          debugPrint('No existing customer found: $e');
        }

        // If customer exists, store the ID
        if (existingCustomer?.id != null) {
          _shopController.setCustomerId(existingCustomer!.id.toString());
          customerId=existingCustomer.id;
        } else {
          // If customer doesn't exist, create a new one
          final response = await _shopController.customerReg(
            email: email,
            phone: userData?.phone ?? '',
            firstName: name.split(' ').first,
            lastName: name.split(' ').length > 1 ? name.split(' ').sublist(1).join(' ') : '',
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final newCustomerId = response.body['id']?.toString();
            if (newCustomerId != null) {
              _shopController.setCustomerId(newCustomerId);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching customer: $e');
    }
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
    

   final List<Map<String, dynamic>> productMaps = 
    widget.selectedProducts.entries.map((entry) {
      final product = entry.key;
      final quantity = entry.value;
      
      return {
        'product_id': product.id,
        'name': product.name,
        'price': double.tryParse(product.regularPrice ?? '0') ?? 0.0,
        'quantity': quantity,
        // include other required properties
      };
    }).toList();

    // final String joinedProducts = productDescriptions.join(', ');
// Output: "Product1 (10 USD) x 2, Product2 (15 USD) x 1"

    return PopScope(
      canPop: true,
      onPopInvoked: (_) => Get.back(closeOverlays: true, canPop: true),
      child: Container(
        
          decoration: BoxDecoration(
            color: ColorResources.getBackgroundColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radiusSizeLarge),
              topRight: Radius.circular(Dimensions.radiusSizeLarge),
            ),
          ),
          child: GetBuilder<ShopController>(builder: (shopController) {
            return GetBuilder<TransactionMoneyController>(
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
                              color: ColorResources.getLightGray()
                                  .withOpacity(0.8),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(
                                      Dimensions.radiusSizeLarge)),
                            ),
                            child: Text(
                              '${'confirm_to'.tr} $type',
                              style: rubikSemiBold.copyWith(),
                            ),
                          ),
                          !transactionMoneyController.isLoading
                              ? Visibility(
                                  visible: !transactionMoneyController
                                      .isNextBottomSheet,
                                  child: Positioned(
                                    top: Dimensions.paddingSizeSmall,
                                    right: 8.0,
                                    child: GestureDetector(
                                        onTap: () {
                                          if (!kIsWeb) {
                                            Get.find<BottomSliderController>()
                                                .goBackButton();
                                          } else {
                                            Get.find<BottomSliderController>()
                                                .goBackButton();
                                          }
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorResources
                                                    .getGreyBaseGray6()),
                                            child: const Icon(
                                              Icons.clear,
                                              size:
                                                  Dimensions.paddingSizeDefault,
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
                                        : widget.transactionType ==
                                                'request_money'
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        transactionId != null
                                            ? Text(
                                                '${'receipt'.tr}:$transactionId',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              )
                                            : const SizedBox(),
                                        sizedBox10,
                                        //********************* Student is Problem Here */
                                        Wrap(
                                          spacing:
                                              8.0, // Horizontal space between items
                                          runSpacing:
                                              4.0, // Vertical space between lines
                                          children: widget.studentInfo!
                                              .map((student) {
                                            return Text(
                                              '${'code'.tr}: ${student.code!}\n${'name'.tr}: ${student.name}',
                                            );
                                          }).toList(),
                                        ),
                                        sizedBox5,
                                        Container(
                                          height: Dimensions.dividerSizeMedium,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        sizedBox5,
                                        Text('${'product'.tr}:'),
                                        Wrap(
                                          spacing:
                                              8.0, // Horizontal space between items
                                          runSpacing:
                                              4.0, // Vertical space between lines
                                          children: widget
                                              .selectedProducts.entries
                                              .map((entry) {
                                            final product = entry.key;
                                            final quantity = entry.value;
                                            return Text(
                                              '${product.name} (${product.regularPrice} ${AppConstants.currency}) x $quantity, ',
                                            );
                                          }).toList(),
                                        ),
                                        sizedBox10,
                                        Text(
                                            '${'destination'.tr}: ${widget.shippingAddress1}'),
                                        //${widget.studentInfo![widget.studentIndex!].studentClass}
                                        sizedBox10,
                                        Container(
                                          height: Dimensions.dividerSizeMedium,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        sizedBox10,
                                        Text(
                                            '${'delivery_cost'.tr}: ${widget.deliveryCost} ${AppConstants.currency}'),
                                        Text(
                                            '${'material_cost'.tr}: ${widget.materialCost} ${AppConstants.currency}'),

                                        Text(widget.vat!),

                                        Text(
                                            '${'convenience_fee'.tr} (${widget.serviceCharge!} ${AppConstants.currency}'),
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
                                    // Text(widget.availableBalance,
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleMedium!
                                    //         .copyWith(
                                    //           fontWeight: FontWeight.bold,
                                    //         )),
                                    const SizedBox(height: 15),
                                  ])
                                : const SizedBox(),
                            transactionMoneyController.isNextBottomSheet
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      Text(
                                          PriceConverterHelper
                                              .balanceWithSymbol(
                                                  balance: widget.amount),
                                          style: rubikMedium.copyWith(
                                              fontSize: 34.0)),
                                      sizedBox10,
                                      // ************************ Payment Method*******************/
                                      
                                      PaymentMethodSelector(
                                        customerNote: widget.customerNote,
                                        deliveryCost: widget.deliveryCost,
                                        shopController: shopController,
                                        vat: widget.vat!,
                                        shopList: productMaps,
                                        //  widget.selectedProducts.entries
                                        //     .map((entry) {
                                        //   final product = entry.key;
                                        //   final quantity = entry.value;
                                        //   return '${product.name} (${product.regularPrice} ${AppConstants.currency}) x $quantity, ';
                                        // }).toList(),
                                        shippingAddress1:
                                            widget.shippingAddress1,
                                        shippingAddress2:
                                            widget.shippingAddress2,
                                        shippingFirstName: '',
                                        shippingLastName: '',
                                        shippingCompany: widget.shippingCompany,
                                        shippingCity: widget.shippingCity,
                                        shippingCountry: widget.shippingCountry,
                                        productName: widget.edubox_service ??
                                            'no product available',
                                        homePhone: widget.homePhone,
                                        service_charge:
                                            widget.serviceCharge ?? '0',
                                        edubox_service: widget.edubox_service ??
                                            'no Edubox Service',
                                        randomNumber: widget.randomNumber,
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
                                        serviceCharge:
                                            widget.serviceCharge ?? '0',
                                        contactController: contactController,
                                        amount: widget.amount ?? '0',
                                        purpose: widget.purpose ??
                                            'Payment', // Default purpose
                                        pinCode: widget.pinCode ??
                                            '', // Empty string if null
                                        contactModel: widget.contactModel ??
                                            ContactModel(), // Default empty model
                                        mtnMomoApiClient: mtnMomoApiClient,
                                        transactionType:
                                            widget.transactionType ??
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
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child:
                                  Divider(height: Dimensions.dividerSizeSmall),
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
                                              'TrxID: ${widget.randomNumber}',
                                              style: rubikLight.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
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
                                  child: Divider(
                                      height: Dimensions.dividerSizeSmall),
                                ),
                                const SizedBox(
                                    height: Dimensions.paddingSizeDefault),
                                // CustomInkWellWidget(
                                //   onTap: () async => await Get.find<ShareControllerSp>()
                                //       .statementScreenShootFunction(
                                //         deliveryCost: '${'delivery_cost'.tr}: ${widget.deliveryCost!} ${AppConstants.currency}',
                                //     destination: widget.destination,
                                //     amount: widget.materialCost,
                                //     transactionType: widget.transactionType,
                                //     contactModel: widget.contactModel,
                                //     charge: widget.transactionType == 'send_money'
                                //         ? Get.find<SplashController>()
                                //             .configModel!
                                //             .sendMoneyChargeFlat
                                //             .toString()
                                //         : cashOutCharge.toString(),
                                //     trxId: transactionId,
                                //     eduboxService: widget.edubox_service,
                                //     studentInfo:
                                //         '${'code'.tr}: ${widget.studentInfo![widget.studentIndex!].code!}\n${'code'.tr}: ${widget.studentInfo![widget.studentIndex!].name}',
                                //     inputBalance: widget.inputBalance,
                                //     product: widget.product,
                                //     productIndex: widget.productIndex,
                                //     amountToPay: widget.materialCost,
                                //     nowPaid: widget.nowPaid,
                                //     remainingAmount: widget.availableBalance,
                                //     vat: widget.vat,
                                //     serviceCharge:'${'convenience_fee'.tr}: ${widget.serviceCharge}',
                                //     totalNowPaid: widget.totalNowPaid,
                                //     serviceValue: widget.serviceValue,
                                //     serviceIndex: widget.serviceIndex,

                                //   ),
                                //   child: Text('share_statement'.tr,
                                //       style: rubikMedium.copyWith(
                                //           fontSize: Dimensions.fontSizeLarge)),
                                // ),
                                // sizedBox05h,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions
                                          .paddingSizeExtraExtraLarge),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSizeSmall),
                                    ),
                                    child: CustomInkWellWidget(
                                      onTap: () {
                                         
                                        Get.to(ShopOrderScreen(customerId: customerId,)) ;
                                      }
                                      ,
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
                                          'my_orders'.tr,
                                          style: rubikMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBox05h
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
                                          .goBackToHomeButton();
                                    } else {
                                      Get.find<BottomSliderController>()
                                          .goBackToHomeButton();
                                      // Get.offAll(const MzaziScreen(isShop: false));
                                      // Get.put(AllSchoolController(
                                      //         allSchoolRepo: Get.find()))
                                      //     .getSchoolList(false)
                                      //     .then((_) {
                                      //   allSchoolList =
                                      //       Get.find<AllSchoolController>()
                                      //           .schoolList;
                                      // });
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
                          : const SizedBox(height: 40.0),
                    ],
                  ),
                ),
              );
            });
          })),
    );
  }
}
