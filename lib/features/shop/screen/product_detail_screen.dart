import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final Function(Product, int) onAddToCart;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  void _showImageGallery(BuildContext context, int initialIndex) {
    final images = product.images ?? [];
    if (images.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: Colors.black,
          body: PhotoViewGallery.builder(
            itemCount: images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index].src??'no image'),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
                heroAttributes: PhotoViewHeroAttributes(tag: images[index].id ?? index),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = product.images ?? [];
    final hasImages = images.isNotEmpty;

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
              // Product Image Gallery Preview
              if (hasImages)
                GestureDetector(
                  onTap: () => _showImageGallery(context, 0),
                  child: Stack(
                    children: [
                      Hero(
                        tag: images[0].id ?? 'product_image_hero',
                        child: CustomImageWidget(
                          height: 300,
                          width: double.infinity,
                          image: images[0].src ?? 'no image',
                          fit: BoxFit.contain,
                          placeholder: Images.bannerPlaceHolder,
                        ),
                      ),
                      if (images.length > 1)
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '+${images.length - 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              else
                const CustomImageWidget(
                  height: 300,
                  width: double.infinity,
                  image: '',
                  placeholder: Images.bannerPlaceHolder,
                ),

              const SizedBox(height: 16),
              
              // Product Name
              Text(
                product.name ?? 'product_name_not_available'.tr,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 8),
              
              // Product Price
              Text(
                '${AppConstants.currency} ${product.regularPrice ?? 'N/A'}',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              
              const SizedBox(height: 16),
              
              // Product Description
              Html(data: product.shortDescription ?? 'no_description_available'.tr),
              
              const SizedBox(height: 16),
              
              // Additional Images Thumbnails
              if (images.length > 1)
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _showImageGallery(context, index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: CustomImageWidget(
                            height: 80,
                            width: 80,
                            image: images[index].src ?? 'no image',
                            fit: BoxFit.cover,
                            placeholder: Images.bannerPlaceHolder,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () {
                    onAddToCart(product, 1);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'add_to_cart'.tr,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}