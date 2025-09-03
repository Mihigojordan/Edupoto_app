class Products {
  final String name;
  final double price;
  final String image;
  final String color; // New property
  final String size;  // New property
  final String type;  // New property

  Products({
    required this.name,
    required this.price,
    required this.image,
    this.color = 'N/A', // Default value
    this.size = 'N/A',  // Default value
    this.type = 'N/A',  // Default value
  });

  // Override equality and hashCode to use Product as a key in the cart Map
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Products &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          image == other.image;

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ image.hashCode;
}