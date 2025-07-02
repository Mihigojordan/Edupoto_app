import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/class_controller.dart';
import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
import 'package:hosomobile/features/home/controllers/school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/class_model.dart';
import 'package:hosomobile/features/home/domain/models/student_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/student/widgets/dependent_student_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/student/screens/student_profile_screen.dart';
import 'package:hosomobile/features/student/widgets/student_profile_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/student/screens/student_logistic_screen.dart';
import 'package:hosomobile/features/student/widgets/student_add_info.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/home/widgets/floating_action_button_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/images.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentScreen extends StatefulWidget {
  final bool isShop;

  const StudentScreen({super.key, required this.isShop});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  bool isClicked = false;
  bool isServices = false;
  String displayText = 'Enter Parent Phone Number';
  String passwordText = 'Enter Parent Password';
  String displayStudentName = 'Enter Your Student Name';
  String displaySchoolCode = 'Enter Your Student School Code';
  String displayStudentNumber = 'Enter Your Student Code';
  int selectedIndex = 0;
  String? parentId;
  int? studentId;
  int? classId;
  int? schoolId;
  bool isAddAccount = false;
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  final TextEditingController studentEditingController =
      TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController parentController = TextEditingController();
  final TextEditingController studentNameEditingController =
      TextEditingController();
  final TextEditingController studentCodeEditingController =
      TextEditingController();
  final TextEditingController schoolCodeEditingController =
      TextEditingController();

  // Click to see currency values
  void onClick() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  void setAddAccount() {
    setState(() {
      isAddAccount = !isAddAccount;
    });
  }

  void onClickServices() {
    setState(() {
      isServices = !isServices;
    });
  }

  late UserShortDataModel? userData;

  void displayTextMethod() {
    setState(() {
      displayText = '${userData?.countryCode}${userData?.phone}';
    });
  }

  Map<String, dynamic> cStates = {};

  // Function to normalize phone number by removing prefixes
  String _normalizePhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+255')) {
      return phoneNumber.substring(4); // Remove +255
    } else if (phoneNumber.startsWith('255')) {
      return phoneNumber.substring(3); // Remove 255
    } else if (phoneNumber.startsWith('0')) {
      return phoneNumber.substring(1); // Remove leading 0
    }
    return phoneNumber; // Return the original if no prefix is found
  }

  void _updateDisplayText() {
    String inputText = _normalizePhoneNumber(studentEditingController.text);
    String storedPhone = _normalizePhoneNumber(userData?.phone ?? '');

    if (inputText == storedPhone && storedPhone.isNotEmpty) {
      setState(() {
        displayText = '${userData?.countryCode}${userData?.phone}';
      });
    } else {
      setState(() {
        displayText = 'Enter Parent Phone Number';
      });
    }
  }

  // Function to normalize student name by trimming spaces and ignoring case
  String _normalizeStudentName(String studentName) {
    return studentName.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '');
  }

  void _updateDisplayStudentName() {
    String inputText = _normalizeStudentName(studentNameEditingController.text);
    String storedName = _normalizeStudentName(userData?.name ?? '');

    if (inputText == storedName && storedName.isNotEmpty) {
      setState(() {
        displayStudentName = '${userData?.name}';
        displayStudentNumber = '${userData?.countryCode}${userData?.phone}';
      });
    } else {
      setState(() {
        displayStudentName = 'Enter Your Student Name';
        displayStudentNumber = 'Enter Your Student Code';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userData = Get.find<AuthController>().getUserData();
    parentId = Get.find<AuthController>().getUserId();

    studentEditingController.addListener(_updateDisplayText);
    studentNameEditingController.addListener(_updateDisplayStudentName);
    displayTextMethod();
  }

  @override
  void dispose() {
    studentEditingController.removeListener(_updateDisplayText);
    studentNameEditingController.removeListener(_updateDisplayStudentName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<StudentRegistrationController>(
      builder: (studentRegistrationController) {
        return GetBuilder<SplashController>(
          builder: (splashController) {
            return GetBuilder<EduboxMaterialController>(
              builder: (eduboxController) {
                return eduboxController.isLoading
                    ? const WebSiteShimmer()
                    : GetBuilder<StudentController>(
                        builder: (studentController) {
                          if (studentController.isLoading == false) {
                            if (studentController.studentList == null ||
                                studentController.studentList!.isEmpty) {
                              return Container(
                                margin: const EdgeInsets.only(top: 100),
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: kTextLightColor,
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: kTextWhiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: addAccout(
                                  student: studentController.studentList ?? [],
                                  studentRegController:
                                      studentRegistrationController,
                                  studentController: studentController,
                                  eduboxController: eduboxController,
                                ),
                              );
                            }

                            if (selectedIndex < 0 ||
                                selectedIndex >=
                                    studentController.studentList!.length) {
                              return const Center(
                                  child: Text('Invalid student selected.'));
                            }
                          } else {
                            const WebSiteShimmer();
                          }
                          final student =
                              studentController.studentList![selectedIndex];
                          return studentController.isLoading
                              ? const WebSiteShimmer()
                              : Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //******************************Upper part of Student Widget */
                                      upperContainer(
                                        student: student,
                                        studentController: studentController,
                                        eduboxController: eduboxController,
                                        studentRegistrationController:
                                            studentRegistrationController,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: screenHeight / 2.6,
                                        width: screenWidth >= 520
                                            ? 340
                                            : screenWidth / 1.2,
                                        child: eduboxController
                                                .eduboxMaterialList!.isEmpty
                                            ? Text(
                                                'No Material for now',
                                                style: TextStyle(
                                                  fontSize: screenHeight >= 763
                                                      ? 16
                                                      : 14,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : passwordEditingController.text !=
                                                    '1234'
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 100,
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              passwordEditingController
                                                                  .text;
                                                            });
                                                            if (passwordEditingController
                                                                    .text ==
                                                                '') {
                                                              showInfoDialog(
                                                                // password:
                                                                //     passwordEditingController
                                                                //         .text,
                                                                context,
                                                                title:
                                                                    'Student Info',
                                                                student_name:
                                                                    student.name ??
                                                                        'No Name',
                                                                student_code:
                                                                    student.code ??
                                                                        'No Code',
                                                                description:
                                                                    'Please Enter a password to continue.',
                                                                studentController:
                                                                    studentController,
                                                                studentRegController:
                                                                    studentRegistrationController,
                                                                studentId:
                                                                    studentId ??
                                                                        0,
                                                                selectedIndex:
                                                                    selectedIndex,
                                                                parentId:
                                                                    parentId ??
                                                                        '0',
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 6,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                    child:
                                                                        const SizedBox(
                                                                      height:
                                                                          60,
                                                                      width: 60,
                                                                      child: IconImages(
                                                                          'assets/icons1/student_icon.png'),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.6,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Enter Password above and press here to continue',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleMedium!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )

                                                //**************************** Student List ***************************/
                                                : ListView.builder(
                                                    itemCount: studentController
                                                            .studentList
                                                            ?.length ??
                                                        0,
                                                    itemBuilder:
                                                        (context, index) {
                                                      // Safe student access
                                                      final student =
                                                          studentController
                                                                  .studentList?[
                                                              index];
                                                      if (student == null) {
                                                        return const SizedBox(); // Handle null student
                                                      }

                                                      final school =
                                                          student.school;
                                                      final name = student.name;

                                                      // Safe edubox material access - use first image if index is out of bounds
                                                      String profileImage =
                                                          'assets/icons1/student_icon.png'; // Default image
                                                      // if (eduboxController.eduboxMaterialList != null &&
                                                      //     eduboxController.eduboxMaterialList!.isNotEmpty) {
                                                      //   final materialIndex = index < eduboxController.eduboxMaterialList!.length
                                                      //       ? index
                                                      //       : 0; // Fallback to first image
                                                      //   final imagePath = eduboxController.eduboxMaterialList![materialIndex].title_image;
                                                      //   if (imagePath != null && imagePath.isNotEmpty) {
                                                      //     profileImage = "${AppConstants.baseUrl}/storage/app/public/edupoto_product/$imagePath";
                                                      //   }
                                                      // }

                                                      return InkWell(
                                                        onTap: () {
                                                          if (studentController
                                                              .studentList!
                                                              .isEmpty) {
                                                            showInfoDialog(
                                                              context,
                                                              title:
                                                                  'Student Info',
                                                              student_name:
                                                                  student.name ??
                                                                      'No Name',
                                                              student_code:
                                                                  student.code ??
                                                                      'No Code',
                                                              description:
                                                                  'Student is not available! Please add a student to continue.',
                                                              studentController:
                                                                  studentController,
                                                              studentRegController:
                                                                  studentRegistrationController,
                                                              studentId:
                                                                  studentId ??
                                                                      0,
                                                              selectedIndex:
                                                                  selectedIndex,
                                                              parentId:
                                                                  parentId ??
                                                                      '0',
                                                            );
                                                          } else {
                                                            Get.to(() => SchoolListScreen(
                                                                studentController: studentController,
                                                                studentIndex: selectedIndex,
                                                                homePhone: '',
                                                                shipper: '',
                                                                destination: '',
                                                                studentCode:
                                                                    student
                                                                            .code ??
                                                                        '0000000000',
                                                                studentId:
                                                                    student
                                                                            .id ??
                                                                        0,
                                                                schoolId:
                                                                    student
                                                                            .schoolId ??
                                                                        0,
                                                                classId:
                                                                    student
                                                                            .classId ??
                                                                        0,
                                                                className: student
                                                                        .studentClass ??
                                                                    'No Class Available',
                                                                studentName: student
                                                                        .name ??
                                                                    'No student Available',
                                                                schoolName: student
                                                                        .school ??
                                                                    'No School Available'));
                                                          }
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.1),
                                                                spreadRadius: 2,
                                                                blurRadius: 6,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 60,
                                                                    width: 60,
                                                                    child: IconImages(
                                                                        profileImage),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        name ??
                                                                            'No Name',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleMedium!
                                                                            .copyWith(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Text(
                                                                        school ??
                                                                            'No School',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .copyWith(
                                                                              fontSize: 14,
                                                                              color: Colors.grey[600],
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              PopupMenuButton<
                                                                  String>(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: Colors
                                                                        .grey),
                                                                onSelected:
                                                                    (value) {
                                                                  switch (
                                                                      value) {
                                                                    case 'delete':
                                                                      print(
                                                                          'Delete clicked');
                                                                      break;
                                                                    case 'edit':
                                                                      Get.to(
                                                                        StudentAddInfo(
                                                                          studentInfo:
                                                                              'Code: ${student.code ?? 'No Code'}, Name: ${student.name ?? 'No Name'}',
                                                                          studentId:
                                                                              studentId ?? 0,
                                                                          studentRegController:
                                                                              studentRegistrationController,
                                                                          studentController:
                                                                              studentController,
                                                                          selectedIndex:
                                                                              selectedIndex,
                                                                        ),
                                                                      );
                                                                      print(
                                                                          'Edit clicked');
                                                                      break;
                                                                    case 'student_info':
                                                                      Get.to(() => StudentProfileScreen(
                                                                          student:
                                                                              student,
                                                                          studentRegistrationController:
                                                                              studentRegistrationController,
                                                                          selectedIndex:
                                                                              selectedIndex,
                                                                          studentController:
                                                                              studentController,
                                                                          studentId:
                                                                              studentId ?? 0));
                                                                      print(
                                                                          'Student Info clicked');
                                                                      break;
                                                                    case 'status':
                                                                      print(
                                                                          'Status clicked');
                                                                      break;
                                                                  }
                                                                },
                                                                itemBuilder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return [
                                                                    const PopupMenuItem<
                                                                        String>(
                                                                      value:
                                                                          'delete',
                                                                      child: Text(
                                                                          'Delete'),
                                                                    ),
                                                                    const PopupMenuItem<
                                                                        String>(
                                                                      value:
                                                                          'edit',
                                                                      child: Text(
                                                                          'Edit'),
                                                                    ),
                                                                    const PopupMenuItem<
                                                                        String>(
                                                                      value:
                                                                          'student_info',
                                                                      child: Text(
                                                                          'Student Info'),
                                                                    ),
                                                                    const PopupMenuItem<
                                                                        String>(
                                                                      value:
                                                                          'status',
                                                                      child: Text(
                                                                          'Status'),
                                                                    ),
                                                                  ];
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                      ),
                                      !kIsWeb
                                          ? FloatingActionButtonWidget(
                                              strokeWidth: 1.5,
                                              radius: 40,
                                              gradient: LinearGradient(
                                                colors: [
                                                  ColorResources.gradientColor,
                                                  ColorResources.gradientColor
                                                      .withOpacity(0.5),
                                                  ColorResources.secondaryColor
                                                      .withOpacity(0.3),
                                                  ColorResources.gradientColor
                                                      .withOpacity(0.05),
                                                  ColorResources.gradientColor
                                                      .withOpacity(0),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              child: FloatingActionButton(
                                                shape: const CircleBorder(),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .secondaryHeaderColor,
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
                                                          color: const Color(
                                                                  0xFFFFFFFF)
                                                              .withOpacity(0.1),
                                                          spreadRadius: 3,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0, 3)),
                                                    ],
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Image.asset(
                                                      'assets/image/home_bold.png',
                                                      height:
                                                          screenHeight * 0.015,
                                                      width:
                                                          screenHeight * 0.015,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : FloatingActionButton(
                                              shape: const CircleBorder(),
                                              backgroundColor: Theme.of(context)
                                                  .secondaryHeaderColor,
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
                                                        color: const Color(
                                                                0xFFFFFFFF)
                                                            .withOpacity(0.1),
                                                        spreadRadius: 3,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(0, 3)),
                                                  ],
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Image.asset(
                                                    'assets/image/home_bold.png',
                                                    height:
                                                        screenHeight * 0.015,
                                                    width: screenHeight * 0.015,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                        },
                      );
              },
            );
          },
        );
      },
    );
  }

  TextFormField buildFormField(
    String labelText,
    TextEditingController editingController,
    TextInputType textInputType,
    String hint,
    List<TextInputFormatter>? formatter,
    FocusNode? focusNode,
    FormFieldValidator<String>? validator,
  ) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      keyboardType: textInputType,
      style: screenHeight >= 763 ? kInputTextStyle : kInputTextStyle10,
      inputFormatters: formatter,
      focusNode: focusNode,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hint,
        hintStyle: screenHeight >= 763 ? kHintTextStyle : kHintTextStyle10,
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight >= 763 ? 13 : 10,
          horizontal: 15,
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius:
              BorderRadius.circular(screenHeight >= 763 ? 20.0 : 15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kTextLightColor),
          borderRadius:
              BorderRadius.circular(screenHeight >= 763 ? 20.0 : 15.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius:
              BorderRadius.circular(screenHeight >= 763 ? 20.0 : 15.0),
        ),
        labelText: labelText,
        labelStyle: screenHeight >= 763 ? kLabelTextStyle : kLabelTextStyle10,
      ),
      validator: validator,
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget upperContainer({
    required StudentController studentController,
    required EduboxMaterialController eduboxController,
    required final student,
    required StudentRegistrationController studentRegistrationController,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth >= 520 ? 340 : screenWidth / 1.2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(
              height: screenHeight >= 763 ? 165 : 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // SizedBox(
                  //   height: screenHeight >= 763 ? 185 : 130,
                  //   width: screenHeight >= 763 ? 115 :90,
                  //   child: const IconImages('assets/image/edubox_kid.png'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: screenHeight >= 763 ? 70 : 30,
                      width: screenHeight >= 763 ? 290 : 150,
                      child: const IconImages('assets/image/HOSO MOBILE.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kTextLightColor,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: kTextWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isAddAccount == true
                              ? addAccout(
                                  student: student,
                                  studentRegController:
                                      studentRegistrationController,
                                  studentController: studentController,
                                  eduboxController: eduboxController,
                                )
                              : studentController.studentList!.isEmpty
                                  ? addAccout(
                                      student: student,
                                      studentRegController:
                                          studentRegistrationController,
                                      studentController: studentController,
                                      eduboxController: eduboxController,
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        userData?.name != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'Parent ${userData?.name} Phone Number' ??
                                                      '',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenHeight >= 763
                                                            ? 12
                                                            : 10,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                'No Parent Name',
                                                style: TextStyle(
                                                  fontSize: screenHeight >= 763
                                                      ? 12
                                                      : 10,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        buildFormField(
                                          displayText,
                                          studentEditingController,
                                          TextInputType.text,
                                          '',
                                          [],
                                          FocusNode(),
                                          (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter required details to continue';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            studentController
                                                    .studentList!.isEmpty
                                                ? Text(
                                                    'You have no Student for now Please add Student:',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenHeight >= 763
                                                              ? 12
                                                              : 10,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        'Enter Password To continue:',
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenHeight >=
                                                                      763
                                                                  ? 12
                                                                  : 10,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            buildFormField(
                                              passwordText,
                                              passwordEditingController,
                                              TextInputType.text,
                                              '',
                                              [],
                                              FocusNode(),
                                              (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter required details to continue';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                          const SizedBox(height: 5),
                          isAddAccount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BorderButton1(
                                      borderColor: Colors.black,
                                      vertical: 5,
                                      textColor: Colors.black,
                                      horizontal: 5,
                                      onPress: () {
                                        if (isAddAccount == true ||
                                            studentController
                                                .studentList!.isEmpty) {
                                          studentRegistrationController
                                              .addStudent(
                                            name: student.name!,
                                            code: student.code,
                                            schoolCode: schoolId.toString(),
                                            parentId: parentId!,
                                            classId: classId!,
                                          )
                                              .then((onValue) {
                                            setState(() {
                                              studentController.getStudentList(
                                                  true,
                                                  id: parentId!);
                                            });

                                            setAddAccount();
                                            showInfoDialog(
                                              context,
                                              student_code: student.code!,
                                              student_name: student.name!,
                                              studentRegController:
                                                  studentRegistrationController,
                                              title: 'Student Info',
                                              description:
                                                  'Student added successfully\nYou can continue by adding uniform details',
                                              studentController:
                                                  studentController,
                                              studentId: student.id,
                                              selectedIndex: selectedIndex,
                                              parentId: parentId!,
                                            );
                                          });
                                        } else {
                                          setAddAccount();
                                        }
                                      },
                                      height: 50,
                                      width: screenWidth >= 520
                                          ? 148
                                          : screenWidth / 2.8,
                                      icon: (isAddAccount == true ||
                                              studentController
                                                  .studentList!.isEmpty)
                                          ? 'Save'
                                          : 'Add Student',
                                      title: (isAddAccount == true ||
                                              studentController
                                                  .studentList!.isEmpty)
                                          ? 'assets/icons1/save.png'
                                          : 'assets/icons1/add_account.png',
                                      clas: '',
                                    ),
                                    screenHeight >= 763
                                        ? PartinerServices(
                                            borderColor: Colors.black,
                                            vertical: 5,
                                            textColor: Colors.black,
                                            horizontal: 5,
                                            onPress: () => Get.to(
                                              TerekaAsome(
                                                productId: eduboxController
                                                    .eduboxMaterialList![6].id,
                                                studentId: studentController
                                                    .studentList![0].id,
                                                schoolId: studentController
                                                    .studentList![0].schoolId!,
                                                classId: studentController
                                                    .studentList![0].classId!,
                                                contactModelMtn:
                                                    ContactModelMtn(
                                                  phoneNumber:
                                                      '${userData?.countryCode}${userData?.phone}' ??
                                                          '',
                                                  name: '${userData?.name}',
                                                ),
                                                transactionType:
                                                    TransactionType.sendMoney,
                                                contactModel: ContactModel(
                                                  phoneNumber:
                                                      '${userData?.countryCode}${userData?.phone}' ??
                                                          '',
                                                  name: '${userData?.name}',
                                                  avatarImage:
                                                      '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image' ?? ''}',
                                                ),
                                                studentIndex: selectedIndex,
                                                productValue:
                                                    productValueList[0]
                                                        ['action'],
                                                productIndex: 6,
                                                iconImages:
                                                    'assets/image/Partner services.png',
                                                edubox_service: 'SAVE/DEPOSIT',
                                              ),
                                            ),
                                            height: 40,
                                            width: screenWidth >= 520
                                                ? 148
                                                : screenWidth / 2.8,
                                            icon: 'SAVE/DEPOSIT',
                                            title:
                                                'assets/image/edubox_icon.png',
                                            clas: '',
                                          )
                                        : PartinerServices(
                                            borderColor: Colors.black,
                                            vertical: 2,
                                            textColor: Colors.black,
                                            horizontal: 2,
                                            onPress: () => Get.to(
                                              TerekaAsome(
                                                productId: eduboxController
                                                    .eduboxMaterialList![6].id,
                                                studentId: studentController
                                                    .studentList![0].id,
                                                schoolId: schoolId!,
                                                classId: classId!,
                                                contactModelMtn:
                                                    ContactModelMtn(
                                                  phoneNumber:
                                                      '${userData?.countryCode}${userData?.phone}' ??
                                                          '',
                                                  name: '${userData?.name}',
                                                ),
                                                transactionType:
                                                    TransactionType.sendMoney,
                                                contactModel: ContactModel(
                                                  phoneNumber:
                                                      '${userData?.countryCode}${userData?.phone}' ??
                                                          '',
                                                  name: '${userData?.name}',
                                                  avatarImage:
                                                      '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image' ?? ''}',
                                                ),
                                                studentIndex: selectedIndex,
                                                productValue:
                                                    productValueList[0]
                                                        ['action'],
                                                productIndex: 6,
                                                iconImages:
                                                    'assets/image/Partner services.png',
                                                edubox_service: 'SAVE/DEPOSIT',
                                              ),
                                            ),
                                            height: 20,
                                            width: screenWidth >= 520
                                                ? 148
                                                : screenWidth / 2.7,
                                            icon: 'SAVE/DEPOSIT',
                                            title:
                                                'assets/image/edubox_icon.png',
                                            clas: '',
                                          ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addAccout({
    required student,
    required StudentRegistrationController studentRegController,
    required StudentController studentController,
    required EduboxMaterialController eduboxController,
  }) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight / 1.3,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Please Register Your Student Here',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                        fontSize: screenHeight >= 763 ? 12 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: screenWidth / 1.1,
                  child: DependentStudentDropdowns(
                    isStudentEdit: false,
                    isAddAccount: isAddAccount,
                    studentController: studentController,
                    studentRegistrationController: studentRegController,
                    selectedIndex: selectedIndex,
                    parentId: parentId!,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
            Positioned(
              top: -7,
              right: 2,
              child: IconButton(
                onPressed: setAddAccount,
                icon: const Icon(Icons.cancel_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Loan Terms and Conditions"),
          content: const SingleChildScrollView(
            child: Text(
              "By applying for this loan, you agree to the following terms:\n\n"
              "1. You must be at least 18 years old.\n"
              "2. Provide valid identification and income proof.\n"
              "3. The loan is subject to credit approval.\n"
              "4. Late payments may result in additional fees.\n"
              "5. The interest rate and repayment terms are fixed as per the agreement.\n"
              "6. Any default may lead to legal action.\n\n"
              "Clicking OK means you have read, understood, and agreed to these terms.",
              style: TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handleLoanAgreement(context);
                setAddAccount();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _handleLoanAgreement(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("You have agreed to the loan terms and conditions.")),
    );
  }
}
