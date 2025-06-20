import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_school_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/add_account.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/student_add_info.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/images.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentWidget extends StatefulWidget {
  const StudentWidget({
    super.key,
  });

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  bool isClicked = false;
  bool isServices = false;
  String displayText = 'Enter Parent Phone Number';
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

  TextEditingController studentEditingController = TextEditingController();
  TextEditingController parentController = TextEditingController();
  TextEditingController studentNameEditingController = TextEditingController();
  TextEditingController studentCodeEditingController = TextEditingController();
  TextEditingController schoolCodeEditingController = TextEditingController();

  //click to see currency values
  onClick() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  setAddAccount() {
    setState(() {
      isAddAccount = !isAddAccount;
    });
  }

  onClickServices() async {
    setState(() {
      isServices = !isServices;
    });
  }

  late UserShortDataModel? userData;
  displayTextMethod() {
    setState(() {
      displayText = '${userData?.countryCode}${userData?.phone}';
    });

    return displayText;
  }

  Map<String, dynamic> cStates = {};
  //changes current state

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
      // If the normalized input matches the normalized stored phone, show the phone number with country code
      setState(() {
        displayText =
            '${userData?.countryCode}${userData?.countryCode}${userData?.phone}';
      });
    } else {
      // Otherwise, show the default message
      setState(() {
        displayText = 'Enter Parent Phone Number';
      });
    }
  }

