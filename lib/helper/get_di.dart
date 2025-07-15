import 'dart:convert';
import 'dart:io'; 
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hosomobile/common/controllers/share_controller_sl.dart';
import 'package:hosomobile/data/api/woocommerce_api_client.dart';
import 'package:hosomobile/features/forget_pin/domain/reposotories/forget_pin_repo.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/announcement_controller.dart';
import 'package:hosomobile/features/home/controllers/banner_controller.dart';
import 'package:hosomobile/features/auth/controllers/create_account_controller.dart';
import 'package:hosomobile/features/home/controllers/bilboard_controller.dart';
import 'package:hosomobile/features/home/controllers/class_controller.dart';
import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
import 'package:hosomobile/features/home/controllers/school_controller.dart';
import 'package:hosomobile/features/home/controllers/school_requirement_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/reposotories/all_school_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/announcement_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/bilboard_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/class_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/edubox_material_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/payment_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/school_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/school_requirement_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/student_registration_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/student_repo.dart';
import 'package:hosomobile/features/onboarding/controllers/on_boarding_controller.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/repositories/school_list_repo.dart';
import 'package:hosomobile/features/setting/controllers/edit_profile_controller.dart';
import 'package:hosomobile/features/setting/controllers/faq_controller.dart';
import 'package:hosomobile/features/forget_pin/controllers/forget_pin_controller.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/repository/shop_repo.dart';
import 'package:hosomobile/features/transaction_money/controllers/bootom_slider_controller.dart';
import 'package:hosomobile/features/add_money/controllers/add_money_controller.dart';
import 'package:hosomobile/features/kyc_verification/controllers/kyc_verify_controller.dart';
import 'package:hosomobile/features/home/controllers/menu_controller.dart';
import 'package:hosomobile/features/notification/controllers/notification_controller.dart';
import 'package:hosomobile/features/camera_verification/controllers/qr_code_scanner_controller.dart';
import 'package:hosomobile/common/controllers/share_controller.dart';
import 'package:hosomobile/features/requested_money/controllers/requested_money_controller.dart';
import 'package:hosomobile/features/camera_verification/controllers/camera_screen_controller.dart';
import 'package:hosomobile/features/home/controllers/home_controller.dart';
import 'package:hosomobile/features/language/controllers/language_controller.dart';
import 'package:hosomobile/features/language/controllers/localization_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/setting/controllers/theme_controller.dart';
import 'package:hosomobile/features/history/controllers/transaction_history_controller.dart';
import 'package:hosomobile/features/transaction_money/domain/reposotories/contact_repo.dart';
import 'package:hosomobile/features/verification/controllers/verification_controller.dart';
import 'package:hosomobile/features/home/controllers/websitelink_controller.dart';
import 'package:hosomobile/data/api/api_client.dart';
import 'package:hosomobile/features/add_money/domain/reposotories/add_money_repo.dart';
import 'package:hosomobile/features/auth/domain/reposotories/auth_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/banner_repo.dart';
import 'package:hosomobile/features/setting/domain/reposotories/faq_repo.dart';
import 'package:hosomobile/features/notification/domain/reposotories/notification_repo.dart';
import 'package:hosomobile/features/setting/domain/reposotories/profile_repo.dart';
import 'package:hosomobile/features/transaction_money/domain/reposotories/transaction_repo.dart';
import 'package:hosomobile/features/history/domain/reposotories/transaction_history_repo.dart';
import 'package:hosomobile/features/home/domain/reposotories/websitelink_repo.dart';
import 'package:hosomobile/features/splash/domain/reposotories/splash_repo.dart';
import 'package:hosomobile/features/requested_money/domain/reposotories/requested_money_repo.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/common/models/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
//import 'package:unique_identifier/unique_identifier.dart';

import '../features/kyc_verification/domain/reposotories/kyc_verify_repo.dart';




Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  final BaseDeviceInfo deviceInfo =  await DeviceInfoPlugin().deviceInfo;
  // String? uniqueId = await  UniqueIdentifier.serial ?? '';

//device identifier
String deviceIdentifier = "unknown";
DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

