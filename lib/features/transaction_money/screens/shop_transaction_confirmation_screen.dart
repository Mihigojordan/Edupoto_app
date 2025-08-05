import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/common/widgets/custom_pin_code_field_widget.dart';
import 'package:hosomobile/common/widgets/demo_otp_hint_widget.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_school_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/student_data.dart';
import 'package:hosomobile/features/map/screens/autocompletes_map_screen.dart';
import 'package:hosomobile/features/map/screens/delivery_map_screen.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/widgets/bottom_sheet_with_slider_sp.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_person_widget.dart';
import 'package:hosomobile/features/transaction_money/widgets/for_student_widget.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
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

  Random random = Random();

  // List to store indices of selected students
  List<int> selectedStudents = [];
  double deliveryCost = 3000.0;

  bool isHomeDelivery = false;
  bool isSchoolDelivery = false;
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
  TextEditingController destinationEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  String deliveryOptionsValue = 'choose_delivery_company'.tr;
  String? _deliveryOptionError;

  List<Map<dynamic, String>> topSize = const [
    {'name': 'Dropp', 'logo': 'assets/icons1/dropp.jpeg'},
    {'name': 'i-Posita', 'logo': 'assets/icons1/iposita.jpeg'},
    {'name': 'Vuba Vuba', 'logo': 'assets/icons1/vuba.png'},
    {'name': 'Zugu', 'logo': 'assets/icons1/zugu.jpeg'},
  ];

  homeDeliveryAction() {
    // Check if no students are selected
    // if (selectedStudents.isEmpty) {
    //   // Show an alert or snackbar to inform the user
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: const Text('No Student Selected!'),
    //         content: const Text(
    //             'But, you can proceed to place your own order.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context); // Close the dialog
    //             },
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );

    //   return; // Exit the function early
    // }
    setState(() {
      isHomeDelivery = !isHomeDelivery;
    });
  }

  schoolDeliveryAction() {
    setState(() {
      isSchoolDelivery = !isSchoolDelivery;
    });
  }

  double deliveryCostWithMAterialCost() {
    return widget.totalAmount + deliveryCost;
  }

  void _validateForm() {
    if (deliveryOptionsValue == 'choose_delivery_company'.tr) {
      setState(() {
        _deliveryOptionError = 'please_select_delivery_option'.tr;
      });
      // Optionally show a snackbar for more visibility
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('please_select_delivery_option'.tr),
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
    final bottomSliderController = Get.find<BottomSliderController>();
    final totalAmount =
        AppConstants.calculateTotal(double.parse('${widget.totalAmount}'))
            .toStringAsFixed(2);
    final double convenienceFee = AppConstants.calculateConvenienceFee(
        double.parse('${widget.totalAmount}'));
    // final vat =
    //     AppConstants.calculateVAT(double.parse('${widget.totalAmount}'));
    final availableBalance = AppConstants.availableBalance(
            amount: double.parse('${widget.totalAmount}'),
            balance: double.parse('${widget.totalAmount}'))
        .toStringAsFixed(2);
    int randomNumber = random.nextInt(90000000) + 10000000;

    return Scaffold(
      body: GetBuilder<StudentController>(builder: (studentController) {
        // Proceed with the transaction if students are selected
        final configModel = Get.find<SplashController>().configModel;
        List<StudentModel> checkedStudents = selectedStudents
            .map((index) => studentController.studentList![index])
            .toList();

        // if (studentController.studentList == null ||
        //     studentController.studentList!.isEmpty) {
        //   return Center(
        //     child: Column(
        //       children: [
        //         Text(
        //           '${'no_student_available'.tr}!, ${'please_add_student_to_continue'}',
        //           style: Theme.of(context).textTheme.titleLarge,
        //         ),
        //         sizedBox10,
        //         TextButton(
        //           onPressed: () => const MzaziScreen(isShop: true),
        //           child: Text(
        //             'add'.tr,
        //             style: Theme.of(context).textTheme.titleMedium,
        //           ),
        //         )
        //       ],
        //     ),
        //   );
        // } else {
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
                  '${'invoice_no'.tr}: $randomNumber',
                  style: Theme.of(context).textTheme.titleLarge,
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
                      height: MediaQuery.of(context).size.height /
                          3, // Increased height to accommodate new layout
                      child: ListView.builder(
                        itemCount: widget.cart.length,
                        itemBuilder: (context, productIndex) {
                          final product =
                              widget.cart.keys.elementAt(productIndex);
                          final quantity = widget.cart[product]!;
                          final totalPrice =
                              double.parse(product.regularPrice ?? '0') *
                                  quantity;

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top section - Product info
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CustomImageWidget(
                                            height: 40,
                                            width: 40,
                                            image: product.images?[0].src ??
                                                'no image',
                                            fit: BoxFit.cover,
                                            placeholder:
                                                Images.bannerPlaceHolder),
                                      ),
                                      const SizedBox(width: 12),
                                      // Product details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${AppConstants.currency} ${product.regularPrice}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${'quantity'.tr}: $quantity',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${'total'.tr}: ${AppConstants.currency} ${totalPrice.toStringAsFixed(2)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
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
                                              widget.totalAmount -=
                                                  double.parse(
                                                      product.regularPrice ??
                                                          '0');
                                            });
                                          },
                                        ),
                                        // Quantity display
                                        Text(
                                          quantity.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        // Increase Quantity Button
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .onIncreaseQuantity(product);
                                              widget.totalAmount +=
                                                  double.parse(
                                                      product.regularPrice ??
                                                          '0');
                                            });
                                          },
                                        ),
                                        // Remove Product Button
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
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
                      'delivery_options'.tr,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    sizedBox15,
                    isSchoolDelivery == false
                        ? DefaultButton2(
                            color1: kamber300Color,
                            color2: kyellowColor,
                            onPress: () => schoolDeliveryAction(),
                            title: 'school_cap'.tr,
                            iconData: Icons.arrow_forward_outlined,
                          )
                        : (studentController.studentList == null ||
                                studentController.studentList!.isEmpty)
                            ?
                            // ************************DISPLAY FIELD FOR ENTERING STUDENT FOR ACCOMPLISH PAYMENT****************
                            DependentSchoolDropdowns(
                              onInputStudent: ({required className, required schoolName, required studentCode, required studentName, required schoolId}) => _captureInformation(
                                                context,
                                                studentIndex:0, // Use first selected student
                                                productIndex: productIndex,
                                                schoolName: schoolName,
                                                randomNumber: randomNumber,
                                                className: className,
                                                totalAmount: totalAmount,
                                                orderId: '21323443421',
                                                vat:0,
                                                convenienceFee: convenienceFee,
                                                studentCode: studentCode,
                                                studentName: studentName,
                                                pinCode: _pinCodeFieldController.text,
                                                homePhone: phoneNumberEditingController.text,
                                                customerNote: descriptionEditingController.text,
                                                
                                              ),
                                isShop: true,
                                isNotRegStudent: true,
                                parentId: randomNumber.toString(),
                                studentController: studentController,
                                isAddAccount: false,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'select_your_student_who_is_going_to_receive_the_product_at_school'
                                          .tr),
                                  sizedBox05h,
                                  SizedBox(
                                    height: screenHeight / 6,
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        itemCount: studentController
                                            .studentList!.length,
                                        itemBuilder: (context, studentIndex) {
                                          return ForStudentWidget(
                                            studentInfo:
                                                '${'code'.tr}: ${studentController.studentList![studentIndex].code}\n${'name'.tr}: ${studentController.studentList![studentIndex].name}\n${'school'.tr}:${studentController.studentList![studentIndex].school}. ${'class'.tr}: ${studentController.studentList![studentIndex].studentClass}',
                                            onChecked: (isChecked) {
                                              // Update the selectedStudents list
                                              setState(() {
                                                if (isChecked) {
                                                  selectedStudents.add(
                                                      studentIndex); // Add to list
                                                } else {
                                                  selectedStudents.remove(
                                                      studentIndex); // Remove from list
                                                }
                                              });
                                            },
                                            initialChecked: selectedStudents
                                                .contains(studentIndex),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  sizedBox05h,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      DefaultButtonWidth(
                                          onPress: (){
                                                       if (selectedStudents.isEmpty) {
      // Show error if no students selected
           ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            content: Text('please_select_at_least_one_student_to_proceed'.tr),
            backgroundColor: Colors.red,
          ),
        );
    } else{

_captureInformation(
                                                context,
                                                studentIndex: selectedStudents
                                                    .first, // Use first selected student
                                                studentController:
                                                    studentController,
                                                productIndex: productIndex,
                                                schoolName: studentController
                                                    .studentList![
                                                        selectedStudents.first]
                                                    .school!,
                                                randomNumber: randomNumber,
                                                className: studentController
                                                    .studentList![
                                                        selectedStudents.first]
                                                    .studentClass!,
                                                    studentCode: studentController
                                                    .studentList![
                                                        selectedStudents.first]
                                                    .code,
                                                studentName: studentController
                                                    .studentList![
                                                        selectedStudents.first]
                                                    .name,
                                                totalAmount: totalAmount,
                                                orderId: '21323443421',
                                                vat: 0,
                                                convenienceFee: convenienceFee,
                                       pinCode: _pinCodeFieldController.text,
                                       homePhone: phoneNumberEditingController.text,
                                       customerNote: descriptionEditingController.text
                                              );
    }
                                          } ,
                                          title: 'next'.tr,
                                          color1: kamber300Color,
                                          color2: kyellowColor,
                                          width: 123)
                                    ],
                                  )
                                ],
                              ),

                    sizedBox15,

                    isSchoolDelivery == true
                        ? const SizedBox.shrink()
                        : isHomeDelivery == false
                            ? DefaultButton2(
                                color1: kamber300Color,
                                color2: kyellowColor,
                                onPress: () => homeDeliveryAction(),
                                // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                                title: 'home_cap'.tr,
                                iconData: Icons.arrow_forward_outlined,
                              )
                            : (studentController.studentList == null ||
                                    studentController.studentList!.isEmpty)
                                ? DeliveryMapScreen(
                                    deliveryCost: deliveryCost,
                                    isShop: 1,
                                    product: widget.product,
                                    cart: widget.cart,
                                    checkedStudents: checkedStudents,
                                    checkedStudentsId: selectedStudents.isEmpty
                                        ? 0
                                        : checkedStudents[0].id,
                                    quantity: widget.quantity,
                                    studentIndex: studentIndex,
                                    schoolId: 0,
                                    classId: 0,
                                    className: 'unkown_class'.tr,
                                    schoolName: 'unknown_school'.tr,
                                    studentCode: randomNumber.toString(),
                                    studentId: 0,
                                    studentName: 'unkown_name'.tr,
                                    screenId: 0,
                                    calculatedTotal: widget.totalAmount,
                                    contactModel: widget.contactModel!,
                                    eduboxService: widget.product.name!,
                                    dataList: [],
                                    shipper: widget.shipper,
                                    homePhone: phoneNumberEditingController.text,
                                    productId: 0,
                                    pinCodeFieldController:
                                        _pinCodeFieldController.text,
                                    transactionType:
                                        widget.transactionType ?? '',
                                    calculatedTotalWithServices:
                                        double.parse(totalAmount),
                                    productIndex: 0,
                                    purpose: '',
                                    calculateServiceCharge: convenienceFee,
                                    calculateVAT: 0,
                                    productName: widget.product.name!,
                                    randomNumber: randomNumber,
                                    serviceIndex: 0,
                                    totalAmount: double.parse(totalAmount),
                                    vatPercentage: AppConstants.vatPercentage,
                                    descriptionController: descriptionEditingController,
                                    destinationController: destinationEditingController,
                                    phoneNumberEditingController: phoneNumberEditingController,

                                    )
                                : DeliveryMapScreen(
                                  phoneNumberEditingController: phoneNumberEditingController,
                                  descriptionController: descriptionEditingController,
                                  destinationController:destinationEditingController,
                                    deliveryCost: deliveryCost,
                                    isShop: 1,
                                    product: widget.product,
                                    cart: widget.cart,
                                    checkedStudents: checkedStudents,
                                    checkedStudentsId: selectedStudents.isEmpty
                                        ? 0
                                        : checkedStudents[0].id,
                                    quantity: widget.quantity,
                                    studentIndex: studentIndex,
                                    schoolId: 0,
                                    classId: studentController
                                            .studentList![studentIndex]
                                            .classId ??
                                        0,
                                    className: studentController
                                            .studentList![studentIndex]
                                            .studentClass ??
                                        'unkown_class'.tr,
                                    schoolName: studentController
                                            .studentList![studentIndex]
                                            .school ??
                                        'unknown_school'.tr,
                                    studentCode: studentController
                                            .studentList![studentIndex].code ??
                                        randomNumber.toString(),
                                    studentId:
                                        studentController.studentList![studentIndex].id ?? 0,
                                    studentName: studentController.studentList![studentIndex].name ?? 'unkown_name'.tr,
                                    screenId: 0,
                                    calculatedTotal: widget.totalAmount,
                                    contactModel: widget.contactModel!,
                                    eduboxService: widget.product.name!,
                                    dataList: [],
                                    shipper: widget.shipper,
                                    homePhone: phoneNumberEditingController.text,
                                    productId: 0,
                                    pinCodeFieldController: _pinCodeFieldController.text,
                                    transactionType: widget.transactionType ?? '',
                                    calculatedTotalWithServices: double.parse(totalAmount),
                                    productIndex: 0,
                                    purpose: '',
                                    calculateServiceCharge: convenienceFee,
                                    calculateVAT: 0,
                                    productName: widget.product.name!,
                                    randomNumber: randomNumber,
                                    serviceIndex: 0,
                                    totalAmount: double.parse(totalAmount),
                                    vatPercentage: AppConstants.vatPercentage),

                    Text(
                      '${'delivery_cost'.tr}: ${deliveryCost.toStringAsFixed(2)} ${AppConstants.currency}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    // Display Total Price

                    Text(
                        '${'material_cost'.tr}: ${widget.totalAmount} ${AppConstants.currency}'),
                    // Text('Now Paying: ${calculatedTotal.toStringAsFixed(2)} ${AppConstants.currency}'),
                    Text('${'vat'.tr}: ${'inclusive'.tr}'),

                    Text(
                        '${'convenience_fee'.tr}: $convenienceFee ${AppConstants.currency}'),
                    const Divider(),

                    Text(
                      '${'total_amount_paid_now'.tr}: $totalAmount ${AppConstants.currency}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
        // }
      }),
    );
  }

