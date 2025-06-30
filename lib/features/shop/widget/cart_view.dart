// Cart View Widget
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/student/screens/student_logistic_screen.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/screens/shop_transaction_confirmation_screen.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';

// Cart View Widget
class CartView extends StatefulWidget {
  final Map<Product, int> cart;
  final Function(Product) onReduceQuantity;
  final Function(Product) onRemoveProduct;
  final Function(Product) onAddQuantity; // New callback for adding quantity

  const CartView({
    super.key,
    required this.cart,
    required this.onReduceQuantity,
    required this.onRemoveProduct,
    required this.onAddQuantity, // Add this parameter
  });

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Function to calculate the total amount
  double _calculateTotal() {
    double total = 0.0;
    widget.cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = _calculateTotal();
    final userData = Get.find<AuthController>().getUserData();

    return Scaffold(
      appBar: AppBar(
        title:  Text('cart'.tr),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final product = widget.cart.keys.elementAt(index);
                final quantity = widget.cart[product]!;
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                      '${AppConstants.currency} ${product.price.toStringAsFixed(2)} x $quantity'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Add Quantity Button
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          widget.onAddQuantity(
                              product); // Call the add quantity callback
                          setState(
                              () {}); // Rebuild the widget to reflect the updated quantity
                        },
                      ),
                      // Reduce Quantity Button
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          widget.onReduceQuantity(product);
                          setState(
                              () {}); // Rebuild the widget to reflect the updated quantity
                        },
                      ),
                      // Remove Product Button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          widget.onRemoveProduct(product);
                          setState(
                              () {}); // Rebuild the widget to reflect the updated cart
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Total Amount and Checkout Button
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'total'.tr}: ${AppConstants.currency} ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:  Text('${'proceed_to_checkout'.tr}...'),
                        behavior: SnackBarBehavior
                            .floating, // Makes the SnackBar float
                        margin: const EdgeInsets.only(
                          bottom:
                              100, // Adjust this value to position it at the top
                          left: 20,
                          right: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Optional: Add rounded corners
                        ),
                      ),
                    );

                    Get.to(
                      ShopTransactionConfirmationScreen(
                          totalAmount: totalAmount,
                          homePhone: 'homePhone',
                          destination: 'destination',
                          shipper: 'shipper',
                          onIncreaseQuantity: widget.onAddQuantity,
                          transactionType: TransactionType.sendMoney,
                          contactModel: ContactModel(
                            phoneNumber:
                                '${userData!.countryCode}${userData.phone}',
                            name: '${userData.name}',
                            avatarImage:
                                '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image'}',
                          ),
                          contactModelMtn: ContactModelMtn(
                            phoneNumber:
                                '${userData.countryCode}${userData.phone}',
                            name: '${userData.name}',
                          ),
                          cart: widget.cart,
                          product: widget.cart.keys.first,
                          quantity: widget.cart.values.first,
                          onReduceQuantity: widget.onReduceQuantity,
                          onRemoveProduct: widget.onRemoveProduct
                          ),
                    );
                  },
                  child:  Text('checkout'.tr),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
