import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/common/widgets/custom_pin_code_field_widget.dart';
import 'package:hosomobile/common/widgets/demo_otp_hint_widget.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/map/screens/map_screen.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/shop/widget/product.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sp.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_person_widget.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';

class ShopTransactionConfirmationScreen extends StatefulWidget {
  final Map<Product, int> cart;
  final Function(Product) onReduceQuantity;
  final Function(Product) onRemoveProduct;
  final Function(Product) onIncreaseQuantity;
  final String transactionType;
  final ContactModel contactModel;
  final ContactModelMtn contactModelMtn;
  final String homePhone;
  final String destination;
  final String shipper;
  double totalAmount;
  Product product;
  int quantity;

  ShopTransactionConfirmationScreen({
    super.key,
    required this.totalAmount,
    required this.homePhone,
    required this.destination,
    required this.shipper,
    required this.onIncreaseQuantity,
    required this.transactionType,
    required this.contactModel,
    required this.contactModelMtn,
    required this.cart,
    required this.product,
    required this.quantity,
    required this.onReduceQuantity,
    required this.onRemoveProduct,
  });

  @override
  State<ShopTransactionConfirmationScreen> createState() =>
      _TransactionConfirmationScreenState();
}

class _TransactionConfirmationScreenState
    extends State<ShopTransactionConfirmationScreen> {
  final _pinCodeFieldController = TextEditingController(text: "1234");
  final TransactionMoneyController transactionMoneyController =
      Get.find<TransactionMoneyController>();
  final MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  final double vatPercentage = 18.0; // Example VAT percentage
  final double serviceChargePercentage =
      4.0; // Example service charge percentage
  Random random = Random();

  // List to store indices of selected students
  List<int> selectedStudents = [];
  double deliveryCost = 3000.0;

  bool isHomeDelivery = false;
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
  TextEditingController destinationEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  String deliveryOptionsValue = 'Choose Delivery Company';
  String? _deliveryOptionError;

  List<Map<dynamic, String>> topSize = const [
    {'name': 'Dropp', 'logo': 'assets/icons1/dropp.jpeg'},
    {'name': 'i-Posita', 'logo': 'assets/icons1/iposita.jpeg'},
    {'name': 'Vuba Vuba', 'logo': 'assets/icons1/vuba.png'},
    {'name': 'Zugu', 'logo': 'assets/icons1/zugu.jpeg'},
  ];

  homeDeliveryAction() {
    // Check if no students are selected
    if (selectedStudents.isEmpty) {
      // Show an alert or snackbar to inform the user
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('No Student Selected!'),
            content: const Text(
                'But, you can proceed to place your own order.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

 setState(() {
      isHomeDelivery = !isHomeDelivery;
    });

      return; // Exit the function early
    }
   
  }

  double deliveryCostWithMAterialCost() {
    return widget.totalAmount + deliveryCost;
  }

  void _validateForm() {
    if (deliveryOptionsValue == 'Choose Delivery Company') {
      setState(() {
        _deliveryOptionError = 'Please select a delivery option';
      });
      // Optionally show a snackbar for more visibility
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a delivery option'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Get.to(
      () => ShopTransactionConfirmationScreen(
        shipper: deliveryOptionsValue,
        homePhone: phoneNumberEditingController.text,
        destination: destinationEditingController.text,
        totalAmount: widget.totalAmount,
        onIncreaseQuantity: widget.onIncreaseQuantity,
        transactionType: widget.transactionType,
        contactModel: widget.contactModel,
        contactModelMtn: widget.contactModelMtn,
        cart: widget.cart,
        product: widget.product,
        quantity: widget.quantity,
        onReduceQuantity: widget.onReduceQuantity,
        onRemoveProduct: widget.onRemoveProduct,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int productIndex = 0;
    int studentIndex = 0;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final String totalAmount =
        calculateTotal(double.parse('${widget.totalAmount}'))
            .toStringAsFixed(2);
    String phoneNumber = widget.contactModel.phoneNumber!.replaceAll('+', '');
    int randomNumber = random.nextInt(90000000) + 10000000;

    return Scaffold(
      body: GetBuilder<StudentController>(builder: (studentController) {
        // Proceed with the transaction if students are selected
        final configModel = Get.find<SplashController>().configModel;
        List<StudentModel> checkedStudents = selectedStudents
            .map((index) => studentController.studentList![index])
            .toList();

        if (studentController.studentList == null ||
            studentController.studentList!.isEmpty) {
          return Center(
            child: Column(
              children: [
                Text(
                  'No Student Available!, Please Add Your Student to Continue',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                sizedBox10,
                TextButton(
                  onPressed: () => const MzaziScreen(isShop: true),
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CustomBackButton(),
              if (widget.transactionType != TransactionType.withdrawRequest)
                ForPersonWidget(contactModel: widget.contactModel),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice No:$randomNumber',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  sizedBox15,
                  SizedBox(
                    height: screenHeight / 6,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: studentController.studentList!.length,
                        itemBuilder: (context, studentIndex) {
                          return ForStudentWidget(
                            studentInfo:
                                'Code: ${studentController.studentList![studentIndex].code}\nName: ${studentController.studentList![studentIndex].name}\nSchool:${studentController.studentList![studentIndex].school}. Class: ${studentController.studentList![studentIndex].studentClass}',
                            onChecked: (isChecked) {
                              // Update the selectedStudents list
                              setState(() {
                                if (isChecked) {
                                  selectedStudents
                                      .add(studentIndex); // Add to list
                                } else {
                                  selectedStudents
                                      .remove(studentIndex); // Remove from list
                                }
                              });
                            },
                            initialChecked:
                                selectedStudents.contains(studentIndex),
                          );
                        },
                      ),
                    ),
                  ),
                  sizedBox05h,
                  Container(
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
  height: MediaQuery.of(context).size.height / 3, // Increased height to accommodate new layout
  child: ListView.builder(
    itemCount: widget.cart.length,
    itemBuilder: (context, productIndex) {
      final product = widget.cart.keys.elementAt(productIndex);
      final quantity = widget.cart[product]!;
      final totalPrice = product.price * quantity;
      
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section - Product info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product.image,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'RWF ${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quantity: $quantity',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total: RWF ${totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Bottom section - Action buttons aligned to right
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Reduce Quantity Button
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          widget.onReduceQuantity(product);
                          widget.totalAmount -= product.price;
                        });
                      },
                    ),
                    // Quantity display
                    Text(
                      quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // Increase Quantity Button
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          widget.onIncreaseQuantity(product);
                          widget.totalAmount += product.price;
                        });
                      },
                    ),
                    // Remove Product Button
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.onRemoveProduct(product);
                          widget.totalAmount -= totalPrice;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
                    ),
                  ),
                  sizedBox10,
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
                        onPress: () {
                          print(
                              'this is selected student:::::::::: $selectedStudents | $studentIndex');
                          // Check if no students are selected
                          if (selectedStudents.isEmpty) {
                            // Show an alert or snackbar to inform the user
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('No Student Selected'),
                                  content: const Text(
                                      'Please select at least one student before proceeding.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return; // Exit the function early
                          }

                          // Proceed with the transaction if students are selected
                          final configModel =
                              Get.find<SplashController>().configModel;
                          List<StudentModel> checkedStudents = selectedStudents
                              .map((index) =>
                                  studentController.studentList![index])
                              .toList();
                          print(
                              'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx$checkedStudents');

                          Get.find<TransactionMoneyController>()
                              .pinVerify(
                            pin: _pinCodeFieldController.text,
                          )
                              .then((isCorrect) {
                            if (isCorrect) {
                              if (configModel!.twoFactor! &&
                                  Get.find<ProfileController>()
                                      .userInfo!
                                      .twoFactor!) {
                                Get.find<AuthController>()
                                    .checkOtp()
                                    .then((value) => value.isOk
                                        ? Get.defaultDialog(
                                            barrierDismissible: false,
                                            title: 'otp_verification'.tr,
                                            content: Column(
                                              children: [
                                                CustomPinCodeFieldWidget(
                                                  onCompleted: (pin) =>
                                                      Get.find<AuthController>()
                                                          .verifyOtp(pin)
                                                          .then((value) {
                                                    if (value.isOk) {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        context: Get.context!,
                                                        isDismissible: false,
                                                        enableDrag: false,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius.circular(
                                                                      Dimensions
                                                                          .radiusSizeLarge)),
                                                        ),
                                                        builder: (context) =>
                                                            BottomSheetWithSliderSp(
                                                          materialCost: widget
                                                              .totalAmount
                                                              .toStringAsFixed(
                                                                  2),
                                                          deliveryCost:
                                                              deliveryCost,
                                                          shipper:
                                                              widget.shipper,
                                                          homePhone:
                                                              widget.homePhone,
                                                          destination: widget
                                                              .destination,
                                                          studentId:
                                                              checkedStudents[0]
                                                                  .id!,
                                                          randomNumber:
                                                              randomNumber,
                                                          selectedProducts:
                                                              widget.cart,
                                                          quantity:
                                                              widget.quantity,
                                                          productIndex:
                                                              productIndex,
                                                          amount: '0',
                                                          availableBalance:
                                                              '0.00',
                                                          contactModel: widget
                                                              .contactModel,
                                                          contactModelMtn: widget
                                                              .contactModelMtn,
                                                          pinCode: Get.find<
                                                                  BottomSliderController>()
                                                              .pin,
                                                          transactionType: widget
                                                              .transactionType,
                                                          purpose: widget
                                                              .transactionType,
                                                          inputBalance: 0.0,
                                                          product:
                                                              widget.product,
                                                          amountToPay:
                                                              'Amount to be Paid: ${calculateTotalWithService(double.parse('${widget.totalAmount}')).toStringAsFixed(2)} RWF',
                                                          nowPaid:
                                                              'Now Paid: ${widget.totalAmount.toStringAsFixed(2)} RWF',
                                                          vat:
                                                              'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateVAT(double.parse('${widget.totalAmount}')).toStringAsFixed(2)} RWF',
                                                          serviceCharge:
                                                              calculateServiceCharge(double.parse('${widget.totalAmount}')).toStringAsFixed(2),
                                                          totalNowPaid:
                                                              'Total Amount paid now: $totalAmount RWF',
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                ),
                                                const DemoOtpHintWidget(),
                                                GetBuilder<AuthController>(
                                                  builder: (verifyController) =>
                                                      verifyController
                                                              .isVerifying
                                                          ? CircularProgressIndicator(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleLarge!
                                                                  .color,
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                )
                                              ],
                                            ),
                                          )
                                        : null);
                              } else {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: Get.context!,
                                    isDismissible: true,
                                    enableDrag: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          Dimensions.radiusSizeLarge),
                                    )),
                                    builder: (context) {
                                      return BottomSheetWithSliderSp(
                                        deliveryCost: deliveryCost,
                                        shipper: widget.shipper,
                                        homePhone: widget.homePhone,
                                        destination: widget.destination,
                                        studentId: checkedStudents[0].id!,
                                        randomNumber: randomNumber,
                                        selectedProducts: widget.cart,
                                        quantity: widget.quantity,
                                        studentIndex: studentIndex,
                                        availableBalance: '0.00',
                                        amount: totalAmount.toString(),
                                        materialCost: widget.totalAmount
                                            .toStringAsFixed(2),
                                        productId: 1,
                                        contactModel: widget.contactModel,
                                        pinCode: _pinCodeFieldController.text,
                                        transactionType: widget.transactionType,
                                        purpose: widget.transactionType,
                                        studentInfo: checkedStudents,
                                        inputBalance: widget.totalAmount,
                                        product: widget.product,
                                        productIndex: productIndex,
                                        edubox_service: 'Shop',
                                        amountToPay:
                                            'Delivery Cost: ${deliveryCost.toStringAsFixed(2)}',
                                        nowPaid:
                                            'Material Cost: ${widget.totalAmount.toStringAsFixed(2)}',
                                        vat:
                                            'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateVAT(double.parse('${widget.totalAmount}')).toStringAsFixed(2)} RWF',
                                        serviceCharge:calculateServiceCharge(double.parse('${widget.totalAmount}')).toStringAsFixed(2),
                                        totalNowPaid:
                                            'Total Amount paid now: $totalAmount RWF',
                                        serviceValue: widget.product.name,
                                      );
                                    });
                              }
                            }
                          });
                        },
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
                              deliveryCost: deliveryCost,
                              isShop: 1,
                              product: widget.product,
                              cart: widget.cart,
                              checkedStudents: checkedStudents,
                              checkedStudentsId:selectedStudents.isEmpty?0: checkedStudents[0].id,
                              quantity: widget.quantity,
                              studentIndex: studentIndex,
                              schoolId: 0,
                              classId: studentController
                                  .studentList![studentIndex].classId!,
                              className: studentController
                                  .studentList![studentIndex].studentClass!,
                              schoolName: studentController
                                  .studentList![studentIndex].school??'Unkown School',
                              studentCode: studentController
                                  .studentList![studentIndex].code!,
                              studentId: studentController
                                  .studentList![studentIndex].id!,
                              studentName: studentController
                                  .studentList![studentIndex].name!,
                              screenId: 0,
                              calculatedTotal: widget.totalAmount,
                              contactModel: widget.contactModel!,
                              eduboxService: widget.product.name,
                              dataList: [],
                              shipper: widget.shipper,
                              destination: widget.destination,
                              homePhone: widget.homePhone,
                              productId: 0,
                              pinCodeFieldController:
                                  _pinCodeFieldController.text,
                              transactionType: widget.transactionType ?? '',
                              calculatedTotalWithServices:
                                  calculateTotalWithService(
                                      double.parse('${widget.totalAmount}')),
                              productIndex: 0,
                              purpose: '',
                              calculateServiceCharge: calculateServiceCharge(
                                  double.parse('${widget.totalAmount}')),
                              calculateVAT: calculateVAT(
                                  double.parse('${widget.totalAmount}')),
                              productName: widget.product.name,
                              randomNumber: randomNumber,
                              serviceIndex: 0,
                              totalAmount: double.parse(totalAmount),
                              vatPercentage: vatPercentage),

                      Text(
                        'Delivery Cost: ${deliveryCost.toStringAsFixed(2)} RWF',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                      // Display Total Price

                      Text('Material Cost: ${widget.totalAmount} RWF'),
                      // Text('Now Paying: ${calculatedTotal.toStringAsFixed(2)} RWF'),
                      Text(
                          'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateVAT(double.parse('${widget.totalAmount}')).toStringAsFixed(2)} RWF'),

                      Text(
                          'Convinience Fee (${serviceChargePercentage.toStringAsFixed(1)}%): ${calculateServiceCharge(double.parse('${widget.totalAmount}')).toStringAsFixed(2)} RWF'),
                      const Divider(),

                      Text(
                        'Total Amount paid now: $totalAmount RWF',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      if (widget.transactionType !=
                          TransactionType.withdrawRequest)
                        Container(
                          height: Dimensions.dividerSizeMedium,
                          color: Theme.of(context).dividerColor,
                        ),
                      if (widget.transactionType ==
                          TransactionType.withdrawRequest)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeSmall,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Column(children: [
                              // _MethodFieldWidget(
                              //   type: 'withdraw_method'.tr,
                              //   value: widget.withdrawMethod!.methodName!,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                        ),
                      sizedBox
                    ],
                  ),
                ],
              ),
            ]),
          ));
        }
      }),
    );
  }

  double calculateVAT(double amount) {
    return (amount * vatPercentage) / 100;
  }

  double calculateServiceCharge(double amount) {
    return (amount * serviceChargePercentage) / 100;
  }

  double calculateTotalWithService(double amount) {
    return amount + calculateServiceCharge(amount);
  }

  double calculateTotal(double amount) {
    return amount +
        calculateServiceCharge(amount) +
        deliveryCost +
        calculateVAT(amount);
  }

  TextFormField buildFormField(
      String labelText,
      TextEditingController editingController,
      TextInputType textInputType,
      hintText) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      keyboardType: textInputType,
      style: kInputTextStyle,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13, horizontal: 15), // Customize as needed
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kamber300Color),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kTextLightColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF000000)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
