import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/student/widgets/student_add_info.dart';
import 'package:hosomobile/features/student/widgets/student_profile_widget.dart';
import 'package:upgrader/upgrader.dart';

class StudentProfileScreen extends StatefulWidget {
  static String routeName = 'ShopScreen';
  final StudentModel student;
  final int studentId;
  final StudentController studentController;
  final StudentRegistrationController studentRegistrationController;
  final int selectedIndex;

  const StudentProfileScreen(
      {super.key,
      required this.student,
      required this.studentRegistrationController,
      required this.selectedIndex,
      required this.studentController,
      required this.studentId});

  @override
  StudentProfileScreenState createState() => StudentProfileScreenState();
}

class StudentProfileScreenState extends State<StudentProfileScreen> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                      child: const IconImages('assets/image/HOSO MOBILE.png'),
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
            child: StudentProfileWidget(
              name: widget.student.name ?? 'No Student Name Available',
              code: widget.student.code ?? 'No Student Code Available',
              className: widget.student.studentClass ?? 'No class Available',
              school: widget.student.school,
              province: 'Province',
              onEditPressed: () => Get.to(
                StudentAddInfo(
                  studentInfo:
                      'Code: ${widget.student.code ?? 'No Code'}, Name: ${widget.student.name ?? 'No Name'}',
                  studentId: widget.studentId ?? 0,
                  studentRegController: widget.studentRegistrationController,
                  studentController: widget.studentController,
                  selectedIndex: widget.selectedIndex,
                ),
              ),
            ),
          ),
        ],
      ),

      //   bottomNavigationBar: BottomNav(
      //   color: kamber300Color,
      // ),
    ));
  }
}
