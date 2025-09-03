import 'package:flutter/material.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';

class ProductDetailsDialog extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final ValueChanged<int>? onQuantityChanged;
  final int initialQuantity;

  const ProductDetailsDialog({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onQuantityChanged,
    required this.initialQuantity,
  });

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
   late int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                //image with Close Button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageWidget(
                 
                      image:
                             widget.product.images?[0].src ?? 'no image',
                      fit: BoxFit.cover,
                      placeholder: Images.bannerPlaceHolder),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Product Name
              Text(
                widget.product.name??'N/A',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Price and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.product.price} ${AppConstants.currency}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  // if (widget.product.rating != null)
                  //   Row(
                  //     children: [
                  //       Icon(Icons.star, 
                  //         color: Colors.amber, 
                  //         size: 20),
                  //       const SizedBox(width: 4),
                  //       Text(
                  //         widget.product.rating.toString(),
                  //         style: Theme.of(context).textTheme.bodyLarge,
                  //       ),
                  //     ],
                  //   ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              if (widget.product.shortDescription != null && widget.product.shortDescription!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.shortDescription!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

             // Quantity Selector
             
     Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_currentQuantity > 1) {
                      setState(() {
                        _currentQuantity--;
                        widget.onQuantityChanged?.call(_currentQuantity);
                      });
                    }
                  },
                ),
                Text(
                  _currentQuantity.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _currentQuantity++;
                      widget.onQuantityChanged?.call(_currentQuantity);
                    });
                  },
                ),
              ],
            ),

          // Add to Cart Button
                  ElevatedButton(
              onPressed: () {
                // widget.onQuantityChanged?.call(_currentQuantity);
                // widget.onAddToCart();
                Navigator.pop(context);
              },
              child: Text('Add to Cart'),
            ),
            ],
          ),
        );
        })
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    int quantity = widget.initialQuantity ?? 1;
    
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() => quantity--);
                    widget.onQuantityChanged?.call(quantity);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() => quantity++);
                  widget.onQuantityChanged?.call(quantity);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}