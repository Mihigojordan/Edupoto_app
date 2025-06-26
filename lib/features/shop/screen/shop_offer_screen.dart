import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/shop/screen/shop_screen.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopOfferScreen extends StatefulWidget {
  static String routeName = 'ShopScreen';

  const ShopOfferScreen({super.key});

  @override
  ShopOfferScreenState createState() => ShopOfferScreenState();
}

class ShopOfferScreenState extends State<ShopOfferScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  late String videoTitle;
  // Url List
  final List<String> _videoUrlList = [
    'https://youtu.be/dWs3dzj4Wng',
    'https://www.youtube.com/watch?v=668nUCeBHyY',
    '8ElxB_w0Bk0',
    'https://youtu.be/S3npWREXr8s',
  ];

  Map<String, dynamic> cStates = {};
  //changes current state

  bool? isUserLoggedIn = false;
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};

  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.BsT7.edupoto",
  //   );
  //   final  status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status!,
  //     dialogTitle: "UPDATE!!!",
  //     dismissButtonText: "Skip",
  //     dialogText: "Please update the app from " +
  //         "${status.localVersion}" +
  //         " to " +
  //         "${status.storeVersion}",
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "Lets update",
  //   );

  //   print("DEVICE : " + status.localVersion);
  //   print("STORE : " + status.storeVersion);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _checkVersion();

    // showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;

    return UpgradeAlert(
        child: Scaffold(
      backgroundColor: kOtherColor,
      // drawer: NavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                color: kyellowColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(
                              height: screenHeight >= 763 ? 70 : 30,
                              width: screenHeight >= 763 ? 290 : 150,
                              child: const IconImages(
                                  'assets/image/HOSO MOBILE.png'),
                            ),
                            sizedBox05h
               
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kyellowColor,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height,
                    //   padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                        color: kOtherColor,
                        //reusable radius,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 10,
            left: 10,
            child: CustomBackButton(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: 20,
            right: 20,
            child: const HomeCard1(
                phoneNumber: 'assets/icons1/edupotoERP.png',
                title: 'title',
                fromEdit: false),
          ),
        ],
      ),

      //   bottomNavigationBar: BottomNav(
      //   color: kamber300Color,
      // ),
    ));
  }
}

class HomeCard1 extends StatefulWidget {
  const HomeCard1(
      {super.key,
      required this.phoneNumber,
      required this.title,
      required this.fromEdit});

  final String phoneNumber;
  final String title;
  final bool? fromEdit;
  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
    // Track whether the user has successfully verified their identity
  bool _isVerified = false;

  String? phoneNumber;
  String studentcardValue = 'Choose student\'s card to fund';
  String productValue = 'Choose product to save for';
  String transactionType = 'add_money';
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};

  late ContactController contactController;
  // Controllers for ID and password input
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ContactModel? _contact;
//   String? customerImageBaseUrl =
//       Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl;

//   String? agentImageBaseUrl =
//       Get.find<SplashController>().configModel!.baseUrls!.agentImageUrl;
//   final ScrollController _scrollController = ScrollController();
//   String? _countryCode;
//    ContactModel? contactModel;
//   ContactModel? get contact => _contact;
// final FocusNode _inputAmountFocusNode = FocusNode();
  // void setFocus() {
  //   _inputAmountFocusNode.requestFocus();
  //   Get.back();
  // }

  @override
  void initState() {
    final ContactController contactController = Get.find<ContactController>();

    // _countryCode = CountryCode.fromCountryCode(
    //         Get.find<SplashController>().configModel!.country!)
    //     .dialCode;

    contactController.onSearchContact(searchTerm: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController searchController = TextEditingController();
    // widget.fromEdit! ? searchController.text = phoneNumber! : const SizedBox();
    return Container(
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
      height: 300,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              'assets/image/hoso_mobile.png',
             // 'assets/image/AFOS_LOGO.png', // Add your logo here
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
             Text('cerify_your_identity'.tr),
            TextField(
              controller: _idController,
              decoration:  InputDecoration(
                labelText: 'id_number'.tr,
                hintText: 'enter_your_id_number'.tr,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                labelText: 'password'.tr,
                hintText: 'enter_your_password'.tr,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Go back to the previous page
                  },
                  child:  Text('cancel'.tr),
                ),
                // Submit Button
                TextButton(
                  onPressed: () {
                    // Validate ID and password
                    if (_idController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      setState(() {
                        _isVerified = true; // Mark user as verified
                      });
                      Get.to(const ShoppingScreen(isOffer: true));
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text('verification_successfully'.tr),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text('please_enter_your_id_and_password'.tr),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('submit'.tr),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // sendMoney() {
  //   _contact = ContactModel(
  //       phoneNumber: numberEditingController.text,
  //       avatarImage: productValue,
  //       name: studentcardValue);
  // }

  TextFormField buildFormField(String labelText,
      TextEditingController editingController, TextInputType textInputType) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      keyboardType: textInputType,
      style: kInputTextStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 15), //Change this value to custom as you like
        isDense: true,
        focusedBorder: OutlineInputBorder(
          ////<-- SEE HERE
          borderSide: const BorderSide(width: 1, color: kamber300Color),
          borderRadius: BorderRadius.circular(20.0),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kTextLightColor),
          borderRadius: BorderRadius.circular(20.0),
        ),

        errorBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20.0),
          //<-- SEE HERE
        ),

        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        // RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
        //  else if (!regExp.hasMatch(value)) {
        //   return 'Please enter a valid Email';
        // }
      },
    );
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
