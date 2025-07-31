import 'package:hosomobile/common/widgets/custom_app_bar_widget.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/history/controllers/transaction_history_controller.dart';
import 'package:hosomobile/features/history/domain/models/transaction_model.dart';
import 'package:hosomobile/features/history/widgets/transaction_type_button_widget.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
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

  final int schoolId;
  final int studentId;
  final int classId;
  final String studentName;
  final String className;
  final String schoolName;
  final String studentCode;
  final String homePhone;
  final String destination;
  final String shipper;
  final StudentController studentController;
  int studentIndex;

  SchoolListScreen(
      {super.key,
      required this.studentController,
      required this.studentIndex,
      required this.studentCode,
      required this.shipper,
      required this.homePhone,
      required this.destination,
      required this.studentName,
      required this.className,
      required this.schoolName,
      required this.schoolId,
      required this.studentId,
      required this.classId});

  @override
  Widget build(BuildContext context) {
    Get.find<SchoolListController>().setIndex(0);

    Get.find<SchoolListController>()
        .getSchoolListData(1, reload: false, schoolId: schoolId);

    return Scaffold(
      // appBar: CustomAppbarWidget(title: 'School  List'.tr, onlyTitle: true),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Get.find<SchoolListController>()
                .getSchoolListData(1, reload: true, schoolId: schoolId);
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
                          top: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0, vertical: 30),
                                child: RichText(
                                  text: TextSpan(
                                    text: '${'preparing_list_for'.tr}:\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '$studentName\n',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .bold, // Regular weight for the rest of the text
                                            ),
                                      ),
                                      TextSpan(
                                        text: '$className, ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .w500, // Regular weight for the rest of the text
                                            ),
                                      ),
                                      TextSpan(
                                        text: schoolName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight
                                                  .w500, // Regular weight for the rest of the text
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
              const Positioned(
                top: 10,
                left: 10,
                child: CustomBackButton(),
              ),

              //************* Requirement List  */
              Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: requirementList(
                    context,
                    productName: 'Edubox Materials',
                    studentId: studentId,
                    schoolId: schoolId,
                    classId: classId,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget requirementList(BuildContext context,
      {required int studentId,
      required int schoolId,
      required int classId,
      required String productName}) {
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
                    final ScrollController scrollController =
                        ScrollController();

                    return Row(
                      children: [
                        // Left Arrow Button
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: () {
                            // Scroll left
                            scrollController.animateTo(
                              scrollController.offset -
                                  100, // Adjust scroll distance
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        // Horizontal ListView
                        Expanded(
                          child: ListView(
                            controller:
                                scrollController, // Attach the ScrollController
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
                              // SchoolListButtonWidget(
                              //   text: 'Headteachers M'.tr,
                              //   index: 1,
                              //   schoolList: schoolListController.headteacherMessageList,
                              // ),
                              const SizedBox(width: 10),
                              SchoolListButtonWidget(
                                text: 'class_requirements'.tr,
                                index: 2,
                                schoolList:
                                    schoolListController.classRequirementList,
                              ),
                              const SizedBox(width: 10),
                              SchoolListButtonWidget(
                                text: 'paid_at_school'.tr,
                                index: 5,
                                schoolList: schoolListController.tuitionFeeList,
                              ),
                              const SizedBox(width: 10),
                              SchoolListButtonWidget(
                                text: 'dormitory_essentials'.tr,
                                index: 3,
                                schoolList:
                                    schoolListController.domitoryEssentialList,
                              ),
                              const SizedBox(width: 10),
                              // SchoolListButtonWidget(
                              //   text: 'text_books'.tr,
                              //   index: 4,
                              //   schoolList: schoolListController.textBookList,
                              // ),
                              // const SizedBox(width: 10),
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
                              scrollController.offset +
                                  100, // Adjust scroll distance
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

//************* School List Widget */
          SliverToBoxAdapter(
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: SchoolListWidget(
                    studentController: studentController,
                    studentIndex: studentIndex,
                    shipper: shipper,
                    homePhone: homePhone,
                    destination: destination,
                    schoolName: schoolName,
                    className: className,
                    studentCode: studentCode,
                    studentName: studentName,
                    scrollController: _scrollController,
                    isHome: false,
                    studentId: studentId,
                    schoolId: schoolId,
                    classId: classId,
                    productName: productName),
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
