class SchoolModel {
  String? name;
  String? image;
  String? url;
  String? code;

  SchoolModel({this.name, this.image, this.url, this.code});

  SchoolModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    url = json['url'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['url'] = url;
    data['code'] = code;
    return data;
  }
}
