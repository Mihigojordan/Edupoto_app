import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  // Import SharedPreferences
import 'package:hosomobile/util/app_constants.dart';
import 'package:uuid/uuid.dart';

class MtnMomoApiClient {
  late String token;
  String? referenceId;
  final String apiKey = '6e94f304982142d39a774e217b58937b';
  final String userId = '10f59fb6-24cf-4fc3-a260-551ac4dcf576';
  final String subscriptionKey = '8d44cd466d6448b1906705e640997896';
  final int timeoutInSeconds = 30;
  var uuid = const Uuid();
  
  String appBaseUrlMomo = AppConstants.baseUrl;
  String uri = AppConstants.sendMoneyMtnMomo;
  String uritoken = AppConstants.createTokenMtnMomo;
  String uriInfo = AppConstants.getPaymentInfo;

  Map<String, String>? _mtnMomoHeader;
  Map<String, String>? _getMtnMomoHeader;
  Map<String, String>? _mtnMomoTokenHeader;
  dynamic body;

  // Temporary method to save the token using SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiToken', token);  // Save the token with the key 'apiToken'
<<<<<<< HEAD
    print('Token saved: $token');
=======
    // print('Token saved: $token');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
  }

    Future<void> saveReferenceId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('referenceId',id);  // Save the token with the key 'apiToken'
<<<<<<< HEAD
    print('Token saved: $id');
=======
    // print('Token saved: $id');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
  }

      Future<void> saveStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('status',status);  // Save the token with the key 'apiToken'
<<<<<<< HEAD
    print('Token saved: $status');
=======
    // print('Token saved: $status');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
  }

       Future<void> savePaymentStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('payStatus',status);  // Save the token with the key 'apiToken'
<<<<<<< HEAD
    print('Token saved: $status');
