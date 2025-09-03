
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

class SchoolRequirementModel {
  String? name;
  String? quantity;
  String? price;
  int? termId;
  int? classId;
  int? schoolId;
  PaymentHistoryModel? paymentHistory;

  SchoolRequirementModel(
      {this.name,
      this.quantity,
      this.price,
      this.classId,
      this.schoolId,
      this.termId,
      this.paymentHistory
      });

  SchoolRequirementModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    termId = json['term_id'];
    schoolId = json['school_id'];
    classId = json['class_id'];
     paymentHistory = json['payments'] != null
        ? PaymentHistoryModel.fromJson(json['payments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['term_id'] = termId;
    data['school_id'] = schoolId;
    data['class_id'] = classId;
    return data;
  }
}
class ProductTypeModel {
  String? price;
  String? name;
  String? description;
  List<SchoolRequirementModel>? schoolRequirements;

  ProductTypeModel({
    this.price,
    this.description,
    this.name,
    this.schoolRequirements,
  });

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    description = json['description'];
    if (json['school_requirements'] != null) {
      schoolRequirements = (json['school_requirements'] as List)
          .map((material) => SchoolRequirementModel.fromJson(material))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['name'] = name;
    data['description'] = description;
    if (schoolRequirements != null) {
      data['school_requirements'] =
          schoolRequirements!.map((material) => material.toJson()).toList();
    }
    return data;
  }
}