import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/widgets/school_list_shimmer_widget.dart';
import 'package:hosomobile/common/widgets/no_data_widget.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/domain/models/withdraw_model.dart';
import 'package:hosomobile/features/transaction_money/screens/credit_transaction_confirmation_screen_sl.dart';
import 'package:hosomobile/features/transaction_money/screens/school_transaction_confirmation_screen.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'single_school_list_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

class SchoolListWidget extends StatefulWidget {
  final ScrollController? scrollController;
  final Student? studentId;
  final AllSchoolModel? schoolId;
  final ClassDetails? classId;
  final String? productName;
  final bool? isHome;
  final String? type;

  const SchoolListWidget({
    super.key,
    this.scrollController,
    this.productName,
    this.classId,
    this.schoolId,
    this.studentId,
    this.isHome,
    this.type,
  });

  @override
  _SchoolListWidgetState createState() => _SchoolListWidgetState();
}

class _SchoolListWidgetState extends State<SchoolListWidget> {
  double totalPrice = 0.0; // Total price for all items
  List<bool> isChecked = [];
  Map<int, double> caseTotals = {}; // Map to store totals for each case

  @override
  void initState() {
    super.initState();
    _initializeCheckedList();
  }

  void _initializeCheckedList() {
    final schoolList = Get.find<SchoolListController>().schoolList;
    setState(() {
      isChecked = List<bool>.filled(schoolList.length, true);
      _calculateTotals();
    });
  }

  void _calculateTotals() {
    final schoolLists = Get.find<SchoolListController>();
    double calculatedTotal = 0.0;
    caseTotals.clear(); // Reset case totals

    // Calculate total for all items
    for (int i = 0; i < schoolLists.schoolList.length; i++) {
      if (i < isChecked.length && isChecked[i]) {
        calculatedTotal += schoolLists.schoolList[i].amount ?? 0.0;
      }
    }

    // Calculate totals for each case
    _calculateCaseTotal(schoolLists.headteacherMessageList, 1);
    _calculateCaseTotal(schoolLists.classRequirementList, 2);
    _calculateCaseTotal(schoolLists.domitoryEssentialList, 3);
    _calculateCaseTotal(schoolLists.textBookList, 4);
    _calculateCaseTotal(schoolLists.tuitionFeeList, 5);
    _calculateCaseTotal(schoolLists.withdrawList, 6);
    _calculateCaseTotal(schoolLists.paymentList, 7);

    setState(() {
      totalPrice = calculatedTotal;
    });
  }

  void _calculateCaseTotal(List<SchoolLists> caseList, int caseIndex) {

    double caseTotal = 0.0;
    for (int i = 0; i < caseList.length; i++) {
      if (i < isChecked.length && isChecked[i]) {
        caseTotal += caseList[i].amount ?? 0.0;
          print('clclclclclclclclcl ${isChecked[i]}:${caseList[i].amount}:${caseList.length}:$i');
      }
    }
    
    
       caseTotals[caseIndex] = caseTotal; // Store the total for this case
 print('ccccccccccccccccccccc ${caseTotals[caseIndex]}');
  }

