import 'package:flutter/material.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/widget/shop_map_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopMapScreen extends StatefulWidget {
  final UserShortDataModel userData;
  final int index;
  final int selectedIndex;
  final int productId;
  final int studentIndex;
  final bool isShop;
  final String iconImage;
  final Map<Product, int>? cart;
  final Function(Product)? onReduceQuantity;
  final Function(Product)? onRemoveProduct;
  final Function(Product)? onIncreaseQuantity;
  final String? transactionType;
  final ContactModel? contactModel;
  final ContactModelMtn? contactModelMtn;
  final double? totalAmount;
  final Product? product;
  final int? quantity;

  const ShopMapScreen({
    super.key,
    this.cart,
    this.onRemoveProduct,
    this.product,
    this.quantity,
    this.totalAmount,
    this.transactionType,
    this.contactModel,
    this.contactModelMtn,
    this.onIncreaseQuantity,
    this.onReduceQuantity,
    required this.iconImage,
    required this.isShop,
    required this.userData,
    required this.index,
    required this.selectedIndex,
    required this.productId,
    required this.studentIndex,
  });

  @override
  State<ShopMapScreen> createState() => _ShopMapScreenState();
}

class _ShopMapScreenState extends State<ShopMapScreen> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;

  bool isSelected = false;
  UserShortDataModel? userData;

  final TextEditingController classEditingController = TextEditingController();
  final TextEditingController numberEditingController = TextEditingController();
  final TextEditingController dayEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController schoolNameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showDetails();
  }

  void showDetails() async {
    // Add your logic here if needed
  }

  void selectedValue() {
    setState(() {
      isSelected = !isSelected;
      print(isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kTextLightColor,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: kTextWhiteColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: MediaQuery.of(context).size.height / 1.3,
      width: 340,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShopMapWidget(
            transactionType: widget.transactionType!,
            quantity: widget.quantity!,
            cart: widget.cart!,
            contactModel: widget.contactModel!,
            contactModelMtn: widget.contactModelMtn!,
            onIncreaseQuantity: widget.onIncreaseQuantity!,
            onReduceQuantity: widget.onReduceQuantity!,
            onRemoveProduct: widget.onRemoveProduct!,
            product: widget.product!,
            totalAmount: widget.totalAmount!,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}