import 'package:flutter/material.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
<<<<<<< HEAD
import 'package:hosomobile/features/shop/screen/prduct_detail_screen.dart';
=======
import 'package:hosomobile/features/shop/screen/product_detail_screen.dart';
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;
  final int? quantityInCart;

  const ProductItem({
    super.key,
    required this.product,
    this.onAddToCart,
    this.quantityInCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // Navigate to product details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product,onAddToCart: (p0, p1) {
                
              },),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomImageWidget(
                    height: 120,
                    width: 120,
                    image: product.images?.isNotEmpty == true 
                        ? product.images![0].src!
                        : 'no image',
                    fit: BoxFit.cover,
                    placeholder: Images.bannerPlaceHolder,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              // Product Name
              Text(
                product.name ?? 'No name',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Price Information
              _buildPriceInfo(),
              
              // Quantity in cart (if any)
              if (quantityInCart != null && quantityInCart! > 0) ...[
                const SizedBox(height: 4),
                Text(
                  'In cart: $quantityInCart',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
              
              const Spacer(),
              
              // Add to cart button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: onAddToCart,
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    // Check if product is on sale
    final isOnSale = product.salePrice != null && product.salePrice!.isNotEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOnSale) ...[
          Text(
            '${AppConstants.currency} ${product.regularPrice}',
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
        ],
        Text(
          '${AppConstants.currency} ${isOnSale ? product.salePrice : product.price}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}