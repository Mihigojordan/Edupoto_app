import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/edubox_material_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/student_add_info.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/single_school.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/screens/transaction_confirmation_screen.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';

class DependentSchoolDropdowns extends StatefulWidget {
  final StudentController studentController;
  final StudentRegistrationController? studentRegistrationController;
  final int? selectedIndex;
  final String? parentId;
  bool isAddAccount;
  bool isNotRegStudent;
  final int? eduboxId;
  final int? index;
  final String? titleImage;
  final bool isShop;
  final Function({required String schoolName,required String className,required String studentName,required String studentCode}) onInputStudent;

  DependentSchoolDropdowns(
      {
      required this.onInputStudent,
      required this.isShop,
      required this.studentController,
      required this.isAddAccount,
      required this.isNotRegStudent,
      this.studentRegistrationController,
      this.selectedIndex,
      this.parentId,
      this.eduboxId,
      this.index,
      this.titleImage,
      super.key});

  @override
  _DependentSchoolDropdownsState createState() =>
      _DependentSchoolDropdownsState();
}

class _DependentSchoolDropdownsState extends State<DependentSchoolDropdowns> {
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
  TextEditingController studentCodeEditingController = TextEditingController();
  TextEditingController studentNameEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

// Add these variables to your state class
  String? _districtError;
  String? _schoolError;
  String? _classError;
  String? _studentError;

// Validation methods
  void _validateDistrict(Districts? value) {
    setState(() {
      _districtError = value == null ? 'please_select_district'.tr : null;
    });
  }

  void _validateSchool(AllSchoolModel? value) {
    setState(() {
      _schoolError = value == null ? 'please_select_school'.tr : null;
    });
  }

  void _validateClass(ClassDetails? value) {
    setState(() {
      _classError = value == null ? 'please_select_class'.tr : null;
    });
  }

  void _validateStudent(Student? value) {
    setState(() {
      _studentError = value == null ? 'please_select_student'.tr : null;
    });
  }

  bool _validateAll() {
    _validateDistrict(selectedDistrict);
    _validateSchool(selectedCategory);
    _validateClass(selectedSubCategory);
    _validateStudent(selectedStudent);

    return _districtError == null &&
        _schoolError == null &&
        _classError == null &&
        _studentError == null;
  }

