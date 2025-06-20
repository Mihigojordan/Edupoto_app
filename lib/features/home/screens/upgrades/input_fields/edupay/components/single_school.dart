// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hosomobile/common/models/contact_model.dart';
// import 'package:hosomobile/common/models/contact_model_mtn.dart';
// import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
// import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
// import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
// import 'package:hosomobile/features/home/controllers/school_requirement_controller.dart';
// import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
// import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
// import 'package:hosomobile/features/home/domain/models/school_requirement_model.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
// import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_invoice.dart';
// import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
// import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
// import 'package:hosomobile/features/transaction_money/screens/school_transaction_confirmation_screen.dart';

// import 'package:hosomobile/helper/transaction_type.dart';

// import 'package:url_launcher/url_launcher.dart';
// import 'package:upgrader/upgrader.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SingleSchool extends StatefulWidget {
//   static String routeName = 'SingleSchool';

//   Student? studentId;
 
//   AllSchoolModel? schoolId;
//   ClassDetails? classId;
//   SingleSchool({super.key,this.classId, this.schoolId, this.studentId});

//   @override
//   _SingleSchoolState createState() => _SingleSchoolState();
// }

// class _SingleSchoolState extends State<SingleSchool> {
//   //validate our form now
//   final _formKey = GlobalKey<FormState>();
  
//   late String videoTitle;
//   // Url List
//   final List<String> _videoUrlList = [
//     'https://youtu.be/dWs3dzj4Wng',
//     'https://www.youtube.com/watch?v=668nUCeBHyY',
//     '8ElxB_w0Bk0',
//     'https://youtu.be/S3npWREXr8s',
//   ];

//   Map<String, dynamic> cStates = {};
//   //changes current state

//   bool? isUserLoggedIn = false;

//   showDetails() async {}

//   // void _checkVersion() async {
//   //   final newVersion = NewVersion(
//   //     androidId: "com.BsT7.edupoto",
//   //   );
//   //   final  status = await newVersion.getVersionStatus();
//   //   newVersion.showUpdateDialog(
//   //     context: context,
//   //     versionStatus: status!,
//   //     dialogTitle: "UPDATE!!!",
//   //     dismissButtonText: "Skip",
//   //     dialogText: "Please update the app from " +
//   //         "${status.localVersion}" +
//   //         " to " +
//   //         "${status.storeVersion}",
//   //     dismissAction: () {
//   //       SystemNavigator.pop();
//   //     },
//   //     updateButtonText: "Lets update",
//   //   );

//   //   print("DEVICE : " + status.localVersion);
//   //   print("STORE : " + status.storeVersion);
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     // _checkVersion();

//     showDetails();
//     super.initState();
//     fetchData();
//   }
//    Future<void> fetchData() async {
//   try {
//    await Get.find<EduboxMaterialController>()
//         .getEduboxMaterialList(
//       true,
//       isUpdate: false,
//       schoolId: widget.schoolId!.id!,
//       classId: widget.classId!.id!,
//       studentId: widget.studentId!.id!,
//     );

//  await  Get.find<SchoolRequirementController>()
//         .getSchoolRequirementList(
//       true,
//       isUpdate: false,
//       schoolId: widget.schoolId!.id!,
//       classId: widget.classId!.id!,
//       studentId: widget.studentId!.id!,
//     );
//   } catch (e) {
//     print("Error fetching data: $e");
 
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//         child: Scaffold(
//       backgroundColor: kOtherColor,
//       // drawer: NavDrawer(),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 3,
//                 width: MediaQuery.of(context).size.width,
//                 color: kyellowColor,
//                 child: Stack(
//                   children: [
//                     // SizedBox(
//                     //   // height: 0,
//                     //   child: ImagesUp(Images.launch_page),
//                     // ),
//                     Positioned(
//                         left: 20,
//                         right: 10,
//                         top: 40,
//                         child: RichText(
//                           text: TextSpan(
//                             text: '${widget.schoolId!.schoolName}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleMedium!
//                                 .copyWith(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight
//                                       .bold, // Bold only for 'St Michael’s School'
//                                 ),
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text:
//                                     '\n${widget.schoolId!.address}\nTel:',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .copyWith(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight
//                                           .normal, // Regular weight for the rest of the text
//                                     ),
//                               ),
//                               TextSpan(
//                                 text: '${widget.schoolId!.countryCode}${widget.schoolId!.phone}',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .copyWith(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight
//                                           .bold, // Regular weight for the rest of the text
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: kamber300Color,
//                   child: Container(
//                     //  height: MediaQuery.of(context).size.height,
//                     //   padding: EdgeInsets.symmetric(vertical: 5.h),
//                     decoration: const BoxDecoration(
//                         color: kOtherColor,
//                         //reusable radius,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20))),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//               top: 150,
//               left: 20,
//               right: 20,
//               child: HomeCard1(
//                 productName: 'Edubox Materials',
//                 studentId: widget.studentId!,
//                 schoolId: widget.schoolId!,
//                 classId: widget.classId!,
//               )),
//         ],
//       ),

