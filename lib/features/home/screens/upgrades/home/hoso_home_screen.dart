import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/rounded_button_widget.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/announcement_controller.dart';
import 'package:hosomobile/features/home/controllers/class_controller.dart';
import 'package:hosomobile/features/home/domain/models/announcement_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/add_account.dart';
import 'package:hosomobile/features/home/widgets/announcement_widget.dart';
import 'package:hosomobile/features/introduction/screen/appbar_header_widget.dart';
import 'package:hosomobile/features/language/controllers/localization_controller.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:http/http.dart' as http;
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/history/controllers/transaction_history_controller.dart';
import 'package:hosomobile/features/home/controllers/banner_controller.dart';
import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
import 'package:hosomobile/features/home/controllers/home_controller.dart';
import 'package:hosomobile/features/home/controllers/school_requirement_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/websitelink_controller.dart';
import 'package:hosomobile/features/home/domain/models/banner_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/hoso_services/hoso_services.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:hosomobile/features/home/widgets/banner_widget.dart';
import 'package:hosomobile/features/home/widgets/edubox_material_widget.dart';
import 'package:hosomobile/features/home/widgets/linked_website_widget.dart';
import 'package:hosomobile/features/student/widgets/student_widget.dart';
import 'package:hosomobile/features/notification/controllers/notification_controller.dart';
import 'package:hosomobile/features/requested_money/controllers/requested_money_controller.dart';
import 'package:hosomobile/features/setting/controllers/profile_screen_controller.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/helper/price_converter_helper.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class HosoHomeScreen extends StatefulWidget {
  static String routeName = 'HosoHomeScreen';

  const HosoHomeScreen({super.key});

  @override
  _HosoHomeScreenState createState() => _HosoHomeScreenState();
}

