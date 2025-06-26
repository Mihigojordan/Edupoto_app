import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/controllers/student_registration_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/student_add_info.dart';

showInfoDialog(
    BuildContext context, {
    required String title,
    required String description,
    required String student_name,
    required String student_code,
    required StudentRegistrationController studentRegController,
    required StudentController studentController,
    required int studentId,
    required String parentId,
    int selectedIndex = 0, // Ensure selectedIndex is passed or set default
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              onPressed: () {
                studentController
                    .getStudentList(true, id: parentId)
                    .then((value) {
                  Get.back(); // Close the dialog
                });
              },
              child: Text(
                "cancel".tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            // OK Button
            TextButton(
              onPressed: () {
                if (studentController.studentList != null &&
                    studentController.studentList!.isNotEmpty &&
                    selectedIndex < studentController.studentList!.length) {
                  final student = studentController.studentList![selectedIndex];
                  print(
                      'Selected Index: $selectedIndex  | $studentId');

                  Get.back(); // Close the dialog first

                  Future.delayed(const Duration(milliseconds: 200), () {
                    // Delay navigation slightly
                    Get.to(StudentAddInfo(
                      studentInfo:
                          '${'code'.tr}: $student_code ${'name'.tr}: $student_name',
                      studentId: studentId,
                      studentRegController: studentRegController,
                      studentController: studentController,
                      selectedIndex: selectedIndex,
                    ));
                  });
                } else {
                  print("🚨 Error: Missing required student data!");
                }
              },
              child: Text(
                "ok".tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }