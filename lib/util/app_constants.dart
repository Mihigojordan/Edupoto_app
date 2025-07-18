import 'package:get/get.dart';
import 'package:hosomobile/common/models/language_model.dart';
import 'package:hosomobile/common/models/on_boarding_model.dart';
import 'images.dart';

class AppConstants {
  static const String appName = 'Babyeyi';
  // 'http://192.168.1.83/edupoto_rw_admin';

  static const String baseUrl = 'https://edupoto.com';
  // 'http://127.0.0.1/edupoto_rw_admin';
  static const String wooBaseUrl = 'https://hosomobile.rw';
  //  'http://192.168.1.76/edupoto_rw_admin''https://www.hosomobile.rw' ;                                         //'http://192.168.1.69/edupoto_rw_admin'; //'http://192.168.1.66/edupoto_rw_admin';
  static const bool demo = false;
  static const double appVersion = 4.3;
  static const String customerPhoneCheckUri =
      '/api/v1/customer/auth/check-phone';

  //******************************* introduction screen ******************************
  static const String appShareLink = 'https://babyeyi.web.app';

  static const String customerPhoneVerifyUri =
      '/api/v1/customer/auth/verify-phone';
  static const String customerRegistrationUri =
      '/api/v1/customer/auth/register';
  static const String customerUpdateProfile = '/api/v1/customer/update-profile';
  static const String customerLoginUri = '/api/v1/customer/auth/login';
  static const String customerLogoutUri = '/api/v1/customer/logout';
  static const String customerForgetPassOtpUri =
      '/api/v1/customer/auth/forgot-password';
  static const String customerForgetPassVerification =
      '/api/v1/customer/auth/verify-token';
  static const String customerForgetPassReset =
      '/api/v1/customer/auth/reset-password';
  static const String customerLinkedWebsite = '/api/v1/customer/linked-website';
  static const String student = '/api/v1/customer/student';
  static const String school = '/api/v1/customer/school';
  static const String allSchool = '/api/v1/customer/all-schools';
  static const String studentClass = '/api/v1/customer/student-class';
  static const String studentRegistration = '/api/v1/customer/student-reg';
  static const String schoolRequirement = '/api/v1/customer/school-requirement';
  static const String eduboxMaterial = '/api/v1/customer/edubox-material';
  static const String announcement = '/api/v1/customer/announcement';
  static const String paymentHistory = '/api/v1/customer/payment';
  static const String customerBanner = '/api/v1/customer/get-banner';
  static const String customerTransactionHistory =
      '/api/v1/customer/transaction-history';
  static const String schoolList = '/api/v1/customer/school-list';
  static const String customerPurposeUrl = '/api/v1/customer/get-purpose';
  static const String configUri = '/api/v1/config';
  static const String imageConfigUrlApiNeed = '/storage/app/public/purpose/';
  static const String customerProfileInfo = '/api/v1/customer/get-customer';
  static const String customerEMoney = '/api/v1/customer/emoney/index';
  static const String customerAddEMoney = '/api/v1/customer/emoney/store';
  static const String customerCheckOtp = '/api/v1/customer/check-otp';
  static const String customerVerifyOtp = '/api/v1/customer/verify-otp';
  static const String customerChangePin = '/api/v1/customer/change-pin';
  static const String customerUpdateTwoFactor =
      '/api/v1/customer/update-two-factor';
  static const String customerSendMoney = '/api/v1/customer/send-money';
  static const String customerRequestMoney = '/api/v1/customer/request-money';
  static const String customerCashOut = '/api/v1/customer/cash-out';
  static const String customerPinVerify = '/api/v1/customer/verify-pin';
  static const String customerAddMoney = '/api/v1/customer/add-money';
  static const String faqUri = '/api/v1/faq';
  static const String notificationUri = '/api/v1/customer/get-notification';
  static const String transactionHistoryUri =
      '/api/v1/customer/transaction-history';
  static const String requestedMoneyUri =
      '/api/v1/customer/get-requested-money';
  static const String acceptedRequestedMoneyUri =
      '/api/v1/customer/request-money/approve';
  static const String deniedRequestedMoneyUri =
      '/api/v1/customer/request-money/deny';
  static const String tokenUri = '/api/v1/customer/update-fcm-token';
  static const String checkCustomerUri = '/api/v1/check-customer';
  static const String checkAgentUri = '/api/v1/check-agent';
  static const String wonRequestedMoney =
      '/api/v1/customer/get-own-requested-money';
  static const String customerRemove = '/api/v1/customer/remove-account';
  static const String updateKycInformation =
      '/api/v1/customer/update-kyc-information';
  static const String withdrawMethodList =
      '/api/v1/customer/withdrawal-methods';
  static const String withdrawRequest = '/api/v1/customer/withdraw';
  static const String getWithdrawalRequest =
      '/api/v1/customer/withdrawal-requests';
  static const String getImage = '/storage/app/public/banner/';

  //Mtn MOMO Api Url Links

  static const String sendMoneyMtnMomo = '/api/v1/momopay/pay';
  static const String createTokenMtnMomo = '/api/v1/momopay/token';
  static const String getPaymentInfo = '/api/v1/momopay/payment';

