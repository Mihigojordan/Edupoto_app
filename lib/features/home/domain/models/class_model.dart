class ClassModel {
  int? id; 
  String? name;
  String? image;
  int? capacity;
  String? code;

  ClassModel({this.name,this.id, this.image, this.capacity, this.code});

  ClassModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    name = json['name'];
    image = json['image'];
    capacity = json['capacity'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id']=id;
    data['name'] = name;
    data['image'] = image;
    data['capacity'] = capacity;
    data['code'] = code;
    return data;
  }
}
