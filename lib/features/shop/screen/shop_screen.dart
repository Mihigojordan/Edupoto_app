import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/domain/product_lists.dart';
import 'package:hosomobile/features/shop/widget/cart_view.dart';
import 'package:hosomobile/features/shop/widget/company.dart';
import 'package:hosomobile/features/shop/widget/company_nav_bar.dart';
import 'package:hosomobile/features/shop/widget/company_type.dart';
import 'package:hosomobile/features/shop/widget/company_type_nav_bar.dart';
import 'package:hosomobile/features/shop/widget/product.dart';
import 'package:hosomobile/features/shop/widget/product_grid.dart';
import 'package:hosomobile/features/shop/widget/product_list.dart';

class ShoppingScreen extends StatefulWidget {
  final bool? isOffer;
  const ShoppingScreen({super.key, this.isOffer});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _selectedTypeIndex = 0; // Index of the selected company type
  int _selectedCompanyIndex = 0; // Index of the selected company
  bool _isGridView = true;
  String _searchQuery = '';
  late final Map<Product, int> _cart;
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;

  // List of company types with their companies
  final List<CompanyType> companyTypes = [
    CompanyType(
      name: '     Librairie Caritas           ',
      companies: [
        Company(
          name: 'stationery'.tr,
          logo: 'assets/image/stationery.png',
          products: mAndGProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
        ),
        Company(
          name: 'books'.tr,
          logo: 'assets/image/book.png',
          products: natarajProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
        ),

      ],
    ),
    CompanyType(
      name: 'Edubox',
      companies: [
        Company(
          name: 'stationery'.tr,
          logo: 'assets/image/stationery.png',
          products: mAndGProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
        ),
        Company(
          name: 'class_kit'.tr,
          logo: 'assets/image/Button01.png',
          products: rwandaPensProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
        ),
        Company(
          name: 'school_shoes'.tr,
          logo: 'assets/image/shoebox.png',
          products: natarajProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
        ),
        Company(
          name: 'dormitory_sssentials'.tr,
          logo: 'assets/image/dormitory.png',
          products: bicProducts
              .map((product) => Product(
                    name: product["name"],
                    price: product["price"],
                    image: product["image"],
                  ))
              .toList(),
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
      builder: (context) => CartView(
        onAddQuantity: _addQuantity,
        cart: _cart,
        onReduceQuantity: _reduceQuantity,
        onRemoveProduct: _removeProduct,
      ),
    );
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_searchQuery.isEmpty) return products;
    return products
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentType = companyTypes[_selectedTypeIndex];
    final currentCompanies = currentType.companies;
    final filteredProducts =
        _filterProducts(currentCompanies[_selectedCompanyIndex].products);

    return Scaffold(
      appBar: AppBar(
        title:  Text('shopping_screen'.tr),
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
                      '${_cart.length}',
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
      body: Column(
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
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          // Company Type Navigation
          CompanyTypeNavigationBar(
            company_types: companyTypes,
            selectedIndex: _selectedTypeIndex,
            onTap: (index) {
              setState(() {
                _selectedTypeIndex = index;
                _selectedCompanyIndex =
                    0; // Reset to first company when type changes
              });
            },
          ),
          // Company Navigation (shows companies for selected type)
          CompanyNavigationBar(
            companies: currentCompanies,
            selectedIndex: _selectedCompanyIndex,
            onTap: (index) => setState(() => _selectedCompanyIndex = index),
          ),
          // Products
          Expanded(
            child: _isGridView
                ? ProductGrid(
                    products: filteredProducts,
                    onAddToCart: _addToCart,
                    cart: _cart, // Pass the cart here
                  )
                : ProductList(
                    products: filteredProducts,
                    onAddToCart: _addToCart,
                    cart: _cart
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCart,
        child: Stack(
          children: [
            const Icon(Icons.shopping_cart),
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
                    '${_cart.length}',
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
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
