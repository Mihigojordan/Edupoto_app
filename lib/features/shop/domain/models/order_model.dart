class OrderModel {
  final int id;
  final String status;
  final String currency;
  final bool pricesIncludeTax;
  final String dateCreated;
  final String dateModified;
  final String discountTotal;
  final String discountTax;
  final String shippingTotal;
  final String shippingTax;
  final String total;
  final String totalTax;
  final String cartTax;
  final int customerId;
  final String orderKey;
  final BillingInfo billing;
  final ShippingInfo shipping;
  final String paymentMethod;
  final String paymentMethodTitle;
  final String transactionId;
  final String customerNote;
  final String? dateCompleted;
  final String? datePaid;
  final String cartHash;
  final String number;
  final List<LineItem> lineItems;

  OrderModel({
    required this.id,
    required this.status,
    required this.currency,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.total,
    required this.totalTax,
    required this.cartTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerNote,
    this.dateCompleted,
    this.datePaid,
    required this.cartHash,
    required this.number,
    required this.lineItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      currency: json['currency'] ?? '',
      pricesIncludeTax: json['prices_include_tax'] ?? false,
      dateCreated: json['date_created'] ?? '',
      dateModified: json['date_modified'] ?? '',
      discountTotal: json['discount_total'] ?? '0',
      discountTax: json['discount_tax'] ?? '0',
      shippingTotal: json['shipping_total'] ?? '0',
      shippingTax: json['shipping_tax'] ?? '0',
      total: json['total'] ?? '0',
      totalTax: json['total_tax'] ?? '0',
      cartTax: json['cart_tax'] ?? '0',
      customerId: json['customer_id'] ?? 0,
      orderKey: json['order_key'] ?? '',
      billing: BillingInfo.fromJson(json['billing'] ?? {}),
      shipping: ShippingInfo.fromJson(json['shipping'] ?? {}),
      paymentMethod: json['payment_method'] ?? '',
      paymentMethodTitle: json['payment_method_title'] ?? '',
      transactionId: json['transaction_id'] ?? '',
      customerNote: json['customer_note'] ?? '',
      dateCompleted: json['date_completed'],
      datePaid: json['date_paid'],
      cartHash: json['cart_hash'] ?? '',
      number: json['number'] ?? '',
      lineItems: (json['line_items'] as List<dynamic>?)
          ?.map((item) => LineItem.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'currency': currency,
      'prices_include_tax': pricesIncludeTax,
      'date_created': dateCreated,
      'date_modified': dateModified,
      'discount_total': discountTotal,
      'discount_tax': discountTax,
      'shipping_total': shippingTotal,
      'shipping_tax': shippingTax,
      'total': total,
      'total_tax': totalTax,
      'cart_tax': cartTax,
      'customer_id': customerId,
      'order_key': orderKey,
      'billing': billing.toJson(),
      'shipping': shipping.toJson(),
      'payment_method': paymentMethod,
      'payment_method_title': paymentMethodTitle,
      'transaction_id': transactionId,
      'customer_note': customerNote,
      'date_completed': dateCompleted,
      'date_paid': datePaid,
      'cart_hash': cartHash,
      'number': number,
      'line_items': lineItems.map((item) => item.toJson()).toList(),
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
  final String state;
  final String postcode;
  final String country;
  final String email;
  final String phone;

  BillingInfo({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
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
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
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
      'state': state,
      'postcode': postcode,
      'country': country,
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
  final String state;
  final String postcode;
  final String country;
  final String phone;

  ShippingInfo({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
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
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
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
      'state': state,
      'postcode': postcode,
      'country': country,
      'phone': phone,
    };
  }
}

class LineItem {
  final int id;
  final String name;
  final int productId;
  final int variationId;
  final int quantity;
  final String taxClass;
  final String subtotal;
  final String subtotalTax;
  final String total;
  final String totalTax;
  final List<dynamic> taxes;
  final List<dynamic> metaData;
  final String sku;
  final int price;
  final ProductImage image;
  final dynamic parentName;

  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.sku,
    required this.price,
    required this.image,
    this.parentName,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      productId: json['product_id'] ?? 0,
      variationId: json['variation_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      taxClass: json['tax_class'] ?? '',
      subtotal: json['subtotal'] ?? '0',
      subtotalTax: json['subtotal_tax'] ?? '0',
      total: json['total'] ?? '0',
      totalTax: json['total_tax'] ?? '0',
      taxes: json['taxes'] ?? [],
      metaData: json['meta_data'] ?? [],
      sku: json['sku'] ?? '',
      price: json['price'] ?? 0,
      image: ProductImage.fromJson(json['image'] ?? {}),
      parentName: json['parent_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'product_id': productId,
      'variation_id': variationId,
      'quantity': quantity,
      'tax_class': taxClass,
      'subtotal': subtotal,
      'subtotal_tax': subtotalTax,
      'total': total,
      'total_tax': totalTax,
      'taxes': taxes,
      'meta_data': metaData,
      'sku': sku,
      'price': price,
      'image': image.toJson(),
      'parent_name': parentName,
    };
  }
}

class ProductImage {
  final String id;
  final String src;

  ProductImage({
    required this.id,
    required this.src,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: (json['id'] ?? '').toString(),
      src: json['src'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
    };
  }
}