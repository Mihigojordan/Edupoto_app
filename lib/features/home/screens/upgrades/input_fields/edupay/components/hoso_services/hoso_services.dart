import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HosoServices extends StatefulWidget {
  static String routeName = 'HosoServices';

  const HosoServices({super.key});

  @override
  HosoServicesState createState() => HosoServicesState();
}

class HosoServicesState extends State<HosoServices> {
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
                child: Stack(
                  children: [
                    const Positioned(
                        left: 100,
                        right: 100,
                        top: 50,
                        child: SizedBox(
                          height: 80,
                          width: 120,
                          child: IconImages('assets/image/hoso_services.png'),
                        )),
                    Positioned(
                        right: 100,
                        left: 120,
                        top: 150,
                        child: Row(
                          children: [
                            Text(
                              'HOSO Services',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  
                                      color:Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                
                          ],
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kamber300Color,
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
       const       Positioned(
      top:10,
         left:10,

            child:CustomBackButton(),
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

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.clas});
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: kTextWhiteColor, //                   <--- border color
                width: 1.0,
              ),
            ),
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width / 7,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ButtonImages(icon),
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: ktextWhite,
          )
        ],
      ),
    );
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

  String? phoneNumber;
  String studentcardValue = 'Choose student\'s card to fund';
  String productValue = 'Choose product to save for';
  String transactionType = 'add_money';
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};

  late ContactController contactController;
  TextEditingController cardEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController productEditingController = TextEditingController();
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
        child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox,

                  const Text('The School Leader'),
                  const Divider(),
 
              sizedBox15,
       const Text('Teacher Talk'),
                  const Divider(),
              sizedBox15,
    const Text('HOSO Channel'),
                  const Divider(),
              sizedBox15,
  const Text('HOSO Notice Board'),
                  const Divider(),
              sizedBox10,
            ]),
      ),
    );
  }

  sendMoney() {
    _contact = ContactModel(
        phoneNumber: numberEditingController.text,
        avatarImage: productValue,
        name: studentcardValue);
  }

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

class HomeCard2 extends StatefulWidget {
  const HomeCard2({
    super.key,
  });

  @override
  State<HomeCard2> createState() => _HomeCard2State();
}

class _HomeCard2State extends State<HomeCard2> {
  List orderLists = [], announcement = [];
  bool isLoading = false;
  var getUserId;

  Future listOrder() async {
    var url = 'https://roya.shulepoto.cloud/api/ads';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        orderLists = json.decode(response.body)['ads'];
        isLoading = true;
      });
      print('wayaa: $orderLists');
    } else {
      print('fail');
    }
  }

  @override
  void initState() {
    listOrder();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? Container(
            height: 20,
            color: kTextLightColor.withOpacity(0.7),
            child: const Center(child: CircularProgressIndicator()))
        : CarouselSlider.builder(
            options: CarouselOptions(
              height: 20,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              initialPage: 1,
            ),
            itemCount: orderLists.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              return orderLists[index] == []
                  ? const SizedBox(
                      height: 20,
                      child: Center(
                        child: Text(
                          'No Ads for now',
                          style: ktextLight,
                        ),
                      ))
                  : FadeInImage.assetNetwork(
                      image: orderLists[index]['ads_banner'] == null
                          ? "https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg"
                          : "https://roya.shulepoto.cloud/storage/ads_banner/${orderLists[index]['ads_banner']}",

                      placeholder:
                          "assets/icons1/noads.webp", // your assets image path
                      fit: BoxFit.fill,
                    );
            },
          );
  }
}
