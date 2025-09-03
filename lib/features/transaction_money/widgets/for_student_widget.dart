import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/styles.dart';

class ForStudentWidget extends StatefulWidget {
  final String? studentInfo;
  final Function(bool)? onChecked; // Callback for checkbox state
  final bool initialChecked; // Initial checked state
  const ForStudentWidget({
    super.key,
    this.studentInfo,
    this.onChecked,
    this.initialChecked = false, // Default to false
  });

  @override
  _ForStudentWidgetState createState() => _ForStudentWidgetState();
}

class _ForStudentWidgetState extends State<ForStudentWidget> {
  late bool _isChecked; // Track whether the student is selected

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialChecked; // Initialize with the provided value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: ColorResources.getBackgroundColor(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'for_student'.tr,
                style: rubikSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: ColorResources.getGreyBaseGray1(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.studentInfo!),
                  ),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                      widget.onChecked?.call(_isChecked); // Notify parent widget
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}