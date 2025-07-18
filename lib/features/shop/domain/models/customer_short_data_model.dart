class CustomerShortDataModel {
  String? id;
    String? name;
    String? email;
    String? phone;
    String? firstName;
    String? lastName;

    CustomerShortDataModel({this.id,this.name, this.email, this.phone, this.firstName, this.lastName});

    CustomerShortDataModel.fromJson(Map<String, dynamic> json) {
        id =json['id'];
        name = json['name'];
        email = json['email'];
        phone = json['phone'];
        firstName = json['first_name'];
        lastName=json['last_name'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, String?> data = <String, String?>{};
        data['id']=id.toString();
        data['name'] = name;
        data['email'] = email;
        data['phone'] = phone;
        data['first_name'] = firstName;
        data['last_name']=lastName;
        return data;
    }
}