//       //   bottomNavigationBar: BottomNav(
//       //   color: kamber300Color,
//       // ),
//     ));
//   }
// }

// class HomeCard extends StatelessWidget {
//   const HomeCard(
//       {super.key,
//       required this.onPress,
//       required this.icon,
//       required this.title,
//       required this.clas});
//   final VoidCallback onPress;
//   final String icon;
//   final String title;
//   final String clas;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPress,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(5)),
//               border: Border.all(
//                 color: kTextWhiteColor, //                   <--- border color
//                 width: 1.0,
//               ),
//             ),
//             height: MediaQuery.of(context).size.height / 14,
//             width: MediaQuery.of(context).size.width / 2,
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: ButtonImages(icon),
//             ),
//           ),
//           Text(
//             title,
//             overflow: TextOverflow.ellipsis,
//             style: ktextWhite,
//           )
//         ],
//       ),
//     );
//   }
// }

// class HomeCard1 extends StatefulWidget {
//   const HomeCard1(
//       {super.key,
//       required this.studentId,
//       required this.productName,
//       required this.schoolId,
//       required this.classId});

//   final Student studentId;
//   final String productName;
//   final AllSchoolModel schoolId;
//   final ClassDetails classId;
//   @override
//   State<HomeCard1> createState() => _HomeCard1State();
// }

// class _HomeCard1State extends State<HomeCard1> {
//   bool? isTeacherLoggedIn = false;
//   bool? isParentLoggedIn = false;
//   bool? isUserLoggedIn = false;
//   String studentCardValue = 'Choose from a list of partiner school';
//   String classValue = 'Class';
//   bool isSelected = false;
//   UserShortDataModel? userData;
//   TextEditingController classEditingController = TextEditingController();
//   TextEditingController numberEditingController = TextEditingController();
//   TextEditingController dayEditingController = TextEditingController();
//   TextEditingController nameEditingController = TextEditingController();
//   TextEditingController schoolNameEditingController = TextEditingController();

//   showDetails() async {}

// List<EduboxMaterialModel> eduboxMaterialList = [];
// List<SchoolRequirementModel> schoolList = [];

//   // This list will hold the state of each checkbox (checked or unchecked)
//   List<bool> _isChecked = [];
//   List<bool> _isReqChecked = [];

//   selectedVale() {
//     setState(() {
//       isSelected = !isSelected;
//       print(isSelected);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Initialize all checkboxes as unchecked (false)
// userData = Get.find<AuthController>().getUserData();
 
//   }

 


//   @override
//   Widget build(BuildContext context) {
 
//  return GetBuilder<SchoolRequirementController>(
//         builder: (schoolRequirementController) {
//              _isReqChecked = List<bool>.filled(schoolRequirementController.schoolRequirementList!.length, true);
//       return schoolRequirementController.isLoading
//           ? const WebSiteShimmer()
//           : schoolRequirementController.schoolRequirementList!.isEmpty
//               ? const SizedBox()
//               :
//     GetBuilder<EduboxMaterialController>(
//         builder: (eduboxMaterialController) {
//           _isChecked = List<bool>.filled(eduboxMaterialController.eduboxMaterialList!.length, true);
//       return eduboxMaterialController.isLoading
//           ? const WebSiteShimmer()
//           : eduboxMaterialController.eduboxMaterialList!.isEmpty
//               ? const SizedBox()
//               : Container(
//                   decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: kTextLightColor,
//                             spreadRadius: 3,
//                             blurRadius: 7,
//                             offset: Offset(0, 3)),
//                       ],
//                       color: kTextWhiteColor,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   height: MediaQuery.of(context).size.height / 1.3,
//                   width: 340,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListView(
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           alignment: Alignment.bottomLeft,
//                           child: TextButton(
//                               onPressed: () => selectedVale(),
//                               child: Text(
//                                 'Babyeyi: Ibisabwa',
//                                 textAlign: TextAlign.left,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleSmall!
//                                     .copyWith(
//                                         decoration: TextDecoration.underline,
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                         //  buildFormField(  'Choose student\'s card to fund',cardEditingController,TextInputType.text,),
//                         containerMethod1(
//                         requirementList: schoolRequirementController.schoolRequirementList![0].schoolRequirements!
//                         ),
                       

//                         sizedBox15,

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             iconImages('assets/image/edubox.png'),
//                           ],
//                         ),

//                         sizedBox10,
//                         containerMethod(
//                           productName:eduboxMaterialController.eduboxMaterialList![3].name!,
//                             materialList: eduboxMaterialController
//                                 .eduboxMaterialList![3]
//                                 .productTypes![0]
//                                 .eduboxMaterials!,
//                             productId: 9),
//                       ],
//                     ),
//                   ),
//                 );
//     });
//     });
//   }

