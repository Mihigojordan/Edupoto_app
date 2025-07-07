import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/widgets/custom_dropdown.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/single_school.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/school_directory/screen/school_directory_screen.dart';
import 'package:hosomobile/features/school_directory/widgets/custom_dropdown_with_search.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';

class SchoolDirectoryDropdowns extends StatefulWidget {
  const SchoolDirectoryDropdowns({super.key});

  @override
  _DependentDropdownsState createState() => _DependentDropdownsState();
}

class _DependentDropdownsState extends State<SchoolDirectoryDropdowns> {
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
TextEditingController schoolNameEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          padding:const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height / 1.3,
      width: 340,
      child: SingleChildScrollView(
        child: GetBuilder<SplashController>(builder: (splashController) {
          return splashController.configModel!.systemFeature!.linkedWebSiteStatus!
              ? GetBuilder<AllSchoolController>(builder: (allSchoolController) {
                  return allSchoolController.isLoading
                      ? const WebSiteShimmer()
                      : allSchoolController.schoolList.isEmpty
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sizedBox15,
                                // Top Searchable dropdown
                                DropdownSearch<Districts>(
                                  compareFn: (Districts? item1, Districts? item2) {
                                    if (item1 == null || item2 == null) {
                                      // allSchoolController.hasMore != false;
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
                                      // allSchoolController.hasMore != false;
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
                              sizedBox15, // Spacing between dropdowns
        
                                // Second Searchable Dropdown
                      
                           Padding(
                                        padding:const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          ' Schools Directory is a comprehensive digital platform that profiles all schools in Rwanda, providing detailed information about each institution.',
                                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.center,
                                        ),
                                      ),
                             
                               sizedBox15, // Spacing between dropdowns
      
                          
                                 
       
                                DefaultButton2(
                                  color1: kamber300Color,
                                  color2: kyellowColor,
                                  onPress: () => (selectedCategory == null)
                                      ? () {}
                                      : Get.to( SchoolDirectoryScreen(schoolName: selectedCategory!.schoolName!,schoolDistrict:selectedDistrict!.name! ,)
                                          // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)
                                          ),
                                  title: 'NEXT',
                                  iconData: Icons.arrow_forward_outlined,
                                ),
                               
                            
                              ],
                            );
                })
              : const SizedBox();
        }),
      ),
    );
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

class SchoolListWidget extends StatelessWidget {
  const SchoolListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllSchoolController>();

    return Obx(() {
      if (controller.isInitialLoad && controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.schoolList.length + (controller.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= controller.schoolList.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            
            final district = controller.schoolList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      district.name ?? 'Unnamed District',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...district.schools.map((school) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            school.schoolName ?? 'Unnamed School',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (school.classes.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Classes: ${school.classes.length}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                          const Divider(height: 16),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}