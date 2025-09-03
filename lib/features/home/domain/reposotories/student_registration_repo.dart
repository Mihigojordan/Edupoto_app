
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/util/app_constants.dart';

class StudentRegistrationRepo {
  final ApiClient apiClient;
   MtnMomoApiClient? mtnMomoApiClient;

  final SharedPreferences sharedPreferences;

  StudentRegistrationRepo({required this.apiClient, required this.sharedPreferences, this.mtnMomoApiClient});


  Future<Response>  getPurposeListApi() async {
    return await apiClient.getData(AppConstants.customerPurposeUrl );
  }

  // Future<Response>  sendMoneyApi({required String? phoneNumber, required double amount,required String? purpose,required String? pin }) async {
  //   return await apiClient.postData(AppConstants.customerSendMoney,{'phone': phoneNumber, 'amount': amount, 'purpose':purpose, 'pin': pin});
  // }

  //  Future<Response>  traApi({required String? phoneNumber, required double amount,required String? purpose,required String? pin }) async {
  //   return await apiClient.postData(AppConstants.customerSendMoney,{'phone': phoneNumber, 'amount': amount, 'purpose':purpose, 'pin': pin});
  // }


  //  Future<Response>  makePaymentApi({required int? studentId, required double amount,required double? totalAmount,required double charge,required int productId,required int productType,required String phoneNumber,required double balance }) async {
  //   return await apiClient.postData(AppConstants.paymentHistory,{'student_id': studentId, 'amount': amount, 'total_amount':totalAmount, 'charge': charge, 'product_id':productId,'product_type':productType,'phone_number':phoneNumber,'balance':balance});
  // }

  Future<Response>  requestMoneyApi({required String? phoneNumber, required double amount}) async {
    return await apiClient.postData(AppConstants.customerRequestMoney,  {'phone' : phoneNumber, 'amount' : amount});
  }
  Future<Response>  cashOutApi({required String? phoneNumber, required double amount, required String? pin}) async {
    return await apiClient.postData(AppConstants.customerCashOut, {'phone' : phoneNumber, 'amount' : amount, 'pin' : pin});
  }
 Future<Response>  addStudentApi({ String? name, required String code,required String schoolCode,required String parentId,required int classId})  //,required String gender,required String age,required String hipSize,required String waistSize,required String heightSize,required String topWear,required String bottomWear,required String sportsWear,required String feetWear,required String topSize,required String size}) 
 async {
    return await apiClient.postData(AppConstants.studentRegistration,{'name': name!, 'code': code, 'school_code':schoolCode, 'parent_id': parentId, 'class_id':classId}); //,'gender':gender,'age':age,'hip_size':hipSize,'waist_size':waistSize,'height_size':heightSize,'top_wear':topWear,'bottom_wear':bottomWear,'sports_wear':sportsWear,'feet_wear':feetWear,'top_size':topSize,'size':size});
  }

Future<Response> updateStudentApi({
  required String name,
  required String code,
  required String schoolCode,
  required String parentId,
  required int classId,
  required int id,
  required String gender,
  required String age,
  required String hipSize,
  required String waistSize,
  required String heightSize,
  required String topWear,
  required String bottomWear,
  required String sportsWear,
  required String feetWear,
  required String topSize,
  required String shoeSize,
  required String sportSize,
  required String shoulderSize,
  required String handSize
}) async {
  // Construct request body
  Map<String, dynamic> requestBody = {
    'name': name,
    'code': code,
    'school_code': schoolCode,
    'parent_id': parentId,
    'class_id': classId,
    'id': id,
    'gender': gender,
    'age': age,
    'hip_size': hipSize,
    'waist_size': waistSize,
    'height_size': heightSize,
    'top_wear': topWear,
    'bottom_wear': bottomWear,
    'sports_wear': sportsWear,
    'feet_wear': feetWear,
    'top_size': topSize,
    'shoe_size': shoeSize,
    'sport_size':sportSize,
    'shoulder_size':shoulderSize,
    'hand_size':handSize
  };

  print("🟢 API Request to: ${AppConstants.studentRegistration}");
  print("📩 Request Body: $requestBody");

  Response response = await apiClient.postData(AppConstants.studentRegistration, requestBody);

  print("🔵 API Response: ${response.statusCode} | ${response.body}");

  return response;
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