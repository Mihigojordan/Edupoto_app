import 'package:hosomobile/common/models/balance_model.dart';

class TransactionDataModel {
  TransactionDataModel({
    this.fromUserId,
    this.toUserId,
    this.userId,
    this.type,
    this.transactionType,
    this.refTransId,
    this.amount,
  });

  int? fromUserId;
  int? toUserId;
  int? userId;
  String? type;
  String? transactionType;
  String? refTransId;
  double? amount;

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) => TransactionDataModel(
    fromUserId: json["from_user_id"],
    toUserId: json["to_user_id"],
    userId: json["user_id"],
    type: json["type"],
    transactionType: json["transaction_type"],
    refTransId: json["ref_trans_id"],
    amount: json["amount"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "from_user_id": fromUserId,
    "to_user_id": toUserId,
    "user_id": userId,
    "type": type,
    "transaction_type": transactionType,
    "ref_trans_id": refTransId,
    "amount": amount,
  };
}

class EMoneyModel {
  EMoneyModel({
    this.balance,
    this.transactionData,
  });

  BalanceModel? balance;
  TransactionDataModel? transactionData;

  factory EMoneyModel.fromJson(Map<String, dynamic> json) => EMoneyModel(
    balance: BalanceModel.fromJson(json["balance"]),
    transactionData: TransactionDataModel.fromJson(json["transaction_data"]),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance?.toJson(),
    "transaction_data": transactionData?.toJson(),
  };
}
