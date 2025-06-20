import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/tereka_asome.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/single_school.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';

class DependentLogisticDropdowns extends StatefulWidget {
  const DependentLogisticDropdowns(
      {super.key,
      required this.schoolId,
      required this.classId,
      required this.studentId,
      required this.className,
      required this.schoolName,
      required this.studentName,
      required this.studentCode});
  final int schoolId;
  final int studentId;
  final int classId;
  final String schoolName;
  final String className;
  final String studentName;
  final String studentCode;

  @override
  _DependentLogisticDropdownsState createState() =>
      _DependentLogisticDropdownsState();
}

class _DependentLogisticDropdownsState
    extends State<DependentLogisticDropdowns> {
  bool isHomeDelivery = false;
  Districts? selectedDistrict;
  AllSchoolModel? selectedCategory; // Selected value for the first dropdown
  ClassDetails? selectedSubCategory; // Selected value for the second dropdown
  Student? selectedStudent; // Selected value for the third dropdown
  TextEditingController mapDestinationEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  String deliveryOptionsValue = 'Choose Delivery Company';
  String? _deliveryOptionError;

  List<Map<dynamic, String>> topSize = const [
    {'name': 'Dropp', 'logo': 'assets/icons1/dropp.jpeg'},
    {'name': 'i-Posita', 'logo': 'assets/icons1/iposita.jpeg'},
    {'name': 'Vuba Vuba', 'logo': 'assets/icons1/vuba.png'},
    {'name': 'Zugu', 'logo': 'assets/icons1/zugu.jpeg'},
  ];

  homeDeliveryAction() {
    setState(() {
      isHomeDelivery = !isHomeDelivery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

      void validateForm() {
    if (deliveryOptionsValue == 'Choose Delivery Company') {
      setState(() {
        _deliveryOptionError = 'Please select a delivery option';
      });
      // Optionally show a snackbar for more visibility
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a delivery option'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Get.to(() => SchoolListScreen(
                        homePhone:phoneNumberEditingController.text,
                        destination:mapDestinationEditingController.text,
                        shipper:deliveryOptionsValue,
                        schoolName: widget.schoolName,
                        className: widget.className,
                        studentName: widget.studentName,
                        studentCode: widget.studentCode,
                        schoolId: widget.schoolId,
                        classId: widget.classId,
                        studentId: widget.studentId));
  }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' Delivery Options',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        sizedBox15,
        DefaultButton2(
          color1: kamber300Color,
          color2: kyellowColor,
          onPress: () => Get.to(() => SchoolListScreen(
              homePhone: '',
              shipper: '', //if there will be needed a company for shipment to school
              destination: widget.schoolName,//lets use school name for now instead of address
              studentCode: widget.studentCode,
              studentName: widget.studentName,
              className: widget.className,
              schoolName: widget.schoolName,
              schoolId: widget.schoolId,
              studentId: widget.studentId,
              classId: widget.classId)),
          // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

          title: 'SCHOOL',
          iconData: Icons.arrow_forward_outlined,
        ),
        sizedBox15,
        isHomeDelivery == false
            ? DefaultButton2(
                color1: kamber300Color,
                color2: kyellowColor,
                onPress: () => homeDeliveryAction(),
                // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                title: 'HOME',
                iconData: Icons.arrow_forward_outlined,
              )
            : Column(
                children: [
                  Text(
                    'Chose Delivery Address',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBox10,
                  buildFormField(
                    'Where to ?',
                    mapDestinationEditingController,
                    TextInputType.name,
                    'KN 360 St 6'
                  ),
                  sizedBox15,
                  _buildListTile(
                      icon: Icons.location_on,
                      title: 'KG 338 St, Kigali, Rwanda',
                      onTap: () {}),
                  sizedBox15,
                  _buildListTile(
                      icon: Icons.star,
                      title: 'Choose saved place',
                      onTap: () {}),
                  sizedBox10,
                  Text('Please Provide the phone number that is currently available at the destinaltion location',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kErrorBorderColor,fontWeight: FontWeight.normal),
                  ),
                  sizedBox5,
                      buildFormField(
                    'Home Phone Number',
                    phoneNumberEditingController,
                    TextInputType.name,
                    '07XXXXXXXX'
                  ),
                  sizedBox10,
                  DropDownMapInfo(
                    menuHeight: 320,
                    prefixIcon: 'assets/icons1/delivery.jpg',
                    onChanged: (onChanged) {
                      setState(() {
                        deliveryOptionsValue = onChanged!;
                      });
                    },
                    itemLists: topSize,
                    title: deliveryOptionsValue,
                    width: screenWidth,
                    menuWidth: screenWidth,
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
                    onPress: () =>validateForm(),
                    // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)

                    title: 'NEXT',
                    iconData: Icons.arrow_forward_outlined,
                  ),
                ],
              ),
      ],
    );
  }

  TextFormField buildFormField(String labelText,
      TextEditingController editingController, TextInputType textInputType,hintText) {
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
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
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

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF000000)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
