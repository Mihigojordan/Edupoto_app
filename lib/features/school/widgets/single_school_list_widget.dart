import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/controllers/cart_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/widgets/product_details_dialog.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/util/app_constants.dart';

class SingleSchoolListModernWidget extends StatefulWidget {
  final SchoolLists? schoolLists;
  final int? index;
  final bool? initialChecked;
  final Function(bool?)? onChanged;
  final List<Product>? products;
  final Function(double total, int transactionType) onTotalChanged;
    // Add this new parameter
  final int transactionType;

  const SingleSchoolListModernWidget({
    super.key,
    this.schoolLists,
    this.index,
    this.initialChecked,
    this.onChanged,
    this.products,
    required this.onTotalChanged,
     required this.transactionType,
  });

  @override
  State<SingleSchoolListModernWidget> createState() => _SingleSchoolListWidgetState();
}

class _SingleSchoolListWidgetState extends State<SingleSchoolListModernWidget> {
  bool _isExpanded = false;
  final Map<Product, int> _selectedProducts = {};
  double _currentTotal = 0.0;

  void _updateProductSelection(Product product, bool isSelected, [int quantity = 1]) {
    setState(() {
      if (isSelected) {
        _selectedProducts[product] = quantity;
      } else {
        _selectedProducts.remove(product);
      }
      _calculateCurrentTotal();
      widget.onTotalChanged(_currentTotal, widget.transactionType);
    });
  }

  void _updateProductQuantity(Product product, int quantity) {
    setState(() {
      if (_selectedProducts.containsKey(product)) {
        _selectedProducts[product] = quantity;
        _calculateCurrentTotal();
        widget.onTotalChanged(_currentTotal, widget.transactionType);
      }
    });
  }

  void _calculateCurrentTotal() {
    double newTotal = 0.0;
    _selectedProducts.forEach((product, quantity) {
      newTotal += (double.tryParse(product.price ?? '0') ?? 0) * quantity;
    });
    _currentTotal = newTotal;
  }

    void onAddToCart(Product product, int quantity) {
    final cartController = Get.find<CartController>();
    cartController.addToCart(product, quantity);
    
    // Show a snackbar feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${product.name} to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    String? heading;
    Color? color;

    try {
      heading = widget.schoolLists!.transactionType == AppConstants.classRequirement
          ? 'class_requirements'.tr
          : widget.schoolLists!.transactionType == AppConstants.dormitoryEssential
              ? 'dormitory_essentials'.tr
              : widget.schoolLists!.transactionType == AppConstants.textBook
                  ? 'text_books'.tr
                  : widget.schoolLists!.transactionType == AppConstants.tuitionFee
                      ? 'tuition_fee'.tr
                      : '';
      
      color = widget.schoolLists!.transactionType == AppConstants.classRequirement
          ? Colors.deepPurple
          : widget.schoolLists!.transactionType == AppConstants.dormitoryEssential
              ? Colors.lightBlueAccent
              : widget.schoolLists!.transactionType == AppConstants.textBook
                  ? Colors.pinkAccent
                  : widget.schoolLists!.transactionType == AppConstants.tuitionFee
                      ? Colors.orangeAccent
                      : Colors.grey;
    } catch (e) {
      'no_user'.tr;
    }

    // Check if this is a tuition fee item
    final isTuitionFee = widget.schoolLists?.transactionType == AppConstants.tuitionFee;

    // Filter products by category if available (only for non-tuition items)
    final categoryProducts = isTuitionFee 
        ? []
        : widget.products?.where((product) {
            return product.categories?.any((category) => 
                category.name == widget.schoolLists?.category) ?? false;
          }).toList() ?? [];

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: widget.schoolLists!.transactionType == AppConstants.headteacherMessage ? 2 : 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: widget.schoolLists!.transactionType == AppConstants.headteacherMessage
            ? const Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - show for all items except tuition fee
          if (widget.index! > 0 && !isTuitionFee)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title:     Text(
                '${widget.schoolLists!.transactionId} ${_currentTotal.toStringAsFixed(2)} ${AppConstants.currency}' ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
       
              trailing: categoryProducts.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: color,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    )
                  : null,
            )
          else if (widget.index! > 0 && isTuitionFee)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.schoolLists!.transactionId ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
           
            ),

          // Content area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // For tuition fee, show checkbox and price directly
                if (isTuitionFee)
                  Row(
                    children: [
                      Checkbox(
                        value: widget.initialChecked ?? false,
                        onChanged: widget.onChanged,
                        activeColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                  
                      Text(
                        '${widget.schoolLists!.amount ?? 0} ${AppConstants.currency}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  )
                else if(widget.index==0)
                  // For non-tuition items, show just the transaction ID
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Text(
                heading!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              sizedBox05h,
                   ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title:     Text(
                '${widget.schoolLists!.transactionId } ${_currentTotal.toStringAsFixed(2)} ${AppConstants.currency}'?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
       
              trailing: categoryProducts.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: color,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    )
                  : null,
            )
                    ],
                  )
              else
          const  SizedBox.shrink(),
                // Expanded products list (only for non-tuition items)
    if (!isTuitionFee && _isExpanded && categoryProducts.isNotEmpty)
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Column(
          children: [
            const Divider(color: Colors.grey),
            Text(
              'Available Products',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
       ...categoryProducts.map((product) {
      final isSelected = _selectedProducts.containsKey(product);
      final quantity = _selectedProducts[product] ?? 1;
      
      return ProductItem(
        product: product,
        initialQuantity: quantity,
        isSelected: isSelected,
        onChanged: (value) => _updateProductSelection(product, value ?? false, quantity),
        onQuantityChanged: (newQuantity) => _updateProductQuantity(product, newQuantity),
        color: color,
      );
    }),
            const SizedBox(height: 8),
            Text(
              'Subtotal: ${_currentTotal.toStringAsFixed(2)} ${AppConstants.currency}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
            ),
            sizedBox10,
     Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  // Add all selected products to cart
                  _selectedProducts.forEach((product, quantity) {
                    onAddToCart(product, quantity);
                  });
                  // Show feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added ${_selectedProducts.length} items to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
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
         ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isSelected;
  final int initialQuantity;
  final Function(bool?)? onChanged;
  final Function(int)? onQuantityChanged;
  final Color? color;

  const ProductItem({
    super.key,
    required this.product,
    required this.isSelected,
    required this.initialQuantity,
    this.onChanged,
    this.onQuantityChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.price} ${AppConstants.currency} X ${isSelected ? initialQuantity : 1}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ProductDetailsDialog(
                  product: product,
                  initialQuantity: initialQuantity,
                  onAddToCart: () {
                    if (onChanged != null) onChanged!(true);
                    // Navigator.pop(context);
                  },
                  onQuantityChanged: onQuantityChanged,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}