void _captureInformation(
  BuildContext context, {
  required int randomNumber,
  required String totalAmount,
  required String schoolName,
  required String className,
  required String orderId,
  required double vat,
  required double convenienceFee,
  required int studentIndex,
  StudentController? studentController,
  required int productIndex,
  String? studentName,
  String? studentCode,
  required String pinCode,
  required String homePhone,
  required String customerNote
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('confirm'.tr),
        content: (studentController==null || studentController.studentList==null||studentController.studentList!.isEmpty)? 
           Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'your_school_materials_will_be_delivered_at'.tr};'),
            Text('${'school_name'.tr}: $schoolName'),
            Text('${'class'.tr}: $className'),
            Text('${'student_name'.tr}: $studentName ${'student_code'.tr}: $studentCode'),
            const SizedBox(
              height: 3,
              width: double.infinity,
              child: Divider(thickness: 1,color: Colors.grey,),
            ),
            Text('${'delivery_company'.tr}: ${AppConstants.deliveryCompany}'),
            Text('${'receiver_phone'.tr}: $homePhone'),  // Displayed here
            Text('${'customer_note'.tr}: $customerNote'),
          ],
        ):
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${'your_school_materials_will_be_delivered_at'.tr};'),
            Text('${'school_name'.tr}: ${studentController.studentList![studentIndex].school}'),
            Text('${'class'.tr}: ${studentController.studentList![studentIndex].studentClass}'),
            Text('${'student_name'.tr}: ${studentController.studentList![studentIndex].name} ${'student_code'.tr}: ${studentController.studentList![studentIndex].code}'),
            const SizedBox(
              height: 3,
              width: double.infinity,
              child: Divider(thickness: 1,color: Colors.grey,),
            ),
            Text('${'delivery_company'.tr}: ${AppConstants.deliveryCompany}'),
            Text('${'receiver_phone'.tr}: $homePhone'),  // Displayed here
            Text('${'customer_note'.tr}: $customerNote'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () {
              final configModel = Get.find<SplashController>().configModel;
              Get.find<TransactionMoneyController>()
                  .pinVerify(pin: _pinCodeFieldController.text)
                  .then((isCorrect) {
                if (isCorrect) {
                  if (studentController==null || studentController.studentList==null||studentController.studentList!.isEmpty){
                    if (configModel!.twoFactor! && Get.find<ProfileController>().userInfo!.twoFactor!) {
                      Get.find<AuthController>()
                          .checkOtp()
                          .then((value) => value.isOk
                              ? _showOtpVerificationDialog(
                                  context,
                                  studentId: 0,
                                  randomNumber: randomNumber,
                                  productIndex: productIndex,
                                  vat: vat,
                                  totalAmount: totalAmount,
                                  convenienceFee: convenienceFee,
                                  pinCode: pinCode,
                                  studentIndex: studentIndex,
                                  checkedStudents: [],
                                  shipper: AppConstants.deliveryCompany,
                                  homePhone: homePhone,  // Added this
                                  customerNote: customerNote,
                                  destination: '$schoolName, $className, $studentName, $studentCode'
                                )
                              : null);
                    } else {
                      _showTransactionBottomSheet(
                        context,
                        studentId: 0,
                        randomNumber: randomNumber,
                        productIndex: productIndex,
                        vat: vat,
                        convenienceFee: convenienceFee,
                        totalAmount: totalAmount,
                        pinCode: pinCode,
                        studentIndex: studentIndex,
                        checkedStudents: [],
                        shipper: AppConstants.deliveryCompany,
                        homePhone: homePhone,  // Added this
                        customerNote: customerNote,
                        destination: destinationEditingController.text
                      );
                    }
                  } else {
                    if (configModel!.twoFactor! && Get.find<ProfileController>().userInfo!.twoFactor!) {
                      Get.find<AuthController>()
                          .checkOtp()
                          .then((value) => value.isOk
                              ? _showOtpVerificationDialog(
                                  context,
                                  studentId: studentController.studentList![studentIndex].id!,
                                  randomNumber: randomNumber,
                                  productIndex: productIndex,
                                  vat: vat,
                                  totalAmount: totalAmount,
                                  convenienceFee: convenienceFee,
                                  pinCode: pinCode,
                                  studentIndex: studentIndex,
                                  checkedStudents: studentController.studentList!,
                                  shipper: AppConstants.deliveryCompany,
                                  homePhone: homePhone,  // Added this
                                  customerNote: customerNote,
                                  destination: destinationEditingController.text
                                )
                              : null);
                    } else {
                      _showTransactionBottomSheet(
                        context,
                        studentId: studentController.studentList![studentIndex].id!,
                        randomNumber: randomNumber,
                        productIndex: productIndex,
                        vat: vat,
                        convenienceFee: convenienceFee,
                        totalAmount: totalAmount,
                        pinCode: pinCode,
                        studentIndex: studentIndex,
                        checkedStudents: studentController.studentList!,
                        shipper: AppConstants.deliveryCompany,
                        homePhone: homePhone,  // Added this
                        customerNote: customerNote,
                        destination: destinationEditingController.text
                      );
                    }
                  }
                }
              });
            },
            child: Text('ok'.tr),
          ),
        ],
      );
    },
  );
}
// Helper method for OTP verification dialog
void _showOtpVerificationDialog(
  BuildContext context, {
  required int studentId,
  required int randomNumber,
  required int productIndex,
  required double vat,
  required double convenienceFee,
  required String totalAmount,
  required String pinCode,
  required int studentIndex,
  required List<StudentModel> checkedStudents,
  required String destination,
  required String homePhone,
  required String customerNote,
  required String shipper
}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: 'otp_verification'.tr,
    content: Column(
      children: [
        CustomPinCodeFieldWidget(
          onCompleted: (pin) => Get.find<AuthController>()
              .verifyOtp(pin)
              .then((value) {
            if (value.isOk) {
              _showTransactionBottomSheet(
                pinCode: pinCode,
                Get.context!,
                studentId: studentId,
                randomNumber: randomNumber,
                productIndex: productIndex,
                vat: vat,
                convenienceFee: convenienceFee,
                totalAmount: totalAmount,
                studentIndex: studentIndex,
                checkedStudents: checkedStudents,
                shipper: shipper,
                 homePhone :homePhone,
                 customerNote: customerNote,
                 destination: destination
              );
            }
          }),
        ),
        const DemoOtpHintWidget(),
        GetBuilder<AuthController>(
          builder: (verifyController) => verifyController.isVerifying
              ? CircularProgressIndicator(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                )
              : const SizedBox.shrink(),
        )
      ],
    ),
  );
}

