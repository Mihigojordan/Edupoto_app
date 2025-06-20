import 'package:flutter/material.dart';
import 'package:hosomobile/features/shop/widget/product.dart';

class ProductDetailsScreen extends StatelessWidget {
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
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.asset(
                product.image,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Product Name
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Product Price
            Text(
              'RWF ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            // Additional Properties
            Text(
              'Color: ${product.color}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Size: ${product.size}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Type: ${product.type}',
              style: const TextStyle(fontSize: 16),
            ),
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
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}