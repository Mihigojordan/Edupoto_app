import 'package:hosomobile/features/shop/widget/product.dart';

class Company {
  final String name;
  final String logo;
  final List<Product> products;

  Company({required this.name, required this.logo, required this.products});
}