  void onCheckboxChanged(int index, bool value) {
    if (index >= 0 && index < isChecked.length) {
      setState(() {
        isChecked[index] = value;
      });
      
      _calculateTotals(); // Recalculate totals when checkbox state changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolListController>(builder: (schoolLists) {
      List<SchoolLists> schoolList = _getFilteredSchoolList(schoolLists);

      // Ensure `isChecked` length matches `schoolList`
      if (isChecked.length != schoolList.length) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            setState(() {
              isChecked = List<bool>.filled(schoolList.length, true);
              _calculateTotals();
            });
          }
        });
      }

  int schoolListIndex = schoolLists.schoolListIndex;

    String? heading = schoolList[schoolListIndex].transactionType == AppConstants.headteacherMessage
          ? 'Headteachers Message'
          : schoolList[schoolListIndex].transactionType == AppConstants.classRequirement
              ? 'Class Requirements': schoolList[schoolListIndex].transactionType == AppConstants.dormitoryEssential
          ? 'Dormitory Essentials'
          : schoolList[schoolListIndex].transactionType == AppConstants.tuitionFee
              ? 'Tuition Fees'
          : schoolList[schoolListIndex].transactionType == AppConstants.textBook
              ? 'Text Books'
                          : '';


      return Column(
        children: [
          !schoolLists.firstLoading
              ? schoolList.isNotEmpty
                  ? _buildSchoolList(context, schoolList,schoolListIndex)
                  : NoDataFoundWidget(fromHome: widget.isHome)
              : const SchoolListShimmerWidget(),
          schoolLists.isLoading
              ? _buildLoadingIndicator(context)
              : const SizedBox.shrink(),
     schoolLists.schoolListIndex !=1?  _buildTotalPriceAndButtons(context,  schoolListIndex:schoolLists.schoolListIndex,heading:heading,schoolList:schoolList,isChecked:isChecked):const SizedBox.shrink(),
        ],
      );
    });
  }

  List<SchoolLists> _getFilteredSchoolList(SchoolListController schoolLists) {
    if (widget.isHome != null && !widget.isHome!) {
      switch (schoolLists.schoolListIndex) {
        case 1:
          return schoolLists.headteacherMessageList;
        case 2:
          return schoolLists.classRequirementList;
        case 3:
          return schoolLists.domitoryEssentialList;
        case 4:
          return schoolLists.textBookList;
        case 5:
          return schoolLists.tuitionFeeList;
        case 6:
          return schoolLists.withdrawList;
        case 7:
          return schoolLists.paymentList;
        default:
          return schoolLists.schoolList;
      }
    }
    return schoolLists.schoolList;
  }

  Widget _buildSchoolList(BuildContext context, List<SchoolLists> schoolList,int schoolListIndex) {
  
    
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall),
      child: Container(
        height: schoolListIndex==1?MediaQuery.of(context).size.height / 1.5: MediaQuery.of(context).size.height / 2.5,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: schoolList.length,
            itemBuilder: (ctx, index) {
           
              return (schoolList[index].transactionType==AppConstants.headteacherMessage &&schoolListIndex==0)?const SizedBox.shrink(): SingleSchoolListWidget(
                index: schoolListIndex,
                schoolLists: schoolList[index],
                initialChecked: isChecked[index],
                onChanged: (value) {
               
                   onCheckboxChanged(index, value!);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildTotalPriceAndButtons(BuildContext context, {required int schoolListIndex,required String heading, required List<SchoolLists> schoolList,required List<bool> isChecked}) {
  final  userData = Get.find<AuthController>().getUserData();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (schoolListIndex > 0)
            Column(
              children: [
                _buildRichTextSutitle(
                  context,
                  heading,
                  ' Sub Total:',
                  '${caseTotals[schoolListIndex]}',
                  'RWF'
                ),
                const SizedBox(height: 10),
                DefaultButton2(
                  onPress: () => Get.to(
            () => SchoolTransactionConfirmationScreen(
              inputBalance: schoolList.isNotEmpty ? schoolList[0].amount : 0,
              productId: schoolListIndex,
              isChecked: isChecked,
              schoolId: widget.schoolId,
              productName: widget.productName,
              transactionType: TransactionType.sendMoney,
              classDetails: widget.classId,
              contactModel: ContactModel(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
                avatarImage: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
              ),
              contactModelMtn: ContactModelMtn(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
              ),
              dataList: schoolList,
              productIndex: 0,
              student: widget.studentId,
              edubox_service: widget.productName,
              serviceIndex: 0,
              price: schoolList.isNotEmpty ? schoolList[0].amount : 0,
            ),
          ),
                  title: 'ADD TO ALL TOTAL INVOICE',
                  iconData: Icons.arrow_forward,
                  color1: kamber300Color,
                  color2: kyellowColor,
                ),
                const SizedBox(height: 10),
                _buildRichText(
                  context,
                  'Add',
                  '${caseTotals[schoolListIndex]}',
                  ' RWF Sub Total to All Total Invoice to pay or request credit at once.\nOR',
                ),
              ],
            )
          else
            _buildRichText(
              context,
              'Total All : ',
              '$totalPrice',
              ' RWF',
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultButtonWidth(
                onPress: () => Get.to(
            () => SchoolTransactionConfirmationScreen(
              inputBalance: schoolList.isNotEmpty ? schoolList[0].amount : 0,
              productId: schoolListIndex,
              isChecked: isChecked,
              schoolId: widget.schoolId,
              productName: widget.productName,
              transactionType: TransactionType.sendMoney,
              classDetails: widget.classId,
              contactModel: ContactModel(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
                avatarImage: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
              ),
              contactModelMtn: ContactModelMtn(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
              ),
              dataList: schoolList,
              productIndex: 0,
              student: widget.studentId,
              edubox_service: widget.productName,
              serviceIndex: 0,
              price: schoolList.isNotEmpty ? schoolList[0].amount : 0,
            ),
          ),
                title: 'PAY CASH',
               
                color1: kamber300Color,
                color2: kyellowColor,
                width: 123,
              ),
              DefaultButtonWidth(
                onPress: ()=>  Get.to(
            () => SchoolTransactionConfirmationScreen(
              screenId:1,
              inputBalance: schoolList.isNotEmpty ? schoolList[0].amount : 0,
              productId: schoolListIndex,
              isChecked: isChecked,
              schoolId: widget.schoolId,
              productName: widget.productName,
              transactionType: TransactionType.sendMoney,
              classDetails: widget.classId,
              contactModel: ContactModel(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
                avatarImage: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
              ),
              contactModelMtn: ContactModelMtn(
                phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                name: userData?.name ?? '',
              ),
              dataList: schoolList,
              productIndex: 0,
              student: widget.studentId,
              edubox_service: widget.productName,
              serviceIndex: 0,
              price: schoolList.isNotEmpty ? schoolList[0].amount : 0,
            )),
        
                title: 'REQUEST CREDIT',
            
                color1: kamber300Color,
                color2: kyellowColor,
                width: 123,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Display case totals
          // ...caseTotals.entries.map((entry) {
          //   return _buildRichText(
          //     context,
          //     'Case ${entry.key} Total: ',
          //     '${entry.value}',
          //     ' RWF',
          //   );
          // }).toList(),
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String prefix, String value, String suffix) {
    return RichText(
      text: TextSpan(
        text: prefix,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: suffix,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
  Widget _buildRichTextSutitle(BuildContext context, String prefix, String value, String suffix, String farSuffix) {
    return RichText(
      text: TextSpan(
        text: prefix,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: suffix,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
                    TextSpan(
            text: farSuffix,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}