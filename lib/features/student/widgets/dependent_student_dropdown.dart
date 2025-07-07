import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/show_info_dialog.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';

class DependentStudentDropdowns extends StatefulWidget {
  final StudentController studentController;
  final StudentRegistrationController studentRegistrationController;
  final int selectedIndex;
  final isStudentEdit;
  final String parentId;
  bool isAddAccount;
  DependentStudentDropdowns(
      {required this.parentId,
      required this.isStudentEdit,
      required this.selectedIndex,
      required this.studentController,
      required this.isAddAccount,
      required this.studentRegistrationController,
      super.key});

  @override
  _DependentStudentDropdownsState createState() =>
      _DependentStudentDropdownsState();
}

class _DependentStudentDropdownsState extends State<DependentStudentDropdowns> {
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory;
  ClassDetails? selectedSubCategory;
  Student? selectedStudent;
  TextEditingController studentCodeEditingController = TextEditingController();
  TextEditingController studentNameEditingController = TextEditingController();
  String displayCode = 'enter_student_code'.tr;
  String displayName = 'enter_student_name'.tr;
  List<Districts>? allSchoolList;

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

  void displayTextMethod() {
    final student = widget.studentController.studentList![widget.selectedIndex];
    setState(() {
      displayCode = student.code ?? 'enter_student_code'.tr;
      displayName = student.name ?? 'enter_student_code'.tr;
      // Initialize controllers with existing values
      studentCodeEditingController.text = student.code ?? '';
      studentNameEditingController.text = student.name ?? '';
    });
  }

  void _updateDisplayCode() {
    String inputCode = studentCodeEditingController.text;
    final studentCode =
        widget.studentController.studentList![widget.selectedIndex].code;

    setState(() {
      displayCode = (inputCode.isEmpty || inputCode != studentCode)
          ? 'enter_student_code'.tr
          : studentCode!;
    });
  }

