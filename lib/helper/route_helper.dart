import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/school_requirement_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/hoso_home_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/studentpoto_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/hoso_services/hoso_services.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/installment_pay/installment_pay.dart';
import 'package:hosomobile/features/student/widgets/student_add_info.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/student/screens/student_logistic_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_invoice.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/single_school.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/common/models/signup_body_model.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/features/auth/screens/create_account_screen.dart';
import 'package:hosomobile/features/auth/screens/login_screen.dart';
import 'package:hosomobile/features/auth/screens/sign_up_information_screen.dart';
import 'package:hosomobile/features/auth/screens/pin_set_screen.dart';
import 'package:hosomobile/features/splash/screens/restart.dart';
import 'package:hosomobile/features/transaction_money/screens/credit_transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/credit_transaction_confirmation_screen_sl.dart';
import 'package:hosomobile/features/transaction_money/screens/school_transaction_confirmation_screen.dart';
import 'package:hosomobile/features/verification/screens/varification_screen.dart';
import 'package:hosomobile/features/home/screens/nav_bar_screen.dart';
import 'package:hosomobile/features/forget_pin/screens/forget_pin_screen.dart';
import 'package:hosomobile/features/forget_pin/screens/reset_pin_screen.dart';
import 'package:hosomobile/features/history/screens/history_screen.dart';
import 'package:hosomobile/features/home/screens/home_screen.dart';
import 'package:hosomobile/features/language/screens/change_language_screen.dart';
import 'package:hosomobile/features/notification/screens/notification_screen.dart';
import 'package:hosomobile/features/onboarding/screens/on_boarding_sceen.dart';
import 'package:hosomobile/features/setting/screens/profile_screen.dart';
import 'package:hosomobile/features/setting/widgets/change_pin_screen.dart';
import 'package:hosomobile/features/setting/screens/edit_profile_screen.dart';
import 'package:hosomobile/features/setting/widgets/faq_screen.dart';
import 'package:hosomobile/features/setting/screens/html_view_screen.dart';
import 'package:hosomobile/features/setting/screens/qr_code_download_or_share_screen.dart';
import 'package:hosomobile/features/setting/screens/support_screen.dart';
import 'package:hosomobile/features/splash/screens/splash_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_balance_input_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_money_screen.dart';
import 'package:hosomobile/features/transaction_money/widgets/share_statement_widget.dart';
import 'package:hosomobile/features/splash/screens/welcome_screen.dart';


class RouteHelper {
  static const String restart ='/';
  static const String splash = '/splash';
  static const String product ='/product';
  static const String home = '/home';
  static const String hosoHome = '/hoso_home';
  static const String hosoServices = '/hoso_services';
  static const String eduboxBudget = '/edubox_budget';
  static const String eduboxPlus = '/edubox_plus';
  static const String ababyeyi = '/ababyeyi';
  static const String singleSchool = '/single_school';
  static const String studentAddInfo = '/student_add_info';
  static const String schoolList ='/school_list';
  static const String paymentInvoice = '/payment_invoice';
  static const String paymentMethod = '/payment_method';
  static const String studentPoto='/student_poto';
  static const String installmentPay='/installment_pay';
  static const String navbar = '/navbar';
  static const String srMentor='sr_mentor';
  static const String jrMentor='jr_mentor';

  static const String history = '/history';
  static const String notification = '/notification';
  static const String themeAndLanguage = '/themeAndLanguage';
  static const String profile = '/profile';
  static const String changePinScreen = '/change_pin_screen';
  static const String verifyOtpScreen = '/verify_otp_screen';
  static const String noInternetScreen = '/no_internet_screen';
  static const String sendMoney = '/send_money';
  static const String choseLoginOrRegScreen = '/chose_login_or_reg';
  static const String createAccountScreen = '/create_account';
  static const String verifyScreen = '/verify_account';
  static const String selfieScreen = '/selfie_screen';
  static const String otherInfoScreen = '/other_info_screen';
  static const String pinSetScreen = '/pin_set_screen';
  static const String welcomeScreen = '/welcome_screen';
  static const String loginScreen = '/login_screen';
  static const String fPhoneNumberScreen = '/f_phone_number';
  static const String fVerificationScreen = '/f_verification_screen';
  static const String resetPassScreen = '/f_reset_pass_screen';

  static const String qrCodeScannerScreen = '/qr_code_scanner_screen';
  static const String showWebViewScreen = '/show_web_view_screen';

