import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final Product product;
  final Product product;
  final Function(Product, int) onAddToCart; // Callback function

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.onAddToCart, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('product_details'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child:     CustomImageWidget(
                 
                      image:
                             product.images?[0].src ?? 'no image',
                      fit: BoxFit.cover,
                      placeholder: Images.bannerPlaceHolder),
              ),
              const SizedBox(height: 16),
              // Product Name
              Text(
                product.name!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Product Price
              Text(
                '${AppConstants.currency} ${product.price}',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 16),
              Html(data: product.shortDescription??''),
     
              // Additional Properties
              // Text(
              //   '${'color'.tr}: ${product.color}',
              //   style: const TextStyle(fontSize: 16),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   '${'size'.tr}: ${product.size}',
              //   style: const TextStyle(fontSize: 16),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   '${'type'.tr}: ${product.type}',
              //   style: const TextStyle(fontSize: 16),
              // ),
              const SizedBox(height: 16),
              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Call the callback function to add the product to the cart
                     onAddToCart(product, 1); // Add 1 quantity by default
                    Navigator.pop(context); // Go back to the previous screen
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Added ${product.name} to cart')),
                    // );
                  },
                  child:  Text('add_to_cart'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}