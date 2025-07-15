class CustomerModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  final bool isPayingCustomer;
  final BillingInfo billing;
  final ShippingInfo shipping;

  CustomerModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.isPayingCustomer,
    required this.billing,
    required this.shipping,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      role: json['role'] ?? 'customer',
      username: json['username'] ?? '',
      isPayingCustomer: json['is_paying_customer'] ?? false,
      billing: BillingInfo.fromJson(json['billing'] ?? {}),
      shipping: ShippingInfo.fromJson(json['shipping'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'username': username,
      'is_paying_customer': isPayingCustomer,
      'billing': billing.toJson(),
      'shipping': shipping.toJson(),
    };
  }
}

class BillingInfo {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String email;
  final String phone;

  BillingInfo({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.email,
    required this.phone,
  });

  factory BillingInfo.fromJson(Map<String, dynamic> json) {
    return BillingInfo(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postcode,
      'country': country,
      'state': state,
      'email': email,
      'phone': phone,
    };
  }
}

class ShippingInfo {
  final String firstName;
  final String lastName;
  final String company;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;
  final String state;
  final String phone;

  ShippingInfo({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.phone,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'postcode': postcode,
      'country': country,
      'state': state,
      'phone': phone,
    };
  }
}