  static const String sendMoneyBalanceInput =
      '/send_money_balance_inputsend_money_balance_input';
  static const String sendMoneyConfirmation =
      '/transaction_confirmation_screen.dart';

  static const String requestMoney = '/request_money';
  static const String requestMoneyBalanceInput = '/requestMoney_balance_input';
  static const String requestMoneyConfirmation = '/requestMoney_confirmation';

  static const String cashOut = '/cash_out';
  static const String cashOutBalanceInput = '/cash_out_balance_input';
  static const String cashOutConfirmation = '/cash_out_confirmation';

  static const String addMoney = '/add_money';
  static const String addMoneyInput = '/add_money_input';
  static const String bankSelect = '/bank_select';
  static const String bankList = '/bank_listbank_list';
  static const String addMoneySuccessful = '/add_money_successful';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String faq = '/faq';
  static const String aboutUs = '/about_us';
  static const String terms = '/terms';
  static const String privacy = '/privacy_policy';
  static const String requestedMoney = '/requested_money';
  static const String shareStatement = '/share_statement';
  static const String support = '/support';
  static const String choseLanguageScreen = '/chose_language_screen';
  static const String qrCodeDownloadOrShare = '/qr_code_download_or_share';

  static getRestart() => restart;
  static getSplashRoute() => splash;
  static getProductRoute()=>product;
  static String getHomeRoute(String name) => '$home?name=$name';
  static getHosoHomeRoute() => hosoHome;
  static getAbabyeyi()=>ababyeyi;
  static getHosoServices() => hosoServices;
  static getEduboxBudget({String? transactionType, ContactModel? conatactModel }) => '$eduboxBudget?transaction-type=$transactionType&contact-model=$conatactModel';
  static getEduboxPlus() => eduboxPlus;
  static getSingleSchool() => singleSchool;
    static getStudentAddInfo() => studentAddInfo;
  static getSchoolList()=> schoolList;
  static getPaymentInvoice({List<String>? dataList, String? amount}) {
    return '$paymentInvoice?data-list=$dataList&amount=$amount';
  }
  static getPaymentMethod({String?totalAmount}){
    return '$paymentMethod?total-amount=$totalAmount';
  }
  static getInstallmentPay({String?totalAmount}){
    return '$installmentPay?total-amount=$totalAmount';
  }
  static getStudentPoto()=>studentPoto;

  static getLoginRoute(
      {required String? countryCode, required String? phoneNumber}) {
    return '$loginScreen?country-code=$countryCode&phone-number=$phoneNumber';
  }

  static getRegistrationRoute() => createAccountScreen;
  static getVerifyRoute({String? phoneNumber}) =>
      '$verifyScreen?phone_number=${Uri.encodeComponent(phoneNumber ?? 'null')}';

  static getWelcomeRoute(
      {String? countryCode, String? phoneNumber, String? password}) {
    return '$welcomeScreen?country-code=$countryCode&phone-number=$phoneNumber&password=$password';
  }

  // static getSelfieRoute({required bool fromEditProfile}) =>
  //     '$selfieScreen?page=${fromEditProfile ? 'edit-profile' : 'verify'}';
  static getNavBarRoute({String? destination}) {
    return '$navbar?destination=$destination';
  }
  static getOtherInformationRoute() => otherInfoScreen;
  static getPinSetRoute({required SignUpBodyModel signUpBody}) {
    String signUpData =
        base64Url.encode(utf8.encode(jsonEncode(signUpBody.toJson())));
    return '$pinSetScreen?signup=$signUpData';
  }

