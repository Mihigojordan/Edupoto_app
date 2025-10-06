// List View Widget
import 'package:flutter/material.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
<<<<<<< HEAD
import 'package:hosomobile/features/shop/screen/prduct_detail_screen.dart';
=======
import 'package:hosomobile/features/shop/screen/product_detail_screen.dart';
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';


// List View Widget
class ProductList extends StatelessWidget {
  // final List<Product> products;
  final List<Product> products;
  final Function(Product, int) onAddToCart;
  final  Map<Product, int> cart;

  const ProductList({super.key, required this.products, required this.onAddToCart, required this.cart});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
<<<<<<< HEAD
        final product = products[index];
=======
         // Safe access to product
        if (index >= products.length) return const SizedBox();
        final product = products[index];
        
        // Safe image handling
        final imageUrl = (product.images != null && product.images!.isNotEmpty)
            ? product.images![0].src
            : Images.bannerPlaceHolder;
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
        final quantity = cart[product] ?? 0; // Get quantity from cart
      // Inside the ListView.builder itemBuilder
return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  ProductDetailsScreen(
                  product: product,
                  onAddToCart: onAddToCart, // Pass the callback
                ),
      ),
    );
  },
  child: Card(
    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    child: ListTile(
      leading:CustomImageWidget(
                   height: 50,
                  width: 50,
                    image:
<<<<<<< HEAD
                           product.images?[0].src ?? 'no image',
=======
                          imageUrl?? 'no image',
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                    fit: BoxFit.cover,
                    placeholder: Images.bannerPlaceHolder),
      title: Text(product.name??'Unknown', style: const TextStyle(fontSize: 12)),
      subtitle:       RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                      TextSpan(
                        text: '${AppConstants.currency} ${product.regularPrice}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                      if (quantity > 0) ...[
                     
                        TextSpan(
                          text: ' X $quantity',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ])),
              
      trailing: IconButton(
        icon: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          // Add 1 quantity by default
      onAddToCart(product, 1);
        },
      ),
    ),
  ),
);
      },
    );
  }
}