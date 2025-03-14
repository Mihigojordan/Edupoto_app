
// Future<Response> createEMoneyTransaction(EMoneyModel eMoneyModel) async {
//   _isLoading = true;
//   update();

//   // Prepare the transaction data
//   Map<String, String> transactionData = {
//     'from_user_id': eMoneyModel.transactionData?.fromUserId.toString() ?? '',
//     'to_user_id': eMoneyModel.transactionData?.toUserId.toString() ?? '',
//     'user_id': eMoneyModel.transactionData?.userId.toString() ?? '',
//     'type': eMoneyModel.transactionData?.type ?? '',
//     'transaction_type': eMoneyModel.transactionData?.transactionType ?? '',
//     'ref_trans_id': eMoneyModel.transactionData?.refTransId ?? '',
//     'amount': eMoneyModel.transactionData?.amount.toString() ?? '',
//   };

//   // Make the API request
//   Response response = await emoneyRepo.createTransaction(transactionData);

//   if (response.statusCode == 200) {
//     // Handle success, such as updating the balance or redirecting to another screen
//     BalanceModel balanceModel = BalanceModel.fromJson(response.body);
//     updateBalance(balanceModel);

//     // Optionally navigate to a success page or show a success message
//     Get.offAllNamed(RouteHelper.getTransactionSuccessRoute());
//   } else {
//     // Handle API error, such as showing an error message
//     ApiChecker.checkApi(response);
//   }

//   _isLoading = false;
//   update();
//   return response;
// }

// Future<Response> updateEMoneyTransaction(int transactionId, EMoneyModel eMoneyModel) async {
//   _isLoading = true;
//   update();

//   // Prepare the transaction data
//   Map<String, String> transactionData = {
//     'from_user_id': eMoneyModel.transactionData?.fromUserId.toString() ?? '',
//     'to_user_id': eMoneyModel.transactionData?.toUserId.toString() ?? '',
//     'user_id': eMoneyModel.transactionData?.userId.toString() ?? '',
//     'type': eMoneyModel.transactionData?.type ?? '',
//     'transaction_type': eMoneyModel.transactionData?.transactionType ?? '',
//     'ref_trans_id': eMoneyModel.transactionData?.refTransId ?? '',
//     'amount': eMoneyModel.transactionData?.amount.toString() ?? '',
//   };

//   // Make the API request to update the transaction
//   Response response = await emoneyRepo.updateTransaction(transactionId, transactionData);

//   if (response.statusCode == 200) {
//     // Handle success, such as updating the balance or redirecting to another screen
//     BalanceModel balanceModel = BalanceModel.fromJson(response.body);
//     updateBalance(balanceModel);

//     // Optionally navigate to a success page or show a success message
//     Get.offAllNamed(RouteHelper.getTransactionSuccessRoute());
//   } else {
//     // Handle API error, such as showing an error message
//     ApiChecker.checkApi(response);
//   }

//   _isLoading = false;
//   update();
//   return response;
// }
