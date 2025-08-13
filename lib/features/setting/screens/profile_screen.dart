import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/models/customer_model.dart';
import 'package:hosomobile/features/shop/screen/shop_order_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/history/screens/history_screen.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/setting/domain/models/profile_model.dart';
import 'package:hosomobile/helper/dialog_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:hosomobile/common/widgets/custom_ink_well_widget.dart';
import 'package:hosomobile/common/widgets/custom_dialog_widget.dart';
import 'package:hosomobile/features/setting/widgets/menu_item.dart' as widget;
import 'package:hosomobile/features/setting/widgets/profile_holder.dart';
import 'package:hosomobile/features/setting/widgets/status_menu.dart';
import 'package:hosomobile/features/setting/widgets/user_info_widget.dart';
import 'package:hosomobile/features/setting/screens/transaction_limit_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ShopController _shopController = Get.find<ShopController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _fetchCustomer();
  }

  Future<void> _fetchCustomer() async {
    try {
      // First check if we already have a customer ID stored locally
      int? customerId = _shopController.getCustomerId();
      
      if (customerId == null ) {
        // If no customer ID exists, try to find or create one
        final userId = _authController.getUserId();
        final userData = _authController.getUserData();
        final name = userData?.name ?? 'User$userId';
        final String nameWithoutSpaces = name.replaceAll(' ', '');
        final String email = '$nameWithoutSpaces$userId@gmail.com';

        // Fetch customer list from API
        await _shopController.getCustomerData(reload: true);

        // Try to find existing customer by email
        CustomerModel? existingCustomer;
        try {
          existingCustomer = _shopController.customerList?.firstWhere(
            (customer) => customer.email?.toLowerCase() == email.toLowerCase(),
          );
        } catch (e) {
          debugPrint('No existing customer found: $e');
        }

        // If customer exists, store the ID
        if (existingCustomer?.id != null) {
          _shopController.setCustomerId(existingCustomer!.id.toString());
        } else {
          // If customer doesn't exist, create a new one
          final response = await _shopController.customerReg(
            email: email,
            phone: userData?.phone ?? '',
            firstName: name.split(' ').first,
            lastName: name.split(' ').length > 1 ? name.split(' ').sublist(1).join(' ') : '',
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final newCustomerId = response.body['id']?.toString();
            if (newCustomerId != null) {
              _shopController.setCustomerId(newCustomerId);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching customer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    List<TransactionTableModel> transactionTableModelList = [];
    ProfileModel? userInfo = Get.find<ProfileController>().userInfo;

    if (userInfo != null) {
      transactionTableModelList.addAll([
        if (splashController.configModel!.systemFeature!.sendMoneyStatus! &&
            splashController.configModel!.customerSendMoneyLimit!.status)
          TransactionTableModel(
            'send_money'.tr,
            Images.sendMoneyImage,
            splashController.configModel!.customerSendMoneyLimit!,
            Transaction(
              userInfo.transactionLimits!.dailySendMoneyCount ?? 0,
              userInfo.transactionLimits!.monthlySendMoneyCount ?? 0,
              userInfo.transactionLimits!.dailySendMoneyAmount ?? 0,
              userInfo.transactionLimits!.monthlySendMoneyAmount ?? 0,
            ),
          ),
        if (splashController.configModel!.systemFeature!.cashOutStatus! &&
            splashController.configModel!.customerCashOutLimit!.status)
          TransactionTableModel(
            'cash_out'.tr,
            Images.cashOutLogo,
            splashController.configModel!.customerCashOutLimit!,
            Transaction(
              userInfo.transactionLimits!.dailyCashOutCount ?? 0,
              userInfo.transactionLimits!.monthlyCashOutCount ?? 0,
              userInfo.transactionLimits!.dailyCashOutAmount ?? 0,
              userInfo.transactionLimits!.monthlyCashOutAmount ?? 0,
            ),
          ),
        if (splashController.configModel!.systemFeature!.sendMoneyRequestStatus! &&
            splashController.configModel!.customerRequestMoneyLimit!.status)
          TransactionTableModel(
            'send_money_request'.tr,
            Images.requestMoneyLogo,
            splashController.configModel!.customerRequestMoneyLimit!,
            Transaction(
              userInfo.transactionLimits!.dailySendMoneyRequestCount ?? 0,
              userInfo.transactionLimits!.monthlySendMoneyRequestCount ?? 0,
              userInfo.transactionLimits!.dailySendMoneyRequestAmount ?? 0,
              userInfo.transactionLimits!.monthlySendMoneyRequestAmount ?? 0,
            ),
          ),
        if (splashController.configModel!.systemFeature!.addMoneyStatus! &&
            splashController.configModel!.customerAddMoneyLimit!.status)
          TransactionTableModel(
            'add_money'.tr,
            Images.addMoneyLogo3,
            splashController.configModel!.customerAddMoneyLimit!,
            Transaction(
              userInfo.transactionLimits?.dailyAddMoneyCount ?? 0,
              userInfo.transactionLimits?.monthlyAddMoneyCount ?? 0,
              userInfo.transactionLimits?.dailyAddMoneyAmount ?? 0,
              userInfo.transactionLimits?.monthlyAddMoneyAmount ?? 0,
            ),
          ),
        if (splashController.configModel!.systemFeature!.withdrawRequestStatus! &&
            splashController.configModel!.customerWithdrawLimit!.status)
          TransactionTableModel(
            'withdraw'.tr,
            Images.withdraw,
            splashController.configModel!.customerWithdrawLimit!,
            Transaction(
              userInfo.transactionLimits?.dailyWithdrawRequestCount ?? 0,
              userInfo.transactionLimits?.monthlyWithdrawRequestCount ?? 0,
              userInfo.transactionLimits?.dailyWithdrawRequestAmount ?? 0,
              userInfo.transactionLimits?.monthlyWithdrawRequestAmount ?? 0,
            ),
          ),
      ]);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: CustomAppbarWidget(title: 'profile'.tr, onlyTitle: true),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          final customerId = _shopController.getCustomerId();
          return ModalProgressHUD(
            inAsyncCall: authController.isLoading,
            progressIndicator: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const UserInfoWidget(),
                  ProfileHeader(title: 'setting'.tr),
                  Column(
                    children: [
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.editProfile, title: 'edit_profile'.tr),
                        onTap: () => Get.toNamed(RouteHelper.getEditProfileRoute()),
                      ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.withdraw, title: 'my_orders'.tr),
                        onTap: () => Get.to(() => ShopOrderScreen(customerId: customerId ?? 0)),
                      ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.sendMoneyImage, title: 'transaction_history'.tr),
                        onTap: () => Get.to(() => HistoryScreen()),
                      ),
                      if (transactionTableModelList.isNotEmpty)
                        CustomInkWellWidget(
                          child: widget.MenuItem(
                            image: Images.transactionLimit,
                            title: 'transaction_limit'.tr,
                          ),
                          onTap: () => Get.to(() => TransactionLimitScreen(
                            transactionTableModelList: transactionTableModelList,
                          )),
                        ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.pinChangeLogo, title: 'change_pin'.tr),
                        onTap: () => Get.toNamed(RouteHelper.getChangePinRoute()),
                      ),
                      if (AppConstants.languages.length > 1)
                        CustomInkWellWidget(
                          child: widget.MenuItem(image: Images.languageLogo, title: 'change_language'.tr),
                          onTap: () => Get.toNamed(RouteHelper.getChoseLanguageRoute()),
                        ),
                      if (Get.find<SplashController>().configModel!.twoFactor!)
                        GetBuilder<ProfileController>(
                          builder: (profileController) {
                            return profileController.isLoading
                                ? const TwoFactorShimmer()
                                : StatusMenu(
                                    title: 'two_factor_authentication'.tr,
                                    leading: Image.asset(Images.twoFactorAuthentication, width: 28.0),
                                  );
                          },
                        ),
                      if (authController.isBiometricSupported)
                        StatusMenu(
                          title: 'biometric_login'.tr,
                          leading: SizedBox(width: 25, child: Image.asset(Images.fingerprint)),
                          isAuth: true,
                        ),
                      if (splashController.configModel?.selfDelete == true)
                        CustomInkWellWidget(
                          child: widget.MenuItem(
                            iconData: Icons.delete,
                            image: null,
                            title: 'delete_account'.tr,
                          ),
                          onTap: () {
                            DialogHelper.showAnimatedDialog(
                              context,
                              CustomDialogWidget(
                                icon: Icons.question_mark_sharp,
                                title: 'are_you_sure_to_delete_account'.tr,
                                description: 'it_will_remove_your_all_information'.tr,
                                onTapFalseText: 'no'.tr,
                                onTapTrueText: 'yes'.tr,
                                isFailed: true,
                                onTapFalse: () => Get.back(),
                                onTapTrue: () {
                                  Get.find<AuthController>().removeUser();
                                  _shopController.removeUserId();
                                } ,
                                bigTitle: true,
                              ),
                              dismissible: false,
                              isFlip: true,
                            );
                          },
                        ),
                      GetBuilder<ProfileController>(
                        builder: (profileController) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                  child: Image.asset(Images.changeTheme, width: Dimensions.fontSizeOverOverLarge),
                                ),
                                Text('dark_mode'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                const Spacer(),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () => profileController.onChangeTheme(),
                                  child: Transform.scale(
                                    scale: 1,
                                    child: Switch(
                                      onChanged: (_) {
                                        profileController.onChangeTheme();
                                      },
                                      value: profileController.isSwitched,
                                      activeColor: Theme.of(context).primaryColor,
                                      activeTrackColor: Colors.white,
                                      inactiveThumbColor: Theme.of(context).primaryColor,
                                      inactiveTrackColor: Colors.black26,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  ProfileHeader(title: 'support'.tr),
                  Column(
                    children: [
                      if (((splashController.configModel!.companyEmail != null) ||
                          (splashController.configModel!.companyPhone != null)))
                        CustomInkWellWidget(
                          child: widget.MenuItem(image: Images.supportLogo, title: '24_support'.tr),
                          onTap: () => Get.toNamed(RouteHelper.getSupportRoute()),
                        ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.questionLogo, title: 'faq'.tr),
                        onTap: () => Get.toNamed(RouteHelper.faq),
                      )
                    ],
                  ),
                  ProfileHeader(title: 'policies'.tr),
                  Column(
                    children: [
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.aboutUs, title: 'about_us'.tr),
                        onTap: () => Get.toNamed(RouteHelper.aboutUs),
                      ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.terms, title: 'terms'.tr),
                        onTap: () => Get.toNamed(RouteHelper.terms),
                      ),
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.privacy, title: 'privacy_policy'.tr),
                        onTap: () => Get.toNamed(RouteHelper.privacy),
                      ),
                    ],
                  ),
                  ProfileHeader(title: 'account'.tr),
                  Column(
                    children: [
                      CustomInkWellWidget(
                        child: widget.MenuItem(image: Images.logOut, title: 'logout'.tr),
                        onTap: (){
                          Get.find<ProfileController>().logOut(context);
                           _shopController.removeUserId();
                        } 
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}