  setAddAccount() {
    setState(() {
      widget.isAddAccount = !widget.isAddAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.linkedWebSiteStatus!
          ? GetBuilder<AllSchoolController>(builder: (allSchoolController) {
              return
                  // allSchoolController.isLoading
                  //     ? const WebSiteShimmer()
                  //     :
                  allSchoolController.schoolList.isEmpty
                      ? const SizedBox()
                      : Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: widget.isNotRegStudent
                                    ? screenHeight / 2
                                    : screenHeight / 1.8,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      buildFormField(
                                        'enter_student_code'
                                            .tr, // Fixed label capitalization
                                        studentCodeEditingController,
                                        TextInputType
                                            .number, // Consider using `TextInputType.text` if codes include letters
                                        '', // Optional hint text
                                        [], // Optional input formatters
                                        FocusNode(), // Focus node
                                        (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_student_code'
                                                .tr; // More specific error
                                          } else if (value.length != 12) {
                                            return 'student_code_must_be_exactly_12_digits'
                                                .tr; // Clearer error
                                          } else if (!RegExp(r'^[0-9]{12}$')
                                              .hasMatch(value)) {
                                            // Ensures only digits
                                            return 'only_numbers_are_allowed'
                                                .tr;
                                          }
                                          return null; // Validation passed
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      buildFormField(
                                        'enter_student_name'.tr,
                                        studentNameEditingController,
                                        TextInputType.text,
                                        '${'eg'.tr}; Juma Ally Omary',
                                        [],
                                        FocusNode(),
                                        (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'please_enter_student_name_to_continue'
                                                .tr;
                                          }

                                          // Regular expression: Allows names with any capitalization but ensures two words
                                          RegExp nameRegExp = RegExp(
                                              r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');

                                          if (!nameRegExp
                                              .hasMatch(value.trim())) {
                                            return '${'please_enter_atleast_two_name_to_continue'.tr}(${'eg'.tr}., Juma Ally)';
                                          }

                                          return null;
                                        },
                                      ),
                                      sizedBox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: SizedBox(
                                              width: screenWidth / 1.7,
                                              child: Text(
                                                'select_district_school_and_class'
                                                    .tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Top Searchable dropdown
                                      DropdownSearch<Districts>(
                                        compareFn: (Districts? item1,
                                            Districts? item2) {
                                          if (item1 == null || item2 == null) {
                                            allSchoolController.hasMore !=
                                                false;
                                            return false;
                                          }

                                          return item1 == item2;
                                        },
                                        validator: (value) =>
                                            value == null ? '' : null,
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: '${'search'.tr}...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                            ),
                                          ),
                                        ),
                                        decoratorProps: DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText: "select_district".tr,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            errorText: _districtError,
                                            errorStyle: TextStyle(
                                                color: Colors.red[700]),
                                          ),
                                        ),
                                        items: (filter, infiniteScrollProps) =>
                                            allSchoolController.schoolList,
                                        itemAsString: (Districts? item) =>
                                            item?.name ?? '',
                                        selectedItem: selectedDistrict,
                                        onChanged: (Districts? value) {
                                          setState(() {
                                            selectedDistrict = value;
                                            print(
                                                'this is district id::::::::::::::::::::::: ${selectedDistrict!.id}');
                                            selectedSubCategory =
                                                null; // Reset class dropdown
                                            selectedStudent =
                                                null; // Reset student dropdown
                                          });
                                          _validateDistrict(value);
                                        },
                                      ),
                                      sizedBox10,
                                      // First Searchable Dropdown
                                      DropdownSearch<AllSchoolModel>(
                                        compareFn: (AllSchoolModel? item1,
                                            AllSchoolModel? item2) {
                                          if (item1 == null || item2 == null) {
                                            allSchoolController.hasMore !=
                                                false;
                                            return false;
                                          }

                                          return item1 == item2;
                                        },
                                        validator: (value) =>
                                            value == null ? '' : null,
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: '${'search'.tr}...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                            ),
                                          ),
                                        ),
                                        decoratorProps: DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.grey),
                                            hintText:
                                                "select_from_our_partner_schools"
                                                    .tr,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            errorText: _schoolError,
                                            errorStyle: TextStyle(
                                                color: Colors.red[700]),
                                          ),
                                        ),
                                        items: (filter, infiniteScrollProps) =>
                                            selectedDistrict?.schools ?? [],
                                        itemAsString: (AllSchoolModel? item) =>
                                            item?.schoolName ?? '',
                                        selectedItem: selectedCategory,
                                        onChanged: (AllSchoolModel? value) {
                                          setState(() {
                                            selectedCategory = value;
                                            print(
                                                'this is school id::::::::::::::::::::::: ${selectedCategory!.id}');
                                            selectedSubCategory =
                                                null; // Reset class dropdown
                                            selectedStudent =
                                                null; // Reset student dropdown
                                          });
                                          _validateSchool(value);
                                        },
                                      ),
                                      // Spacing between dropdowns
                                      sizedBox10,
                                      // Second Searchable Dropdown
                                      DropdownSearch<ClassDetails>(
                                        compareFn: (ClassDetails? item1,
                                            ClassDetails? item2) {
                                          if (item1 == null || item2 == null) {
                                            return false;
                                          }
                                          return item1 == item2;
                                        },
                                        validator: (value) =>
                                            value == null ? '' : null,
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: '${'search'.tr}...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                            ),
                                          ),
                                        ),
                                        decoratorProps: DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText: "select_class".tr,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            errorText: _classError,
                                            errorStyle: TextStyle(
                                                color: Colors.red[700]),
                                          ),
                                        ),

                                        items: (filter, infiniteScrollProps) =>
                                            selectedCategory?.classes ??
                                            [], // Populate based on the selected school
                                        itemAsString: (ClassDetails? item) =>
                                            item?.className ?? '',
                                        selectedItem: selectedSubCategory,
                                        onChanged: (ClassDetails? value) {
                                          setState(() {
                                            selectedSubCategory = value;
                                            print(
                                                'Class ID: ${selectedSubCategory!.id}');
                                            widget
                                                .studentController.studentList;
                                            selectedStudent =
                                                null; // Reset student dropdown
                                          });
                                          _validateClass(value);
                                        },
                                      ),
                                      // Spacing between dropdowns

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //                               TextFormField(
                                          //   controller: studentCodeEditingController ,
                                          //   keyboardType: TextInputType.number,
                                          //   inputFormatters: [
                                          //     FilteringTextInputFormatter.digitsOnly,
                                          //       LengthLimitingTextInputFormatter(10), // For phone numbers
                                          //   ],
                                          //   decoration: InputDecoration(
                                          //     hintText:'Enter student code',
                                          //     prefixIcon:  const Icon(Icons.code),
                                          //     border: OutlineInputBorder(
                                          //       borderRadius: BorderRadius.circular(15),
                                          //     ),
                                          //   ),
                                          //   validator: (value) {
                                          //     if (value == null || value.isEmpty) {
                                          //       return 'Please enter required details';
                                          //     }
                                          //     if (value.length != 12) {
                                          //       return 'Enter a valid 12-digit number';
                                          //     }
                                          //     return null;
                                          //   },
                                          // ),

                                          sizedBox,
                                          widget.isNotRegStudent == true
                                              ? const SizedBox.shrink()
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    'student_registration_note'
                                                        .tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBox15,
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    widget.isNotRegStudent == true
                                        ? DefaultButtonWidth(
                                            width: 123,
                                            color1: kamber300Color,
                                            color2: kyellowColor,
                                            onPress: () {
                                              widget.onInputStudent(schoolName:  selectedCategory!.schoolName!,className:  selectedSubCategory!.className!,studentName:  studentNameEditingController.text,studentCode:studentCodeEditingController.text);
                                              //****************************Check if you want to edit student registration or you do not have student */
                                              if (widget.isAddAccount == true ||
                                                  widget.studentController
                                                      .studentList!.isEmpty) {
                                                //************************** Check if the student has been selected */
                                                // if(widget.isShop==true){

                                                // }else{

                                                // }
                                              } else {
                                                setAddAccount();
                                              }
                                            },
                                            title: 'next'.tr,
                                          )
                                        : BorderButton1(
                                            borderColor: Colors.black,
                                            vertical: 5,
                                            textColor: Colors.black,
                                            horizontal: 5,
                                            onPress: () {
                                              //****************************Check if you want to edit student registration or you do not have student */
                                              if (widget.isAddAccount == true ||
                                                  widget.studentController
                                                      .studentList!.isEmpty) {
                                                //************************** Check if the student has been selected */
                                                if (selectedStudent == null) {
                                                  widget
                                                      .studentRegistrationController!
                                                      .addStudent(
                                                          name:
                                                              studentNameEditingController
                                                                  .text,
                                                          code:
                                                              studentCodeEditingController
                                                                  .text,
                                                          schoolCode:
                                                              selectedCategory!
                                                                  .id
                                                                  .toString(),
                                                          parentId:
                                                              widget.parentId!,
                                                          classId:
                                                              selectedSubCategory!
                                                                  .id!)
                                                      .then((onValue) {
                                                    setState(() {
                                                      widget.studentController
                                                          .getStudentList(true,
                                                              id: widget
                                                                  .parentId!);
                                                    });
                                                    setAddAccount();
                                                  });
                                                  showInfoDialog(context,
                                                      student_name:
                                                          studentNameEditingController
                                                              .text,
                                                      student_code:
                                                          studentCodeEditingController
                                                              .text,
                                                      studentRegController: widget
                                                          .studentRegistrationController!,
                                                      title: 'student_info'.tr,
                                                      description:
                                                          '${'student_added_successfully'.tr}\n${'you_can_continue_by_adding_uniform_details'.tr}',
                                                      studentController: widget
                                                          .studentController,
                                                      studentId: widget
                                                          .studentController
                                                          .studentList![widget
                                                              .selectedIndex!]
                                                          .id!,
                                                      selectedIndex:
                                                          widget.selectedIndex!,
                                                      parentId:
                                                          widget.parentId!);
                                                }
                                                widget
                                                    .studentRegistrationController!
                                                    .addStudent(
                                                        name: selectedStudent!
                                                                .name ??
                                                            studentNameEditingController
                                                                .text,
                                                        code: selectedStudent!
                                                                .code ??
                                                            studentCodeEditingController
                                                                .text,
                                                        schoolCode:
                                                            selectedCategory!.id
                                                                .toString(),
                                                        parentId:
                                                            widget.parentId!,
                                                        classId:
                                                            selectedSubCategory!
                                                                .id!)
                                                    .then((onValue) {
                                                  setState(() {
                                                    widget.studentController
                                                        .getStudentList(true,
                                                            id: widget
                                                                .parentId!);
                                                  });
                                                  setAddAccount();
                                                  // ignore: use_build_context_synchronously
                                                });
                                                showInfoDialog(context,
                                                    student_name:
                                                        selectedStudent!.name!,
                                                    student_code:
                                                        selectedStudent!.code!,
                                                    studentRegController: widget
                                                        .studentRegistrationController!,
                                                    title: 'student_info'.tr,
                                                    description:
                                                        '${'student_added_successfully'.tr}\n${'you_can_continue_by_adding_uniform_details'.tr}',
                                                    studentController: widget
                                                        .studentController,
                                                    studentId:
                                                        selectedStudent!.id!,
                                                    selectedIndex:
                                                        widget.selectedIndex!,
                                                    parentId: widget.parentId!);
                                              } else {
                                                setAddAccount();
                                              }
                                            },
                                            height: 50,
                                            width: screenWidth >= 520
                                                ? 320
                                                : screenWidth / 1.3,
                                            icon:
                                                (widget.isAddAccount == true ||
                                                        widget
                                                            .studentController
                                                            .studentList!
                                                            .isEmpty)
                                                    ? 'save'.tr
                                                    : 'add_student'.tr,
                                            title: (widget.isAddAccount ==
                                                        true ||
                                                    widget.studentController
                                                        .studentList!.isEmpty)
                                                ? 'assets/icons1/save.png'
                                                : 'assets/icons1/add_account.png',
                                            clas: ''),
                                  ]),
                            ],
                          ),
                        );
            })
          : const SizedBox();
    });
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenHeight >= 763;

    return TextFormField(
      controller: editingController,
      keyboardType: textInputType,
      textAlign: TextAlign.start,
      inputFormatters: formatter,
      focusNode: focusNode,
      validator: validator,
      style: isLargeScreen ? kInputTextStyle : kInputTextStyle10,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hint,
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: isLargeScreen ? 13 : 15,
          horizontal: 15,
        ),
        labelStyle: isLargeScreen ? kLabelTextStyle : kLabelTextStyle10,
        hintStyle: isLargeScreen ? kHintTextStyle : kHintTextStyle10,
        errorStyle: TextStyle(
          fontSize: isLargeScreen ? 12 : 10,
          color: Colors.red[700],
        ),
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          borderSide: const BorderSide(color: kTextLightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          borderSide: const BorderSide(color: kTextLightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          borderSide: BorderSide(width: 1, color: Colors.red[700]!),
        ),
      ),
    );
  }
}
