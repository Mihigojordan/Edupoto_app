
import 'dart:async';
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/camera_verification/controllers/camera_screen_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/verification/controllers/verification_controller.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/common/models/signup_body_model.dart';
import 'package:hosomobile/common/models/response_model.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/auth/domain/reposotories/auth_repo.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _biometric = authRepo.isBiometricEnabled();
    checkBiometricSupport();
  }

    bool _isLoading = false;
    bool _isVerifying = false;
    bool _biometric = true;
    bool _isBiometricSupported = false;
    List<BiometricType> _bioList = [];
    List<BiometricType> get bioList => _bioList;

    bool get isLoading => _isLoading;
    bool get isVerifying => _isVerifying;
    bool get biometric => _biometric;
    bool get isBiometricSupported => _isBiometricSupported;




    Future<void> _callSetting() async {
      final LocalAuthentication bioAuth = LocalAuthentication();
      _bioList = await bioAuth.getAvailableBiometrics();
      if(_bioList.isEmpty){
        try{
          AppSettings.openAppSettings(type: AppSettingsType.lockAndPassword);
        }catch(e){
          debugPrint('error ===> $e');
        }
      }
    }

    Future<void> updatePin(String pin) async {
      await authRepo.writeSecureData(AppConstants.biometricPin, pin);
    }

    bool setBiometric(bool isActive) {
      _callSetting().then((value) {
        _callSetting();
      });

      final String? pin = Get.find<BottomSliderController>().pin;
      Get.find<ProfileController>().pinVerify(getPin: pin, isUpdateTwoFactor: false).then((response) async {
        if(response.statusCode == 200 && response.body != null) {
          _biometric = isActive;
          authRepo.setBiometric(isActive && _bioList.isNotEmpty);
          try{
            await authRepo.writeSecureData(AppConstants.biometricPin, pin);
          }catch(error) {
            debugPrint('error ===> $error');
          }
          Get.back(closeOverlays: true);
          update();
        }
      });

    return _biometric;
  }


  Future<String> biometricPin() async {
      return await  authRepo.readSecureData(AppConstants.biometricPin);
  }

  Future<void> removeBiometricPin() async {
    return await  authRepo.deleteSecureData(AppConstants.biometricPin);
  }

  void checkBiometricWithPin() async {
    if(_biometric && (await biometricPin() == ''))  {
      authRepo.setBiometric(false).then((value) => _biometric = authRepo.isBiometricEnabled());
    }
  }

  Future<void> authenticateWithBiometric(bool autoLogin, String? pin) async {
    final LocalAuthentication bioAuth = LocalAuthentication();
    _bioList = await bioAuth.getAvailableBiometrics();
    if((await bioAuth.canCheckBiometrics || await bioAuth.isDeviceSupported()) && authRepo.isBiometricEnabled()) {
      final List<BiometricType> availableBiometrics = await bioAuth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty && (!autoLogin || await biometricPin() != '')) {
        try {
          final bool didAuthenticate = await bioAuth.authenticate(
            localizedReason: autoLogin ? 'please_authenticate_to_login'.tr : 'please_authenticate_to_easy_access_for_next_time'.tr,
            options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
          );
          if(didAuthenticate) {
            if(autoLogin) {
             login(code: getUserData()?.countryCode, phone: getUserData()?.phone, password: await biometricPin());
            }else{
              authRepo.writeSecureData(AppConstants.biometricPin, pin);
            }
          }else{
            if(pin != null) {
              authRepo.setBiometric(false);
            }
          }
        } catch(e) {
          bioAuth.stopAuthentication();
        }
      }
    }
  }

  void checkBiometricSupport() async {
    final LocalAuthentication bioAuth = LocalAuthentication();
    _isBiometricSupported = await bioAuth.canCheckBiometrics || await bioAuth.isDeviceSupported();
  }

  Future<Response> checkPhone(String phone) async{
      _isLoading = true;
      update();
      Response response = await authRepo.checkPhoneNumber(phoneNumber: phone);
   print('yet to be done for configuration$phone++++++++++++|${response.body}');
      if(response.statusCode == 200){
         print('ready for configuration++++++++++++|${response.body}');
        if(!Get.find<SplashController>().configModel!.phoneVerification!) {
           print('verification++++++++++++|${response.body}');
          // requestCameraPermission(fromEditProfile: false);
           Get.toNamed(RouteHelper.getOtherInformationRoute());
        }else if(response.body['otp'] == "active"){
         Get.find<VerificationController>().startTimer();
         Get.toNamed(RouteHelper.getVerifyRoute());
        }else{
          showCustomSnackBarHelper(response.body['message']);
        }

      }
      else if(response.statusCode == 403 && response.body['user_type'] == 'customer'){

        PhoneNumber phoneNumber = PhoneNumber.parse(phone);
        String numberWithCountryCode = phoneNumber.international;

        String? countryCode = phoneNumber.countryCode;
        String? nationalNumber = numberWithCountryCode.replaceAll(countryCode, '');
              print('We have completed the registration: $nationalNumber++++++++++++${response.body}');
        authRepo.setBiometric(false);
        Get.offNamed(RouteHelper.getLoginRoute(countryCode: countryCode,phoneNumber: nationalNumber));

      }
      else{
        ApiChecker.checkApi(response);
      
      }
      _isLoading = false;
      update();
      return response;
    }


  Future<void> requestCameraPermission({required bool fromEditProfile}) async {
    var serviceStatus = await Permission.camera.status;

    if(serviceStatus.isGranted && GetPlatform.isAndroid){
      // Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: fromEditProfile));
 Get.toNamed(RouteHelper.getOtherInformationRoute());
    }else{
      if(GetPlatform.isIOS){
        // Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: fromEditProfile));
         Get.toNamed(RouteHelper.getOtherInformationRoute());
      }else{
        final status = await Permission.camera.request();
        if (status == PermissionStatus.granted) {
          // Get.offNamed(RouteHelper.getSelfieRoute(fromEditProfile: fromEditProfile));
           Get.toNamed(RouteHelper.getOtherInformationRoute());
        } else if (status == PermissionStatus.denied) {
          Get.find<CameraScreenController>().showDeniedDialog(fromEditProfile: fromEditProfile);
        } else if (status == PermissionStatus.permanentlyDenied) {
          Get.find<CameraScreenController>().showPermanentlyDeniedDialog(fromEditProfile: fromEditProfile);
        }
      }

    }
  }

    //Phone Number verification
  Future<ResponseModel> phoneVerify(String phoneNumber,String otp) async{
    _isLoading = true;
    update();
    Response response = await authRepo.verifyPhoneNumber(phoneNumber: phoneNumber, otp: otp);

    ResponseModel responseModel;
    if(response.statusCode == 200){
      responseModel = ResponseModel(true, response.body["message"]);
      Get.find<VerificationController>().cancelTimer();
      showCustomSnackBarHelper(responseModel.message, isError: false);
      // requestCameraPermission(fromEditProfile: false);
       Get.toNamed(RouteHelper.getOtherInformationRoute());
    }
    else{
      responseModel = ResponseModel(false, response.body['errors'][0]['message']);
      showCustomSnackBarHelper(
          responseModel.message,
          isError: true);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  // registration ..
  Future<Response> registration(SignUpBodyModel signUpBody,List<MultipartBody> multipartBody) async{
      _isLoading = true;
      update();

      Map<String, String> allCustomerInfo = {
        'f_name': signUpBody.fName ?? '',
        'l_name': signUpBody.lName ?? '',
        'phone': signUpBody.phone!,
        'dial_country_code': signUpBody.dialCountryCode!,
        'password': signUpBody.password!,
        'gender': signUpBody.gender!,
        'occupation': signUpBody.occupation ?? '',
      };
      if(signUpBody.otp != null) {
        allCustomerInfo.addAll({'otp': signUpBody.otp!});
      }
      if(signUpBody.email != '') {
        allCustomerInfo.addAll({'email': signUpBody.email!});
      }

      Response response = await authRepo.registration(allCustomerInfo, multipartBody);

      if (response.statusCode == 200) {
        Get.find<CameraScreenController>().removeImage();

        await setUserData(UserShortDataModel(
          countryCode: signUpBody.dialCountryCode,
          phone: signUpBody.phone,
          name: '${signUpBody.fName} ${signUpBody.lName}'
        ));

        // Get.offAllNamed(RouteHelper.getWelcomeRoute(
        //   countryCode: signUpBody.dialCountryCode,phoneNumber: signUpBody.phone,
        //   password: signUpBody.password,
        // ));
    // ************************ remove the delay after registration******************
            Get.offAllNamed(RouteHelper.getRestart());
       //Set Parent Id for the child
        authRepo.setUserId(response.body['id'].toString());

      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
      return response;
  }


Future<Response>  login({String? code, String? phone, String? password}) async {
  _isLoading = true;
  update();

  try {
    print('Attempting login with phone: $phone | $password | $code');
    Response response = await authRepo.login(phone: phone, password: password, dialCode: code);
    
    print('Raw API response: ${response.body}');
  

    final responseBody = response.body;

    // Check status code and response code
    if (response.statusCode == 200 && 
        responseBody['response_code'] == 'auth_login_200') {
      
      // Safely access content
      if (responseBody['content'] != null) {
        await authRepo.saveUserToken(responseBody['content']);
        // await authRepo.updateToken();

        // Navigate only if not already there
        if (Get.currentRoute != RouteHelper.navbar) {
          Get.offAllNamed(
            RouteHelper.getNavBarRoute(destination: 'home'), 
            arguments: true
          );
        }

        // Safely get user ID
        if (responseBody['id'] != null) {
          authRepo.setUserId(responseBody['id'].toString());
        }
      } else {
         showCustomSnackBarHelper('Content is null in successful response 2: ${response.body}',
          isError: true);
        throw Exception('Content is null in successful response');
      }
    } else {
      // Handle API error
       showCustomSnackBarHelper('Unknown error occurred 3: ${response.body}',
          isError: true);
      final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }

    return  Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: 'Login successful'
    );
    
  } on FormatException catch (e) {
    print('Format Exception: $e');
    showCustomSnackBarHelper('Unknown error occurred 3: $e',
          isError: true);
    return Response(
      statusCode: 500,
      statusText: 'Invalid response format from server'
    );
  } on Exception catch (e) {
    print('Login Exception: $e');
     showCustomSnackBarHelper('Login Exception4: $e',
          isError: true);
    return Response(
      statusCode: 500,
      statusText: e.toString()
    );
  } finally {
    _isLoading = false;
    update();
  }
}



  Future removeUser() async {

    _isLoading = true;
    update();
    Get.back();
    Response response = await authRepo.deleteUser();

    if (response.statusCode == 200) {
      Get.find<SplashController>().removeSharedData();
      showCustomSnackBarHelper('your_account_remove_successfully'.tr);
      Get.offAllNamed(RouteHelper.getSplashRoute());
    }else{
      Get.back();
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }


  Future<Response> checkOtp()async{
      _isLoading = true;
      update();
      Response  response = await authRepo.checkOtpApi();
      if(response.statusCode == 200){
        _isLoading = false;
      }else{
        _isLoading = false;
        ApiChecker.checkApi(response);
      }
      update();
      return response;
  }

  Future<Response> verifyOtp(String otp)async{
    _isVerifying = true;
    update();
    Response  response = await authRepo.verifyOtpApi(otp: otp);
    if(response.statusCode == 200){
      _isVerifying = false;
      Get.back();
    }else{
      Get.back();
      ApiChecker.checkApi(response);
      _isVerifying = false;
    }
    _isVerifying = false;
    update();
    return response;
  }


  Future<Response> logout() async {
    _isLoading = true;
    update();
    Response response = await authRepo.logout();
    if (response.statusCode == 200) {

      Get.offAllNamed(RouteHelper.getSplashRoute());
      _isLoading = false;
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<ResponseModel?> otpForForgetPass(String phoneNumber) async{
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassOtp(phoneNumber: phoneNumber);
    ResponseModel? responseModel;

    if(response.statusCode == 200){
      _isLoading = false;
      Get.toNamed(RouteHelper.getVerifyRoute(phoneNumber: phoneNumber));
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);

    }
    update();
    return responseModel;
  }

  Future<Response> verificationForForgetPass(String? phoneNumber, String otp) async{
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassVerification(phoneNumber: phoneNumber,otp: otp);

    if(response.statusCode == 200){
      _isLoading = false;
      Get.offNamed(RouteHelper.getFResetPassRoute(phoneNumber: phoneNumber, otp: otp));
    }
    else{
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }


  String? getAuthToken() {
    return authRepo.getUserToken();
  }


  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  void removeCustomerToken() {
    authRepo.removeCustomerToken();
  }



  Future setUserData(UserShortDataModel userData) async {
    await authRepo.setUserData(userData);
  }
  UserShortDataModel? getUserData(){
    UserShortDataModel? userData;
    if(authRepo.getUserData() != '') {
      userData = UserShortDataModel.fromJson(jsonDecode(authRepo.getUserData()));
    }
    return userData;
  }

  void removeUserData()=>  authRepo.removeUserData();

  
  Future setUserId(String userId) async {
    await authRepo.setUserId(userId);
  }
 String? getUserId(){
    String? userId;
    if(authRepo.getUserId() != '') {
      userId = authRepo.getUserId();
    }
    return userId;
  }

  void removeUserId()=>  authRepo.removeUserId();
}
