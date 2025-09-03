import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_district_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AllSchoolWidget extends StatefulWidget {
  const AllSchoolWidget({super.key});

  @override
  State<AllSchoolWidget> createState() => _AllSchoolWidgetState();
}

class _AllSchoolWidgetState extends State<AllSchoolWidget> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  String studentCardValue = 'Choose from a list of partiner School';
  String districtValue = 'Choose The District of your School';
  String classValue = 'Od Level';
  String classCategoryValue = 'Class';
  bool isSelected = false;
  UserShortDataModel? userData;

  TextEditingController classEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController dayEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController schoolNameEditingController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
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
      height: MediaQuery.of(context).size.height / 1.3,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                      onPressed: () {}, // => selectedVale(),
                      child: Text(
                        'Delivery Address if different from school',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                // InkWell(
                //   onTap: ()=> Get.to(SchoolListScreen(
                //                        )
                //                       // SingleSchool( classId: selectedSubCategory, schoolId: selectedCategory, studentId: selectedStudent)
                //                       ),
                //   child: Container(
                //     width:screenWidth/2.7,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       gradient: const LinearGradient(
                //         colors: [
                //           kamber300Color,
                //           kyellowColor,
                //         ],
                        
                //         begin:  FractionalOffset(0.0, 0.0),
                //         end:  FractionalOffset(0.5, 0.0),
                //         stops:  [0.0, 1.0],
                //         tileMode: TileMode.clamp,
                //       ),
                //     ),
                //       padding:const EdgeInsets.symmetric(horizontal:10,vertical: 5),
                //     child: Text(
                //       'Generate Your Own School List',
                //       style: Theme.of(context).textTheme.titleSmall!.copyWith(
                //           color: Colors.black,
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold),
                //           overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                // )
              ],
            ),
            //  buildFormField(  'Choose student\'s card to fund',cardEditingController,TextInputType.text,),
            // DropDown(
            //             onChanged: (onChanged) {
            //               setState(() {
            //                 districtValue = onChanged!;
            //               });
            //             },
            //             itemLists: districtList,
            //             title: '$districtValue',
            //             isExpanded: true),
            sizedBox15,
        
        //************************************Dependent Dropdown *****************************/        
                // const DependentDropdowns(),

          ],
        ),
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
