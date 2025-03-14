import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/single_school.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';

class DependentDropdowns extends StatefulWidget {
  const DependentDropdowns({super.key});

  @override
  _DependentDropdownsState createState() => _DependentDropdownsState();
}

class _DependentDropdownsState extends State<DependentDropdowns> {
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
TextEditingController schoolNameEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return splashController.configModel!.systemFeature!.linkedWebSiteStatus!
          ? GetBuilder<AllSchoolController>(builder: (allSchoolController) {
              return allSchoolController.isLoading
                  ? const WebSiteShimmer()
                  : allSchoolController.schoolList.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            sizedBox5,
                            selectedDistrict == null
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Please Select District',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                         sizedBox10, // Spacing between dropdowns
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
                            sizedBox5,
                            selectedCategory == null
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Please Select School',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                          sizedBox10, // Spacing between dropdowns

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
                                  print(
                                      'this is class id::::::::::::::::::::::: ${selectedSubCategory!.id}');
                                  selectedStudent =
                                      null; // Reset student dropdown
                                });
                              },
                            ),
                            sizedBox5,
                            selectedSubCategory == null
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Please Select Class',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                           sizedBox10, // Spacing between dropdowns

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
                            sizedBox5,
                            selectedStudent == null
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: const Text(
                                      'Please Select Student',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                            sizedBox15,
                                              DefaultButton2(
                              color1: kamber300Color,
                              color2: kyellowColor,
                              onPress: () => (selectedCategory == null ||
                                      selectedSubCategory == null ||
                                      selectedStudent == null)
                                  ? () {}
                                  : Get.to(SchoolListScreen(
                                          schoolId: selectedCategory,
                                          classId: selectedSubCategory,
                                          studentId: selectedStudent)
                                      // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)
                                      ),
                              title: 'ALTERNATIVELY, You can generate your own list',
                              iconData: Icons.arrow_forward_outlined,
                            ), 
                            sizedBox15,
                            Text(
                      'FOR HOME DELIVERIES',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                    ),
                    sizedBox10,
    buildFormField(
                    'Enter Your Delivery Address',
                    schoolNameEditingController,
                    TextInputType.name,
                  ),
sizedBox15,
                     const SizedBox(
                  height: 130,
                  width: 340,
                  child: IconImages('assets/icons1/map.png'),
                ),
            sizedBox15,
                            DefaultButton2(
                              color1: kamber300Color,
                              color2: kyellowColor,
                              onPress: () => (selectedCategory == null ||
                                      selectedSubCategory == null ||
                                      selectedStudent == null)
                                  ? () {}
                                  : Get.to(SchoolListScreen(
                                         isSchool:true,
                                          schoolId: selectedCategory,
                                          classId: selectedSubCategory,
                                          studentId: selectedStudent)
                                      // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)
                                      ),
                              title: 'NEXT',
                              iconData: Icons.arrow_forward_outlined,
                            ),
                           
                        
                          ],
                        );
            })
          : const SizedBox();
    });
  }


TextFormField buildFormField(String labelText,
      TextEditingController editingController, TextInputType textInputType) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      
      keyboardType: textInputType,
      style: kInputTextStyle,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13, horizontal: 15), // Customize as needed
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kamber300Color),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kTextLightColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
        hintStyle:const TextStyle(color: Colors.grey),
        hintText: 'KN 360 St 6',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null; // Return null if the input is valid
      },
    );
  }

}
