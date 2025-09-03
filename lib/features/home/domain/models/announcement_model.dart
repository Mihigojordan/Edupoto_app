class AnnouncementModel {

  String? name;
  String? image;
  String? description;

  AnnouncementModel(
      {
        this.name,
        this.image,
        this.description,});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
