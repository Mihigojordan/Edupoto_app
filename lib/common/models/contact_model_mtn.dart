import 'dart:convert';

List<ContactModelMtn> contactModelFromJson(String str) =>
    List<ContactModelMtn>.from(
        json.decode(str).map((x) => ContactModelMtn.fromJson(x)));

String contactModelToJson(List<ContactModelMtn> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModelMtn {
  ContactModelMtn({
    this.phoneNumber,
    this.name,
    this.avatarImage,
  });

  String? phoneNumber;
  String? name;
  String? avatarImage;

  factory ContactModelMtn.fromJson(Map<String, dynamic> json) =>
      ContactModelMtn(
        phoneNumber: json["phoneNumber"]?.replaceAll('+', ''), // Remove '+' from phone number
        name: json["name"],
        avatarImage: json["avatarImage"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber, // You can modify this to re-add '+' if needed
        "name": name,
        "avatarImage": avatarImage,
      };
}