// Function to normalize student name by trimming spaces and ignoring case
  String _normalizeStudentName(String studentName) {
    // Remove leading and trailing spaces and make the string lowercase
    return studentName.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '');
  }

  void _updateDisplayStudentName() {
    // Get the normalized input text and stored name
    String inputText = _normalizeStudentName(studentNameEditingController.text);
    String storedName = _normalizeStudentName(userData?.name ?? '');

    // Check if the normalized input matches the stored name
    if (inputText == storedName && storedName.isNotEmpty) {
      // If they match, display the student name and number with country code
      setState(() {
        displayStudentName = '${userData?.name}';
        displayStudentNumber =
            '${userData?.countryCode}${userData?.countryCode}${userData?.phone}';
      });
    } else {
      // Otherwise, show a default message
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
    //  Get.find<PaymentController>().getPaymentList(reload);
    // Listen for changes in the studentController
    studentEditingController.addListener(_updateDisplayText);
    studentNameEditingController.addListener(_updateDisplayStudentName);
    displayTextMethod();
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
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
      return GetBuilder<SplashController>(builder: (splashController) {
        return GetBuilder<EduboxMaterialController>(
            builder: (eduboxController) {
          return eduboxController.isLoading
              ? const WebSiteShimmer()
              : GetBuilder<StudentController>(builder: (studentController) {
                  //*************** Check if studentList is null or empty */
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
                              offset: Offset(0, 3)),
                        ],
                        color: kTextWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: addAccout(
                          student: studentController.studentList ?? [],
                          studentRegController: studentRegistrationController,
                          studentController: studentController,
                          eduboxController: eduboxController),
                    );
                  }

                  // Validate selectedIndex
                  if (selectedIndex < 0 ||
                      selectedIndex >= studentController.studentList!.length) {
                    return const Center(
                        child: Text('Invalid student selected.'));
                  }
                  final student = studentController.studentList![selectedIndex];
                  return studentController.isLoading
                      ? const WebSiteShimmer()
                      : Form(
                          key: _formKey,
                          child: Column(children: [
//***************************************** Student Upper container ***************************************8*/

                            upperContainer(
                              student: student,
                              studentController: studentController,
                              eduboxController: eduboxController,
                              studentRegistrationController:
                                  studentRegistrationController,
                            ),
                            sizedBox10,
                            SizedBox(
                                height: screenHeight / 2.3,
                                width: screenWidth >= 520
                                    ? 340
                                    : screenWidth / 1.2,
                                child: (eduboxController
                                        .eduboxMaterialList!.isEmpty)
                                    ? Text(
                                        'No Material for now',
                                        style: TextStyle(
                                          fontSize:
                                              screenHeight >= 763 ? 16 : 14,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    //*********************** Student bootom Grid View *************************************888*/
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                          childAspectRatio: 1.0,
                                        ),
                                        itemCount: eduboxController
                                                .eduboxMaterialList?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          // Safe access to material list
                                          if (eduboxController
                                                      .eduboxMaterialList ==
                                                  null ||
                                              index >=
                                                  eduboxController
                                                      .eduboxMaterialList!
                                                      .length) {
                                            return const SizedBox(); // Return empty widget if invalid index
                                          }

                                          final edubox = eduboxController
                                              .eduboxMaterialList![index];
                                          final image = edubox.image ?? '';
                                          final titleImage =
                                              edubox.title_image ?? '';

                                          return InkWell(
                                            onTap: () {
                                              debugPrint(
                                                  'Student info: ${student.name} | ${student.id} | ${student.classId} | ${student.schoolId}');

                                              // Safe student checks
                                              final studentName =
                                                  student.name ?? 'Unknown';
                                              final studentCode =
                                                  student.code ?? '';
                                              final studentId = student.id ?? 0;
                                              final classId =
                                                  student.classId ?? 0;
                                              final schoolId =
                                                  student.schoolId ?? 0;
                                              final className =
                                                  student.studentClass ?? '';
                                              final schoolName =
                                                  student.school ?? '';

                                              if (studentController
                                                      .studentList?.isEmpty ??
                                                  true) {
                                                showInfoDialog(
                                                  context,
                                                  title: 'Student Info',
                                                  student_name: studentName,
                                                  student_code: studentCode,
                                                  description:
                                                      'Student is not available! Please add Student to continue',
                                                  studentController:
                                                      studentController,
                                                  studentRegController:
                                                      studentRegistrationController,
                                                  studentId: studentId,
                                                  selectedIndex: selectedIndex,
                                                  parentId: parentId ?? '',
                                                );
                                              } else {
                                                if (index == 0) {
                                                  Get.to(
                                                    SchoolListScreen(
                                                      studentCode: studentCode,
                                                      shipper: 'shipper',
                                                      homePhone: 'homePhone',
                                                      destination:
                                                          'destination',
                                                      studentName: studentName,
                                                      className: className,
                                                      schoolName: schoolName,
                                                      schoolId: schoolId,
                                                      studentId: studentId,
                                                      classId: classId,
                                                    ),
                                                  );
                                                } else {
                                                  // Safe user data access
                                                  final userData =
                                                      Get.find<AuthController>()
                                                          .getUserData();
                                                  final countryCode =
                                                      userData?.countryCode ??
                                                          '';
                                                  final phone =
                                                      userData?.phone ?? '';
                                                  final name =
                                                      userData?.name ?? '';

                                                  Get.to(
                                                    TerekaAsome(
                                                        productId: edubox.id,
                                                        studentId:
                                                            studentController
                                                                .studentList![0]
                                                                .id,
                                                        schoolId:
                                                            studentController
                                                                .studentList![0]
                                                                .schoolId!,
                                                        classId:
                                                            studentController
                                                                .studentList![0]
                                                                .classId!,
                                                        contactModelMtn:
                                                            ContactModelMtn(
                                                          phoneNumber:
                                                              '${userData?.countryCode}${userData?.phone}' ??
                                                                  '',
                                                          name:
                                                              '${userData?.name}',
                                                        ),
                                                        transactionType:
                                                            TransactionType
                                                                .sendMoney,
                                                        contactModel:
                                                            ContactModel(
                                                          phoneNumber:
                                                              '${userData?.countryCode}${userData?.phone}' ??
                                                                  '',
                                                          name:
                                                              '${userData?.name}',
                                                          avatarImage:
                                                              '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image' ?? ''}',
                                                        ),
                                                        studentIndex:
                                                            selectedIndex,
                                                        productValue:
                                                            productValueList[
                                                                    index]
                                                                [
                                                                'action'], // Dynamic value
                                                        productIndex: index,
                                                        iconImages:
                                                            "${AppConstants.baseUrl}/storage/app/public/edupoto_product/$titleImage", // Adjust icon logic
                                                        edubox_service:
                                                            productValueList[
                                                                    index]
                                                                ['action'],
                                                        parent: userData?.name),
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.grey.shade100
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 4,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: CustomImageWidget(
                                                      image:
                                                          "${AppConstants.baseUrl}/storage/app/public/edupoto_product/$image",
                                                      fit: BoxFit.cover,
                                                      placeholder: Images
                                                          .bannerPlaceHolder,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                          ]),
                        );
                });
        });
      });
    });
  }

  TextFormField buildFormField(
      String labelText,
      TextEditingController editingController,
      TextInputType textInputType,
      String hint,
      List<TextInputFormatter>? formatter,
      FocusNode? focusNode,
      FormFieldValidator<String>? validator) {
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
                horizontal: 15), //Change this value to custom as you like
            isDense: true,
            focusedBorder: OutlineInputBorder(
              ////<-- SEE HERE
              borderSide: const BorderSide(width: 1, color: Colors.black),
              borderRadius: screenHeight >= 763
                  ? BorderRadius.circular(20.0)
                  : BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: kTextLightColor),
              borderRadius: screenHeight >= 763
                  ? BorderRadius.circular(20.0)
                  : BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              //<-- SEE HERE
              borderSide: const BorderSide(width: 1, color: Colors.redAccent),
              borderRadius: screenHeight >= 763
                  ? BorderRadius.circular(20.0)
                  : BorderRadius.circular(15.0),
              //<-- SEE HERE
            ),
            labelText: labelText,
            labelStyle:
                screenHeight >= 763 ? kLabelTextStyle : kLabelTextStyle10
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
        validator: validator);
  }

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget upperContainer(
      {required StudentController studentController,
      required EduboxMaterialController eduboxController,
      required final student,
      required StudentRegistrationController studentRegistrationController}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth >= 520 ? 340 : screenWidth / 1.2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    height: screenHeight >= 763 ? 185 : 50,
                    width: screenHeight >= 763 ? 115 : 30,
                    child: const IconImages('assets/image/edubox_kid.png')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      height: screenHeight >= 763 ? 40 : 35,
                      width: screenHeight >= 763 ? 180 : 160,
                      child: const IconImages('assets/image/edubox.png')),
                ),
              ],
            ),
          ),
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
                                  eduboxController: eduboxController)
                              : studentController.studentList!.isEmpty
                                  ? addAccout(
                                      student: student,
                                      studentRegController:
                                          studentRegistrationController,
                                      studentController: studentController,
                                      eduboxController: eduboxController)
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
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            : Text(
                                                'No Parent Name',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenHeight >= 763
                                                            ? 12
                                                            : 10,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                        sizedBox10,
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
                                                            FontWeight.w400),
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        'Select Student Code:',
                                                        style: TextStyle(
                                                            fontSize:
                                                                screenHeight >=
                                                                        763
                                                                    ? 12
                                                                    : 10,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      const Spacer(),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() => studentId =
                                                                studentController
                                                                    .studentList![
                                                                        selectedIndex]
                                                                    .id!);
                                                            Get.to(StudentAddInfo(
                                                                studentInfo:
                                                                    'Code: ${studentController.studentList![selectedIndex].code!} Name: ${studentController.studentList![selectedIndex].name!}',
                                                                studentId:
                                                                    studentId!,
                                                                studentRegController:
                                                                    studentRegistrationController,
                                                                studentController:
                                                                    studentController,
                                                                selectedIndex:
                                                                    selectedIndex));
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit))
                                                    ],
                                                  ),
                                            SizedBox(
                                              width: screenWidth / 1.1,
                                              child: DropDownAccount(
                                                onChanged: (selectedCode) {
                                                  setState(() {
                                                    // Find the index of the selected student in the list using the selected code
                                                    selectedIndex =
                                                        studentController
                                                            .studentList!
                                                            .indexWhere(
                                                                (student) =>
                                                                    student
                                                                        .code ==
                                                                    selectedCode);

                                                    // You may want to add additional logic here based on the selected code

                                                    studentId = studentController
                                                        .studentList!
                                                        .firstWhere((student) =>
                                                            student.code ==
                                                            selectedCode)
                                                        .id!;
                                                    print(
                                                        'Selected student index: $selectedIndex');
                                                    print(
                                                        'Selected student id: $studentId');
                                                  });
                                                },
                                                itemLists: studentController
                                                    .studentList!,
                                                title:
                                                    'Code: ${studentController.studentList![0].code!}\nName: ${studentController.studentList![0].name!}',
                                                isExpanded: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                          sizedBox05h,
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
                                                      schoolCode:
                                                          schoolId.toString(),
                                                      parentId: parentId!,
                                                      classId: classId!)
                                                  .then((onValue) {
                                                setState(() {
                                                  studentController
                                                      .getStudentList(true,
                                                          id: parentId!);
                                                });

                                                if (studentRegistrationController
                                                        .isNextBottomSheet ==
                                                    true) {
                                                  setAddAccount();
                                                  showInfoDialog(context,
                                                      student_code:
                                                          student.code!,
                                                      student_name:
                                                          student.name!,
                                                      studentRegController:
                                                          studentRegistrationController,
                                                      title: 'Student Info',
                                                      description:
                                                          'Student added successfully\nYou can continue by adding uniform details',
                                                      studentController:
                                                          studentController,
                                                      studentId: student.id,
                                                      selectedIndex:
                                                          selectedIndex,
                                                      parentId: parentId!);
                                                }
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
                                          clas: ''),
                                      screenHeight >= 763
                                          ? PartinerServices(
                                              borderColor: Colors.black,
                                              vertical: 5,
                                              textColor: Colors.black,
                                              horizontal: 5,
                                              onPress: () => Get.to(TerekaAsome(
                                                    productId: eduboxController
                                                        .eduboxMaterialList![6]
                                                        .id,
                                                    studentId: studentController
                                                        .studentList![0].id,
                                                    schoolId: studentController
                                                        .studentList![0]
                                                        .schoolId!,
                                                    classId: studentController
                                                        .studentList![0]
                                                        .classId!,
                                                    contactModelMtn: ContactModelMtn(
                                                        phoneNumber:
                                                            '${userData?.countryCode}${userData?.phone}' ??
                                                                '',
                                                        name:
                                                            '${userData?.name}'),
                                                    transactionType:
                                                        TransactionType
                                                            .sendMoney,
                                                    contactModel: ContactModel(
                                                        phoneNumber:
                                                            '${userData?.countryCode}${userData?.phone}' ??
                                                                '',
                                                        name:
                                                            '${userData?.name}',
                                                        avatarImage:
                                                            '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image' ?? ''}'),
                                                    studentIndex: selectedIndex,
                                                    productValue:
                                                        productValueList[0]
                                                            ['action'],
                                                    productIndex: 6,
                                                    iconImages:
                                                        'assets/image/Partner services.png',
                                                    edubox_service:
                                                        'SAVE/DEPOSIT',
                                                  )),
                                              height: 40,
                                              width: screenWidth >= 520
                                                  ? 148
                                                  : screenWidth / 2.8,
                                              icon: 'SAVE/DEPOSIT',
                                              title:
                                                  'assets/image/edubox_icon.png',
                                              clas: '')
                                          : PartinerServices(
                                              borderColor: Colors.black,
                                              vertical: 2,
                                              textColor: Colors.black,
                                              horizontal: 2,
                                              onPress: () => Get.to(TerekaAsome(
                                                    productId: eduboxController
                                                        .eduboxMaterialList![6]
                                                        .id,
                                                    studentId: studentController
                                                        .studentList![0].id,
                                                    schoolId: schoolId!,
                                                    classId: classId!,
                                                    contactModelMtn: ContactModelMtn(
                                                        phoneNumber:
                                                            '${userData?.countryCode}${userData?.phone}' ??
                                                                '',
                                                        name:
                                                            '${userData?.name}'),
                                                    transactionType:
                                                        TransactionType
                                                            .sendMoney,
                                                    contactModel: ContactModel(
                                                        phoneNumber:
                                                            '${userData?.countryCode}${userData?.phone}' ??
                                                                '', //'${userData?.countryCode}${userData?.phone}' ?? ,
                                                        name:
                                                            '${userData?.name}',
                                                        avatarImage:
                                                            '${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${'image' ?? ''}'),
                                                    studentIndex: selectedIndex,
                                                    productValue:
                                                        productValueList[0]
                                                            ['action'],
                                                    productIndex: 6,
                                                    iconImages:
                                                        'assets/image/Partner services.png',
                                                    edubox_service:
                                                        'SAVE/DEPOSIT',
                                                  )),
                                              height: 20,
                                              width: screenWidth >= 520
                                                  ? 148
                                                  : screenWidth / 2.7,
                                              icon: 'SAVE/DEPOSIT',
                                              title:
                                                  'assets/image/edubox_icon.png',
                                              clas: ''),
                                    ])
                              : SizedBox(),
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
    ClassModel? classModel;

    return SizedBox(
      height: screenHeight / 1.3,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                sizedBox10,
                Text(
                  'Please Register Your Student Here',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                        fontSize: screenHeight >= 763 ? 12 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),

                //********************THIS IS THE DEPENDENCE DROPDOWN FOR REGISTERING STUDENTS *********************/
                SizedBox(
                  width: screenWidth / 1.1,
                  child: DependentSchoolDropdowns(
                    isAddAccount: isAddAccount,
                    studentController: studentController,
                    studentRegistrationController: studentRegController,
                    selectedIndex: selectedIndex,
                    userData: userData!,
                    eduboxController: eduboxController,
                    parentId: parentId!,
                  ),
                ),
                sizedBox15,
              ],
            ),
            Positioned(
              top: -7,
              right: 2,
              child: IconButton(
                onPressed: setAddAccount, // ✅ No parentheses
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
                setAddAccount(); // ✅ Moved inside callback
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

    // Add your loan application logic here
  }
}