  static getRequestMoneyRoute({String? phoneNumber, required bool fromEdit}) =>
      '$requestMoney?phone-number=$phoneNumber&from-edit=${fromEdit ? 'edit-number' : 'home'}';
  static getForgetPassRoute(
          {required String? countryCode, required String phoneNumber}) =>
      '$fPhoneNumberScreen?country-code=$countryCode&phone-number=$phoneNumber';
  static getRequestMoneyBalanceInputRoute() => requestMoneyBalanceInput;
  static getRequestMoneyConfirmationRoute({required String inputBalanceText}) =>
      '$requestMoneyConfirmation?input-balance=$inputBalanceText';
  static getNoInternetRoute() => noInternetScreen;
  static getChoseLoginRegRoute() => choseLoginOrRegScreen;
  static getSendMoneyRoute({String? phoneNumber, required bool fromEdit}) =>
      '$sendMoney?phone-number=$phoneNumber&from-edit=${fromEdit ? 'edit-number' : 'home'}';
  static getSendMoneyInputRoute({required String transactionType}) =>
      '$sendMoneyBalanceInput?transaction-type=$transactionType';
  static getSendMoneyConfirmationRoute(
          {required String inputBalanceText,
          required String transactionType}) =>
      '$sendMoneyConfirmation?input-balance=$inputBalanceText&transaction-type=$transactionType';
  static getChoseLanguageRoute() => choseLanguageScreen;
  static getCashOutScreenRoute({String? phoneNumber, required bool fromEdit}) =>
      '$cashOut?phone-number=$phoneNumber&from-edit=${fromEdit ? 'edit-number' : 'home'}';
  static getCashOutBalanceInputRoute() => cashOutBalanceInput;
  static getFResetPassRoute({String? phoneNumber, String? otp}) =>
      '$resetPassScreen?phone-number=$phoneNumber&otp=$otp';
  static getEditProfileRoute() => editProfileScreen;
  static getChangePinRoute() => changePinScreen;
  static getAddMoneyInputRoute() => addMoneyInput;
  // static  getFVerificationRoute({required String phoneNumber}) => '$fVerificationScreen?phone-number=$phoneNumber';

  static getSupportRoute() => support;
  static getCashOutConfirmationRoute({required String inputBalanceText}) =>
      '$cashOutConfirmation?input-balance=$inputBalanceText';
  static getShareStatementRoute(
      {required String amount,
      required String transactionType,
      required ContactModel contactModel}) {
    String data =
        base64Url.encode(utf8.encode(jsonEncode(contactModel.toJson())));
    String transactionType0 = base64Url.encode(utf8.encode(transactionType));
    return '$shareStatement?amount=$amount&transaction-type=$transactionType0&contact=$data';
  }

  static getQrCodeDownloadOrShareRoute(
      {required String qrCode, required String phoneNumber}) {
    String qrCode0 = base64Url.encode(utf8.encode(qrCode));
    String phoneNumber0 = base64Url.encode(utf8.encode(phoneNumber));

    return '$qrCodeDownloadOrShare?qr-code=$qrCode0&phone-number=$phoneNumber0';
  }