class _HosoHomeScreenState extends State<HosoHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isDeposite = false;
  UserShortDataModel? userData;
  String? userId;
  List<BannerModel>? banners;
  List<AnnouncementModel>? announcenents;
  List<SchoolLists>? schoolList;

  Future<void> _loadData(BuildContext context, bool reload, String id) async {
    if (reload) {
      // Reload configurations and user data if needed
      Get.find<SplashController>().getConfigData();
    }

    // Wait for banner data to load
    await Get.find<BannerController>()
        .getBannerList(reload, type: 1, application: 1)
        .then((_) {
      banners = Get.find<BannerController>().bannerList;
    });

    await Get.find<AnnouncementController>()
        .getAnnouncementList(reload)
        .then((_) {
      announcenents = Get.find<AnnouncementController>().announcementList;
    });
    await Get.find<SchoolListController>()
        .getSchoolListData(1, reload: reload)
        .then((_) {
      schoolList = Get.find<SchoolListController>().schoolList;
    });

    // Perform the other fetch operations as needed
    Get.find<ProfileController>().getProfileData(reload: reload);
    Get.find<RequestedMoneyController>()
        .getRequestedMoneyList(reload, isUpdate: reload);
    Get.find<RequestedMoneyController>()
        .getOwnRequestedMoneyList(reload, isUpdate: reload);
    Get.find<TransactionHistoryController>()
        .getTransactionData(1, reload: reload);
  Get.find<AllSchoolController>().getSchoolList(reload);

    Get.find<ShopController>().getShopList(reload);
    Get.find<ShopController>().getCategoryList(reload);
    Get.find<ShopController>().getBrandList(reload); 
    Get.find<ShopController>().getAttributeList(reload); 

    Get.find<ClassController>().getClasList(reload);
    Get.find<StudentController>()
        .getStudentList(reload, isUpdate: reload, id: id);
    Get.find<SchoolRequirementController>().getSchoolRequirementList(reload,
        schoolId: 1, classId: 1, studentId: 322);
    Get.find<NotificationController>().getNotificationList(reload);
    Get.find<TransactionMoneyController>()
        .getPurposeList(reload, isUpdate: reload);
    Get.find<TransactionMoneyController>().getWithdrawMethods(isReload: reload);
    Get.find<RequestedMoneyController>().getWithdrawHistoryList(reload: false);
    Get.find<EduboxMaterialController>()
        .getEduboxMaterialList(false, schoolId: 0, classId: 0, studentId: 300);
  }

  @override
  void initState() {
    super.initState();
    userData = Get.find<AuthController>().getUserData();
    userId = Get.find<AuthController>().getUserId();

    _loadData(context, false, userId!);

    print('++++++++++++++++ user: $userId');
  }

  void onDeposit() {
    setState(() {
      isDeposite = !isDeposite;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final String languageText = AppConstants
        .languages[Get.find<LocalizationController>().selectedIndex]
        .languageName!;
    // Now the bannerList will be populated

    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: const Color(0xFF777777),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenHeight >= 763 ? 290 : 150,
                  width: screenWidth,
                  color: kyellowColor,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight >= 763 ? 10 : 3),
                            SizedBox(
                              height: screenHeight >= 763 ? 70 : 30,
                              width: screenHeight >= 763 ? 185 : 70,
                              child: const IconImages(
                                  'assets/image/HOSO MOBILE.png'),
                            ),
                            sizedBox05h,
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: RoundedButtonWidget(
                          buttonText: languageText,
                          onTap: AppConstants.languages.length > 1
                              ? () {
                                  Get.toNamed(
                                      RouteHelper.getChoseLanguageRoute());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kOtherColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight >= 763 ? 101 : 91),
                        Center(
                          child: SizedBox(
                            width: screenWidth >= 520 ? 340 : screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${'announcement'.tr}:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 3.0),
                                    child: Text('more'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: kTextLightColor,
                                                fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const AnnouncementWidget(),
                        const SizedBox(height: 5),
                        const BannerWidget(),
                        const SizedBox(height: 5),
                        Divider(
                          thickness: 1.0,
                          color: kTextBlackColor,
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
                  ),
                ),
              ],
            ),
            Positioned(
              top: screenHeight >= 763 ? 200 : 100,
              left: screenWidth >= 520 ? screenWidth / 6.5 : 20,
              right: screenWidth >= 520 ? screenWidth / 6.5 : 20,
              child: HomeCard1(
                icon: 'assets/icons1/edupotoERP.png',
                title: 'title',
                clas: 'clas',
                onClickFunction: () => Get.to(const NoConnection()),
              ),
            ),
          ],
        ),
        // floatingActionButton: Container(
        //   height: screenHeight * 0.1,
        //   width: screenHeight * 0.1,
        //   margin: EdgeInsets.all(7),
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     boxShadow: [
        //       BoxShadow(
        //           color: kTextLightColor,
        //           spreadRadius: 3,
        //           blurRadius: 7,
        //           offset: Offset(0, 3)),
        //     ],
        //     color: Color(0xFF1b4922),
        //   ),
        //   child: InkWell(
        //     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentpotoScreen(),)),
        //     child: Padding(
        //       padding: EdgeInsets.all(10),
        //       child: Image.asset(
        //         'assets/icons1/tax speech button.png',
        //         height: screenHeight * 0.025,
        //         width: screenHeight * 0.025,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class HomeCard1 extends StatefulWidget {
  const HomeCard1(
      {super.key,
      required this.icon,
      required this.title,
      required this.clas,
      required this.onClickFunction});

  final String icon;
  final String title;
  final String clas;
  final Function() onClickFunction;
  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  bool isClicked = false;

  MtnMomoApiClient mtnMomoApiClient = MtnMomoApiClient();
  //click to see currency values
  onClick() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  showDetails() async {}

  @override
  void initState() {
    // TODO: implement initState
    showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: kTextLightColor,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3)),
            ],
            color: kTextWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: screenWidth >= 520 ? 340 : screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          screenHeight >= 763
                              ? sizedBox
                              : const SizedBox(height: 10),
                          const AppBarHeaderWidget()
                        ],
                      ),
                      SizedBox(height: screenHeight >= 763 ? 30 : 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BorderButton1(
                              borderColor: kTextBlackColor,
                              vertical: screenHeight >= 763 ? 10.0 : 5,
                              textColor: kTextBlackColor,
                              horizontal: screenHeight >= 763 ? 10.0 : 5,
                              onPress: () {
                                mtnMomoApiClient.createMomoToken();
                                Get.to(const MzaziScreen(
                                  isShop: false,
                                ));
                              },
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>MzaziScreen())),
                              height: 30,
                              width:
                                  screenWidth >= 520 ? 148 : screenWidth / 2.5,
                              icon: 'parent_button'.tr,
                              title: 'assets/image/Ababyeyi Icon.png',
                              clas: ''),
                          const Spacer(),
                          BorderButton1(
                              borderColor: kTextBlackColor,
                              vertical: screenHeight >= 763 ? 10.0 : 5,
                              textColor: kTextBlackColor,
                              horizontal: screenHeight >= 763 ? 10 : 5,
                              onPress: () =>
                                  _launchURL('https://supply.hosomobile.rw/'),
                              height: 30,
                              width:
                                  screenWidth >= 520 ? 148 : screenWidth / 2.5,
                              icon: 'school_button'.tr,
                              title: 'assets/image/School Amashuri Icon.png',
                              clas: ''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Positioned(
              //   top: 8,
              //   left: 0,
              //   right: 0,
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,

              //       children: [
              // SizedBox(height: 40,width: 100,child: IconImages('assets/icons1/Latest Student SmartCard Logo.png')),
              // SizedBox(height: 60,width:70)
              //     ],),
              // ),

              // is visible
            ],
          ),
        ),
      ),
      sizedBox,
    ]);
  }

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HomeCard2 extends StatefulWidget {
  const HomeCard2({
    required this.isDeposite,
    required this.bannerList,
    super.key,
  });
  final bool isDeposite;
  final List<BannerModel> bannerList;
  @override
  State<HomeCard2> createState() => _HomeCard2State();
}

class _HomeCard2State extends State<HomeCard2> {
  List orderLists = [], announcement = [];
  bool isLoading = false;

  String appBase = AppConstants.baseUrl;
  String imageUri = AppConstants.getImage;
  List<String> banner = []; // List to hold image URLs or asset paths

  var getUserId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Check if bannerList is loaded
    if (widget.bannerList.isEmpty) {
      return const Center(
          child:
              CircularProgressIndicator()); // Show loading spinner if data is not available
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 150,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            initialPage: 1,
          ),
          itemCount:
              widget.bannerList.length, // Use the length of the banner list
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            final bannerImage =
                '$appBase$imageUri${widget.bannerList[index].image}'; // Assuming `imageUrl` is the field in BannerModel that holds the image URL

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  width: 350, // specify the width here
                  // height: 300, // specify the height here
                  child: Image.network(
                    bannerImage, // Display the network image if it's a URL
                    fit: BoxFit.cover,
                  )
                  // : Image.asset(
                  //     bannerImage,  // Display the local asset image
                  //     fit: BoxFit.cover,
                  //   ),
                  ),
            );
          },
        ),
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
