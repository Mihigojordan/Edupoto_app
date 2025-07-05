class WooCategory {
  final int id;
  final String name;
  final String slug;
  final int parent;
  final String description;
  final String display;
  final String? image; // Nullable image
  final int menuOrder;
  final int count;

  WooCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    this.image,
    required this.menuOrder,
    required this.count,
  });

  factory WooCategory.fromJson(Map<String, dynamic> json) {
    return WooCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      parent: json['parent'] ?? 0,
      description: json['description'] ?? '',
      display: json['display'] ?? 'default',
      image: json['image'] ??'',
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
      'image': image,
      'menu_order': menuOrder,
      'count': count,
    };
  }
}

// Model for category image (nullable in responses)
class WooCategoryImage {
  final String? src;
  final String? alt;

  WooCategoryImage({this.src, this.alt});

  factory WooCategoryImage.fromJson(Map<String, dynamic> json) {
    return WooCategoryImage(
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