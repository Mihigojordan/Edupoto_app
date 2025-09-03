// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hosomobile/common/models/contact_model.dart';
// import 'package:hosomobile/common/models/contact_model_mtn.dart';
// import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
// import 'package:hosomobile/common/widgets/custom_image_widget.dart';
// import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
// import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
// import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
// import 'package:hosomobile/features/home/controllers/student_controller.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
// import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
// import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
// import 'package:hosomobile/features/student/widgets/student_logistic_widget.dart';
// import 'package:hosomobile/features/map/screens/map_screen.dart';
// import 'package:hosomobile/features/shop/screen/shop_map_screen.dart';
// import 'package:hosomobile/features/shop/domain/models/product.dart';
// import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
// import 'package:hosomobile/helper/transaction_type.dart';
// import 'package:hosomobile/util/app_constants.dart';
// import 'package:hosomobile/util/images.dart';
// import 'package:upgrader/upgrader.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class StudentLogisticScreen extends StatefulWidget {
//   static String routeName = 'StudentLogisticScreen';
//   final String className;
//   final String studentName;
//   final String studentCode;
//   final String schoolName;
//   final int studentId;
//   final int classId;
//   final int schoolId;
//   bool? isShop;

//   StudentLogisticScreen(
//       {super.key,
//       required this.studentId,
//       required this.schoolId,
//       required this.classId,
//       this.isShop,
//       required this.className,
//       required this.studentName,
//       required this.studentCode,
//       required this.schoolName});

//   @override
//   _StudentLogisticScreenState createState() => _StudentLogisticScreenState();
// }

// class _StudentLogisticScreenState extends State<StudentLogisticScreen> {
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

// @override
// void initState() {
//   super.initState();

//   showDetails();
// }

//   @override
//   Widget build(BuildContext context) {
    
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     const titleImage = 'image';
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
//                 color: const Color(0xFFFFD700),
//                 child: Stack(
//                   children: [
//                     // SizedBox(
//                     //   // height: 0,
//                     //   child: ImagesUp(Images.launch_page),
//                     // ),
//                     widget.isShop == true
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 18.0, vertical: 30),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     text: 'Skoollist Shop',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleLarge!
//                                         .copyWith(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               sizedBox,
//                               sizedBox15,
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 18.0, vertical: 30),
//                                 child: RichText(
//                                   text: TextSpan(
//                                     text: 'Preparing list for:\n',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleSmall!
//                                         .copyWith(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.normal),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                         text: '${widget.studentName}\n',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium!
//                                             .copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight
//                                                   .bold, // Regular weight for the rest of the text
//                                             ),
//                                       ),
//                                       TextSpan(
//                                         text: '${widget.className}, ',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleSmall!
//                                             .copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight
//                                                   .normal, // Regular weight for the rest of the text
//                                             ),
//                                       ),
//                                       TextSpan(
//                                         text: widget.schoolName,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleSmall!
//                                             .copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight
//                                                   .normal, // Regular weight for the rest of the text
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
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
//             top: screenHeight >= 763 ? 10 : 10,
//             left: screenWidth >= 520 ? 10 : 10,
//             child: const CustomBackButton(),
//           ),

//           //*********************All Schoool Widget */
//           Positioned(
//               top: 150,
//               left: 20,
//               right: 20,
//               child: StudentLogisticWidget(
//                   studentCode: widget.studentCode,
//                   schoolName: widget.schoolName,
//                   className: widget.className,
//                   studentName: widget.studentName,
//                   schoolId: widget.schoolId,
//                   classId: widget.classId,
//                   studentId: widget.studentId))
//         ],
//       ),

//       //   bottomNavigationBar: BottomNav(
//       //   color: kamber300Color,
//       // ),
//     ));
//   }
// }
