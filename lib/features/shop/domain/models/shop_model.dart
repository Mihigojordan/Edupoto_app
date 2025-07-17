import 'package:hosomobile/features/shop/domain/models/attribute_model.dart';
import 'package:hosomobile/features/shop/domain/models/brand_model.dart';
import 'package:hosomobile/features/shop/domain/models/category_model.dart';

class Product {
  int? id;
  String? name;
  List<WooImage>? images; // Use a dedicated class for images
  String? price;
  String? regularPrice; // Assuming 'code' is a custom field (e.g., SKU)
  String? salePrice;
  String? shortDescription;
  List<WooCategory>? categories;
  List<BrandModel>? brands;
  List<AttributeModel>? attributes;

  Product(
      {this.name,
      this.images,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.shortDescription,
      this.categories,
      this.brands,
      this.attributes,
      this.id
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      images: (json['images']
              as List<dynamic>?) // WooCommerce uses 'images' (plural)
          ?.map((image) => WooImage.fromJson(image))
          .toList(),
      price: json['price'],
      regularPrice:
          json['regular_price'], // WooCommerce uses 'sku' for product codes
      salePrice: json['sale_price'],
      shortDescription: json['short_description'],
      categories: (json['categories']
              as List<dynamic>?) // WooCommerce uses 'images' (plural)
          ?.map((category) => WooCategory.fromJson(category))
          .toList(),
      brands: (json['brands']
              as List<dynamic>?) // WooCommerce uses 'images' (plural)
          ?.map((brand) => BrandModel.fromJson(brand))
          .toList(),
      attributes: (json['attributes']
              as List<dynamic>?) // WooCommerce uses 'images' (plural)
          ?.map((brand) => AttributeModel.fromJson(brand))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'images': images?.map((image) => image.toJson()).toList(),
      'price': price,
      'regular_price': regularPrice, // Map back to 'sku' for API compliance
      'sale_price': salePrice,
      'short_description': shortDescription,
      'categories': categories?.map((category) => category.toJson()).toList(),
      'brands': brands?.map((brand) => brand.toJson()).toList(),
      'attributes': attributes?.map((attribute) => attribute.toJson()).toList()
    };
  }
}

// Dedicated class for WooCommerce images
class WooImage {
  String? src;
  String? alt;

  WooImage({this.src, this.alt});

  factory WooImage.fromJson(Map<String, dynamic> json) {
    return WooImage(
      src: json['src'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'src': src,
      'alt': alt,
    };
  }
}
