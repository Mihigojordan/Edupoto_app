import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
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

class DependentSchoolDropdowns extends StatefulWidget {
  final StudentController studentController;
  final StudentRegistrationController studentRegistrationController;
  final int selectedIndex;
  final UserShortDataModel userData;
  final EduboxMaterialController eduboxController;
  final String parentId;
  bool isAddAccount;
  DependentSchoolDropdowns(
      {required this.parentId,
      required this.eduboxController,
      required this.userData,
      required this.selectedIndex,
      required this.studentController,
      required this.isAddAccount,
      required this.studentRegistrationController,
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
              return allSchoolController.isLoading
                  ? const WebSiteShimmer()
                  : allSchoolController.schoolList.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            SizedBox(
                              height: screenHeight/1.8,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                // Top Searchable dropdown
                                DropdownSearch<Districts>(
                                  compareFn: (Districts? item1, Districts? item2) {
                                    if (item1 == null || item2 == null) {
                                      allSchoolController.hasMore != false;
                                      return false;
                                    }
                                
                                    return item1 == item2;
                                  },
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  decoratorProps: const DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.amber),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintText: "Select Districts",
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                    height: 20), // Spacing between dropdowns
                                // First Searchable Dropdown
                                DropdownSearch<AllSchoolModel>(
                                  compareFn: (AllSchoolModel? item1,
                                      AllSchoolModel? item2) {
                                    if (item1 == null || item2 == null) {
                                      allSchoolController.hasMore != false;
                                      return false;
                                    }
                                
                                    return item1 == item2;
                                  },
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  decoratorProps: const DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.amber),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintText: "Select from our Parner Schools",
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                    height: 20), // Spacing between dropdowns
                                
                                // Second Searchable Dropdown
                                DropdownSearch<ClassDetails>(
                                  compareFn:
                                      (ClassDetails? item1, ClassDetails? item2) {
                                    if (item1 == null || item2 == null) {
                                      return false;
                                    }
                                    return item1 == item2;
                                  },
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  decoratorProps: const DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.amber),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintText: "Select a Class",
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                      print('Class ID: ${selectedSubCategory!.id}');
                                      widget.studentController.studentList;
                                      selectedStudent =
                                          null; // Reset student dropdown
                                    });
                                  },
                                ),
                                const SizedBox(
                                    height: 20), // Spacing between dropdowns
                                
                                // Third Searchable Dropdown
                                DropdownSearch<Student>(
                                  compareFn: (Student? item1, Student? item2) {
                                    if (item1 == null || item2 == null) {
                                      return false;
                                    }
                                    return item1 == item2;
                                  },
                                  popupProps: const PopupProps.menu(
                                    showSearchBox: true,
                                  ),
                                  decoratorProps: const DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.amber),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(25.0)),
                                      ),
                                      labelStyle: TextStyle(color: Colors.grey),
                                      hintText: "Select a Student",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  items: (filter, infiniteScrollProps) =>
                                      selectedSubCategory?.students ??
                                      [], // Populate based on the selected class
                                  itemAsString: (Student? item) =>
                                      'Name: ${item?.name}\nCode: ${item?.code}',
                                  selectedItem: selectedStudent,
                                  onChanged: (Student? value) {
                                    setState(() {
                                      selectedStudent = value;
                                      print(
                                          'this is student id::::::::::::::::::::::: ${selectedStudent!.id}');
                                    });
                                  },
                                ),
                                
                                                         selectedStudent !=null?const SizedBox.shrink() :  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sizedBox10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Please Enter student if has not been registered yet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: Colors.black.withOpacity(0.3),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    buildFormField(
                                      'enter student code',
                                      studentCodeEditingController,
                                      TextInputType.text,
                                      '',
                                      [],
                                      FocusNode(),
                                      (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter required details to continue';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    buildFormField(
                                      'Enter student name',
                                      studentNameEditingController,
                                      TextInputType.text,
                                      'Eg; Juma Ally Omary',
                                      [],
                                      FocusNode(),
                                      (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Please enter required details to continue';
                                        }
                                
                                        // Regular expression: Allows names with any capitalization but ensures two words
                                        RegExp nameRegExp =
                                            RegExp(r'^[a-zA-Z]+(?:\s[a-zA-Z]+)+$');
                                
                                        if (!nameRegExp.hasMatch(value.trim())) {
                                          return 'Please enter atleast two names (e.g., Juma Ally)';
                                        }
                                
                                        return null;
                                      },
                                    ),
  
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              
           
                                                          ],
                                                      ),
                              ),
                            ),
                            sizedBox15,
                                         Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
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
                                       if(selectedStudent==null){
                 
                                        widget.studentRegistrationController
                                              .addStudent(
                                                  name:studentNameEditingController
                                                          .text,
                                                  code: studentCodeEditingController
                                                          .text,
                                                  schoolCode: selectedCategory!
                                                      .id
                                                      .toString(),
                                                  parentId: widget.parentId,
                                                  classId:
                                                      selectedSubCategory!.id!)
                                              .then((onValue) {
                                            setState(() {
                                              widget.studentController
                                                  .getStudentList(true,
                                                      id: widget.parentId);
                                            });
                                        
                                          });
                                               setAddAccount();
  //************************************************SHOW SUCCESSFULLY DIALOG FOR ADDED STUDENT IF THERE IS SELECTED STUDENT*/
                                            showInfoDialog(context,
                                                student_name: studentNameEditingController.text,
                                                student_code:studentCodeEditingController.text,
                                                studentRegController: widget
                                                    .studentRegistrationController,
                                                title: 'Student Info',
                                                description:
                                                    'Student added successfully\nYou can continue by adding uniform details',
                                                studentController:
                                                    widget.studentController,
                                                studentId: widget.studentController.studentList![widget.selectedIndex].id!,
                                                selectedIndex:
                                                    widget.selectedIndex,
                                                parentId: widget.parentId);

                                       }   widget.studentRegistrationController
                                              .addStudent(
                                                  name: selectedStudent!.name ??
                                                      studentNameEditingController
                                                          .text,
                                                  code: selectedStudent!.code ??
                                                      studentCodeEditingController
                                                          .text,
                                                  schoolCode: selectedCategory!
                                                      .id
                                                      .toString(),
                                                  parentId: widget.parentId,
                                                  classId:
                                                      selectedSubCategory!.id!)
                                              .then((onValue) {
                                            setState(() {
                                              widget.studentController
                                                  .getStudentList(true,
                                                      id: widget.parentId);
                                            });
                                          
                                          });

  setAddAccount();
  //************************************************SHOW SUCCESSFULLY DIALOG FOR ADDED STUDENT IF THERE IS SELECTED STUDENT*/
                                            showInfoDialog(context,
                                                student_name: selectedStudent!.name!,
                                                student_code: selectedStudent!.code!,
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
                                      width: screenWidth >= 520
                                          ? 148
                                          : screenWidth / 2.8,
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
                vertical: screenHeight >= 763 ? 13 : 15,
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
}
