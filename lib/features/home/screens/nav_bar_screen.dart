import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_dialog_widget.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/controllers/menu_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/studentpoto_screen.dart';
import 'package:hosomobile/features/home/widgets/bottom_item_widget.dart';
import 'package:hosomobile/features/home/widgets/floating_action_button_widget.dart';
import 'package:hosomobile/features/shop/screen/shop_screen.dart';
import 'package:hosomobile/features/splash/screens/splash_screen.dart';
import 'package:hosomobile/helper/dialog_helper.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/images.dart';

class NavBarScreen extends StatefulWidget {
  final String destination;
  const NavBarScreen({super.key, required this.destination});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  final MtnMomoApiClient mtnMomoApiClient= MtnMomoApiClient();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.destination == 'ababyeyi') {
        Get.find<MenuItemController>().selectHistoryPage();
      } else if (widget.destination == 'home') {
        Get.find<MenuItemController>().selectHomePage(isUpdate: true);
      } else {
        Get.find<MenuItemController>().selectHistoryPage();
      }
    });

    // This can remain in initState as it doesn't trigger a rebuild
    Get.find<AuthController>().checkBiometricWithPin();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: Navigator.canPop(context),
      // onPopInvoked:(_) => _onWillPop(context),
      child: GetBuilder<MenuItemController>(builder: (menuController) {
        return Scaffold(
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          body: PageStorage(
              bucket: bucket,
              child: menuController.screen[menuController.currentTabIndex]),
          floatingActionButton: !kIsWeb
              ? FloatingActionButtonWidget(
                  strokeWidth: 1.5,
                  radius: 40,
                  gradient: LinearGradient(
                    colors: [
                      ColorResources.gradientColor,
                      ColorResources.gradientColor.withOpacity(0.5),
                      ColorResources.secondaryColor.withOpacity(0.3),
                      ColorResources.gradientColor.withOpacity(0.05),
                      ColorResources.gradientColor.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    elevation: 1,
                    onPressed: () => Get.to(const ShoppingScreen()),
                    //  Get.to(()=> const CameraScreen(
                    //   fromEditProfile: false, isBarCodeScan: true, isHome: true,
                    // )),
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenHeight * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF1b4922).withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3)),
                        ],
                        color: const Color(0xFFFFA000),
                      ),
                      child: Image.asset(
                        'assets/image/shop.png',
                        // height: screenHeight * 0.025,
                        // width: screenHeight * 0.025,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : InkWell(
                onTap:  () {Get.to(const ShoppingScreen());
              mtnMomoApiClient.createMomoToken();
              },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFA000).withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                    color: const Color(0xFFFFA000), // Amber 700 as base color
                  ),
                  child: Image.asset(
                    'assets/image/shop.png',
                    // height: screenHeight * 0.025,
                    // width: screenHeight * 0.025,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorResources.getBlackAndWhite().withOpacity(0.14),
                  blurRadius: 80,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: ColorResources.getBlackAndWhite().withOpacity(0.20),
                  blurRadius: 0.5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomItemWidget(
                  onTop: () => menuController.selectHomePage(),
                  icon: menuController.currentTabIndex == 0
                      ? Images.homeIconBold
                      : Images.homeIcon,
                  name: 'home'.tr,
                  selectIndex: 0,
                ),
                BottomItemWidget(
                  onTop: () => menuController.selectHistoryPage(),
                  icon: menuController.currentTabIndex == 1
                      ? Images.clockIconBold
                      : Images.clockIcon,
                  name: 'Ababyeyi'.tr,
                  selectIndex: 1,
                ),
                const SizedBox(height: 20, width: 20),
                BottomItemWidget(
                  onTop: () => menuController.selectNotificationPage(),
                  icon: menuController.currentTabIndex == 2
                      ? Images.notificationIconBold
                      : Images.notificationIcon,
                  name: 'School Card'.tr,
                  selectIndex: 2,
                ),
                BottomItemWidget(
                  onTop: () => menuController.selectProfilePage(),
                  icon: menuController.currentTabIndex == 3
                      ? Images.profileIconBold
                      : Images.profileIcon,
                  name: 'profile'.tr,
                  selectIndex: 3,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _onWillPop(BuildContext context) {
    DialogHelper.showAnimatedDialog(
      context,
      CustomDialogWidget(
        icon: Icons.exit_to_app_rounded,
        title: 'exit'.tr,
        description: 'do_you_want_to_exit_the_app'.tr,
        onTapFalse: () => Navigator.of(context).pop(false),
        onTapTrue: () {
          SystemNavigator.pop()
              .then((value) => Get.offAll(() => const SplashScreen()));
        },
        onTapTrueText: 'yes'.tr,
        onTapFalseText: 'no'.tr,
      ),
      dismissible: false,
      isFlip: true,
    );
  }
}
