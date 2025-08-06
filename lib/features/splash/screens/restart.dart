import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/data/api/api_checker.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';

class Restart extends StatefulWidget {
  const Restart({super.key});

  @override
  State<Restart> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Restart> with WidgetsBindingObserver {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isLoading = true;  // New variable to manage loading state
 
  Response<dynamic>? responseResult;

  @override
  void initState() {
    super.initState();
    bool isFirstTime = true;

 if (!kIsWeb) { 
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
     if (await ApiChecker.isVpnActive()) {
        showCustomSnackBarHelper('you are using vpn', isVpn: true, duration: const Duration(minutes: 10));
      } 
      if (isFirstTime) {
        isFirstTime = false;
       _route();
      }
      
    }); }

      _route();
  // html.window.location.reload();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // Function to load PIN from SharedPreferences
Future<String?> _loadPin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_pin');
}

 Future<void> _route() async {
  
  try {
    
    if (!GetPlatform.isWeb) {
      // Step 1: Fetch Contact List
      await Get.find<ContactController>().getContactList();

    } else {
        
      print("Skipping contact list fetch on web.");
    }

    // Step 2: Fetch Config Data
    final response = await Get.find<SplashController>().getConfigData();

  setState(() {
    responseResult=response;
  });
    if (response.isOk) {
      setState(() {
        isLoading = false; // Data is OK, stop loading
      });

      // Step 3: Initialize Shared Data
      try {
        await Get.find<SplashController>().initSharedData();
      } catch (e) {
        print('Error in initSharedData: $e');
      }

      // Step 4: Fetch User Data
      final userData = Get.find<AuthController>().getUserData();
      print('User Data[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]: ${userData!.countryCode}/${userData.phone}');

      // Step 5: Route Navigation
      if (Get.find<SplashController>().configModel?.companyName != null) {
        print('Navigating to Login Route...');
        Get.offNamed(RouteHelper.getLoginRoute(
          countryCode: userData.countryCode,
          phoneNumber: userData.phone,
        ));
      } else {
        print('Navigating to Choose Login/Reg Route...');
        Get.offNamed(RouteHelper.getChoseLoginRegRoute());
      }
   
    } else {
      print('Config Data is not OK.');
      setState(() {
        isLoading = true; // Retry logic
      });
    }
  } catch (e) {
    print('Error during routing: $e');
    setState(() {
      isLoading = true; // Show loader in case of an error
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.launch_page,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
