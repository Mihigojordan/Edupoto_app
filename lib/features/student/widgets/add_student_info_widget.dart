import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/student/widgets/dependent_logistic_dropdown.dart';
import 'package:hosomobile/features/student/widgets/dependent_student_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';

import 'package:url_launcher/url_launcher.dart';

class AddStudentInfoWidget extends StatefulWidget {
  final StudentRegistrationController studentRegController;
  final int studentId;
  final int selectedIndex;
  final StudentController studentController;
  const AddStudentInfoWidget(
      {super.key,
      required this.selectedIndex,
      required this.studentController,
      required this.studentRegController,
      required this.studentId});

  @override
  State<AddStudentInfoWidget> createState() => _AddStudentInfoWidgetState();
}

class _AddStudentInfoWidgetState extends State<AddStudentInfoWidget> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  // Replace your declarations with these tr() keys
  String studentCardValue = 'choose_uniform_type'.tr;
  String genderValue = 'choose_gender'.tr;
  String topWearValue = 'choose_top_wear'.tr;
  String sportSizeValue = 'choose_size'.tr;
  String shoeSizeValue = 'choose_size'.tr;
  String topSizeValue = 'choose_size'.tr;
  String bottomWearValue = 'choose_bottom_wear'.tr;
  String sportsWearValue = 'choose_sports_wear'.tr;
  String feetWearValue = 'choose_feet_wear'.tr;
  String feetWearSizeValue = 'choose_size'.tr;
  String classValue = 'od_level'.tr;
  String classCategoryValue = 'class'.tr;
  bool isSelected = false;
  UserShortDataModel? userData;
  String? parentId;
  // bool isEditStudentInfo=false;

  TextEditingController EditingController = TextEditingController();
  TextEditingController heightSizeEditingController = TextEditingController();
  TextEditingController waistSizeEditingController = TextEditingController();
  TextEditingController hipSizeEditingController = TextEditingController();
  TextEditingController studentAgeEditingController = TextEditingController();
  TextEditingController shoulderSizeEditingController = TextEditingController();
  TextEditingController chestSizeEditingController = TextEditingController();
  TextEditingController handSizeEditingController = TextEditingController();

  

List<Map<dynamic, String>> gender =  [
  {'name': 'male'.tr},
  {'name': 'female'.tr}
];

List<Map<dynamic, String>> bottomWear =  [
  {'name': 'short'.tr},
  {'name': '${'trouser'.tr}'.tr},
  {'name': 'skirt'.tr},
];

List<Map<dynamic, String>> topWear =  [
  {'name': 'shirt'.tr},
  {'name': 'brouse'.tr},
  {'name': 'tie'.tr}
];

List<Map<dynamic, String>> sportsWear =  [
  {'name': 'sports_wear'.tr},
];

List<Map<dynamic, String>> feetWear =  [
  {'name': 'shoes'.tr},
  {'name': 'socs'.tr}
];

List<Map<dynamic, String>> size =[
  {'name': 'size_1'.tr},
  {'name': 'size_2'.tr},
  {'name': 'size_3'.tr},
  {'name': 'size_4'.tr},
  {'name': 'size_5'.tr},
  {'name': 'size_6'.tr},
  {'name': 'size_7'.tr},
  {'name': 'size_8'.tr},
  {'name': 'size_9'.tr},
  {'name': 'size_10'.tr},
  {'name': 'size_11'.tr},
  {'name': 'size_12'.tr},
  {'name': 'size_13'.tr},
];

List<Map<dynamic, String>> topSize = [
  {'name': 'size_s'.tr},
  {'name': 'size_m'.tr},
  {'name': 'size_l'.tr},
  {'name': 'size_xl'.tr},
  {'name': 'size_xxl'.tr},
];

  showDetails() async {}
  selectedVale() {
    setState(() {
      isSelected = !isSelected;
      print(isSelected);
    });
  }

