import 'package:hosomobile/features/shop/domain/models/product.dart';

class CompanyCategory {
  final String name;
  final String logo;
  final List<Product> products;

  CompanyCategory({required this.name, required this.logo, required this.products});
}