  void _updateDisplayName() {
    String inputText = studentNameEditingController.text;
    final studentName =
        widget.studentController.studentList![widget.selectedIndex].name;

    setState(() {
      displayName = (inputText.isEmpty || inputText != studentName)
          ? 'enter_student_name'.tr
          : studentName!;
    });
  }

@override
void initState() {
  super.initState();
  Get.find<AllSchoolController>().getSchoolList(false).then((_) {
    allSchoolList = Get.find<AllSchoolController>().schoolList;
    
    // Initialize dropdown values if in edit mode
    if (widget.isStudentEdit) {
      final student = widget.studentController.studentList![widget.selectedIndex];
      studentCodeEditingController.text = student.code ?? '';
      studentNameEditingController.text = student.name ?? '';
      displayTextMethod();
      
      // Find and set the district that contains the student's school
      for (var district in allSchoolList!) {
        var matchingSchool = district.schools.firstWhereOrNull(
          (school) => school.id.toString() == student.schoolId
        );
        if (matchingSchool != null) {
          setState(() {
            selectedDistrict = district;
            selectedCategory = matchingSchool;
            
            // Find and set the class if available
            if (student.classId != null) {
              selectedSubCategory = matchingSchool.classes.firstWhereOrNull(
                (cls) => cls.id == student.classId
              );
            }
          });
          break;
        }
      }
    }
  });

  studentCodeEditingController.addListener(_updateDisplayCode);
  studentNameEditingController.addListener(_updateDisplayName);
}
  @override
  void dispose() {
    studentCodeEditingController.dispose();
    studentNameEditingController.dispose();
    super.dispose();
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
                   (allSchoolController.schoolList.isEmpty)
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight / 1.8,
                                ),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      selectedStudent != null
                                          ? const SizedBox.shrink()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                sizedBox10,
                                                _buildFormFieldWithKeyboardPadding(
                                                  displayName,
                                                  studentNameEditingController,
                                                ),
                                                const SizedBox(height: 15),
                                                _buildFormFieldWithKeyboardPadding(
                                                  displayCode,
                                                  studentCodeEditingController,
                                                ),
                                              ],
                                            ),
                                      sizedBox,
                                      // Top Searchable dropdown
                                      DropdownSearch<Districts>(
                       compareFn: (item1, item2) => item1?.id == item2?.id,
                       selectedItem: selectedDistrict,
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
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                                errorText: _districtError,
                                                errorStyle: TextStyle(
                                                color: Colors.red[700]),
                                          ),
                                        ),
                                        items: (filter, infiniteScrollProps) =>
                                            allSchoolController.schoolList,
                                        itemAsString: (Districts? item) =>
                                            item?.name ?? '',
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
                                      sizedBox10, // Spacing between dropdowns
                                      // First Searchable Dropdown
                                      DropdownSearch<AllSchoolModel>(
                                        compareFn: (AllSchoolModel? item1,
                                            AllSchoolModel? item2) {
                                          if (item1 == null || item2 == null) {
                                            // allSchoolController.hasMore != false;
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
                                            hintText:
                                                "select_from_our_partner_schools"
                                                    .tr,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
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
                                      const SizedBox(
                                          height:
                                              20), // Spacing between dropdowns

                                      // Second Searchable Dropdown
                                      DropdownSearch<ClassDetails>(
                                        compareFn: (ClassDetails? item1,
                                            ClassDetails? item2) {
                                          if (item1 == null ||
                                              item2 == null) {
                                            return false;
                                          }
                                          return item1 == item2;
                                        },
                                        validator: (value) => value==null?'':null,
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps:
                                              TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                  Icons.search),
                                              hintText:
                                                  '${'search'.tr}...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12),
                                            ),
                                          ),
                                        ),
                                        decoratorProps:
                                            DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          25.0)),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          25.0)),
                                            ),
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText: "select_class".tr,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                                errorText: _classError,
                                                errorStyle: TextStyle(color: Colors.red[700])
                                          ),
                                        ),
                                        items: (filter,
                                                infiniteScrollProps) =>
                                            selectedCategory?.classes ??
                                            [], // Populate based on the selected school
                                        itemAsString:
                                            (ClassDetails? item) =>
                                                item?.className ?? '',
                                        selectedItem: selectedSubCategory,
                                        onChanged: (ClassDetails? value) {
                                          setState(() {
                                            selectedSubCategory = value;
                                            print(
                                                'Class ID: ${selectedSubCategory!.id}');
                                            widget.studentController
                                                .studentList;
                                            selectedStudent =
                                                null; // Reset student dropdown
                                          });
                                          _validateClass(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBox15,
                                   Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BorderButton1(
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
                                                  .studentRegistrationController
                                                  .addStudent(
                                                      name:
                                                          studentNameEditingController
                                                              .text,
                                                      code:
                                                          studentCodeEditingController
                                                              .text,
                                                      schoolCode:
                                                          selectedCategory!.id
                                                              .toString(),
                                                      parentId: widget.parentId,
                                                      classId:
                                                          selectedSubCategory!
                                                              .id!)
                                                  .then((onValue) {
                                                setState(() {
                                                  widget.studentController
                                                      .getStudentList(true,
                                                          id: widget.parentId);
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
                                                      .studentRegistrationController,
                                                  title: 'student_info'.tr,
                                                  description:
                                                      '${'student_added_successfully'.tr}\n${'you_can_continue_by_adding_uniform_details'.tr}',
                                                  studentController:
                                                      widget.studentController,
                                                  studentId: widget
                                                      .studentController
                                                      .studentList![
                                                          widget.selectedIndex]
                                                      .id!,
                                                  selectedIndex:
                                                      widget.selectedIndex,
                                                  parentId: widget.parentId);
                                            }
                                            widget.studentRegistrationController
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
                                                    parentId: widget.parentId,
                                                    classId:
                                                        selectedSubCategory!
                                                            .id!)
                                                .then((onValue) {
                                              setState(() {
                                                widget.studentController
                                                    .getStudentList(true,
                                                        id: widget.parentId);
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
                                                    .studentRegistrationController,
                                                title: 'student_info'.tr,
                                                description:
                                                    '${'student_added_successfully'.tr}\n${'you_can_continue_by_adding_uniform_details'.tr}',
                                                studentController:
                                                    widget.studentController,
                                                studentId: selectedStudent!.id!,
                                                selectedIndex:
                                                    widget.selectedIndex,
                                                parentId: widget.parentId);
                                          } else {
                                            setAddAccount();
                                          }
                                        },
                                        height: 50,
                                        width: screenWidth >= 520
                                            ? 320
                                            : screenWidth / 1.3,
                                        icon: (widget.isAddAccount == true ||
                                                widget.studentController
                                                    .studentList!.isEmpty)
                                            ? 'save'.tr
                                            : 'add_student'.tr,
                                        title: (widget.isAddAccount == true ||
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

  Widget _buildFormFieldWithKeyboardPadding(
    String labelText,
    TextEditingController controller,
  ) {
    // Add TextSelection preservation
    final selection = controller.selection;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 16 : 0,
      ),
      child: buildFormField(
        labelText,
        controller,
        TextInputType.text,
        labelText,
        [],
        FocusNode(),
        (value) {
          if (value == null || value.isEmpty) {
            return 'please_enter_required_information_to_continue'.tr;
          }
          if (labelText.contains('name')) {
            RegExp nameRegExp = RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');
            if (!nameRegExp.hasMatch(value.trim())) {
              // Restore cursor position after validation
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (controller.text.isNotEmpty) {
                  controller.selection = selection;
                }
              });
              return '${'please_enter_atleast_two_name_to_continue'.tr} (${'eg'.tr}., Juma Ally)';
            }
          }
          return null;
        },
      ),
    );
  }

  StatefulBuilder buildFormField(
    String labelText,
    TextEditingController editingController,
    TextInputType textInputType,
    String hint,
    List<TextInputFormatter>? formatter,
    FocusNode? focusNode,
    FormFieldValidator<String>? validator,
  ) {
    // Use StatefulBuilder to preserve cursor
    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          textAlign: TextAlign.start,
          controller: editingController,
          keyboardType: textInputType,
          style: MediaQuery.of(context).size.height >= 763
              ? kInputTextStyle
              : kInputTextStyle10,
          inputFormatters: formatter,
          focusNode: focusNode,
          autofocus: false, // Important for cursor stability
          onChanged: (value) {
            // Force rebuild without losing cursor
            setState(() {});
          },
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: hint,
            hintStyle: MediaQuery.of(context).size.height >= 763
                ? kHintTextStyle
                : kHintTextStyle10,
            contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height >= 763 ? 13 : 15,
              horizontal: 15,
            ),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height >= 763 ? 20.0 : 15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: kTextLightColor),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height >= 763 ? 20.0 : 15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height >= 763 ? 20.0 : 15.0),
            ),
            labelText: labelText,
            labelStyle: MediaQuery.of(context).size.height >= 763
                ? kLabelTextStyle
                : kLabelTextStyle10,
          ),
          validator: validator,
        );
      },
    );
  }
}
