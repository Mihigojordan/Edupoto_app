class BrandModel {
  final int id;
  final String name;
  final String? slug;
  final int? parent;
  final String? description;
  final String? display;
  final ProductGrouImage? image; // Nullable image
  final int? menuOrder;
  final int? count;

  BrandModel({
    required this.id,
    required this.name,
     this.slug,
     this.parent,
     this.description,
     this.display,
    this.image,
   this.menuOrder,
     this.count,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      parent: json['parent'] ?? 0,
      description: json['description'] ?? '',
      display: json['display'] ?? 'default',
      image: json['image'] != null && json['image'] is Map<String, dynamic>
          ? ProductGrouImage.fromJson(json['image'])
          : null,
      menuOrder: json['menu_order'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'parent': parent,
      'description': description,
      'display': display,
      'image': image?.toJson(),
      'menu_order': menuOrder,
      'count': count,
    };
  }
}

// Model for category image (nullable in responses)
class ProductGrouImage {
  final String? src;
  final String? alt;

  ProductGrouImage({this.src, this.alt});

  factory ProductGrouImage.fromJson(Map<String, dynamic> json) {
    return ProductGrouImage(
      src: json['src']?.toString(), // Ensure string conversion
      alt: json['alt']?.toString(), // Ensure string conversion
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'src': src,
      'alt': alt,
    };
  }
}