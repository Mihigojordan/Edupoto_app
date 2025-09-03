import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/util/app_constants.dart';

class SingleSchoolListWidget extends StatelessWidget {
   final SchoolLists? schoolLists;
   final int? index;
  final bool? initialChecked;
  final Function(bool?)? onChanged;

  const SingleSchoolListWidget({
    super.key,
    this.schoolLists,
    this.index,
    this.initialChecked,
    this.onChanged,
  });


  @override
  Widget build(BuildContext context) {
    String? heading;
    Color? color;
    bool isCredit = (schoolLists?.credit ?? 0) > 0;

    try {
      heading =
      //  schoolLists!.transactionType == AppConstants.tuitionFee
      //     ? 'Tuition Fee'
      //     :
           schoolLists!.transactionType == AppConstants.classRequirement
              ? 'class_requirements'.tr: schoolLists!.transactionType == AppConstants.dormitoryEssential
          ? 'dormitory_essentials'.tr
          : schoolLists!.transactionType == AppConstants.textBook
              ? 'text_books'.tr
                          : '';
          //                 color = schoolLists!.transactionType == AppConstants.tuitionFee
          // ? Colors.orangeAccent
          // :
        color =   schoolLists!.transactionType == AppConstants.classRequirement
              ? Colors.deepPurple: schoolLists!.transactionType == AppConstants.dormitoryEssential
          ? Colors.lightBlueAccent
          : schoolLists!.transactionType == AppConstants.textBook
              ? Colors.pinkAccent
                          : Colors.grey;
    } catch (e) {
   'no_user'.tr;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical:  schoolLists!.transactionType == AppConstants.headteacherMessage?2:  2),
      padding:const EdgeInsets.symmetric(horizontal: 3,vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border:schoolLists!.transactionType == AppConstants.headteacherMessage?const Border(
  bottom: BorderSide(
    width: 1.0,          // Required
    color: Colors.grey,  // Required
    style: BorderStyle.solid, // Optional (defaults to solid)
  ),
):null
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
   index! > 0?const SizedBox(): Text(
  heading!,
  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
    color: color, // Vibrant color
    fontWeight: FontWeight.w200, // Bold text
    fontSize: 9, // Custom font size
    fontStyle: FontStyle.italic, // Italic text (optional)
  ),
),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           (schoolLists!.transactionType == AppConstants.headteacherMessage)? const SizedBox(width: 2):   Checkbox(
                value: initialChecked,
                onChanged: onChanged
              ),
              Expanded(
                child: Text(
                  '${schoolLists!.transactionId ?? ''} ${(schoolLists!.transactionType == AppConstants.headteacherMessage)?'' :'${schoolLists!.amount ?? 0} RWF'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}