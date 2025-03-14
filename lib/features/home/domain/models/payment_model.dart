class PaymentModel {

  String? name;
  String? balance;
  String? amount;

  PaymentModel(
      {
        this.name,
        this.balance,
        this.amount,});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    balance = json['balance'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['balance'] = balance;
    data['amount'] = amount;
    return data;
  }
}