// editStudentProfileAction(){
//   setState(() {
//     isEditStudentInfo =! isEditStudentInfo;
//   });
// }

  @override
  void initState() {
    // TODO: implement initState
    showDetails();
    super.initState();
    parentId = Get.find<AuthController>().getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      padding: const EdgeInsets.all(8.0),
      width: 340,
      child: Column(children: [
        SizedBox(
          height: screenHeight / 1.5,
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => showEditStudentDialog(
                      context: context, parentId: parentId!),
                  onHover: (isHovering) {
                    // Optional: Add hover effect state management
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth / 1.6,
                          child: Text(
                            'click_to_edit_student_profile'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.blueGrey.shade800,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit_rounded,
                            size: 18,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBox10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'find_your_uniform_list'.tr,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    sizedBox10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'gender'.tr,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                            sizedBox5,
                            DropDownStudentInfo(
                              menuHeight: 200,
                              onChanged: (onChanged) {
                                setState(() {
                                  genderValue = onChanged!;
                                });
                              },
                              itemLists: gender,
                              title: genderValue,
                              width: screenWidth / 2.5,
                              menuWidth: screenWidth / 2.5,
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        buildFormField(
                          '  ${'age'.tr} (${'years'.tr})',
                          studentAgeEditingController,
                          TextInputType.number,
                          width: screenWidth / 2.7,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                      child: Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Text(
                      '${'shirt'.tr} | ${'brouse'.tr} | ${'tie'.tr}',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        DropDownStudentInfo(
                          menuHeight: 300,
                          onChanged: (onChanged) {
                            setState(() {
                              topWearValue = onChanged!;
                            });
                          },
                          itemLists: topWear,
                          title: topWearValue,
                          width: screenWidth / 2.5,
                          menuWidth: screenWidth / 2.5,
                        ),
                        buildFormField('${'chest_size'.tr}(${'ft'.tr})',
                            chestSizeEditingController, TextInputType.number,
                            width: 150),
                        buildFormField('${'shoulder_size'.tr}(${'ft'.tr})',
                            shoulderSizeEditingController, TextInputType.number,
                            width: 150),
                        buildFormField('${'hand_size'.tr}(${'ft'.tr})',
                            handSizeEditingController, TextInputType.number,
                            width: 150)
                      ],
                    ),
                    SizedBox(
                      height: 15,
                      child: Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Text(
                      '${'trouser'.tr} | ${'short'.tr} | ${'skirt'.tr}',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    genderValue == 'female'.tr
                        ? Wrap(
                            direction: Axis.horizontal,
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              DropDownStudentInfo(
                                menuHeight: 250,
                                onChanged: (onChanged) {
                                  setState(() {
                                    bottomWearValue = onChanged!;
                                  });
                                },
                                itemLists: bottomWear,
                                title: bottomWearValue,
                                width: screenWidth / 2.5,
                                menuWidth: screenWidth / 2.5,
                              ),
                              buildFormField(
                                  '${'hip_size'.tr}(${'ft'.tr})',
                                  hipSizeEditingController,
                                  TextInputType.number,
                                  width: 150),
                              buildFormField(
                                  '${'waist_size'.tr}(${'ft'.tr})',
                                  waistSizeEditingController,
                                  TextInputType.number,
                                  width: 150),
                              buildFormField(
                                  '${'height_size'.tr}(${'ft'.tr})',
                                  heightSizeEditingController,
                                  TextInputType.number,
                                  width: 150)
                            ],
                          )
                        : Wrap(
                            direction: Axis.horizontal,
                            spacing: 15,
                            runSpacing: 15,
                            children: [
                              DropDownStudentInfo(
                                menuHeight: 250,
                                onChanged: (onChanged) {
                                  setState(() {
                                    bottomWearValue = onChanged!;
                                  });
                                },
                                itemLists: bottomWear,
                                title: bottomWearValue,
                                width: screenWidth / 2.5,
                                menuWidth: screenWidth / 2.5,
                              ),
                              buildFormField(
                                  '${'waist_size'.tr}(${'ft'.tr})',
                                  waistSizeEditingController,
                                  TextInputType.number,
                                  width: 150),
                              buildFormField(
                                  '${'height_size'.tr}(${'ft'.tr})',
                                  heightSizeEditingController,
                                  TextInputType.number,
                                  width: 150)
                            ],
                          ),
                    SizedBox(
                      height: 15,
                      child: Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sports_wear'.tr,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                            sizedBox5,
                            DropDownStudentInfo(
                              menuHeight: 150,
                              onChanged: (onChanged) {
                                setState(() {
                                  sportsWearValue = onChanged!;
                                });
                              },
                              itemLists: sportsWear,
                              title: sportsWearValue,
                              width: screenWidth / 2.5,
                              menuWidth: screenWidth / 2.5,
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'size'.tr,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                            sizedBox5,
                            DropDownStudentInfo(
                              menuHeight: 320,
                              onChanged: (onChanged) {
                                setState(() {
                                  feetWearSizeValue = onChanged!;
                                });
                              },
                              itemLists: topSize,
                              title: feetWearSizeValue,
                              width: screenWidth / 2.5,
                              menuWidth: screenWidth / 2.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                      child: Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'shoes'.tr} | ${'socs'.tr}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                            sizedBox5,
                            DropDownStudentInfo(
                              menuHeight: 200,
                              onChanged: (onChanged) {
                                setState(() {
                                  feetWearValue = onChanged!;
                                });
                              },
                              itemLists: feetWear,
                              title: feetWearValue,
                              width: screenWidth / 2.5,
                              menuWidth: screenWidth / 2.5,
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'size'.tr,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                            sizedBox5,
                            DropDownStudentInfo(
                              menuHeight: 500,
                              onChanged: (onChanged) {
                                setState(() {
                                  shoeSizeValue = onChanged!;
                                });
                              },
                              itemLists: size,
                              title: shoeSizeValue,
                              width: screenWidth / 2.5,
                              menuWidth: screenWidth / 2.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    sizedBox15,
                  ],
                ),
              ]),
        ),
        DefaultButton2(
          color1: kamber300Color,
          color2: kyellowColor,
          onPress: () {
            Get.off(const MzaziScreen(
              isShop: false,
            ));
            print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$parentId');
            Future.delayed(
                const Duration(milliseconds: 200),
                () => widget.studentRegController.updateStudent(
                    name: widget.studentController
                        .studentList![widget.selectedIndex].name!,
                    code: widget.studentController
                        .studentList![widget.selectedIndex].code!,
                    schoolCode: widget.studentController
                        .studentList![widget.selectedIndex].schoolId!
                        .toString(),
                    parentId: parentId!,
                    classId: widget.studentController
                        .studentList![widget.selectedIndex].classId!,
                    id: widget.studentId,
                    gender: genderValue,
                    age: studentAgeEditingController.text,
                    hipSize: hipSizeEditingController.text,
                    waistSize: waistSizeEditingController.text,
                    heightSize: heightSizeEditingController.text,
                    topWear: topWearValue,
                    bottomWear: bottomWearValue,
                    sportsWear: sportsWearValue,
                    feetWear: feetWearValue,
                    topSize: chestSizeEditingController.text,
                    shoeSize: shoeSizeValue,
                    sportSize: sportSizeValue,
                    shoulderSize: shoulderSizeEditingController.text,
                    handSize: handSizeEditingController.text));
          },
          title: 'NEXT',
          iconData: Icons.arrow_forward_outlined,
        ),
      ]),
    );
  }

  Widget buildFormField(
    String labelText,
    TextEditingController editingController,
    TextInputType textInputType, {
    double width = 250, // Default width, can be changed
  }) {
    return SizedBox(
      width: width, // Set the width of the TextFormField

      child: TextFormField(
        textAlign: TextAlign.start,
        controller: editingController,
        keyboardType: textInputType,
        style: kInputTextStyle,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: kamber300Color),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15.0),
          ),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

 void showEditStudentDialog(
    {required BuildContext context, required String parentId}) {
    final  screenWidth=MediaQuery.of(context).size.width;
    final  screenHeight=MediaQuery.of(context).size.height;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidth*0.6,
              child: Text(
                'edit_student_profile'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'find_and_update_your_student_information'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blueGrey.shade600,
                  ),
            ),
            const SizedBox(height: 20),
            SizedBox(
               width: screenWidth * 0.9,
               height: screenHeight/1.7,
              child: SingleChildScrollView(
                child: DependentStudentDropdowns(
                  isAddAccount: true,
                  isStudentEdit: true,
                  studentController: widget.studentController,
                  studentRegistrationController: widget.studentRegController,
                  selectedIndex: widget.selectedIndex,
                  parentId: parentId,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () => Navigator.pop(context),
        //     child: const Text('Cancel'),
        //   ),
        //   ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Colors.blueGrey.shade800,
        //     ),
        //     onPressed: () {
        //       // Handle save logic here
        //       Navigator.pop(context);
        //     },
        //     child: const Text(
        //       'Save Changes',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ],
      );
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
