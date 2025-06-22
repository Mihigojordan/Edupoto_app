import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/add_money/controllers/add_money_controller.dart';
import 'package:hosomobile/features/history/screens/history_screen.dart';
import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/widget/widget_dialog.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/transaction_money/domain/models/purpose_model.dart';
import 'package:hosomobile/features/transaction_money/domain/models/withdraw_model.dart';
import 'package:hosomobile/features/transaction_money/screens/credit_transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/credit_transaction_confirmation_screen_sl.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_person_widget.dart';
import 'package:hosomobile/helper/currency_text_input_formatter_helper.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:hosomobile/helper/email_checker_helper.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';

class TerekaAsome extends StatefulWidget {
  final String? transactionType;
  final int? studentId;
  final int? productId;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final String? countryCode;
  final int? schoolId;
  final int? classId;
  final int studentIndex;
  final String? parent;
  String? productValue;
  final String? iconImages;
  final String? edubox_service;
  final int? productIndex;
  TerekaAsome(
      {super.key,
      this.transactionType,
      this.studentId,
      this.productId,
      this.parent,
      this.classId,
      this.schoolId,
      this.contactModel,
      this.countryCode,
      this.contactModelMtn,
      required this.studentIndex,
      this.productValue,
      this.iconImages,
      this.edubox_service,
      this.productIndex});
  @override
  _TerekaAsomeState createState() => _TerekaAsomeState();
}

class _TerekaAsomeState extends State<TerekaAsome> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  late String videoTitle;
  // Url List

  Map<String, dynamic> cStates = {};
  //changes current state
  bool isAddAccount = false;
  bool? isUserLoggedIn = false;

  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;
  List<MethodField>? _fieldList;
  List<MethodField>? _gridFieldList;
  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};

  setAddAccount() {
    setState(() {
      isAddAccount = !isAddAccount;
    });
  }

  final FocusNode _inputAmountFocusNode = FocusNode();

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    if (widget.transactionType == TransactionType.withdrawRequest) {
      Get.find<TransactionMoneyController>().getWithdrawMethods();
    }
    Get.find<EduboxMaterialController>().getEduboxMaterialList(true,
        isUpdate: false,
        schoolId: widget.schoolId!,
        classId: widget.classId!,
        studentId: widget.studentId!);
    Get.find<AddMoneyController>()
        .setPaymentMethod(widget.transactionType, isUpdate: false);
  }

  @override
  Widget build(BuildContext context) {
    print('ssssssssssssssssssss:class Id: ${widget.studentId}');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return UpgradeAlert(
        child: Scaffold(
            backgroundColor: kOtherColor,
            // drawer: NavDrawer(),

            body: GetBuilder<EduboxMaterialController>(
                builder: (eduboxMaterialController) {
              return eduboxMaterialController.isLoading
                  ? const WebSiteShimmer()
                  : eduboxMaterialController.eduboxMaterialList!.isEmpty
                      ? const SizedBox()
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  color: kyellowColor,
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          sizedBox,
                                          sizedBox10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: widget.productIndex == 0
                                                    ? 235
                                                    : 150,
                                                child: IconImageWidget(
                                                    image: widget.iconImages!,
                                                    fit: BoxFit.cover,
                                                    placeholder: Images
                                                        .bannerPlaceHolder),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Positioned(
                                      //     right: 10,
                                      //     top: MediaQuery.of(context).size.height / 8,
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           'Add Account',
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .titleSmall!
                                      //               .copyWith(
                                      //                   fontSize: 14,
                                      //                   color: Colors.black,
                                      //                   fontWeight: FontWeight.bold),
                                      //         ),
                                      //         TextButton(
                                      //           onPressed: () => setAddAccount(),
                                      //           child: const CircleAvatar(
                                      //             child: Padding(
                                      //               padding: EdgeInsets.all(5.0),
                                      //               child: Icon(
                                      //                 Icons.add,
                                      //                 color: Colors.black,
                                      //                 size: 25,
                                      //               ),
                                      //             ),
                                      //             radius: 18,
                                      //             backgroundColor: kTextWhiteColor,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: kamber300Color,
                                    child: Container(
                                      //  height: MediaQuery.of(context).size.height,
                                      //   padding: EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                          color: kOtherColor,
                                          //reusable radius,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: screenHeight >= 763 ? 10 : 10,
                              left: screenWidth >= 520 ? 10 : 10,
                              child: const CustomBackButton(),
                            ),
                            Positioned(
                                top: screenHeight / 5,
                                left:
                                    screenWidth >= 520 ? screenWidth / 6.5 : 20,
                                right:
                                    screenWidth >= 520 ? screenWidth / 6.5 : 20,
                                child: HomeCard1(
                                  productId: widget.productId,
                                  contactModel: widget.contactModel,
                                  countryCode: widget.countryCode,
                                  isAddAccount: isAddAccount,
                                  contactModelMtn: widget.contactModelMtn,
                                  productList: eduboxMaterialController
                                      .eduboxMaterialList![widget.productIndex!]
                                      .productTypes!,
                                  studentIndex: widget.studentIndex,
                                  productValue: widget.productValue,
                                  productIndex: widget.productIndex,
                                  edubox_service: widget.edubox_service,
                                )),
                          ],
                        );
            })
            //   bottomNavigationBar: BottomNav(
            //   color: kamber300Color,
            // ),
            ));
  }
}