  static List<GetPage> routes = [
    GetPage(name: restart, page: () => const Restart()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: product, page: () =>  const MzaziScreen(isShop: false,)),
    GetPage(name: hosoHome, page: () => const HosoHomeScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: ababyeyi, page: () => const MzaziScreen(isShop: false,)),
    GetPage(name: hosoServices, page: () => const HosoServices()),


GetPage(
  name: eduboxBudget,
  page: () {
    final transactionType = Get.parameters['transaction-type'];
    final contactModelString = Get.parameters['contact-model'];
    final productListString = Get.parameters['product-list'];
    

    // Handle the case where contactModelString might be null or invalid
    ContactModel? contactModel;
    if (contactModelString != null) {
      try {
        contactModel = ContactModel.fromJson(jsonDecode(contactModelString));
      } catch (e) {
        print('Error decoding contact-model: $e');
        contactModel = null;
      }
    }

    int? studentIndex; 
    // if (productListString != null) {
    //   try {
    //     productList = (jsonDecode(productListString) as List)
    //         .map((item) => Product.fromJson(item))
    //         .toList();
    //   } catch (e) {
    //     print('Error decoding product-list: $e');
    //     productList = null;
    //   }
    // }

    return TerekaAsome(
      transactionType: transactionType,
      contactModel: contactModel,
      studentIndex: studentIndex!,
    );
  },
),

    
    GetPage(name: studentAddInfo, page: (){
      final studentId=Get.parameters['studentId'];
      final studentInfo=Get.parameters['studentInfo'];
    return StudentAddInfo(studentId: int.parse(studentId!),studentInfo: studentInfo!); 
    }
    
    
    ),


 GetPage(name: installmentPay, page: ()=>InstallmentPayment(totalAmount: Get.parameters['total-amount']!)),
 GetPage(name: studentPoto, page: ()=>const StudentpotoScreen()),
 GetPage(name: navbar, page: () =>  NavBarScreen(destination: Get.parameters['destination']!,)),



    GetPage(
        name: shareStatement,
        page: () => ShareStatementWidget(
          destination: '',
            amount: Get.parameters['amount'],
            charge: null,
            trxId: null,
            transactionType: utf8.decode(base64Url.decode(
                Get.parameters['transaction-type']!.replaceAll(' ', '+'))),
            contactModel: ContactModel.fromJson(jsonDecode(
                utf8.decode(base64Url.decode(Get.parameters['contact']!)))))),

    GetPage(name: history, page: () => HistoryScreen()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    // GetPage(name: themeAndLanguage, page: () => ThemeAndLanguage()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: changePinScreen, page: () => const ChangePinScreen()),
    GetPage(
        name: sendMoney,
        page: () => TransactionMoneyScreen(
            phoneNumber: Get.parameters['phone-number'],
            fromEdit: Get.parameters['from-edit'] == 'edit-number')),
    GetPage(
        name: sendMoneyBalanceInput,
        page: () => TransactionBalanceInputScreen(
            transactionType: Get.parameters['transaction-type'],
            dataList: const [],
            )),
    GetPage(
        name: sendMoneyConfirmation,
        page: () => TransactionConfirmationScreen(
            inputBalance: double.tryParse(Get.parameters['input-balance']!),
            transactionType: Get.parameters['transaction-type'],
            dataList: const [],
            )),

              GetPage(
        name: sendMoneyConfirmation,
        page: () => CreditTransactionConfirmationScreenSL(
            inputBalance: double.tryParse(Get.parameters['input-balance']!),
            transactionType: Get.parameters['transaction-type'],
            dataList: const [],
            )),


    GetPage(name: choseLoginOrRegScreen, page: () => const OnBoardingScreen()),
    GetPage(name: createAccountScreen, page: () => const CreateAccountScreen()),
    GetPage(
        name: verifyScreen,
        page: () {
          final String? phoneNumber =
              Uri.decodeComponent(Get.parameters['phone_number']!) != 'null'
                  ? Uri.decodeComponent(Get.parameters['phone_number']!)
                  : null;
          return VerificationScreen(
            phoneNumber: phoneNumber,
          );
        }),
    // GetPage(
    //     name: selfieScreen,
    //     page: () => CameraScreen(
    //         fromEditProfile: Get.parameters['page'] == 'edit-profile')),
    GetPage(name: otherInfoScreen, page: () => const SignUpInformationScreen()),
    GetPage(
        name: pinSetScreen,
        page: () => PinSetScreen(
              signUpBody: SignUpBodyModel.fromJson(jsonDecode(
                  utf8.decode(base64Url.decode(Get.parameters['signup']!)))),
            )),

    GetPage(
        name: welcomeScreen,
        page: () => WelcomeScreen(
              countryCode: Get.parameters['country-code']!.replaceAll(' ', '+'),
              phoneNumber: Get.parameters['phone-number'],
              password: Get.parameters['password'],
            )),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(
          countryCode: Get.parameters['country-code']!.replaceAll(' ', '+'),
          phoneNumber: Get.parameters['phone-number']),
    ),
    GetPage(
        name: fPhoneNumberScreen,
        page: () => ForgetPinScreen(
              countryCode: Get.parameters['country-code']!.replaceAll(' ', '+'),
              phoneNumber: Get.parameters['phone-number'],
            )),
    // GetPage(name: fVerificationScreen, page: () => PhoneVerification(phoneNumber: Get.parameters['phone-number']!.replaceAll(' ', '+'),)),
    GetPage(
        name: resetPassScreen,
        page: () => ResetPinScreen(
              phoneNumber: Get.parameters['phone-number']!.replaceAll(' ', '+'),
              otp: Get.parameters['otp']!.replaceAll(' ', '+'),
            )),
    GetPage(
        name: choseLanguageScreen, page: () => const ChooseLanguageScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: faq, page: () => FaqScreen(title: 'faq'.tr)),
    GetPage(
        name: terms,
        page: () => HtmlViewScreen(
            title: 'terms'.tr,
            url: Get.find<SplashController>().configModel!.termsAndConditions)),
    GetPage(
        name: aboutUs,
        page: () => HtmlViewScreen(
            title: 'about_us'.tr,
            url: Get.find<SplashController>().configModel!.aboutUs)),
    GetPage(
        name: privacy,
        page: () => HtmlViewScreen(
            title: 'privacy_policy'.tr,
            url: Get.find<SplashController>().configModel!.privacyPolicy)),
    GetPage(name: support, page: () => const SupportScreen()),
    GetPage(
        name: qrCodeDownloadOrShare,
        page: () => QrCodeDownloadOrShareScreen(
              qrCode: utf8.decode(base64Url
                  .decode(Get.parameters['qr-code']!.replaceAll(' ', '+'))),
              phoneNumber: utf8.decode(base64Url.decode(
                  Get.parameters['phone-number']!.replaceAll(' ', '+'))),
            )),
  ];
  
  static get di => null;
}