  //Woocommerce
  static const String shop = '/api/v1/customer/student-class';
  static const String getProduct = '/wp-json/wc/v3/products';
  static const String getCategory = '/wp-json/wc/v3/products/categories';
  static const String getBrand = '/wp-json/wc/v3/products/brands';
  static const String getAttribute = '/wp-json/wc/v3/products/attributes';
  static const String getOrder = '/wp-json/wc/v3/orders';
  static const String getCustomer = '/wp-json/wc/v3/customers';

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String customerCountryCode =
      'customer_country_code'; //not in project
  static const String languageCode = 'language_code';
  static const String topic = 'notify';

  static const String sendMoneySuggestList = 'send_money_suggest';
  static const String requestMoneySuggestList = 'request_money_suggest';
  static const String recentAgentList = 'recent_agent_list';

  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String denied = 'denied';
  static const String cashIn = 'cash_in';
  static const String cashOut = 'cash_out';
  static const String sendMoney = 'send_money';
  static const String receivedMoney = 'received_money';
  static const String adminCharge = 'admin_charge';
  static const String addMoney = 'add_money';
  static const String withdraw = 'withdraw';
  static const String payment = 'payment';

  static const String headteacherMessage = 'headteacher_message';
  static const String classRequirement = 'class_requirement';
  static const String tuitionFee = 'tuition_fee';
  static const String dormitoryEssential = 'dormitory_essential';
  static const String textBook = 'text_book';

  static const String biometricAuth = 'biometric_auth';
  static const String biometricPin = 'biometric';
  static const String contactPermission = '';
  static const String userData = 'user';
  static const String userId = 'userId';
  static const String customerId = 'customerId'; 
  static const String customerData = 'customer';

  //topic
  static const String all = 'all';
  static const String users = 'customers';

  // App Theme
  static const String theme1 = 'theme_1';
  static const String theme2 = 'theme_2';
  static const String theme3 = 'theme_3';

  //input balance digit length
  static const int balanceInputLen = 10;

  //payment invoices
  static String currency = 'RWF';
  static double vatPercentage = 18;
  static double convenienceFeePercentage = 1.0;
  static double deliveryCost = 3000.00;
  static String deliveryCompany= "Maestro";
  static String city= "Kigali";
  static String country= "Rwanda";
  static double calculateVAT(double amount) {
    return (amount * vatPercentage) / 100;
  }

  static double calculateConvenienceFee(double amount) {
    return (amount * convenienceFeePercentage) / 100;
  }

  static double calculateOriginalAmaount(double amount) {
    return amount - calculateVAT(amount) - calculateConvenienceFee(amount);
  }

  static double calculateOriginalVat(double amount) {
    return ((amount - calculateVAT(amount)) * vatPercentage) / 100;
  }

  static double calculateTotalWithService(double amount) {
    double convenienceFee = calculateConvenienceFee(amount);
    return amount + convenienceFee;
  }

  static double calculateTotal(double amount) {
    double vat = calculateVAT(amount);
    double convenienceFee = calculateConvenienceFee(amount);
    return amount + vat + convenienceFee + deliveryCost;
  }

  static double calculateServiceCharge0fPrice(double amount) {
    return amount * convenienceFeePercentage / 100;
  }

  static double remainingAmount(
      {required double amount, required double remainingBalance}) {
    final double remainingAmount;

    if (remainingBalance == 0) {
      remainingAmount = amount;
    } else {
      remainingAmount = remainingBalance;
    }

    return remainingAmount;
  }

  static double availableBalance(
      {required double amount, required double balance}) {
    return balance - amount;
  }

  double deliveryCostWithMAterialCost(amount) {
    final calculatedTotal = calculateTotal(amount);
    return calculatedTotal + deliveryCost;
  }

// Language Model

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),

    LanguageModel(
      imageUrl: Images.english,
      languageName: 'Français',
      languageCode: 'fr',
      countryCode: 'FR',
    ),
    LanguageModel(
      imageUrl: Images.english,
      languageName: 'Kinyarwanda',
      languageCode: 'rw',
      countryCode: 'RW',
    ),
    LanguageModel(
      imageUrl: Images.english,
      languageName: 'Swahili',
      languageCode: 'sw',
      countryCode: 'TZ',
    ),
    // LanguageModel(
    //     imageUrl: Images.saudi,
    //     languageName: 'Kinyarwanda',
    //     countryCode: 'SA',
    //     languageCode: 'ar'),
  ];

  static List<OnboardModel> onboardList = [
    OnboardModel(
      Images.onboardImage1,
      Images.onboardBackground1,
      'on_boarding_title_1'.tr,
      '${'send_money_from'.tr} $appName ${'easily_at_anytime'.tr}',
    ),
    OnboardModel(
      Images.onboardImage2,
      Images.onboardBackground2,
      'on_boarding_title_2'.tr,
      'withdraw_money_is_even_more'.tr,
    ),
    OnboardModel(
      Images.onboardImage3,
      Images.onboardBackground3,
      'on_boarding_title_3'.tr,
      '${'request_for_money_using'.tr} $appName ${'account_to_any_friend'.tr}',
    ),
  ];
}
