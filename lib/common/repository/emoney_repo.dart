import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class EMoneyRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  EMoneyRepo({required this.apiClient, required this.sharedPreferences});

  /// Create a new e-money transaction
  Future<Response> createTransaction(Map<String, String> transactionData) async {
    return await apiClient.postData(AppConstants.customerAddEMoney, transactionData);
  }

  /// Fetch the user's balance
  Future<Response> fetchBalance(int userId) async {
    return await apiClient.getData("${AppConstants.customerEMoney}/$userId");
  }

  /// Update the user's balance
  // Future<Response> updateBalance(Map<String, String> balanceData) async {
  //   return await apiClient.postData(AppConstants.EMONEY_UPDATE_BALANCE_URI, balanceData);
  // }

  /// Save the latest balance to shared preferences
  // Future<void> saveBalance(BalanceModel balance) async {
  //   try {
  //     await sharedPreferences.setString(AppConstants.EMONEY_BALANCE_KEY, jsonEncode(balance.toJson()));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  /// Retrieve the balance from shared preferences
  // BalanceModel? getBalance() {
  //   String? balanceString = sharedPreferences.getString(AppConstants.EMONEY_BALANCE_KEY);
  //   if (balanceString != null && balanceString.isNotEmpty) {
  //     return BalanceModel.fromJson(jsonDecode(balanceString));
  //   }
  //   return null;
  // }

  /// Remove the balance from shared preferences
  // void removeBalance() => sharedPreferences.remove(AppConstants.EMONEY_BALANCE_KEY);

  /// Handle API errors (common utility)
  void checkApi(Response response) {
    if (response.statusCode != 200) {
      debugPrint('API Error: ${response.statusText}');
      // Additional error handling can be added here
    }
  }

  /// Fetch user's transaction history
  // Future<Response> fetchTransactionHistory(int userId) async {
  //   return await apiClient.getData("${AppConstants.EMONEY_TRANSACTION_HISTORY_URI}/$userId");
  // }

  // /// Fetch a specific transaction by ID
  // Future<Response> fetchTransactionById(int transactionId) async {
  //   return await apiClient.getData("${AppConstants.EMONEY_TRANSACTION_URI}/$transactionId");
  // }
}
