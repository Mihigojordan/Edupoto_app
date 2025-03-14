import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/history/controllers/transaction_history_controller.dart';
import 'package:hosomobile/features/history/domain/models/transaction_model.dart';
import 'package:hosomobile/features/history/widgets/transaction_type_button_widget.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/widgets/school_list_button_widget.dart';
import 'package:hosomobile/features/school/widgets/school_list_widget.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/history/widgets/transaction_list_widget.dart';

class SchoolListScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final SchoolLists? schoolLists;
  final AllSchoolModel? schoolId;
  final bool? isSchool;
  final Student? studentId; 
  final ClassDetails? classId;
  SchoolListScreen({super.key,this.isSchool, this.schoolLists,this.schoolId,this.studentId,this.classId});

  @override
  Widget build(BuildContext context) {
    Get.find<SchoolListController>().setIndex(0);
    return Scaffold(
      // appBar: CustomAppbarWidget(title: 'School  List'.tr, onlyTitle: true),
      body:SafeArea(

        child: RefreshIndicator(
             backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Get.find<SchoolListController>()
                .getSchoolListData(1, reload: true);
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: kyellowColor,
                    child: Stack(
                      children: [
                        // SizedBox(
                        //   // height: 0,
                        //   child: ImagesUp(Images.launch_page),
                        // ),
                       Positioned(
                            left: 20,
                            right: 10,
                            top: 40,
                            child: isSchool==false?  RichText(
                              text: TextSpan(
                                text: '${schoolId!.schoolName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .bold, // Bold only for 'St Michael’s School'
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '\n${schoolId!.address}\nTel:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .normal, // Regular weight for the rest of the text
                                        ),
                                  ),
                                  TextSpan(
                                    text: '${schoolId!.countryCode}${schoolId!.phone}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Regular weight for the rest of the text
                                        ),
                                  ),
                                ],
                              ),
                            ):RichText(
                              text: TextSpan(
                                text: 'Generate your School list here',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .bold, // Bold only for 'St Michael’s School'
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .normal, // Regular weight for the rest of the text
                                        ),
                                  ),
                                  TextSpan(
                                    text: '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Regular weight for the rest of the text
                                        ),
                                  ),
                                ],
                              ),
                            )
                            
                            )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: kamber300Color,
                      child: Container(
                        //  height: MediaQuery.of(context).size.height,
                        //   padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: const BoxDecoration(
                            color: kOtherColor,
                            //reusable radius,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
                const  Positioned(
      top:10,
         left:10,

            child: CustomBackButton(),
          ),
              Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: requirementList(
                    context,
                    productName: 'Edubox Materials',
                    studentId: studentId!,
                    schoolId: schoolId!,
                    classId: classId!,
                  )),
            ],
          ),
        ),
      ),
      
      
     
    );
  }

Widget requirementList(BuildContext context,{required Student studentId,required AllSchoolModel schoolId,required ClassDetails classId,required String productName}){
  return   Container(
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
    child: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: [
  SliverPersistentHeader(
  pinned: true,
  delegate: SliverDelegate(
    child: Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall),
      height: 50,
      alignment: Alignment.centerLeft,
      child: GetBuilder<SchoolListController>(
        builder: (schoolListController) {
          // Create a ScrollController for the ListView
          final ScrollController scrollController = ScrollController();

          return Row(
            children: [
              // Left Arrow Button
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () {
                  // Scroll left
                  scrollController.animateTo(
                    scrollController.offset - 100, // Adjust scroll distance
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              // Horizontal ListView
              Expanded(
                child: ListView(
                  controller: scrollController, // Attach the ScrollController
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall),
                  children: [
                    SchoolListButtonWidget(
                      text: 'all'.tr,
                      index: 0,
                      schoolList: schoolListController.schoolList,
                    ),
                    const SizedBox(width: 10),
                    SchoolListButtonWidget(
                      text: 'Headteachers M'.tr,
                      index: 1,
                      schoolList: schoolListController.headteacherMessageList,
                    ),
                    const SizedBox(width: 10),
                    SchoolListButtonWidget(
                      text: 'Class Requirements'.tr,
                      index: 2,
                      schoolList: schoolListController.classRequirementList,
                    ),
                    const SizedBox(width: 10),
                    SchoolListButtonWidget(
                      text: 'Tuition Fees'.tr,
                      index: 5,
                      schoolList: schoolListController.tuitionFeeList,
                    ),
                    const SizedBox(width: 10),
                    SchoolListButtonWidget(
                      text: 'Dormitory Essentials'.tr,
                      index: 3,
                      schoolList: schoolListController.domitoryEssentialList,
                    ),
                    const SizedBox(width: 10),
                    SchoolListButtonWidget(
                      text: 'Text Books'.tr,
                      index: 4,
                      schoolList: schoolListController.textBookList,
                    ),
                    const SizedBox(width: 10),
                    // Uncomment if needed
                    // SchoolListButtonWidget(
                    //   text: 'withdraw'.tr,
                    //   index: 6,
                    //   schoolList: schoolListController.withdrawList,
                    // ),
                    // const SizedBox(width: 10),
                    // SchoolListButtonWidget(
                    //   text: 'payment'.tr,
                    //   index: 7,
                    //   schoolList: schoolListController.paymentList,
                    // ),
                    // const SizedBox(width: 10),
                  ],
                ),
              ),
              // Right Arrow Button
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 20),
                onPressed: () {
                  // Scroll right
                  scrollController.animateTo(
                    scrollController.offset + 100, // Adjust scroll distance
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          );
        },
      ),
    ),
  ),
),
        SliverToBoxAdapter(
          child: Scrollbar(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: SchoolListWidget(
                  scrollController: _scrollController, isHome: false, studentId:studentId,schoolId:schoolId,classId:classId,productName:productName),
            ),
          ),
        ),
      ],
    ),
  );
} 



}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
