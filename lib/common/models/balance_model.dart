class BalanceModel {
  BalanceModel({
    this.totalBalance,
    this.usedBalance,
    this.unusedBalance,
    this.totalEarned,
  });

  double? totalBalance;
  double? usedBalance;
  double? unusedBalance;
  double? totalEarned;

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    totalBalance: json["total_balance"]?.toDouble() ?? 0.0,
    usedBalance: json["used_balance"]?.toDouble() ?? 0.0,
    unusedBalance: json["unused_balance"]?.toDouble() ?? 0.0,
    totalEarned: json["total_earned"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "total_balance": totalBalance,
    "used_balance": usedBalance,
    "unused_balance": unusedBalance,
    "total_earned": totalEarned,
  };
}