// Widget containerMethod({
//   required List<EduboxMaterialModel> materialList,
//   required int productId,
//   required String productName,
// }) {
//   return Column(
//     children: [
//       Container(
//         height: MediaQuery.of(context).size.height / 5,
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           border: Border.all(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Scrollbar(
//           thumbVisibility: true,
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 6,
//             child: ListView.builder(
//               itemCount: materialList.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Checkbox(
//                         value: _isChecked[index], // Fixed index reference
//                         onChanged: (bool? value) {
//                           setState(() {
//                             _isChecked[index] = value ?? false;
//                           });
//                         },
//                       ),
//                       Expanded(
//                         child: Text(
//                           '${materialList[index].name ?? ''} ${materialList[index].price ?? 0} RWF',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//       sizedBox15,
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: DefaultButton2(
//           onPress: () => Get.to(
//             () => SchoolTransactionConfirmationScreen(
//               inputBalance: materialList.isNotEmpty ? materialList[0].price : 0,
//               productId: productId,
//               isChecked: _isChecked,
//               schoolId: widget.schoolId,
//               productName: productName,
//               transactionType: TransactionType.sendMoney,
//               classDetails: widget.classId,
//               contactModel: ContactModel(
//                 phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
//                 name: userData?.name ?? '',
//                 avatarImage: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
//               ),
//               contactModelMtn: ContactModelMtn(
//                 phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
//                 name: userData?.name ?? '',
//               ),
//               dataList:const [], //materialList,
//               productIndex: 0,
//               student: widget.studentId,
//               edubox_service: widget.productName,
//               serviceIndex: 0,
//               price: materialList.isNotEmpty ? materialList[0].price : 0,
//             ),
//           ),
//           title: 'CLICK TO CHOOSE',
//           iconData: Icons.arrow_forward,
//           color1: kamber300Color,
//           color2: kyellowColor,
//         ),
//       ),
//     ],
//   );
// }


// Widget containerMethod1({
//   required List<SchoolRequirementModel> requirementList,
// }) {
//   return Column(
//     children: [
//       Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           border: Border.all(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Scrollbar(
//           thumbVisibility: true,
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 5,
//             child: ListView.builder(
//               itemCount: requirementList.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Checkbox(
//                         value: _isReqChecked[index], // Fixed index reference
//                         onChanged: (bool? value) {
//                           setState(() {
//                             _isReqChecked[index] = value ?? false;
//                           });
//                         },
//                       ),
//                       Expanded(
//                         child: Text(
//                           '${requirementList[index].name ?? ''} ${requirementList[index].price ?? 0} RWF',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//       sizedBox15,
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: DefaultButton2(
//           color1: kamber300Color,
//           color2: kyellowColor,
//           onPress: (){},
//           title: 'CLICK TO CHOOSE',
//           iconData: Icons.arrow_forward_outlined,
//         ),
//       ),
//     ],
//   );
// }


//   Widget iconImages(String questionText) {
//     // TODO: implement build
//     return Image.asset(
//       questionText,
//       width: 200,
//       height: 40,

//       // Make sure questionText holds the correct path
//       fit: BoxFit.fill, // Adjust this to see if it scales properly
//     );
//   }
// }

// _launchURL(url) async {
//   final uri = Uri.parse(url);
//   if (await canLaunchUrl(uri)) {
//     await launch(url, forceSafariVC: false);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// class HomeCard2 extends StatefulWidget {
//   const HomeCard2({
//     super.key,
//   });

//   @override
//   State<HomeCard2> createState() => _HomeCard2State();
// }

// class _HomeCard2State extends State<HomeCard2> {
//   List orderLists = [], announcement = [];
//   bool isLoading = false;
//   var getUserId;

//   Future listOrder() async {
//     var url = 'https://roya.shulepoto.cloud/api/ads';

//     http.Response response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       setState(() {
//         orderLists = json.decode(response.body)['ads'];
//         isLoading = true;
//       });
//       print('wayaa: $orderLists');
//     } else {
//       print('fail');
//     }
//   }

//   @override
//   void initState() {
//     listOrder();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading == false
//         ? Container(
//             height: MediaQuery.of(context).size.height / 3,
//             color: kTextLightColor.withOpacity(0.7),
//             child: const Center(child: CircularProgressIndicator()))
//         : CarouselSlider.builder(
//             options: CarouselOptions(
//               height: MediaQuery.of(context).size.height / 3,
//               viewportFraction: 1,
//               enableInfiniteScroll: true,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 4),
//               autoPlayAnimationDuration: const Duration(milliseconds: 1500),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enlargeCenterPage: false,
//               initialPage: 1,
//             ),
//             itemCount: orderLists.length,
//             itemBuilder: (BuildContext context, int index, int pageViewIndex) {
//               return orderLists[index] == []
//                   ? SizedBox(
//                       height: MediaQuery.of(context).size.height / 3,
//                       child: const Center(
//                         child: Text(
//                           'No Ads for now',
//                           style: ktextLight,
//                         ),
//                       ))
//                   : FadeInImage.assetNetwork(
//                       image: orderLists[index]['ads_banner'] == null
//                           ? "https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg"
//                           : "https://roya.shulepoto.cloud/storage/ads_banner/${orderLists[index]['ads_banner']}",

//                       placeholder:
//                           "assets/icons1/noads.webp", // your assets image path
//                       fit: BoxFit.fill,
//                     );
//             },
//           );
//   }
// }