class HomeCard1 extends StatefulWidget {
  final String? transactionType;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final int? productId;
  final String? countryCode;
  final String? parent;
  String? productValue;
  final int? productIndex;
  final List<ProductTypeModel> productList;
  int studentIndex;
  final bool isAddAccount; // Removed the nullable type since it's required
  final String? edubox_service;
  HomeCard1(
      {super.key,
      this.transactionType,
      this.productId,
      this.contactModel,
      this.parent,
      this.contactModelMtn,
      this.countryCode,
      required this.isAddAccount, // This is required, so no need for nullable type
      required this.productList,
      required this.studentIndex,
      this.productValue,
      this.edubox_service,
      this.productIndex});

  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  final TextEditingController _inputAmountController = TextEditingController();

  String? _selectedMethodId;
  int selectedIndex = 0;
  int materialIndex = 0;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};
  final FocusNode _inputAmountFocusNode = FocusNode();

  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;

  String? phoneNumber;
  String studentcardValue = 'Choose student\'s card to fund';

  String transactionType = 'add_money';

  late ContactController contactController;
  TextEditingController cardEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController productEditingController = TextEditingController();
  WidgetDialog dialog = WidgetDialog();
  ContactModel? _contact;

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }

  void initializeController() {
    _inputAmountController.text = '1000'; // Set the initial value
  }

  double totalCostWithService(double cost) {
    return cost + cost / 100;
  }

  @override
  void initState() {
    super.initState();
    initializeController();
    // if(widget.transactionType == TransactionType.withdrawRequest) {
    //   Get.find<TransactionMoneyController>().getWithdrawMethods();
    // }
    // Get.find<AddMoneyController>().setPaymentMethod(widget.transactionType, isUpdate: false);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final SplashController splashController = Get.find<SplashController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    late EduboxMaterialModel material;

    return GetBuilder<SplashController>(builder: (splashController) {
      return //splashController.configModel!.systemFeature!.linkedWebSiteStatus! ?
          GetBuilder<StudentController>(builder: (studentController) {
        return studentController.isLoading
            ? const WebSiteShimmer()
            : studentController.studentList!.isEmpty
                ? const SizedBox()
                : Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: kTextLightColor,
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3)),
                            ],
                            color: kTextWhiteColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: screenHeight / 1.3,
                        width: screenWidth >= 520 ? 340 : screenWidth / 1.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deposit on your child\'s school requirements',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                              ),
                              if (widget.transactionType !=
                                      TransactionType.addMoney &&
                                  widget.transactionType !=
                                      TransactionType.withdrawRequest)
                                ForPersonWidget(
                                    contactModel: widget.contactModel),
                              sizedBox,
                              Text(
                                'Student Code Number:',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                              DropDownAccount(
                                onChanged: (selectedCode) {
                                  setState(() {
                                    // Find the index of the selected student in the list using the selected code
                                    widget.studentIndex = studentController
                                        .studentList!
                                        .indexWhere((student) =>
                                            student.code == selectedCode);

                                    // You may want to add additional logic here based on the selected code
                                    print(
                                        'Selected student index: ${widget.studentIndex}');
                                  });
                                },
                                itemLists: studentController.studentList!,
                                title:
                                    'Code: ${studentController.studentList![widget.studentIndex].code!}\nName: ${studentController.studentList![widget.studentIndex].name}',
                                isExpanded: true,
                              ),
                              sizedBox15,
                              Text(
                                'Product: ${widget.edubox_service} (${studentController.studentList?[widget.studentIndex]?.studentClass ?? ''}):',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              // Materials List
                              if (widget.productList.isNotEmpty &&
                                  selectedIndex < widget.productList.length &&
                                  widget.productList[selectedIndex]
                                          .eduboxMaterials !=
                                      null)
                                SizedBox(
                                  height: 65,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.productList[selectedIndex]
                                        .eduboxMaterials!.length,
                                    itemBuilder: (context, materialIndex) {
                                      material = widget
                                          .productList[selectedIndex]
                                          .eduboxMaterials![materialIndex];
                                      return ListTile(
                                        title: Text(
                                          '${material.name} ${material.price} ${AppConstants.currency}\n'
                                          'Balance to be Paid: ${material.paymentHistory?.balance != null && double.parse(material.paymentHistory!.balance!) > 0.00 ? material.paymentHistory!.balance : material.price} ${AppConstants.currency}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              else
                                const SizedBox(),

                              sizedBox10,

                              // Dropdown
                              if (widget.productList.isNotEmpty)
                                DropDownEdubox(
                                  onChanged: (selectedProduct) {
                                    setState(() {
                                      selectedIndex = widget.productList
                                          .indexWhere((product) =>
                                              product.name == selectedProduct);

                                      if (selectedIndex >= 0) {
                                        print(
                                            'Selected product index: $selectedIndex');
                                      }
                                    });
                                  },
                                  itemLists: widget.productList,
                                  title: widget.productList.isNotEmpty
                                      ? widget.productList[0].name ??
                                          'Select Product'
                                      : 'No Products',
                                  isExpanded: true,
                                )
                              else
                                Text('No products available'),

                              sizedBox15,
                              //DependentDropdowns(),
                              //   Text.rich(
                              //   TextSpan(
                              //     children: [
                              //       TextSpan(
                              //         text: 'Total Product Cost ',
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           color: Colors.black.withOpacity(0.5), // Text color for the initial part
                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //       ),
                              //       TextSpan(
                              //         text: ' Rwf${widget.productList[selectedIndex]['price']!}:'  ,
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           color: Colors.black, // Color for the amount
                              //           fontWeight: FontWeight.bold, // Optional: bold the amount
                              //         ),
                              //       ),
                              //   //     TextSpan(
                              //   //       text: 'with service charge of ',
                              //   //       style: TextStyle(
                              //   //         fontSize: 14,
                              //   //         color: Colors.black.withOpacity(0.5), // Color for the last part
                              //   //         fontWeight: FontWeight.w400,
                              //   //       ),
                              //   //     ),
                              //   //        TextSpan(
                              //   //       text: '1%',
                              //   //  style: TextStyle(
                              //   //         fontSize: 14,
                              //   //         color: Colors.black, // Color for the amount
                              //   //         fontWeight: FontWeight.bold, // Optional: bold the amount
                              //   //       ),
                              //   //     ),
                              //     ],
                              //   ),
                              // ),

                              // sizedBox10,
                              // buildFormField(
                              //   'Enter amount',
                              //   _inputAmountController,
                              //   TextInputType.number,
                              //   PriceConverterHelper.balanceInputHint(),
                              //   [
                              //     LengthLimitingTextInputFormatter(
                              //       Get.find<SplashController>()
                              //                   .configModel!
                              //                   .currencyPosition ==
                              //               'left'
                              //           ? AppConstants.balanceInputLen +
                              //               (AppConstants.balanceInputLen / 3)
                              //                   .floor() +
                              //               Get.find<SplashController>()
                              //                   .configModel!
                              //                   .currencySymbol!
                              //                   .length
                              //           : AppConstants.balanceInputLen +
                              //               (AppConstants.balanceInputLen / 3)
                              //                   .ceil() +
                              //               Get.find<SplashController>()
                              //                   .configModel!
                              //                   .currencySymbol!
                              //                   .length,
                              //     ),
                              //     CurrencyTextInputFormatterHelper(
                              //       decimalDigits: 0,
                              //       locale: Get.find<SplashController>()
                              //                   .configModel!
                              //                   .currencyPosition ==
                              //               'left'
                              //           ? 'en'
                              //           : 'fr',
                              //       symbol:
                              //           '${Get.find<SplashController>().configModel!.currencySymbol}',
                              //     ),
                              //   ],
                              //   _inputAmountFocusNode,
                              // ),

                            
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  DefaultButtonWidth(
                                    width: 123,
                                    color1: kamber300Color,
                                    color2: kyellowColor,
                                    onPress: () {
                                      // Ensure material exists
                                      if (material == null) {
                                        showCustomSnackBarHelper(
                                            'Material information not available',
                                            isError: true);
                                        return;
                                      }
                                  
                                      // Get material balance with proper null checks
                                      double materialBalance;
                                      try {
                                        materialBalance = (material
                                                        .paymentHistory?.balance !=
                                                    null &&
                                                double.tryParse(material
                                                            .paymentHistory!
                                                            .balance ??
                                                        '0.00')! >
                                                    0.00)
                                            ? double.parse(
                                                material.paymentHistory!.balance!)
                                            : double.parse(
                                                material.price?.toString() ??
                                                    '0.00');
                                      } catch (e) {
                                        materialBalance = 0.00;
                                      }
                                  
                                      // Check input amount
                                      if (_inputAmountController.text.isEmpty) {
                                        showCustomSnackBarHelper(
                                            'please_input_amount'.tr,
                                            isError: true);
                                        return;
                                      }
                                  
                                      // Process amount
                                      String balance = _inputAmountController.text;
                                      balance = balance
                                          .replaceAll(
                                              splashController.configModel
                                                      ?.currencySymbol ??
                                                  '',
                                              '')
                                          .replaceAll(',', '')
                                          .replaceAll(' ', '');
                                  
                                      double amount;
                                      try {
                                        amount = double.parse(balance);
                                      } catch (e) {
                                        showCustomSnackBarHelper(
                                            'invalid_amount_format'.tr,
                                            isError: true);
                                        return;
                                      }
                                  
                                      if (amount <= 0) {
                                        showCustomSnackBarHelper(
                                            'transaction_amount_must_be'.tr,
                                            isError: true);
                                        return;
                                      }
                                  
                                      // Check product list bounds
                                      if (widget.productList.isEmpty ||
                                          selectedIndex >=
                                              widget.productList.length ||
                                          widget.productList[selectedIndex]
                                                  .eduboxMaterials ==
                                              null ||
                                          materialIndex >=
                                              widget.productList[selectedIndex]
                                                  .eduboxMaterials!.length) {
                                        showCustomSnackBarHelper(
                                            'product_information_not_available'.tr,
                                            isError: true);
                                        return;
                                      }
                                  
                                      // Get current material safely
                                      final currentMaterial = widget
                                          .productList[selectedIndex]
                                          .eduboxMaterials![materialIndex];
                                  
                                      // if (amount < 100 ||
                                      //     amount > materialBalance ||
                                      //     materialBalance <= 0.00) {
                                      //   dialog.showWarningDialog(
                                      //       context: context,
                                      //       balance: materialBalance,
                                      //       amount: double.tryParse(currentMaterial
                                      //                   .price
                                      //                   ?.toString() ??
                                      //               '0.00') ??
                                      //           0.00,
                                      //       inputAmaount: amount);
                                      // } else {
                                        _confirmationRoute(
                                            amount: amount,
                                            price: double.tryParse(currentMaterial
                                                        .price
                                                        ?.toString() ??
                                                    '0.00') ??
                                                0.00,
                                            balance: double.tryParse(currentMaterial
                                                        .price
                                                        ?.toString() ??
                                                    '0.00') ??
                                                0.00,
                                            );
                                      // }
                                    },
                                    title: 'PAY CASH',
                                  
                                  ),
                                  DefaultButtonWidth(
  width: 123,
  color1: kamber300Color,
  color2: kyellowColor,
  onPress: () => showDepositDialog(
    context: context,
    title: 'How much would you like to deposit?',
    onDeposit: (amount) {
      _handleDeposit(amount:amount,material: material);
      
    },
  ),
  title: 'DEPOSIT',
),

                                ],
                              ),

                              sizedBox10,

                              DefaultButton2(
                                color1: kamber300Color,
                                color2: kyellowColor,
                                onPress: () {
                                  // Same safety checks as above button
                                  if (material == null) {
                                    showCustomSnackBarHelper(
                                        'Material information not available',
                                        isError: true);
                                    return;
                                  }

                                  double materialBalance;
                                  try {
                                    materialBalance = (material
                                                    .paymentHistory?.balance !=
                                                null &&
                                            double.tryParse(material
                                                        .paymentHistory!
                                                        .balance ??
                                                    '0.00')! >
                                                0.00)
                                        ? double.parse(
                                            material.paymentHistory!.balance!)
                                        : double.parse(
                                            material.price?.toString() ??
                                                '0.00');
                                  } catch (e) {
                                    materialBalance = 0.00;
                                  }

                                  if (_inputAmountController.text.isEmpty) {
                                    showCustomSnackBarHelper(
                                        'please_input_amount'.tr,
                                        isError: true);
                                    return;
                                  }

                                  String balance = _inputAmountController.text;
                                  balance = balance
                                      .replaceAll(
                                          splashController.configModel
                                                  ?.currencySymbol ??
                                              '',
                                          '')
                                      .replaceAll(',', '')
                                      .replaceAll(' ', '');

                                  double amount;
                                  try {
                                    amount = double.parse(balance);
                                  } catch (e) {
                                    showCustomSnackBarHelper(
                                        'invalid_amount_format'.tr,
                                        isError: true);
                                    return;
                                  }

                                  if (amount <= 0) {
                                    showCustomSnackBarHelper(
                                        'transaction_amount_must_be'.tr,
                                        isError: true);
                                    return;
                                  }

                                  if (widget.productList.isEmpty ||
                                      selectedIndex >=
                                          widget.productList.length ||
                                      widget.productList[selectedIndex]
                                              .eduboxMaterials ==
                                          null ||
                                      materialIndex >=
                                          widget.productList[selectedIndex]
                                              .eduboxMaterials!.length) {
                                    showCustomSnackBarHelper(
                                        'product_information_not_available'.tr,
                                        isError: true);
                                    return;
                                  }

                                  final currentMaterial = widget
                                      .productList[selectedIndex]
                                      .eduboxMaterials![materialIndex];

                                  // if (amount < 100 ||
                                  //     amount > materialBalance ||
                                  //     materialBalance <= 0.00) {
                                  //   dialog.showWarningDialog(
                                  //       context: context,
                                  //       balance: materialBalance,
                                  //       amount: double.tryParse(currentMaterial
                                  //                   .price
                                  //                   ?.toString() ??
                                  //               '0.00') ??
                                  //           0.00,
                                  //       inputAmaount: amount);
                                  // } else {
                                    _creditConfirmationRoute(
                                        amount: double.tryParse(currentMaterial
                                                    .price
                                                    ?.toString() ??
                                                '0.00') ??
                                            0.00,
                                        price: double.tryParse(currentMaterial
                                                    .price
                                                    ?.toString() ??
                                                '0.00') ??
                                            0.00,
                                        balance: materialBalance);
                                  // }
                                },
                                title: 'REQUEST FOR CREDIT',
                                iconData: Icons.arrow_forward_outlined,
                              ),
                              sizedBox10,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => dialog.showSntDialog(
                                          school:
                                              'School: ${studentController.studentList![widget.studentIndex].school}\nClass: ${studentController.studentList![widget.studentIndex].studentClass}',
                                          context: context,
                                          index: widget.studentIndex,
                                          title:
                                              'Code: ${studentController.studentList![widget.studentIndex].code!}\nName: ${studentController.studentList![widget.studentIndex].name}'),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: kgrey800Color,
                                          ),
                                          Text(
                                            'Beneficiary Profile',
                                            style: ktextGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => showInfoDialog(
                                          context: context,
                                          index: selectedIndex,
                                          indexM: materialIndex),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: kgrey800Color,
                                          ),
                                          Text(
                                            'Product Details',
                                            style: ktextGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.to(HistoryScreen()),
                                      child: const Column(
                                        children: [
                                          Icon(
                                            Icons.monetization_on,
                                            color: kgrey800Color,
                                          ),
                                          Text(
                                            'Transactions',
                                            style: ktextGrey,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 200,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
      });
    });
  }

  // Separate method for deposit handling
void _handleDeposit({required double amount, EduboxMaterialModel? material}) {
  // Validate material exists
  if (material == null) {
    showCustomSnackBarHelper('Material information not available', isError: true);
    return;
  }

  // Calculate material balance safely
  final materialBalance = _calculateMaterialBalance(material!);

  // Validate amount
  if (amount <= 0) {
    showCustomSnackBarHelper('transaction_amount_must_be'.tr, isError: true);
    return;
  }

  // Validate product information
  if (!_validateProductInfo()) {
    showCustomSnackBarHelper('product_information_not_available'.tr, isError: true);
    return;
  }

  final currentMaterial = _getCurrentMaterial();
  if (currentMaterial == null) {
    showCustomSnackBarHelper('Selected material not found', isError: true);
    return;
  }

  // Validate amount against balance
  if (amount < 100 || amount > materialBalance || materialBalance <= 0.00) {
    dialog.showWarningDialog(
      context: context,
      balance: materialBalance,
      amount: _parseMaterialPrice(currentMaterial),
      inputAmaount: amount,
    );
  } else {
    _confirmationRoute(
      amount:amount,
      price: _parseMaterialPrice(currentMaterial),
      balance: materialBalance,
    );
  }
}

// Helper methods
double _calculateMaterialBalance(EduboxMaterialModel material) {
  try {
    return (material.paymentHistory?.balance != null && 
            double.tryParse(material.paymentHistory!.balance ?? '0.00')! > 0.00)
        ? double.parse(material.paymentHistory!.balance!)
        : double.parse(material.price?.toString() ?? '0.00');
  } catch (e) {
    return 0.00;
  }
}

bool _validateProductInfo() {
  return widget.productList.isNotEmpty &&
      selectedIndex < widget.productList.length &&
      widget.productList[selectedIndex].eduboxMaterials != null &&
      materialIndex < widget.productList[selectedIndex].eduboxMaterials!.length;
}

EduboxMaterialModel? _getCurrentMaterial() {
  if (!_validateProductInfo()) return null;
  return widget.productList[selectedIndex].eduboxMaterials![materialIndex];
}

double _parseMaterialPrice(EduboxMaterialModel material) {
  return double.tryParse(material.price?.toString() ?? '0.00') ?? 0.00;
}

  sendMoney() {
    _contact = ContactModel(
        phoneNumber: numberEditingController.text,
        avatarImage: widget.productValue,
        name: studentcardValue);
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

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Widget addAccout() {
  //   bool? isAddAccount = widget.isAddAccount;
  //   return Container(
  //       decoration: const BoxDecoration(
  //           boxShadow: [
  //             BoxShadow(
  //                 color: kTextLightColor,
  //                 spreadRadius: 3,
  //                 blurRadius: 7,
  //                 offset: Offset(0, 3)),
  //           ],
  //           color: kTextWhiteColor,
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //       height: 300,
  //       width: 340,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ListView(
  //           // crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Register child\'s information here',
  //               style: Theme.of(context).textTheme.titleSmall!.copyWith(
  //                   color: Colors.black,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //             sizedBox,
  //             buildFormField('Enter your child\'s name', cardEditingController,
  //                 TextInputType.text, '', [], FocusNode()),
  //             sizedBox15,
  //             buildFormField(
  //                 'Enter your child\'s code number',
  //                 cardEditingController,
  //                 TextInputType.text,
  //                 '',
  //                 [],
  //                 FocusNode()),
  //             sizedBox15,
  //             DefaultButton2(
  //               color1: kamber300Color,
  //               color2: kyellowColor,
  //               onPress: () {
  //                 setState(() {
  //                   isAddAccount = !isAddAccount!;
  //                 });

  //                 final amountText = amountEditingController.text;
  //               },
  //               title: 'PAY',
  //               iconData: Icons.arrow_forward_outlined,
  //             ),
  //             const SizedBox(
  //               height: 200,
  //             )
  //           ],
  //         ),
  //       ));
  // }

  void _confirmationRoute(
      {required double amount,
      required double price,
      required double balance}) {
    final transactionMoneyController = Get.find<TransactionMoneyController>();
    final studentController = Get.find<StudentController>();
    if (widget.transactionType == TransactionType.addMoney) {
      Get.find<AddMoneyController>().addMoney(amount);
    } else if (widget.transactionType == TransactionType.withdrawRequest) {
      String? message;
      WithdrawalMethod? withdrawMethod = transactionMoneyController
          .withdrawModel!.withdrawalMethods
          .firstWhereOrNull(
              (method) => _selectedMethodId == method.id.toString());

      List<MethodField> list = [];
      String? validationKey;

      if (withdrawMethod != null) {
        for (var method in withdrawMethod.methodFields) {
          if (method.inputType == 'email') {
            validationKey = method.inputName;
          }
          if (method.inputType == 'date') {
            validationKey = method.inputName;
          }
        }
      } else {
        message = 'please_select_a_method'.tr;
      }

      _textControllers.forEach((key, textController) {
        list.add(MethodField(
          inputName: key,
          inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if ((validationKey == key) &&
            EmailCheckerHelper.isNotValid(textController.text)) {
          message = 'please_provide_valid_email'.tr;
        } else if ((validationKey == key) &&
            textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }

        if (textController.text.isEmpty && message == null) {
          message = 'please fill ${key!.replaceAll('_', ' ')} field';
        }
      });

      _gridTextController.forEach((key, textController) {
        list.add(MethodField(
          inputName: key,
          inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if ((validationKey == key) && textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }
      });

      if (message != null) {
        //  showCustomSnackBarHelper(message);
        message = null;
      } else {
        Get.to(() => TransactionConfirmationScreen(
              inputBalance: amount,
              availableBalance: balance.toStringAsFixed(2),
              productId: widget.productId!,
              transactionType: TransactionType.withdrawRequest,
              contactModel: null,
              withdrawMethod: WithdrawalMethod(
                  methodFields: list,
                  methodName: withdrawMethod!.methodName,
                  id: withdrawMethod.id),
              callBack: setFocus,
              dataList: widget.productList[selectedIndex].eduboxMaterials,
              productIndex: materialIndex,
              contactModelMtn: widget.contactModelMtn,
              studentInfo: studentController.studentList,
              edubox_service: widget.productValue,
            
              serviceIndex: widget.productIndex,
             
              price: price,
            ));
      }
    } else {
      Get.to(() => TransactionConfirmationScreen(
            inputBalance: amount,
            availableBalance: balance.toStringAsFixed(2),
            productId: widget.productId!,
            transactionType: TransactionType.sendMoney,
            purpose: widget.transactionType == TransactionType.sendMoney
                ? transactionMoneyController.purposeList != null &&
                        transactionMoneyController.purposeList!.isNotEmpty
                    ? transactionMoneyController
                        .purposeList![transactionMoneyController.selectedItem]
                        .title
                    : PurposeModel().title
                : TransactionType.requestMoney.tr,
            contactModel: widget.contactModel,
            contactModelMtn: widget.contactModelMtn,
            callBack: setFocus,
            dataList: widget.productList[selectedIndex].eduboxMaterials,
            productIndex: materialIndex,
            studentInfo: studentController.studentList,
            edubox_service: widget.productValue,
            serviceIndex: widget.productIndex,
            serviceValue: widget.productValue,
            studentIndex: widget.studentIndex,
            price: price,
          ));
    }
  }

  void _creditConfirmationRoute(
      {required double amount,
      required double price,
      required double balance}) {
    final transactionMoneyController = Get.find<TransactionMoneyController>();
    final studentController = Get.find<StudentController>();
    if (widget.transactionType == TransactionType.addMoney) {
      Get.find<AddMoneyController>().addMoney(amount);
    } else if (widget.transactionType == TransactionType.withdrawRequest) {
      String? message;
      WithdrawalMethod? withdrawMethod = transactionMoneyController
          .withdrawModel!.withdrawalMethods
          .firstWhereOrNull(
              (method) => _selectedMethodId == method.id.toString());

      List<MethodField> list = [];
      String? validationKey;

      if (withdrawMethod != null) {
        for (var method in withdrawMethod.methodFields) {
          if (method.inputType == 'email') {
            validationKey = method.inputName;
          }
          if (method.inputType == 'date') {
            validationKey = method.inputName;
          }
        }
      } else {
        message = 'please_select_a_method'.tr;
      }

      _textControllers.forEach((key, textController) {
        list.add(MethodField(
          inputName: key,
          inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if ((validationKey == key) &&
            EmailCheckerHelper.isNotValid(textController.text)) {
          message = 'please_provide_valid_email'.tr;
        } else if ((validationKey == key) &&
            textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }

        if (textController.text.isEmpty && message == null) {
          message = 'please fill ${key!.replaceAll('_', ' ')} field';
        }
      });

      _gridTextController.forEach((key, textController) {
        list.add(MethodField(
          inputName: key,
          inputType: null,
          inputValue: textController.text,
          placeHolder: null,
        ));

        if ((validationKey == key) && textController.text.contains('-')) {
          message = 'please_provide_valid_date'.tr;
        }
      });

      if (message != null) {
        //  showCustomSnackBarHelper(message);
        message = null;
      } else {
        Get.to(() => CreditTransactionConfirmationScreen(
            // className: studentController
            //     .studentList![widget.studentIndex].studentClass!,
            // schoolName:
            //     studentController.studentList![widget.studentIndex].school!,
            // studentCode:
            //     studentController.studentList![widget.studentIndex].code!,
            // studentName:
            //     studentController.studentList![widget.studentIndex].name!,
            inputBalance: amount,
            productId: widget.productId!,
            transactionType: TransactionType.withdrawRequest,
            contactModel: null,
            withdrawMethod: WithdrawalMethod(
                methodFields: list,
                methodName: withdrawMethod!.methodName,
                id: withdrawMethod.id),
            callBack: setFocus,
            dataList: widget.productList[selectedIndex].eduboxMaterials,
            productIndex: materialIndex,
            contactModelMtn: widget.contactModelMtn,
            studentInfo: studentController.studentList,
            edubox_service: widget.productValue,
            serviceValue: widget.productValue,
            serviceIndex: widget.productIndex,
            studentIndex: widget.studentIndex,
            price: price,
            parent: widget.parent!
            ));
      }
    } else {
      Get.to(() => CreditTransactionConfirmationScreen(
            // className: studentController
            //     .studentList![widget.studentIndex].studentClass!,
            // schoolName:
            //     studentController.studentList![widget.studentIndex].school!,
            // studentCode:
            //     studentController.studentList![widget.studentIndex].code!,
            // studentName:
            //     studentController.studentList![widget.studentIndex].name!,
            inputBalance: amount,
            availableBalance: balance.toStringAsFixed(2),
            productId: widget.productId!,
            transactionType: TransactionType.sendMoney,
            purpose: widget.transactionType == TransactionType.sendMoney
                ? transactionMoneyController.purposeList != null &&
                        transactionMoneyController.purposeList!.isNotEmpty
                    ? transactionMoneyController
                        .purposeList![transactionMoneyController.selectedItem]
                        .title
                    : PurposeModel().title
                : TransactionType.requestMoney.tr,
            contactModel: widget.contactModel,
            contactModelMtn: widget.contactModelMtn,
            callBack: setFocus,
            dataList: widget.productList[selectedIndex].eduboxMaterials,
            productIndex: materialIndex,
            studentInfo: studentController.studentList,
            edubox_service: widget.productValue,
            serviceIndex: widget.productIndex,
            serviceValue: widget.productValue,
            studentIndex: widget.studentIndex,
            price: price,
          ));
    }
  }

  void showInfoDialog(
      {required BuildContext context,
      required int index,
      required int indexM}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(widget.productIndex == 6
              ? "Partner Services"
              : widget.productIndex == 0
                  ? "Edubox Birashoboka"
                  : widget.productIndex == 2
                      ? "Edubox Shoebox"
                      : "Edubox Uniform"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              widget.productList.isNotEmpty &&
                      widget.productList[index].eduboxMaterials!.isNotEmpty
                  ? Text(
                      widget.productIndex == 6
                          ? "Partner Services Details:\n${widget.productList[index].eduboxMaterials![indexM].description ?? 'No Info Available'}"
                          : widget.productIndex == 0
                              ? "Product Details:\n${widget.productList[index].eduboxMaterials![indexM].description ?? 'No Info Available'}"
                              : widget.productIndex == 2
                                  ? "Edubox Shoebox Details:\n${widget.productList[index].eduboxMaterials![indexM].description ?? 'No Info Available'}"
                                  : "Edubox Uniform Details:\n${widget.productList[index].eduboxMaterials![indexM].description ?? 'No Info Available'}",
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      'No Info Available',
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
