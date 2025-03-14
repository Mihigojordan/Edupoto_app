import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_dropdown.dart';
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
  String studentCardValue = 'Choose Uniform Type';
  String genderValue = 'Choose Gender';
  String topWearValue = 'Choose Top Wear';
  String sportSizeValue = 'Choose Size';
  String shoeSizeValue = 'Choose Size';
  String topSizeValue = 'Choose Size';
  String bottomWearValue = 'Choose Bottom Wear';
  String sportsWearValue = 'Choose Sports Wear';
  String feetWearValue = 'Choose Feet Wear';
  String feetWearSizeValue = 'Choose Size';
  String classValue = 'Od Level';
  String classCategoryValue = 'Class';
  bool isSelected = false;
  UserShortDataModel? userData;
  String? parentId;

  TextEditingController EditingController = TextEditingController();
  TextEditingController heightSizeEditingController = TextEditingController();
  TextEditingController waistSizeEditingController = TextEditingController();
  TextEditingController hipSizeEditingController = TextEditingController();
  TextEditingController studentAgeEditingController = TextEditingController();
  TextEditingController shoulderSizeEditingController = TextEditingController();
  TextEditingController chestSizeEditingController = TextEditingController();
  TextEditingController handSizeEditingController = TextEditingController();

  List<Map<dynamic, String>> gender = const [
    {'name': 'Male'},
    {'name': 'Female'}
  ];

  List<Map<dynamic, String>> bottomWear = const [
    {'name': 'Short'},
    {'name': 'Trouser'},
    {'name': 'Skirt'},
  ];

  List<Map<dynamic, String>> topWear = const [
    {'name': 'Shirt'},
    {'name': 'Brouse'},
    {'name': 'Tie'}
  ];

  List<Map<dynamic, String>> sportsWear = const [
    {'name': 'Sports Wear'},
  ];

  List<Map<dynamic, String>> feetWear = const [
    {'name': 'Shoes'},
    {'name': 'Socs'}
  ];

  List<Map<dynamic, String>> size = const [
    {'name': 'Size 1'},
    {'name': 'Size 2'},
    {'name': 'Size 3'},
    {'name': 'Size 4'},
    {'name': 'Size 5'},
    {'name': 'Size 6'},
    {'name': 'Size 7'},
    {'name': 'Size 8'},
    {'name': 'Size 9'},
    {'name': 'Size 10'},
    {'name': 'Size 11'},
    {'name': 'Size 12'},
    {'name': 'Size 13'},
  ];

  List<Map<dynamic, String>> topSize = const [
    {'name': 'S'},
    {'name': 'M'},
    {'name': 'L'},
    {'name': 'XL'},
    {'name': 'XXL'},
    {'name': 'XXL'},
  ];

  showDetails() async {}
  selectedVale() {
    setState(() {
      isSelected = !isSelected;
      print(isSelected);
    });
  }

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
      height: 440,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: () {}, // => selectedVale(),
                  child: Text(
                    'Find Your Uniform List',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                         Text(
                    'Gender',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    DropDownStudentInfo(
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
                buildFormField('  Age (Years)', studentAgeEditingController,
                    TextInputType.number,
                    width: 150,)
              ],
            ),
            SizedBox(
              height: 15,
              child: Divider(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
                Text(
                      'Trouser | Short | Skirt',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
            genderValue == 'Female'
                ? Wrap(
                    direction: Axis.horizontal,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      DropDownStudentInfo(
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
                      buildFormField('Hip Size(ft)', hipSizeEditingController,
                          TextInputType.number,
                          width: 150),
                      buildFormField('Waist Size(ft)',
                          waistSizeEditingController, TextInputType.number,
                          width: 150),
                      buildFormField('Height Size(ft)',
                          heightSizeEditingController, TextInputType.number,
                          width: 150)
                    ],
                  )
                : Wrap(
                    direction: Axis.horizontal,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      DropDownStudentInfo(
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
                      buildFormField('Waist Size(ft)',
                          waistSizeEditingController, TextInputType.number,
                          width: 150),
                      buildFormField('Height Size(ft)',
                          heightSizeEditingController, TextInputType.number,
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
                      'Shirt | Brouse | Tie',
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
                buildFormField('Chest Size(ft)', chestSizeEditingController,
                    TextInputType.number,
                    width: 150),
                buildFormField('Shoulder Size(ft)',
                    shoulderSizeEditingController, TextInputType.number,
                    width: 150),
                buildFormField('Hand Size(ft)', handSizeEditingController,
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
                      'Sports Wear',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    DropDownStudentInfo(
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
                      'Size',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    DropDownStudentInfo(
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
                      'Shoes | Socs',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    DropDownStudentInfo(
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
                      'Size',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    sizedBox5,
                    DropDownStudentInfo(
                      onChanged: (onChanged) {
                        setState(() {
                          shoeSizeValue = onChanged!;
                        });
                      },
                      itemLists: size,
                      title: shoeSizeValue,
                      width: 220,
                      menuWidth: 220,
                    ),
                  ],
                ),
              ],
            ),
            sizedBox15,
            DefaultButton2(
              color1: kamber300Color,
              color2: kyellowColor,
              onPress: () {
                Get.off(const MzaziScreen());
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
          ],
        ),
      ),
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

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
