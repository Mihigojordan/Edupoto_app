import 'package:hosomobile/features/shop/domain/models/company_category.dart';
import 'package:hosomobile/features/shop/domain/models/product.dart';

class Company {
  final String name;
  final String logo;
  final List<CompanyCategory> categories;

  Company({required this.name, required this.logo, required this.categories});
}