=======
    // print('Token saved: $status');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
  }

  // Method to get the token from SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('apiToken');  // Retrieve the token using the key 'apiToken'
    return token;
  }

  // Method to get the reference id from SharedPreferences
  Future<String?> getReferenceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('referenceId');  // Retrieve the token using the key 'apiToken'
    return id;
  }

    // Method to get the status from SharedPreferences
  Future<String?> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? status = prefs.getString('status');  // Retrieve the token using the key 'apiToken'
    return status;
  }

   Future<String?> getPaymentStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? status = prefs.getString('payStatus');  // Retrieve the token using the key 'apiToken'
    return status;
  }

  // Generate Momo Token and store it temporarily
 Future<String?> createMomoToken() async {
  // Define headers
  _mtnMomoTokenHeader = {
    // 'Ocp-Apim-Subscription-Key': subscriptionKey, // Replace with your subscription key
    'Content-Type': 'application/json; charset=UTF-8',
    // 'Authorization': 'Basic ${base64.encode(utf8.encode('$userId:$apiKey'))}',
  };

  try {
    // Send the HTTP POST request to get the token
    final response = await http.get(
      Uri.parse('$appBaseUrlMomo$uritoken'),
      headers: _mtnMomoTokenHeader,
    
    ).timeout(Duration(seconds: timeoutInSeconds));

    // Log the response status
<<<<<<< HEAD
    print('Response status: ${response.statusCode}');
=======
    // print('Response status: ${response.statusCode}');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b

    // Check if the response status is 200 (OK)
    if (response.statusCode == 200) {
      print('Success: The response is 200');

      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the token
      if (jsonResponse.containsKey('access_token')) {
        String token = jsonResponse['access_token'];

        // Save the token temporarily in SharedPreferences
        await saveToken(token);
        return token; // Return the token
      } else {
        print('Error: access_token key not found in response.');
        return null; // Return null if the token key is missing
      }
    } else {
<<<<<<< HEAD
      print('Failed: Response code is not 200. Status code: ${response.statusCode}/${response.body}');
      print('Response body: ${response.body}'); // Log the response body for debugging
=======
      // print('Failed: Response code is not 200. Status code: ${response.statusCode}/${response.body}');
      // print('Response body: ${response.body}'); // Log the response body for debugging
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      return null; // Handle non-200 responses as needed
    }
  } catch (e) {
    // Handle timeout or other errors
    print('Error occurred: $e');
    return null;
  }
}


  // Post Money using Momo API
  Future postMtnMomo({
   
    String? transactionId,
    String? amount,
    String? phoneNumber,
    String? message,
  }) async {
    referenceId = uuid.v4();  // Generate a new reference ID each time

    // Retrieve the token directly from SharedPreferences
    String? token = await getToken();  // Retrieve the stored token

    // Ensure the token is available
    if (token == null) {
      print('Error: Token is required for this operation.');
      return null;  // Return null or handle the error as needed
    }

    await saveReferenceId(referenceId!);

    // Set headers for the request
    _mtnMomoHeader = {
      'referenceId': referenceId!,
      'Authorization': token,
    };

    // Prepare the request body
    body = {
      "token": token,
      "referenceId": referenceId!,
      "externalId": transactionId,
      "amount": amount,
      "payerMessage": message,
      "phoneNumber":phoneNumber
    };

    try {
      // Send the HTTP POST request
      http.Response response = await http.post(
        Uri.parse(appBaseUrlMomo + uri),
        body: body,
        headers: _mtnMomoHeader,
      ).timeout(Duration(seconds: timeoutInSeconds));

<<<<<<< HEAD
      print('Response status: ${response.statusCode}');
=======
      // print('Response status: ${response.statusCode}');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      
      // Check if the response status is 202 (Accepted)
      if (response.statusCode == 202) {
         String status = response.statusCode.toString() ;
<<<<<<< HEAD
        print('Success: The response is 202: $phoneNumber/$referenceId/$message');
        await savePaymentStatus(status);
       
      } else {
        print('Failed: Response code is not $amount. Status code: ${response.body}');
        return null;  // Handle failure as needed
      }
    } catch (e) {
      print('Error occurred: $e');
=======
        // print('Success: The response is 202: $phoneNumber/$referenceId/$message');
        await savePaymentStatus(status);
       
      } else {
        // print('Failed: Response code is not $amount. Status code: ${response.body}');
        return null;  // Handle failure as needed
      }
    } catch (e) {
      // print('Error occurred: $e');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      return null;  // Handle the error and return null or custom message
    }
  }


  Future getMtnMomo() async {
 

  // Retrieve the token directly from SharedPreferences
  String? token = await getToken();  // Retrieve the stored token

  // Ensure the token is available
  if (token == null) {
<<<<<<< HEAD
    print('Error: Token is required for this operation.');
=======
    // print('Error: Token is required for this operation.');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    return null;  // Return null or handle the error as needed
  }

  // Retrieve the reference ID or use the generated one
  String? id = await getReferenceId();  // Assuming `getReferenceId()` is a function that retrieves the reference ID

  // Ensure the reference ID is available
  if (id == null) {
    print('Error: Reference ID is required for this operation.');
    return null;  // Return null or handle the error as needed
  }

  // Prepare the request body
    body = {
      "referenceId": id,
      "token": token,
    };

  try {
    // Send the HTTP GET request (if it's a GET request, otherwise change to POST)
    var response = await http.post(
      Uri.parse(appBaseUrlMomo + uriInfo),  // Ensure this URL is correct
       headers: _mtnMomoHeader,
       body: body,
    );

<<<<<<< HEAD
    print('Response status get mtn: ${response.statusCode}');
=======
    // print('Response status get mtn: ${response.statusCode}');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    
    // Check if the response status is 200 (OK)
    if (response.statusCode == 200) {
      // Assuming the response body is a JSON object
      var jsonResponse = jsonDecode(response.body);

      // Extract the status from the JSON response (adjust the key as per the response structure)
      String status = jsonResponse['status']; 
      await saveStatus(status);
<<<<<<< HEAD
      print('Success: The response status is $status');

      
    } else {
      print('Failed: Response code is not 200. Status code: ${response.statusCode}');
      return null;  // Handle failure as needed
    }
  } catch (e) {
    print('Error occurred: $e');
=======
      // print('Success: The response status is $status');

      
    } else {
      // print('Failed: Response code is not 200. Status code: ${response.statusCode}');
      return null;  // Handle failure as needed
    }
  } catch (e) {
    // print('Error occurred: $e');
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
    return null;  // Handle the error and return null or custom message
  }
}
}
