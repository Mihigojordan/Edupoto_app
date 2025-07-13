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

class WoocommerceApiClient {
String consumerKey='ck_95f230563c385db7997787993ee551e5277e8882';
final String consumerSecret= 'cs_a30eba5947a51bd86d24770bd91390c893130ff2';
final String noInternetMessage = 'Connection to API server failed due to internet connection';
 String appBaseUrlWoo = AppConstants.wooBaseUrl;
  String uriProduct = AppConstants.getProduct;
 

   final _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      
    };

Map<String,dynamic>? queryString;
Map<String,dynamic>? queryCategoryString;


WoocommerceApiClient(){
  late String token;
  String? referenceId;
  final int timeoutInSeconds = 30;
  var uuid = const Uuid();
  
 
  String uri = AppConstants.sendMoneyMtnMomo;
  String uritoken = AppConstants.createTokenMtnMomo;
 

  Map<String, String>? _mtnMomoHeader;
  Map<String, String>? _getMtnMomoHeader;
  Map<String, String>? _mtnMomoTokenHeader;
  dynamic body;

queryString = {
  "consumer_key": consumerKey,
  "consumer_secret": consumerSecret,
  "_fields[]":['id','name','price','regular_price','sale_price','short_description','images','categories','brands','attributes'],
"per_page": "100"
};

queryCategoryString = {
  "consumer_key": consumerKey,
  "consumer_secret": consumerSecret,
  "_fields[]":['id','name','parent','desplay','menu_order','count','description','image'],
  "per_page": "100"
};


}

   Response handleResponse(http.Response response, String uri) {
     dynamic body;
     try {
       body = jsonDecode(response.body);
     }catch(e) {
       debugPrint('**** error$body is it captured ---> $e');
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
     debugPrint('====> API Response: this is response [${response0.statusCode}] $uri\n*${response0.body}');
     return response0;
   }

 Future<Response> getData( { Map<String, String>? headers,Map<String, String>? getQueryString}) async {
  try {

        if (!kIsWeb) {
      // Check for VPN on non-web platforms
      if (await ApiChecker.isVpnActive()) {
        return const Response(statusCode: -1, statusText: 'You are using VPN');
      }
    }
    final url = Uri.parse(appBaseUrlWoo+uriProduct).replace(
      queryParameters: queryString
    );

    debugPrint('====> API Call: $url');

    http.Response response = await http.get(
      url,
      headers: headers ?? _mainHeaders,
    );

    return handleResponse(response, uriProduct);
  } catch (e) {
    debugPrint('yyyyyyyyyyyyyyyyyyyyyyyyyyyyError occurred during API call: $e');
    return Response(statusCode: 1, statusText: noInternetMessage);
  }
}

 Future<Response> getProductGroupData(String uri,{ Map<String, String>? headers}) async {
  try {

        if (!kIsWeb) {
      // Check for VPN on non-web platforms
      if (await ApiChecker.isVpnActive()) {
        return const Response(statusCode: -1, statusText: 'You are using VPN');
      }
    }
    final url = Uri.parse(appBaseUrlWoo+uri).replace(
      queryParameters:queryCategoryString
    );

    debugPrint('====> API Call: $url');

    http.Response response = await http.get(
      url,
      headers: headers ?? _mainHeaders,
    );

    return handleResponse(response, uriProduct);
  } catch (e) {
    debugPrint('yyyyyyyyyyyyyyyyyyyyyyyyyyyyError occurred during API call: $e');
    return Response(statusCode: 1, statusText: noInternetMessage);
  }
}

}
