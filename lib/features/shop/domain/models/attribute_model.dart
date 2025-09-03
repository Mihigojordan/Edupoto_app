class AttributeModel {
  final int id;
  final String name;


  AttributeModel({
    required this.id,
    required this.name,
   
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    return AttributeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,

    };
  }
}
