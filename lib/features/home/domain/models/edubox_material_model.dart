class PaymentHistoryModel {
  String? balance;

  PaymentHistoryModel({this.balance});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    return data;
  }
}

class EduboxMaterialModel {
  int?id;
  String? name;
  String? image;
  double? price;
  String? description;
  int? quantity;
  int? productType;
  int? eduboxProduct;
  int? remainQuantity;
  int? schoolId;
  int? classId;
  PaymentHistoryModel? paymentHistory;

  EduboxMaterialModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.quantity,
    this.productType,
    this.eduboxProduct,
    this.remainQuantity,
    this.schoolId,
    this.classId,
    this.paymentHistory,
  });

  EduboxMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'] is double ? json['price'] : double.tryParse(json['price']?.toString() ?? '');
    image = json['image'];
    description = json['description'];
    quantity = json['product_type_number'];
    eduboxProduct = json['edubox_product_id'];
    productType = json['product_type'];
    remainQuantity = json['product_remain_number'];
    schoolId = json['school_id'];
    classId = json['class_id'];
    paymentHistory = json['payments'] != null
        ? PaymentHistoryModel.fromJson(json['payments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['product_type_number'] = quantity;
    data['edubox_product_id'] = eduboxProduct;
    data['product_type'] = productType;
    data['product_remain_number'] = remainQuantity;
    data['school_id'] = schoolId;
    data['class_id'] = classId;
    if (paymentHistory != null) {
      data['[payments]'] = paymentHistory!.toJson();
    }
    return data;
  }
}

class ProductTypeModel {
  String? price;
  String? name;
  String? description;
  List<EduboxMaterialModel>? eduboxMaterials;

  ProductTypeModel({
    this.price,
    this.description,
    this.name,
    this.eduboxMaterials,
  });

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    description = json['description'];
    if (json['edubox_materials'] != null) {
      eduboxMaterials = (json['edubox_materials'] as List)
          .map((material) => EduboxMaterialModel.fromJson(material))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    if (eduboxMaterials != null) {
      data['edubox_materials'] =
          eduboxMaterials!.map((material) => material.toJson()).toList();
    }
    return data;
  }
}

class EduboxProductModel {
  int? id;
  String? name;
  String? image;
  String? title_image;
  List<ProductTypeModel>? productTypes;

  EduboxProductModel({this.id, this.name,this.image,this.title_image, this.productTypes});

  EduboxProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image=json['image'];
    title_image=json['title_image'];
    if (json['product_types'] != null) {
      productTypes = (json['product_types'] as List)
          .map((type) => ProductTypeModel.fromJson(type))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image']=image;
    data['title_image']=image;
    if (productTypes != null) {
      data['product_types'] =
          productTypes!.map((type) => type.toJson()).toList();
    }
    return data;
  }
}
