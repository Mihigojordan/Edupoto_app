import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/transaction_money/screens/shop_transaction_confirmation_screen.dart';

class ShopMapWidget extends StatefulWidget {
  final Map<Product, int> cart;
  final Function(Product) onReduceQuantity;
  final Function(Product) onRemoveProduct;
  final Function(Product) onIncreaseQuantity;
  final String transactionType;
  final ContactModel contactModel;
  final ContactModelMtn contactModelMtn;
  final double totalAmount;
  final Product product;
  final int quantity;

  const ShopMapWidget({
    super.key,
    required this.cart,
    required this.onReduceQuantity,
    required this.onRemoveProduct,
    required this.onIncreaseQuantity,
    required this.transactionType,
    required this.contactModel,
    required this.contactModelMtn,
    required this.totalAmount,
    required this.product,
    required this.quantity,
  });

  @override
  _ShopMapWidgetState createState() => _ShopMapWidgetState();
}

class _ShopMapWidgetState extends State<ShopMapWidget> {
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
    setState(() {
      isHomeDelivery = !isHomeDelivery;
    });
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: screenHeight / 1.5,
      width: 340,
      child: SingleChildScrollView(
        child: Column(
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
              onPress: () => Get.to(
                () => ShopTransactionConfirmationScreen(
                  shipper: '',
                  homePhone: '',
                  destination: '',
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
                    // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                    title: 'HOME',
                    iconData: Icons.arrow_forward_outlined,
                  )
                : Column(
                    children: [
                      Text(
                        'Chose Delivery Address',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                      sizedBox10,
                      buildFormField('Where to ?', destinationEditingController,
                          TextInputType.name, 'KN 360 St 6'),
                      sizedBox15,
                      _buildListTile(
                          icon: Icons.location_on,
                          title: 'KG 338 St, Kigali, Rwanda',
                          onTap: () {}),
                      sizedBox15,
                      _buildListTile(
                          icon: Icons.star,
                          title: 'Choose saved place',
                          onTap: () {}),
                      sizedBox10,
                      Text(
                        'Please Provide the phone number that is currently available at the destinaltion location',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: kErrorBorderColor,
                            fontWeight: FontWeight.normal),
                      ),
                      sizedBox10,
                      buildFormField(
                          'Home Phone Number',
                          phoneNumberEditingController,
                          TextInputType.name,
                          '07XXXXXXXX'),
                          sizedBox10,
                      DropDownMapInfo(
                        menuHeight: 320,
                        prefixIcon: 'assets/icons1/delivery.jpg',
                        onChanged: (onChanged) {
                          setState(() {
                            deliveryOptionsValue = onChanged!;
                            _deliveryOptionError =
                                null; // Clear error when selection changes
                          });
                        },
                        itemLists: topSize,
                        title: deliveryOptionsValue,
                        width: screenWidth,
                        menuWidth: screenWidth,
                        errorText: _deliveryOptionError, // Show error if exists
                      ),
                      sizedBox15,
                      const SizedBox(
                        height: 130,
                        width: 340,
                        child: IconImages('assets/icons1/map.png'),
                      ),
                      sizedBox15,
                      DefaultButton2(
                        color1: kamber300Color,
                        color2: kyellowColor,
                        onPress: () {
                          _validateForm();
                        },
                        title: 'NEXT',
                        iconData: Icons.arrow_forward_outlined,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
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
