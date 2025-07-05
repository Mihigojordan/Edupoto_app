import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/school/widgets/school_list_shimmer_widget.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/data/categories.dart';
import 'package:hosomobile/features/shop/domain/data/product_lists.dart';
import 'package:hosomobile/features/shop/domain/models/company_category.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/shop/widget/cart_view.dart';
import 'package:hosomobile/features/shop/domain/models/company.dart';
import 'package:hosomobile/features/shop/widget/company_nav_bar.dart';
import 'package:hosomobile/features/shop/domain/models/company_type.dart';
import 'package:hosomobile/features/shop/widget/company_side_bar.dart';
import 'package:hosomobile/features/shop/widget/company_type_nav_bar.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';
import 'package:hosomobile/features/shop/widget/product_grid.dart';
import 'package:hosomobile/features/shop/widget/product_list.dart';
import 'package:hosomobile/features/shop/widget/shop_shimmer_widget.dart';

class ShoppingScreen extends StatefulWidget {
  final bool? isOffer;
  const ShoppingScreen({super.key, this.isOffer});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _selectedTypeIndex = 0;
  int _selectedCompanyIndex = 0;
  int _selectedCategoryIndex = 0;
  bool _isGridView = true;
  String _searchQuery = '';
  late final Map<Product, int> _cart;
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;

  final List<CompanyType> companyTypes = [
    CompanyType(
      name: 'Librairie Caritas',
      companies: [
        Company(
          name: 'stationery'.tr,
          logo: 'assets/image/stationery.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
        Company(
          name: 'books'.tr,
          logo: 'assets/image/book.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
      ],
    ),
    CompanyType(
      name: 'Edubox',
      companies: [
        Company(
          name: 'stationery'.tr,
          logo: 'assets/image/stationery.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
        Company(
          name: 'class_kit'.tr,
          logo: 'assets/image/Button01.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
        Company(
          name: 'school_shoes'.tr,
          logo: 'assets/image/shoebox.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
        Company(
          name: 'dormitory_essentials'.tr,
          logo: 'assets/image/dormitory.png',
          categories: stationery.map((category) => CompanyCategory(
            name: category['name'],
            logo: category['logo'],
            products: (category['products'] as List).map((product) => Products(
              name: product['name'],
              image: product['image'],
              price: product['price'],
            )).toList(),
          )).toList(),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cart = {};
    _idController = TextEditingController();
     
    _passwordController = TextEditingController();
    if (widget.isOffer == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    }

  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      _cart[product] = (_cart[product] ?? 0) + quantity;
    });
  }

  void _reduceQuantity(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        if (_cart[product]! > 1) {
          _cart[product] = _cart[product]! - 1;
        } else {
          _cart.remove(product);
        }
      }
    });
  }

  void _addQuantity(Product product) {
    setState(() {
      _cart[product] = (_cart[product] ?? 0) + 1;
    });
  }

  void _removeProduct(Product product) {
    setState(() {
      _cart.remove(product);
    });
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CartView(
          onAddQuantity: _addQuantity,
          cart: _cart,
          onReduceQuantity: _reduceQuantity,
          onRemoveProduct: _removeProduct,
        ),
      ),
    );
  }

  // List<Product> _filterProducts(List<Product> products) {
  //   if (_searchQuery.isEmpty) return products;
  //   return products
  //       .where((product) =>
  //           product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
  //       .toList();
  // }

List<Product> _filterProductsByCategory(List<Product> products, int categoryId) {
  if (products.isEmpty) return [];
  
  return products.where((product) {
    // Check if product has categories and if any category matches the selected one
    return product.categories != null && 
           product.categories!.isNotEmpty &&
           product.categories!.any((category) => category.id == categoryId);
  }).toList();
}

  @override
  Widget build(BuildContext context) {
    final currentType = companyTypes[_selectedTypeIndex];
    final currentCompany = currentType.companies[_selectedCompanyIndex];
    final currentCategory = currentCompany.categories[_selectedCategoryIndex];
   

    return Scaffold(
      appBar: AppBar(
        title: Text('shopping_screen'.tr),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _showCart,
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cart.values.fold(0, (sum, quantity) => sum + quantity)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GetBuilder<ShopController>(
        builder: (shopController) {
          
      shopController.addListener(() {
    if (mounted && shopController.categoryList != null) {
      setState(() {
        _selectedCategoryIndex = 0; // Reset to first category
      });
    }
  });

    return shopController.isLoading?const Center(child: ShopShimmerWidget()):
    Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '${'search_products'.tr}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          // Company Type Navigation
          CompanyTypeNavigationBar(
            companyTypes: companyTypes,
            selectedIndex: _selectedTypeIndex,
            onTap: (index) {
              setState(() {
                _selectedTypeIndex = index;
                _selectedCompanyIndex = 0;
                _selectedCategoryIndex = 0;
              });
            },
          ),
          // Company Navigation
          CompanyNavigationBar(
            companies: currentType.companies,
            selectedIndex: _selectedCompanyIndex,
            onTap: (index) => setState(() {
              _selectedCompanyIndex = index;
              _selectedCategoryIndex = 0;
            }),
          ),
 Expanded(
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Sidebar with categories - only show if categories exist
      if (shopController.categoryList != null && shopController.categoryList!.isNotEmpty)
        CompanySideBar(
          categoryList: shopController.categoryList!,
          selectedIndex: _selectedCategoryIndex,
          onTap: (index) {
            if (index >= 0 && index < shopController.categoryList!.length) {
              setState(() => _selectedCategoryIndex = index);
            }
          },
        ),
      // Products
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildProductView(shopController),
        ),
      ),
    ],
  ),
),
        ],
      );}),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: _showCart,
        child: Stack(
          children: [
            const Icon(Icons.shopping_cart, color: Colors.white),
            if (_cart.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${_cart.values.fold(0, (sum, quantity) => sum + quantity)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

Widget _buildProductView(ShopController shopController) {
  // Check if categories and products exist
  if (shopController.categoryList == null || 
      shopController.categoryList!.isEmpty ||
      shopController.shopList == null) {
    return const Center(child: CircularProgressIndicator());
  }

  // Ensure selected index is valid
  if (_selectedCategoryIndex >= shopController.categoryList!.length) {
    _selectedCategoryIndex = 0; // Reset to first category if invalid
  }

  final filteredProducts = _filterProductsByCategory(
    shopController.shopList!,
    shopController.categoryList![_selectedCategoryIndex].id,
  );

  if (filteredProducts.isEmpty) {
    return Center(child: Text('no_products_found'.tr));
  }

  return _isGridView
      ? ProductGrid(
          products: filteredProducts,
          onAddToCart: _addToCart,
          cart: _cart,
        )
      : ProductList(
          products: filteredProducts,
          onAddToCart: _addToCart,
          cart: _cart,
        );
}

}