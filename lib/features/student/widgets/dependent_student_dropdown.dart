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
  String displayCode = 'Enter Student Code';
  String displayName = 'Enter Student Name';
  List<Districts>? allSchoolList;

  setAddAccount() {
    setState(() {
      widget.isAddAccount = !widget.isAddAccount;
    });
  }

  void displayTextMethod() {
    final student = widget.studentController.studentList![widget.selectedIndex];
    setState(() {
      displayCode = student.code ?? 'Enter Student Code';
      displayName = student.name ?? 'Enter Student Name';
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
          ? 'Enter Student Code'
          : studentCode!;
    });
  }

  void _updateDisplayName() {
    String inputText = studentNameEditingController.text;
    final studentName =
        widget.studentController.studentList![widget.selectedIndex].name;

    setState(() {
      displayName = (inputText.isEmpty || inputText != studentName)
          ? 'Enter Student Name'
          : studentName!;
    });
  }

  @override
  void initState() {
    super.initState();
    Get.find<AllSchoolController>().getSchoolList(false).then((_) {
      allSchoolList = Get.find<AllSchoolController>().schoolList;
    });

    // Initialize controllers with existing student data if in edit mode
    if (widget.isStudentEdit) {
      final student =
          widget.studentController.studentList![widget.selectedIndex];
      studentCodeEditingController.text = student.code ?? '';
      studentNameEditingController.text = student.name ?? '';
      displayTextMethod();
    }

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
              return allSchoolController.isLoading
                  ? const WebSiteShimmer()
                  : (allSchoolController.schoolList.isEmpty)
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
                                      // Top Searchable dropdown
                                      DropdownSearch<Districts>(
                                        compareFn: (Districts? item1,
                                            Districts? item2) {
                                          if (item1 == null || item2 == null) {
                                            // allSchoolController.hasMore != false;
                                            return false;
                                          }

                                          return item1 == item2;
                                        },
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: 'Search...',
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
                                        decoratorProps:
                                            const DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.grey),
                                            hintText: "Select Districts",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
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
                                        },
                                      ),
                                      const SizedBox(
                                          height:
                                              20), // Spacing between dropdowns
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
                                        popupProps: PopupProps.menu(
                                          showSearchBox: true,
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              hintText: 'Search...',
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
                                        decoratorProps:
                                            const DropDownDecoratorProps(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.amber),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25.0)),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.grey),
                                            hintText:
                                                "Select from our Parner Schools",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
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
                                        },
                                      ),
                                      const SizedBox(
                                          height:
                                              20), // Spacing between dropdowns

                                      // Second Searchable Dropdown
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth / 2.5,
                                            child: DropdownSearch<ClassDetails>(
                                              compareFn: (ClassDetails? item1,
                                                  ClassDetails? item2) {
                                                if (item1 == null ||
                                                    item2 == null) {
                                                  return false;
                                                }
                                                return item1 == item2;
                                              },
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                searchFieldProps:
                                                    TextFieldProps(
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        Icons.search),
                                                    hintText: 'Search...',
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
                                                  const DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.amber),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey),
                                                  hintText: "Select Class",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
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
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth / 2.5,
                                            child: DropdownSearch<ClassDetails>(
                                              compareFn: (ClassDetails? item1,
                                                  ClassDetails? item2) {
                                                if (item1 == null ||
                                                    item2 == null) {
                                                  return false;
                                                }
                                                return item1 == item2;
                                              },
                                              popupProps:  PopupProps.menu(
                                                showSearchBox: true,
                                                     searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: 'Search...',
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
                                              decoratorProps:
                                                  const DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.amber),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey),
                                                  hintText: "Select Grade",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
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
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                          height:
                                              20), // Spacing between dropdowns

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
                                    ],
                                  ),
                                ),
                              ),
                              sizedBox15,
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                                  title: 'Student Info',
                                                  description:
                                                      'Student added successfully\nYou can continue by adding uniform details',
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
                                                title: 'Student Info',
                                                description:
                                                    'Student added successfully\nYou can continue by adding uniform details',
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
                                        width: screenWidth >= 520 ? 100 : 100,
                                        icon: (widget.isAddAccount == true ||
                                                widget.studentController
                                                    .studentList!.isEmpty)
                                            ? 'Save'
                                            : 'Add Student',
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
            return 'Please enter required details to continue';
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
              return 'Please enter at least two names (e.g., Juma Ally)';
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
