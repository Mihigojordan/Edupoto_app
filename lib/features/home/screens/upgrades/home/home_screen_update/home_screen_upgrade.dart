import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/common/widgets/rounded_button_widget.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/home_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/hoso_home_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/hoso_services/hoso_services.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/add_account.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:hosomobile/features/home/widgets/floating_action_button_widget.dart';
import 'package:hosomobile/features/student/widgets/student_widget.dart';
import 'package:hosomobile/features/language/controllers/localization_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:upgrader/upgrader.dart';

class MzaziScreen extends StatefulWidget {
  static String routeName = 'MzaziScreen';
  final bool isShop;
  final int isNavigation;

  const MzaziScreen({super.key, required this.isShop, this.isNavigation = 0});

  @override
  _MzaziScreenState createState() => _MzaziScreenState();
}

class _MzaziScreenState extends State<MzaziScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();
  bool isTeacherLoggedIn = false;
  bool isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  bool isDeposite = false;
  bool isAddAccount = false;
  late UserShortDataModel? userData;

  late String videoTitle;
  // Url List
  final List<String> _videoUrlList = [
    'https://youtu.be/dWs3dzj4Wng',
    'https://www.youtube.com/watch?v=668nUCeBHyY',
    '8ElxB_w0Bk0',
    'https://youtu.be/S3npWREXr8s',
  ];

  onDeposit() {
    setState(() {
      isDeposite = !isDeposite;
    });
  }

  Map<String, dynamic> cStates = {};
  //changes current state

  @override
  void initState() {
    // TODO: implement initState
    // _checkVersion();
    userData = Get.find<AuthController>().getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return UpgradeAlert(
        child: Scaffold(
      backgroundColor: const Color(0xFF777777),
      //  drawer: NavDrawer(),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight / 3,
                width: screenWidth,
                color: kyellowColor,
                child: Stack(
                  children: [
                    // ImagesUp (  Images.launch_page),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.0, left: screenHeight >= 763 ? 123 : 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          screenHeight >= 763
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(children: [
                                      userData?.name != null
                                          ? Text(
                                              '${'welcome'.tr}, ${userData?.name}' ??
                                                  '',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: kTextBlackColor,
                                                  fontWeight: FontWeight.w200),
                                            )
                                          : Text(
                                              '${'welcome'.tr}, ${'parent'.tr}',
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: kTextBlackColor,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                      GetBuilder<HomeController>(
                                          builder: (controller) {
                                        return Text(
                                          controller.greetingMessage(),
                                          style: rubikRegular.copyWith(
                                            fontSize: screenHeight >= 763
                                                ? Dimensions.fontSizeExtraLarge
                                                : Dimensions.fontSizeDefault,
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                    ]),
                        
                               
                                  ],
                                )
                              : const SizedBox(),
                         
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).sizeeight,
                  //   padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: kOtherColor,
                    //reusable radius,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sizedBox15,
                      // Column(
                      //   children: [
                      //     sizedBox,
                      //     Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           sizedBox,

                      //           // Container(
                      //           //   height: 40,
                      //           //   width: 195,
                      //           //   child: IconImages('assets/icons1/Edupoto Menu logo.png'),
                      //           // ),
                      //         ]),
                      //   ],
                      // ),
                      // Divider(
                      //   thickness: 1,
                      //   color: kTextLightColor,
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),

                      // ImageSlider(
                      //   list: [
                      //     'assets/icons1/1.png',
                      //     'assets/icons1/2a.jpeg',
                      //     'assets/icons1/3.png',
                      //     'assets/icons1/2a.jpeg',
                      //     'assets/icons1/1.png',
                      //     'assets/icons1/2a.jpeg',
                      //   ],
                      //   height: 17,
                      //   axis: Axisorizontal,
                      //   sec: 4,
                      // ),
                      // Expanded(
                      //   child: Container(
                      //     // height: 300,
                      //     child: MzaziPannel(),
                      //   ),
                      // )
                      // SizedBox(
                      //   height: 50,
                      // ),
                      // Container(
                      //     height: 54,
                      //     width: 220,
                      //     child: IconImages(
                      //         'assets/icons1/edupoto white logo.png')),
                      // SizedBox(
                      //   height: 1,
                      // ),
                      Column(
                        children: [
                          sizedBox,
                          // HomeCard2(
                          //   isDeposite: isDeposite,
                          // ),
                          sizedBox5,
                          const Divider(
                            thickness: 1.0,
                            color: kTextLightColor,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.01,
                                vertical: screenHeight * 0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BorderButton1(
                                    borderColor: kTextBlackColor,
                                    vertical: screenHeight * 0.005,
                                    textColor: kTextBlackColor,
                                    horizontal: screenWidth * 0.025,
                                    onPress: () => Get.to(AddAccount(
                                          isDirectory: true,
                                          productIndex: 0,
                                          iconImages:
                                              "${AppConstants.baseUrl}/storage/app/public/edupoto_product/titleImage",
                                        )),
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.30,
                                    icon:
                                        '${'school_directory_button_school'.tr}\n${'school_directory_button_directory'.tr}',
                                    title: 'assets/image/Schools Directory.png',
                                    clas: ''),
                                BorderButton1(
                                    borderColor: kTextBlackColor,
                                    vertical: screenHeight * 0.005,
                                    textColor: kTextBlackColor,
                                    horizontal: screenWidth * 0.025,
                                    onPress: () => Get.to(const NoConnection()),
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.30,
                                    icon:
                                        '${'recharge_school_card_button_recharge'.tr}\n${'recharge_school_card_button_school_card'.tr}',
                                    title: 'assets/image/cashout3.png',
                                    clas: ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight >= 763 ? 10 : 10,
            left: 10,
            child: const CustomBackButton(),
          ),
          Positioned(
            top: screenHeight >= 763 ? 20 : 20,
            left: screenWidth >= 520 ? screenWidth / 6.5 : 20,
            right: screenWidth >= 520 ? screenWidth / 6.5 : 20,
            child: const StudentWidget(),
          ),
        ],
      ),
      floatingActionButton: widget.isNavigation == 1
          ? null
          : !kIsWeb
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
                    onPressed: () => Get.back(),
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
                              color: const Color(0xFFFFFFFF).withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 3)),
                        ],
                        color: const Color(0xFFFFFFFF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/image/home_bold.png',
                          height: screenHeight * 0.015,
                          width: screenHeight * 0.015,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              : FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  elevation: 1,
                  onPressed: () => Get.back(),
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
                            color: const Color(0xFFFFFFFF).withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                      color: const Color(0xFFFFFFFF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/image/home_bold.png',
                        height: screenHeight * 0.015,
                        width: screenHeight * 0.015,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //       actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.add_circle),
      //     tooltip: 'Add new entry',
      //     onPressed: () { /* ... */ },
      //   ),
      // ],
    ));
  }

  _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 200,
                  child: IconImages(Images.page_logo),
                ),
              ],
            ),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    BorderButton1(
                        borderColor: Colors.black,
                        vertical: 5.0,
                        textColor: Colors.black,
                        horizontal: 10,
                        onPress: () {},
                        height: 30,
                        width: 110,
                        icon: 'Parent',
                        title: '',
                        clas: ''),
                    const Spacer(),
                    BorderButton1(
                        borderColor: Colors.black,
                        vertical: 5.0,
                        textColor: Colors.black,
                        horizontal: 10,
                        onPress: () {},
                        height: 30,
                        width: 110,
                        icon: 'Teacher',
                        title: '',
                        clas: ''),
                  ],
                ),
              )
            ],
          ),
        )) ??
        false;
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.color});
  final Color color;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool _selectedIndex = false;
  void _onItemTapped() {
    setState(() {
      _selectedIndex = !_selectedIndex;
    });
  }

  void saveBottomNavItem() async {}

  String getItem = '';
  void getBottomnavItem() async {
    print('dah $getItem');
  }

  bool? isUserLoggedIn = false;

  showDetails() async {}

  @override
  void initState() {
    showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      //margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  enableFeedback: false,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HosoHomeScreen()),
                        (route) => false);
                  },
                  child: const SizedBox(
                      height: 40,
                      width: 30,
                      child: IconImages('assets/image/hoso_mobile1.png'))),
              sizedBox05h,
              const Text("HOSO Mobile", style: ktextWhite),
            ],
          ),
          getItem != 'mentor'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        enableFeedback: false,
                        onTap:
                            () {}, //=> Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentpotoScreen(),)),
                        child: const SizedBox(
                          height: 40,
                          width: 40,
                          //radius: 40,
                          child:
                              IconImages('assets/icons1/mzazi lower icon.png'),
                        )
                        //  pageIndex == 0
                        //     ?

                        // : const Icon(
                        //     Iconsome_outlined,
                        //     color: Colors.white,
                        //     size: 35,
                        //   ),
                        ),
                    sizedBox05h,
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width / 7.0,
                      child: const Text(
                        'Mentor',
                        overflow: TextOverflow.ellipsis,
                        style: ktextWhite,
                      ),
                    ),
                  ],
                )
              : Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                enableFeedback: false,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MzaziScreen(
                        isShop: false,
                      ),
                    )),
                child:
                    //  pageIndex == 1
                    //     ?
                    const SizedBox(
                  height: 40,
                  width: 30,
                  // radius: 20,
                  child: IconImages('assets/image/Ababyeyi Icon.png'),
                ),
              ),
              sizedBox05h,
              const Text("Mzazi", style: ktextWhite),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       enableFeedback: false,
          //       onTap: () {
          //         setState(() {
          //           Navigator.pushNamed(context, NoConnection.routeName);
          //           //   pageIndex = 1;
          //         });
          //       },
          //       child:
          //           //  pageIndex == 1
          //           //     ?
          //           Container(
          //               height: 4.6,
          //               width: 11.w,
          //               child: IconImages('assets/icons1/unipoto icon.png')),
          //     ),
          //     sizedBox05h,
          //     Container(
          //       alignment: Alignment.bottomCenter,
          //       width: MediaQuery.of(context).size / 7.0,
          //       child: Text(
          //           overflow: TextOverflow.ellipsis,
          //           "Unipoto",
          //           style: ktextWhite),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _BalanceWidgetUp extends StatelessWidget {
  const _BalanceWidgetUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              PriceConverterHelper.balanceWithSymbol(
                  balance: '${profileController.userInfo?.balance ?? 0}'),
              style: ktextBBlack16),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          if (profileController.userInfo != null)
            Text(
              '(${'sent'.tr} ${PriceConverterHelper.balanceWithSymbol(balance: '${profileController.userInfo?.pendingBalance ?? 0}')} ${'withdraw_req'.tr})',
              style: ktextBBlack,
            ),
        ],
      );
    });
  }
}