if (kIsWeb) {
  WebBrowserInfo webInfo = await deviceInfoPlugin.webBrowserInfo;
  deviceIdentifier = "${webInfo.vendor}_${webInfo.userAgent}";
} else {
if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    deviceIdentifier = androidInfo.serialNumber;
} else if (Platform.isIOS) {
  IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
  deviceIdentifier = iosInfo.identifierForVendor ?? "unknown";
} else if (Platform.isLinux) {
  LinuxDeviceInfo linuxInfo = await deviceInfoPlugin.linuxInfo;
  deviceIdentifier = linuxInfo.machineId ?? "unknown";
} else {
  deviceIdentifier = "unsupported_platform";
}
}
print("Device Identifier: $deviceIdentifier");
  


  Get.lazyPut(() => deviceIdentifier);
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => deviceInfo);


  Get.lazyPut(() => ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: Get.find(),
    uniqueId: Get.find(),
    deiceInfo: Get.find(),
  ));

  
  Get.lazyPut(() => WoocommerceApiClient());

  // Repository
   Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => WebsiteLinkRepo(apiClient: Get.find()));
  Get.lazyPut(() => StudentRepo(apiClient: Get.find()));
  Get.lazyPut(() => StudentRegistrationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ClassRepo(apiClient: Get.find()));
  Get.lazyPut(() => SchoolRepo(apiClient: Get.find()));
    Get.lazyPut(() => ShopRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => AllSchoolRepo(apiClient: Get.find()));
  Get.lazyPut(() => SchoolRequirementRepo(apiClient: Get.find()));
  Get.lazyPut(() => EduboxMaterialRepo(apiClient: Get.find()));
  Get.lazyPut(() => AnnouncementRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => BilboardRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => FaqRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => RequestedMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionHistoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => SchoolListRepo(apiClient: Get.find()));
  Get.lazyPut(() => KycVerifyRepo(apiClient: Get.find()));
  Get.lazyPut(() => ForgetPinRepo(apiClient: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()));
  Get.lazyPut(() => ContactRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
   Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => TransactionMoneyController(paymentRepo: Get.find(), transactionRepo: Get.find(), authRepo: Get.find()));
  Get.lazyPut(() => StudentRegistrationController(paymentRepo: Get.find(), transactionRepo: Get.find(), authRepo: Get.find(), studentRegistrationRepo: Get.find()));
  Get.lazyPut(() => AddMoneyController(addMoneyRepo:Get.find() ));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => FaqController(faqrepo: Get.find()));
  Get.lazyPut(() => BottomSliderController());

  Get.lazyPut(() => MenuItemController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => CreateAccountController());
  Get.lazyPut(() => VerificationController());
  Get.lazyPut(() => CameraScreenController());
  Get.lazyPut(() => ForgetPinController(forgetPinRepo: Get.find()));
  Get.lazyPut(() => WebsiteLinkController(websiteLinkRepo: Get.find()));
  Get.lazyPut(() => StudentController(studentRepo: Get.find()));
  Get.lazyPut(() => SchoolController(schoolRepo: Get.find()));
  Get.lazyPut(() => ShopController(shopRepo: Get.find()));
  Get.lazyPut(() => AllSchoolController(allSchoolRepo: Get.find()));
  Get.lazyPut(() => ClassController(classRepo: Get.find()));
  Get.lazyPut(() => AnnouncementController(announcementRepo: Get.find()));
  Get.lazyPut(() => SchoolRequirementController(schoolRequirementRepo: Get.find()));
  Get.lazyPut(() => EduboxMaterialController(eduboxMaterialRepo: Get.find()));
  Get.lazyPut(() => QrCodeScannerController());
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
   Get.lazyPut(() => BilboardController(bilboardRepo: Get.find()));
  Get.lazyPut(() => TransactionHistoryController(transactionHistoryRepo: Get.find()));
   Get.lazyPut(() => SchoolListController(schoolListRepo: Get.find()));
  Get.lazyPut(() => EditProfileController(authRepo: Get.find()));
  Get.lazyPut(() => RequestedMoneyController(requestedMoneyRepo: Get.find()));
  Get.lazyPut(() => ShareController());
  Get.lazyPut(() => ShareControllerSl());
  Get.lazyPut(() => KycVerifyController(kycVerifyRepo: Get.find()));
  Get.lazyPut(() => OnBoardingController());
  Get.lazyPut(() => ContactController(contactRepo: Get.find()));



  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
