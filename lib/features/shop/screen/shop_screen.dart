import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/school/widgets/school_list_shimmer_widget.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/data/categories.dart';
import 'package:hosomobile/features/shop/domain/data/product_lists.dart';
import 'package:hosomobile/features/shop/domain/models/attribute_model.dart';
import 'package:hosomobile/features/shop/domain/models/brand_model.dart';
import 'package:hosomobile/features/shop/domain/models/category_model.dart';
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
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        Company(
          name: 'books'.tr,
          logo: 'assets/image/book.png',
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
      ],
    ),
    CompanyType(
      name: 'leviticus_shop'.tr,
      companies: [
        Company(
          name: 'stationery'.tr,
          logo: 'assets/image/stationery.png',
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        Company(
          name: 'class_kit'.tr,
          logo: 'assets/image/Button01.png',
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        Company(
          name: 'school_shoes'.tr,
          logo: 'assets/image/shoebox.png',
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        Company(
          name: 'dormitory_essentials'.tr,
          logo: 'assets/image/dormitory.png',
          categories: stationery
              .map((category) => CompanyCategory(
                    name: category['name'],
                    logo: category['logo'],
                    products: (category['products'] as List)
                        .map((product) => Products(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'],
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
      ],
    ),
  ];

  List<Product> _filterProductsBySearch(List<Product> products, String query) {
  if (query.isEmpty) return products;
  return products.where((product) =>
      product.name!.toLowerCase().contains(query.toLowerCase())).toList();
}

  @override
  void initState() {
    super.initState();
    _cart = {};
    _idController = TextEditingController();
    _passwordController = TextEditingController();

    // Initialize selection when data is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final shopController = Get.find<ShopController>();
        final filteredTypes = _getFilteredCompanyTypes(shopController);
        if (filteredTypes.isNotEmpty) {
          setState(() {
            _selectedTypeIndex = 0; // Select first attribute by default
            _selectedCompanyIndex = 0;
            _selectedCategoryIndex = 0;
          });
        }
      }
    });

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
      body: GetBuilder<ShopController>(builder: (shopController) {
        shopController.addListener(() {
          if (mounted && shopController.categoryList != null) {
            setState(() {
              _selectedCategoryIndex = 0; // Reset to first category
            });
          }
        });

        return shopController.isLoading
            ? const Center(child: ShopShimmerWidget())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
  decoration: InputDecoration(
    hintText: '${'search_products'.tr}...',
    prefixIcon: const Icon(Icons.search),
    suffixIcon: _searchQuery.isNotEmpty
        ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() => _searchQuery = ''),
          )
        : null,
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
                    companyTypes: _getFilteredCompanyTypes(shopController),
                    selectedIndex: _selectedTypeIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedTypeIndex = index;
                        _selectedCompanyIndex = 0; // Reset brand selection
                        _selectedCategoryIndex = 0; // Reset category selection
                      });
                    },
                  ),
                  // Company Navigation
                  CompanyNavigationBar(
                    companies: _getFilteredBrands(shopController),
                    selectedIndex: _selectedCompanyIndex,
                    onTap: (index) => setState(() {
                      _selectedCompanyIndex = index;
                      _selectedCategoryIndex = 0;
                    }),
                  ),
                  // Text('data ${shopController.orderList}'),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sidebar with categories - only show if categories exist
                        if (shopController.categoryList != null &&
                            shopController.categoryList!.isNotEmpty)
                          CompanySideBar(
                            categoryList:
                                _getFilteredCategories(shopController),
                            selectedIndex: _selectedCategoryIndex,
                            onTap: (index) {
                              if (index >= 0 &&
                                  index <
                                      _getFilteredCategories(shopController)
                                          .length) {
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
              );
      }),
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

  List<Product> _filterProductsByCategory(
      List<Product> products, int categoryId) {
    if (products.isEmpty || categoryId == 0)
      return products; // 0 means "All Categories"

    return products.where((product) {
      return product.categories != null &&
          product.categories!.isNotEmpty &&
          product.categories!.any((category) => category.id == categoryId);
    }).toList();
  }

  List<WooCategory> _getFilteredCategories(ShopController shopController) {
    if (shopController.categoryList == null) {
      return [];
    }

    // If no specific attribute is selected, show all categories
    final filteredCompanyTypes = _getFilteredCompanyTypes(shopController);
    if (_selectedTypeIndex < 0 ||
        _selectedTypeIndex >= filteredCompanyTypes.length) {
      return [WooCategory(name: 'all'.tr, id: 0)] +
          shopController.categoryList!;
    }

    // Otherwise, show categories related to the selected attribute
    final selectedAttributeId = filteredCompanyTypes[_selectedTypeIndex].id;

    // Get products for the selected attribute
    final attributeProducts = shopController.shopList!.where((product) {
      return product.attributes != null &&
          product.attributes!.isNotEmpty &&
          product.attributes!.any((attr) => attr.id == selectedAttributeId);
    }).toList();

    // Get category IDs from these products
    final categoryIds = attributeProducts.expand((product) {
      return product.categories?.map((category) => category.id) ?? <int>[];
    }).toSet();

    // Return all categories that appear in these products
    return [WooCategory(name: 'all'.tr, id: 0)] +
        shopController.categoryList!.where((category) {
          return categoryIds.contains(category.id);
        }).toList();
  }

  List<Product> _filterProductsByBrand(List<Product> products, int brandId) {
    if (products.isEmpty || brandId == 0)
      return products; // 0 means "All Brands"

    return products.where((product) {
      print('8888888888888888888888888 ${product.brands}');
      return product.brands != null &&
          product.brands!.isNotEmpty &&
          product.brands!.any((brand) => brand.id == brandId);
    }).toList();
  }

  List<BrandModel> _getFilteredBrands(ShopController shopController) {
    if (shopController.shopList == null || shopController.brandList == null) {
      return [];
    }

    final filteredCompanyTypes = _getFilteredCompanyTypes(shopController);
    if (filteredCompanyTypes.isEmpty ||
        _selectedTypeIndex >= filteredCompanyTypes.length) {
      return [];
    }

    final selectedAttributeId = filteredCompanyTypes[_selectedTypeIndex].id;

    // Get all products for the selected attribute
    final attributeProducts = shopController.shopList!.where((product) {
      return product.attributes != null &&
          product.attributes!.isNotEmpty &&
          product.attributes!.any((attr) => attr.id == selectedAttributeId);
    }).toList();

    // Get brand IDs from these products
    final brandIds = attributeProducts.expand((product) {
      return product.brands?.map((brand) => brand.id) ?? <int>[];
    }).toSet();

    // Filter brands to only those that appear in the attribute's products
    return [BrandModel(name: 'all'.tr, id: 0)] +
        shopController.brandList!.where((brand) {
          return brandIds.contains(brand.id);
        }).toList();
  }

  List<AttributeModel> _getFilteredCompanyTypes(ShopController shopController) {
    if (shopController.shopList == null ||
        shopController.attributeList == null) {
      return [];
    }

    // Get all unique company type IDs from products
    final companyTypeIds = <int>{};
    for (final product in shopController.shopList!) {
      if (product.attributes != null) {
        for (final attribute in product.attributes!) {
          companyTypeIds.add(attribute.id);
        }
      }
    }

    // Filter attributes that exist in products
    final availableAttributes = shopController.attributeList!
        .where((companyType) => companyTypeIds.contains(companyType.id))
        .toList();

    // Define the preferred order of attribute names
    const preferredOrder = [
      'Stationery',
      'Text Books',
      'Dormitory Essentials',
      'Gadgets'
    ];

    // Separate attributes into preferred and others
    final preferredAttributes = <AttributeModel>[];
    final otherAttributes = <AttributeModel>[];

    for (final attribute in availableAttributes) {
      if (preferredOrder.contains(attribute.name)) {
        preferredAttributes.add(attribute);
      } else {
        otherAttributes.add(attribute);
      }
    }

    // Sort preferred attributes according to our preferred order
    preferredAttributes.sort((a, b) {
      return preferredOrder
          .indexOf(a.name)
          .compareTo(preferredOrder.indexOf(b.name));
    });

    // Combine them (preferred first, then others)
    return [...preferredAttributes, ...otherAttributes];
  }

Widget _buildProductView(ShopController shopController) {
  if (shopController.shopList == null ||
      shopController.categoryList == null) {
    return const Center(child: CircularProgressIndicator());
  }

  List<Product> filteredProducts = shopController.shopList!;

  // Apply attribute filter if an attribute is selected
  final filteredCompanyTypes = _getFilteredCompanyTypes(shopController);
  if (_selectedTypeIndex >= 0 &&
      _selectedTypeIndex < filteredCompanyTypes.length) {
    final selectedAttributeId = filteredCompanyTypes[_selectedTypeIndex].id;
    filteredProducts = filteredProducts.where((product) {
      return product.attributes != null &&
          product.attributes!.isNotEmpty &&
          product.attributes!.any((attr) => attr.id == selectedAttributeId);
    }).toList();
  }

  // Apply category filter only if a specific category is selected (not "All")
  if (_selectedCategoryIndex > 0) {
    final filteredCategories = _getFilteredCategories(shopController);
    if (_selectedCategoryIndex < filteredCategories.length) {
      final selectedCategoryId =
          filteredCategories[_selectedCategoryIndex].id;
      filteredProducts = filteredProducts.where((product) {
        return product.categories != null &&
            product.categories!.isNotEmpty &&
            product.categories!
                .any((category) => category.id == selectedCategoryId);
      }).toList();
    }
  }

  // Apply brand filter if a brand is selected
  if (_selectedCompanyIndex > 0) {
    final filteredBrands = _getFilteredBrands(shopController);
    if (_selectedCompanyIndex < filteredBrands.length) {
      final selectedBrandId = filteredBrands[_selectedCompanyIndex].id;
      filteredProducts = filteredProducts.where((product) {
        return product.brands != null &&
            product.brands!.isNotEmpty &&
            product.brands!.any((brand) => brand.id == selectedBrandId);
      }).toList();
    }
  }

  // Apply search filter if there's a query
  if (_searchQuery.isNotEmpty) {
    filteredProducts = _filterProductsBySearch(filteredProducts, _searchQuery);
  }

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

// Widget _buildProductView(ShopController shopController) {
//   // Check if data exists
//   if (shopController.brandList == null ||
//       shopController.categoryList == null ||
//       shopController.shopList == null) {
//     return const Center(child: CircularProgressIndicator());
//   }

//   List<Product> filteredProducts = shopController.shopList!;

//   // Apply brand filter if a specific brand is selected (index > 0)
//   if (_selectedCompanyIndex > 0) {
//     final brandId = shopController.brandList![_selectedCompanyIndex - 1].id;
//     filteredProducts = _filterProductsByBrand(filteredProducts, brandId);
//     print('0000000000000000000000000 $brandId');
//   }

//   // Apply category filter if a specific category is selected (index > 0)
//   if (_selectedCategoryIndex > 0) {
//     final categoryId = shopController.categoryList![_selectedCategoryIndex - 1].id;
//     filteredProducts = _filterProductsByCategory(filteredProducts, categoryId);
//   }

//   // Apply search filter
//   if (_searchQuery.isNotEmpty) {
//     filteredProducts = filteredProducts.where((product) =>
//       product.name!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
//   }

//   if (filteredProducts.isEmpty) {
//     return Center(child: Text('no_products_found'.tr));
//   }

//   return _isGridView
//       ? ProductGrid(
//           products: filteredProducts,
//           onAddToCart: _addToCart,
//           cart: _cart,
//         )
//       : ProductList(
//           products: filteredProducts,
//           onAddToCart: _addToCart,
//           cart: _cart,
//         );
// }
}
