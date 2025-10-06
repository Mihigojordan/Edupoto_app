
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class TransactionRepo {
  final ApiClient apiClient;
   MtnMomoApiClient? mtnMomoApiClient;

  final SharedPreferences sharedPreferences;

  TransactionRepo({required this.apiClient, required this.sharedPreferences, this.mtnMomoApiClient});


  Future<Response>  getPurposeListApi() async {
    return await apiClient.getData(AppConstants.customerPurposeUrl );
  }

  Future<Response>  sendMoneyApi({required String? phoneNumber, required double amount,required String? purpose,required String? pin }) async {
    return await apiClient.postData(AppConstants.customerSendMoney,{'phone': phoneNumber, 'amount': amount, 'purpose':purpose, 'pin': pin});
  }

<<<<<<< HEAD
=======
  Future<Response> babyeyiApi({
  required int userId,
  required double price,
  required double totalAmount,
  required int productId,
  required String productType,
  required double balance,
  required double charge,
  required String phoneNumber,
  required String currency,
  required String paymentMethod,
  required String paymentProvider,
  String? purpose,
  String? pin,
}) async {
   return await apiClient.postData(AppConstants.babyeyiTransaction,{
      'user_id': userId,
      'price': price,
      'total_amount': totalAmount,
      'product_id': productId,
      'product_type': productType,
      'balance': balance,
      'charge': charge,
      'payer_number': phoneNumber,
      'currency': currency,
      'payment_method': paymentMethod,
      'payment_provider': paymentProvider,
    });

}

>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
   Future<Response>  makePaymentApi({ required List<SchoolLists> product_list, required payment_media,required payment_method,required payment_phone, required parent_id,  required String product_name, List<EduboxMaterialModel>? sv_product_list, required int? studentId, required double amount,required double? totalAmount,required double charge,required int productId,required int productType,required String phoneNumber,required double balance,required String destination,required String shipper,required String homePhone }) async {
    return await apiClient.postData(AppConstants.paymentHistory,{'payment_media':payment_media,'payment_method':payment_method,'payment_phone':payment_phone, 'parent_id':parent_id, 'student_id': studentId, 'amount': amount, 'total_amount':totalAmount, 'charge': charge, 'product_id':productId,'product_type':productType,'phone_number':phoneNumber,'balance':balance,'home_phone':homePhone,'destination':destination,'shipper':shipper, 'product_name':product_name,'product_list':sv_product_list==[]?product_list:sv_product_list });
  }

  Future<Response>  requestMoneyApi({required String? phoneNumber, required double amount}) async {
    return await apiClient.postData(AppConstants.customerRequestMoney,  {'phone' : phoneNumber, 'amount' : amount});
  }
  Future<Response>  cashOutApi({required String? phoneNumber, required double amount, required String? pin}) async {
    return await apiClient.postData(AppConstants.customerCashOut, {'phone' : phoneNumber, 'amount' : amount, 'pin' : pin});
  }


  // Future<Response>  checkCustomerNumber({required String phoneNumber}) async {
  //   return await apiClient.postData(AppConstants.checkCustomerUri, {'phone' : phoneNumber});
  // }
  // Future<Response>  checkAgentNumber({required String phoneNumber}) async {
  //   return await apiClient.postData(AppConstants.checkAgentUri, {'phone' : phoneNumber});
  // }


  // List<ContactModel>? getRecentList({required String? type})  {
  //   String? recent = '';
  //   String key = type == AppConstants.sendMoney ?
  //     AppConstants.sendMoneySuggestList : type == AppConstants.cashOut ?
  //     AppConstants.recentAgentList : AppConstants.requestMoneySuggestList;
  //
  //   if(sharedPreferences.containsKey(key)){
  //     try {
  //       recent =  sharedPreferences.get(key) as String?;
  //     }catch(error) {
  //       recent = '';
  //     }
  //   }
  //
  //   if(recent != null && recent != '' && recent != 'null'){
  //     return  contactModelFromJson(utf8.decode(base64Url.decode(recent.replaceAll(' ', '+'))));
  //   }
  //
  //   return null;
  //
  // }
  //
  // void addToSuggestList(List<ContactModel> contactModelList,{required String type}) async {
  //   String suggests = base64Url.encode(utf8.encode(contactModelToJson(contactModelList)));
  //
  //   if(type == 'send_money') {
  //    await sharedPreferences.setString(AppConstants.sendMoneySuggestList, suggests);
  //
  //   } else if(type == 'request_money'){
  //    await sharedPreferences.setString(AppConstants.requestMoneySuggestList, suggests);
  //
  //   } else if(type == "cash_out"){
  //    await sharedPreferences.setString(AppConstants.recentAgentList, suggests);
  //
  //   }
  // }

  Future<Response> getWithdrawMethods() async {
    return await apiClient.getData(AppConstants.withdrawMethodList);
  }

  Future<Response>  withdrawRequest({required Map<String, String?>? placeBody}) async {
    return await apiClient.postData(AppConstants.withdrawRequest, placeBody);
  }




}