// Helper method for transaction bottom sheet
void _showTransactionBottomSheet(
  BuildContext context, {
  required int studentId,
  required int randomNumber,
  required int productIndex,
  required double vat,
  required double convenienceFee,
  required String totalAmount,
  required String pinCode,
  required int studentIndex,
  required List<StudentModel> checkedStudents,
  required String shipper,
  required String destination,
  required String customerNote,
  required String homePhone
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Dimensions.radiusSizeLarge),
      ),
    ),
    builder: (context) => BottomSheetWithSliderSp(
                                  deliveryCost: deliveryCost,
                                  materialCost: widget.totalAmount.toStringAsFixed(2),
                                    shippingAddress1:destinationEditingController.text,
                                    shippingAddress2: '',
                                    shippingCompany: shipper,
                                    shippingCity: 'Kigali',
                                    shippingCountry: 'Rwanda',
                                  homePhone:homePhone,
                                  customerNote: customerNote,
                                  studentId: studentId,
                                  randomNumber: randomNumber,
                                  selectedProducts: widget.cart!,
                                  quantity: widget.quantity!,
                                  studentIndex: studentIndex,
                                  availableBalance: '0.00',
                                  amount: widget.totalAmount.toStringAsFixed(2),
                                  productId: 1,
                                  contactModel: widget.contactModel,
                                  pinCode: pinCode,
                                  transactionType: widget.transactionType,
                                  purpose: widget.transactionType,
                                  studentInfo: checkedStudents,
                                  inputBalance: widget.totalAmount,
                                  product: widget.product!,
                                  productIndex: productIndex,
                                  edubox_service: 'shop'.tr,
                                  amountToPay:
                                      '${'delivery_cost'.tr}: ${deliveryCost.toStringAsFixed(2)}',
                                  nowPaid:
                                      '${'material_cost'.tr}: ${widget.totalAmount}',
                                  vat:
                                      '${'vat'.tr}: ${'inclusive'.tr}',
                                  serviceCharge: convenienceFee
                                      .toStringAsFixed(2),
                                  totalNowPaid:
                                      '${'total_amount_paid_now'.tr}: $totalAmount ${AppConstants.currency}',
                                  serviceValue: widget.product!.name,
                                )
  );
}
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
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: onTap,
  );
}
