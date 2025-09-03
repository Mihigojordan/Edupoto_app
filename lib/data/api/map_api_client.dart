import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:hosomobile/common/models/error_model.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  // Import SharedPreferences
import 'package:hosomobile/util/app_constants.dart';
import 'package:uuid/uuid.dart';

class MapApiClient {
String consumerKey='ck_95f230563c385db7997787993ee551e5277e8882';
final String consumerSecret= 'cs_a30eba5947a51bd86d24770bd91390c893130ff2';
final String noInternetMessage = 'Connection to API server failed due to internet connection';
 String appBaseUrl = AppConstants.mapBaseUrl;
  String uriProduct = AppConstants.getProduct;
 
   final _mainHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
 // 'Authorization': 'Basic ${base64Encode(utf8.encode('ck_95f230563c385db7997787993ee551e5277e8882:cs_a30eba5947a51bd86d24770bd91390c893130ff2'))}',
};

Map<String,dynamic>? queryString;
Map<String,dynamic>? queryCategoryString;
Map<String,dynamic>? queryOrderString;
Map<String,dynamic>? queryCustomerString;


MapApiClient(){

queryString = {
  "consumer_key":AppConstants.googlePlacesApiKey,
  "consumer_secret": consumerSecret,
  "_fields[]":['id','name','price','regular_price','sale_price','short_description','images','categories','brands','attributes'],
"per_page": "100"
};

}

   Response handleResponse(http.Response response, String uri) {
     dynamic body;
     try {
       body = jsonDecode(response.body);
     }catch(e) {
       debugPrint('**** error is it captured --->');
     }
     Response response0 = Response(
       body: body ?? response.body, bodyString: response.body.toString(),
       request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
       headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
     );
     if(response0.statusCode != 200 && response0.body != null && response0.body is !String) {
       if(response0.body.toString().startsWith('{errors: [{code:')) {
         ErrorResponseModel errorResponse = ErrorResponseModel.fromJson(response0.body);
         response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.errors![0].message);
       }else if(response0.body.toString().startsWith('{message')) {
         response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
       }
     }else if(response0.statusCode != 200 && response0.body == null) {
       response0 = Response(statusCode: 0, statusText: noInternetMessage);
     }
    //  debugPrint('====> API Response: this is response [${response0.statusCode}] $uri\n*${response0.body}');
     return response0;
   }


 Future<Response> getMapData(String uri,{ Map<String, String>? headers}) async {
  try {

        if (!kIsWeb) {
      // Check for VPN on non-web platforms
      if (await ApiChecker.isVpnActive()) {
        return const Response(statusCode: -1, statusText: 'You are using VPN');
      }
    }
    final url = Uri.parse(appBaseUrl+uri);

    debugPrint('====> API Call: $url');

    http.Response response = await http.get(
      url,
      headers: headers ?? _mainHeaders,
    );

    return handleResponse(response, uriProduct);
  } catch (e) {
    debugPrint('mmmmmmmmmmmmmmmmmmmmmm Error occurred during API call: ');
    return Response(statusCode: 1, statusText: noInternetMessage);
  }
}

}
