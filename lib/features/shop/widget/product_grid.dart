import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/screen/prduct_detail_screen.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/util/app_constants.dart';

class ProductGrid extends StatefulWidget {
  final List<ShopModel> products;
  final Function(Product, int) onAddToCart;
  final Map<Product, int> cart; // Add this parameter

  const ProductGrid({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.cart, // Add this
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final quantity = widget.cart[product] ?? 0; // Get quantity from cart

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: product,
                  onAddToCart: (p, q) {
                    _addToCart(p, q);
                    widget.onAddToCart(p, q);
                  },
                ),
              ),
            );
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  product.image??'no image',
                  height: screenWidth / 8,
                  width: screenWidth / 8,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 4),
            
                      Text(
                    product.name??'no name',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
             
                const SizedBox(height: 4),
                RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                      // TextSpan(
                      //   text: '${AppConstants.currency} ${product.price.toStringAsFixed(2)}',
                      //   style:
                      //       const TextStyle(fontSize: 14, color: Colors.green),
                      // ),
                      if (quantity > 0) ...[
                     
                        TextSpan(
                          text: ' X $quantity',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ])),
                const SizedBox(height: 4),
                // ElevatedButton(
                //   onPressed: () => _addToCart(product, 1),
                //   child: Text('add_to_cart'.tr),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToCart(Product product, int quantity) {
    // Just call the parent's callback, don't maintain local state
    widget.onAddToCart(product, quantity);
  }
}