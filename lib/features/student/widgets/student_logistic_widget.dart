import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/auth/domain/models/user_short_data_model.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/dependent_district_dropdown.dart';
import 'package:hosomobile/features/student/widgets/dependent_logistic_dropdown.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/map/screens/map_screen.dart';
import 'package:hosomobile/features/school/screens/school_list_screen.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/home/widgets/web_site_shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentLogisticWidget extends StatelessWidget {
  final String schoolName;
  final String className;
  final String studentName;
  final int studentId;
  final int classId;
  final int schoolId;
  final String studentCode;

  const StudentLogisticWidget(
      {super.key,
      required this.schoolName,
      required this.studentCode,
      required this.className,
      required this.studentName,
      required this.schoolId,
      required this.classId,
      required this.studentId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
             DependentLogisticDropdowns(
                studentCode: studentCode,
                schoolId: schoolId,
                classId: classId,
                studentId: studentId,
                className: className,
                schoolName: schoolName,
                studentName: studentName)
          //  DeliveryMapScreen(  
          //    studentCode: studentCode,
          //       schoolId: schoolId,
          //       classId: classId,
          //       studentId: studentId,
          //       className: className,
          //       schoolName: schoolName,
          //       studentName: studentName),
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
