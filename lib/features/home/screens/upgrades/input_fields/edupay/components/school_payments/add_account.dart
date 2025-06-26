import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/widgets/all_school_widget.dart';
import 'package:hosomobile/features/school_directory/widgets/school_directory_dropdown.dart';
import 'package:hosomobile/util/images.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAccount extends StatefulWidget {
  static String routeName = 'AddAccount';
  final String iconImages;
  final int productIndex;
  bool? isDirectory;

 AddAccount({super.key,required this.iconImages,required this.productIndex,this.isDirectory});

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
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

  showDetails() async {}

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

    showDetails();
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
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: kyellowColor,
                child: Stack(
                  children: [
                    // SizedBox(
                    //   // height: 0,
                    //   child: ImagesUp(Images.launch_page),
                    // ),
                     Column(
                                        crossAxisAlignment:
                                   CrossAxisAlignment.center,
                                        children: [
                                          sizedBox,
                                          sizedBox15,
                                          widget.isDirectory==true?   Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 30),
                                            child: RichText(
                                                  text: TextSpan(
                                                    text: 'School_directory'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                               
                                                  ),
                                                ),
                                          ):
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: widget.productIndex == 0
                                                    ? 235
                                                    : 150,
                                                child: IconImageWidget(
                                                    image: widget.iconImages,
                                                    fit: BoxFit.cover,
                                                    placeholder: Images
                                                        .bannerPlaceHolder),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kamber300Color,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height,
                    //   padding: EdgeInsets.symmetric(vertical: 5.h),
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
               Positioned(
      top:screenHeight>=763? 10:10,
         left:screenWidth>=520? 10:10,

            child:const CustomBackButton(),
          ),
     Positioned(
              top: 150,
              left: 20,
              right: 20,
              child:widget.isDirectory==true?const SchoolDirectoryDropdowns():const AllSchoolWidget()),
                
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
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: kTextWhiteColor, //                   <--- border color
                width: 1.0,
              ),
            ),
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width / 2,
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
            height: MediaQuery.of(context).size.height/3,
            color: kTextLightColor.withOpacity(0.7),
            child: const Center(child: CircularProgressIndicator()))
        : CarouselSlider.builder(
            options: CarouselOptions(
              height:MediaQuery.of(context).size.height/3,
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
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height/3,
                      child: const Center(
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
