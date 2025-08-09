import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/screen/prduct_detail_screen.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';

class ProductGrid extends StatefulWidget {
  final List<Product> products;
  final Function(Product, int) onAddToCart;
  final Map<Product, int> cart;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.cart,
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
        final quantity = widget.cart[product] ?? 0;

        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Product Image with GestureDetector for details
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: product,
                        onAddToCart: widget.onAddToCart,
                      ),
                    ),
                  );
                },
                child: CustomImageWidget(
                  height: screenWidth / 7.5,
                  width: screenWidth / 6.5,
                  image: product.images?[0].src ?? 'no image',
                  fit: BoxFit.cover,
                  placeholder: Images.bannerPlaceHolder,
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Product Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  product.name ?? 'no name',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4),
              
              // Price and Quantity
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '${AppConstants.currency} ${product.regularPrice}',
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                    if (quantity > 0) ...[
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: 'X $quantity',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(height: 4),
              
              // Add to Cart Button
              ElevatedButton(
                onPressed: () => widget.onAddToCart(product, 1),
                child: Text('add_to_cart'.tr,
                style: const TextStyle(fontSize: 12, color: kyellow800Color,fontWeight:FontWeight.w400, ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}