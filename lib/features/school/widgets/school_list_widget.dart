import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/models/contact_model_mtn.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/controllers/student_controller.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/tereka_asome/widget/widget_dialog.dart';
import 'package:hosomobile/features/school/controllers/school_list_controller.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/school/widgets/school_list_shimmer_widget.dart';
import 'package:hosomobile/common/widgets/no_data_widget.dart';
import 'package:hosomobile/features/school/widgets/single_school_list_widget.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/models/shop_model.dart';
import 'package:hosomobile/features/splash/controllers/splash_controller.dart';
import 'package:hosomobile/features/transaction_money/screens/paid_at_school_transaction_confirmation_screen.dart';
import 'package:hosomobile/features/transaction_money/screens/school_transaction_confirmation_screen.dart';
import 'package:hosomobile/helper/transaction_type.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

class SchoolListWidget extends StatefulWidget {
  final ScrollController? scrollController;
  final int? studentId;
  final int? schoolId;
  final int? classId;
  final String? productName;
  final String studentName;
  final String studentCode;
  final String schoolName;
  final String className;
  final bool? isHome;
  final String? type;
  final String homePhone;
  final String destination;
  final String shipper;
  final StudentController studentController;
  int studentIndex;

  SchoolListWidget(
      {super.key,
      this.scrollController,
      this.productName,
      this.classId,
      this.schoolId,
      this.studentId,
      this.isHome,
      this.type,
      required this.shipper,
      required this.homePhone,
      required this.destination,
      required this.studentCode,
      required this.studentName,
      required this.className,
      required this.schoolName,
      required this.studentController,
      required this.studentIndex});

  @override
  _SchoolListWidgetState createState() => _SchoolListWidgetState();
}

class _SchoolListWidgetState extends State<SchoolListWidget> {
  double totalPrice = 0.0; // Total price for all items
  List<bool> isChecked = [];
  Map<int, double> caseTotals = {}; // Map to store totals for each case
  double _aggregatedTotal = 0.0;
    final Map<int, double> _transactionTypeTotals = {
    1: 0.0, // Tuition Fee (filtered)
    2: 0.0, // Class Requirements
    3: 0.0, // Dormitory Essentials
    4: 0.0, // Text Books
    5: 0.0, // Tuition Fee (all)
    6: 0.0, // Withdraw
    7: 0.0, // Payment
  };

    // Track product quantities per transaction type
  final Map<int, Map<Product, int>> _productSelections = {
    2: {}, // Class Requirements
    3: {}, // Dormitory Essentials
    4: {}, // Text Books
  };

  WidgetDialog dialog = WidgetDialog();
  TextEditingController inputBalanceController = TextEditingController();

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

  int getTotalProductQuantity() {
    int totalQuantity = 0;
    _productSelections.forEach((type, products) {
      products.forEach((product, quantity) {
        totalQuantity += quantity;
      });
    });
    return totalQuantity;
  }

void _handleTotalChange(double newTotal, int transactionType) {
  setState(() {
    // Update the specific transaction type total
    _transactionTypeTotals[transactionType] = newTotal;
    
    // Recalculate the combined total
    _calculateCombinedTotal();
  });
}

void _calculateCombinedTotal() {
  double combined = 0.0;
  _transactionTypeTotals.forEach((type, total) {
    combined += total;
  });
  
  // Also include non-product based totals
  // final schoolList = _getFilteredSchoolList(Get.find<SchoolListController>());
  // for (int i = 0; i < schoolList.length; i++) {
  //   final item = schoolList[i];
  //   if (![2, 3, 4].contains(item.transactionType) && 
  //       i < isChecked.length && 
  //       isChecked[i]) {
  //     combined += item.amount ?? 0.0;
  //   }
  // }
  
  setState(() {
    totalPrice = combined;
  });
}

  void _calculateTotals() {
    final schoolLists = Get.find<SchoolListController>();
    caseTotals.clear();

    // Always use the most recent aggregated total for product-based categories
    _calculateCaseTotal(schoolLists.classRequirementList, 2);
    _calculateCaseTotal(schoolLists.domitoryEssentialList, 3);
    _calculateCaseTotal(schoolLists.textBookList, 4);
    
    // For non-product categories, calculate normally
    _calculateCaseTotal(
        schoolLists.tuitionFeeList
            .where((item) => item.transactionType != AppConstants.headteacherMessage)
            .toList(),
        1);
    _calculateCaseTotal(schoolLists.tuitionFeeList, 5);
    _calculateCaseTotal(schoolLists.withdrawList, 6);
    _calculateCaseTotal(schoolLists.paymentList, 7);

    setState(() {
      totalPrice = _aggregatedTotal > 0 ? _aggregatedTotal : _calculateSimpleTotal();
    });
  }

  double _calculateSimpleTotal() {
    double total = 0.0;
    // final schoolList = _getFilteredSchoolList(Get.find<SchoolListController>());
    // for (int i = 0; i < schoolList.length; i++) {
    //   if (i < isChecked.length && isChecked[i]) {
    //     total += schoolList[i].amount ?? 0.0;
    //   }
    // }
    return total;
  }

  void _calculateCaseTotal(List<SchoolLists> caseList, int caseIndex) {
    double caseTotal = 0.0;
    
    // For product-based categories, use the aggregated total
    if (caseIndex == 2 || caseIndex == 3 || caseIndex == 4) {
      caseTotal = _aggregatedTotal;
    } else {
      // For non-product categories, calculate normally
      for (int i = 0; i < caseList.length; i++) {
        if (i < isChecked.length && isChecked[i]) {
          caseTotal += caseList[i].amount ?? 0.0;
        }
      }
    }
    
    caseTotals[caseIndex] = caseTotal;
  }

  void onCheckboxChanged(int index, bool value) {
    if (index >= 0 && index < isChecked.length) {
      setState(() {
        isChecked[index] = value;
      });

     _calculateTotals(); // Recalculate totals when checkbox state changes
    }
  }

  String? getHeading(List<SchoolLists> schoolList, int schoolListIndex) {
    if (schoolList.isEmpty) return null;

    final item = schoolList[0]; // Safe to access since we checked isEmpty
    switch (item.transactionType) {
      case AppConstants.classRequirement:
        return 'class_requirements'.tr;
      case AppConstants.dormitoryEssential:
        return 'dormitory_essentials'.tr;
      case AppConstants.tuitionFee:
        return 'tuition_fee'.tr;
      default:
        return null;
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

      return GetBuilder<ShopController>(builder: (shop){
        return Column(
        children: [
          !schoolLists.firstLoading
              ? schoolList.isNotEmpty
                  ? _buildSchoolList(context, schoolList, schoolListIndex,shop)
                  : NoDataFoundWidget(fromHome: widget.isHome)
              : const SchoolListShimmerWidget(),
          schoolLists.isLoading
              ? _buildLoadingIndicator(context)
              : const SizedBox.shrink(),
          schoolLists.schoolListIndex != 1
              ? getHeading(schoolList, schoolListIndex) == null
                  ? const SizedBox.shrink()
<<<<<<< HEAD
                  : _buildTotalPriceAndButtons(context,
                      schoolListIndex: schoolLists.schoolListIndex,
                      heading: getHeading(schoolList, schoolListIndex) ?? '',
                      schoolList: schoolList,
                      isChecked: isChecked)
              : const SizedBox.shrink(),
=======
                  :const SizedBox.shrink()
                  // _buildTotalPriceAndButtons(context,
                  //     schoolListIndex: schoolLists.schoolListIndex,
                  //     heading: getHeading(schoolList, schoolListIndex) ?? '',
                  //     schoolList: schoolList,
                  //     isChecked: isChecked)
             : const SizedBox.shrink(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
        ],
      );
        });
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
          // Filter out headteacher message/text books items when showing all_school_list
          return schoolLists.schoolList
              .where((item) =>
                  item.transactionType != AppConstants.tuitionFee &&
                  item.transactionType != AppConstants.headteacherMessage &&
                  item.transactionType != AppConstants.textBook)
              .toList();
      }
    }
    // Filter out tuition fee items for home view as well
    return schoolLists.schoolList
        .where((item) => item.transactionType != AppConstants.tuitionFee
            && item.transactionType != AppConstants.headteacherMessage
            && item.transactionType != AppConstants.textBook
            )
        .toList();
  }

Widget _buildSchoolList(
  BuildContext context, 
  List<SchoolLists> schoolList, 
  int schoolListIndex, 
  ShopController shop
) {
  final heading = getHeading(schoolList, schoolListIndex) ?? '';
  final categoryList = shop.categoryList;
  
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: Dimensions.paddingSizeExtraSmall),
    child: Container(
<<<<<<< HEAD
      height: schoolListIndex == 1
          ? MediaQuery.of(context).size.height / 1.5
          : MediaQuery.of(context).size.height / 2.5,
=======
      height: schoolListIndex == 5
          ? MediaQuery.of(context).size.height / 1.5
          : MediaQuery.of(context).size.height / 1.5,
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: schoolList.isEmpty
          ? Center(
              child: Text(
                'no_items_available'.tr,
                style: TextStyle(color: Colors.grey[600]),
              ),
            )
          : Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: schoolList.length,
                itemBuilder: (ctx, index) {
                  // Skip tuition fee items and headteacher messages when showing all lists
                  if (schoolListIndex == 0 &&
                      (schoolList[index].transactionType == AppConstants.tuitionFee)) {
                    return const SizedBox.shrink();
                  }

                  return SingleSchoolListModernWidget(
                     onTotalChanged: (total, transactionType) {
    _handleTotalChange(total, transactionType);
  },
  transactionType: _getTransactionType(schoolList[index]),
                    index: schoolListIndex,
                    schoolLists: schoolList[index],
                    initialChecked: isChecked[index],
                    onChanged: (value) {
                      onCheckboxChanged(index, value!);
                    },
                    products: shop.shopList, // Pass the products list
                  );
                },
              ),
            ),
    ),
  );
}

int _getTransactionType(SchoolLists item) {
  switch(item.transactionType) {
    case AppConstants.classRequirement: return 2;
    case AppConstants.dormitoryEssential: return 3;
    case AppConstants.textBook: return 4;
    case AppConstants.tuitionFee: return 5;
    // ... other cases ...
    default: return 0;
  }
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

  Widget _buildTotalPriceAndButtons(BuildContext context,
      {required int schoolListIndex,
      required String heading,
      required List<SchoolLists> schoolList,
      required List<bool> isChecked}) {
    final userData = Get.find<AuthController>().getUserData();
    late SchoolLists schoolListModel = SchoolLists();
    final currentTypeTotal = _transactionTypeTotals[schoolListIndex] ?? 0.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (schoolListIndex > 0 && schoolListIndex != 5)
            Column(
              children: [
              _buildRichTextSutitle(
                context, 
                heading, 
                '${'sub_total'.tr}:',
                currentTypeTotal.toStringAsFixed(2), 
                AppConstants.currency
              ),
                const SizedBox(height: 10),
                //       DefaultButton2(
                //         onPress: () => Get.to(
                //   () => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
               // cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                //     shipper:widget.shipper,
                //    homePhone:widget.homePhone,
                //    destination:widget.destination,
                //    studentId: widget.studentId!,
                //     inputBalance: schoolList.isNotEmpty ? schoolList[0].amount : 0,
                //     productId: schoolListIndex,
                //     isChecked: isChecked,
                //     schoolId: widget.schoolId!,
                //     classId: widget.classId!,
                //     productName: widget.productName,
                //     transactionType: TransactionType.sendMoney,
                //     className: widget.className,
                //     schoolName:widget.schoolName,
                //     contactModel: ContactModel(
                //       phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                //       name: userData?.name ?? '',
                //       avatarImage: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                //     ),
                //     contactModelMtn: ContactModelMtn(
                //       phoneNumber: '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                //       name: userData?.name ?? '',
                //     ),
                //     dataList: schoolList,
                //     productIndex: 0,
                //     studentName: widget.studentName,
                //     studentCode: widget.studentCode,
                //     edubox_service:heading,
                //     serviceIndex: 0,
                //     price: schoolList.isNotEmpty ? schoolList[0].amount : 0,
                //   ),
                // ),
                //         title: 'ADD TO ALL TOTAL INVOICE',
                //         iconData: Icons.arrow_forward,
                //         color1: kamber300Color,
                //         color2: kyellowColor,
                //       ),
                //       const SizedBox(height: 10),
                //       _buildRichText(
                //         context,
                //         'Add',
                //         '${caseTotals[schoolListIndex]}',
                //         AppConstants.currencySub Total to All Total Invoice to pay or request_credit .trat once.\nOR',
                //       ),
                //       sizedBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultButtonWidth(
                      onPress: () => Get.to(
                        () => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                          cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                          studentController: widget.studentController,
                          studentIndex: widget.studentIndex,
                          availableBalance: 0.00,
                          shipper: widget.shipper,
                          homePhone: widget.homePhone,
                          destination: widget.destination,
                          studentId: widget.studentId!,
                          inputBalance: -1,
                          productId: schoolListIndex,
                          isChecked: isChecked,
                          schoolId: widget.schoolId!,
                          classId: widget.classId!,
                          productName: widget.productName,
                          transactionType: TransactionType.sendMoney,
                          className: widget.className,
                          schoolName: widget.schoolName,
                          contactModel: ContactModel(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                            avatarImage:
                                '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                          ),
                          contactModelMtn: ContactModelMtn(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                          ),
                          dataList: schoolList,
                          productIndex: 0,
                          studentName: widget.studentName,
                          studentCode: widget.studentCode,
                          edubox_service: schoolListIndex > 0
                              ? heading
                              : 'all_school_list'.tr,
                          serviceIndex: 0,
                          price: schoolList.isNotEmpty ? totalPrice : 0,
                        ),
                      ),
                      title: 'pay_now'.tr,
                      color1: kamber300Color,
                      color2: kyellowColor,
                      width: 123,
                    ),
                    DefaultButtonWidth(
                      onPress: () => showDepositDialog(
                        inputBalanceController: inputBalanceController,
                        context: context,
                        title:
                            '${'how_much_would_you_like_to_deposit'.tr}? $schoolListModel',
                        onDeposit: (amount) {
                          final materialBalance =
                              _calculateMaterialBalance(schoolListModel);
                          // Validate amount against balance
                          if (amount < 100 || materialBalance < 0.00) {
                            dialog.showWarningDialog(
                              context: context,
                              balance: materialBalance,
                              amount: totalPrice,
                              inputAmaount: amount,
                            );
                          } else {
                            Get.to(
                              () => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                                cartItems: Map(),
                              
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                                studentController: widget.studentController,
                                studentIndex: widget.studentIndex,
                                availableBalance: materialBalance,
                                shipper: widget.shipper,
                                homePhone: widget.homePhone,
                                destination: widget.destination,
                                studentId: widget.studentId!,
                                inputBalance: inputBalanceController.text == ''
                                    ? amount
                                    : double.parse(inputBalanceController.text),
                                productId: schoolListIndex,
                                isChecked: isChecked,
                                schoolId: widget.schoolId!,
                                classId: widget.schoolId!,
                                productName: widget.productName,
                                transactionType: TransactionType.sendMoney,
                                className: widget.className,
                                schoolName: widget.schoolName,
                                contactModel: ContactModel(
                                  phoneNumber:
                                      '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                                  name: userData?.name ?? '',
                                  avatarImage:
                                      '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                                ),
                                contactModelMtn: ContactModelMtn(
                                  phoneNumber:
                                      '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                                  name: userData?.name ?? '',
                                ),
                                dataList: schoolList,
                                productIndex: 0,
                                studentName: widget.studentName,
                                studentCode: widget.studentCode,
                                edubox_service: schoolListIndex > 0
                                    ? heading
<<<<<<< HEAD
                                    : 'all_school_list'.tr,
=======
                                    : 'Babyeyi ${'all_school_list'.tr}',
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                                serviceIndex: 0,
                                price: schoolList.isNotEmpty ? totalPrice : 0,
                              ),
                            );
                          }
                        },
                      ),
                      title: 'deposit'.tr,
                      color1: kamber300Color,
                      color2: kyellowColor,
                      width: 123,
                    ),
                  ],
                ),
                sizedBox10,
                DefaultButton2(
                  iconData: Icons.credit_card,
                  onPress: () =>
                      Get.to(() => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                        cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                            studentController: widget.studentController,
                            studentIndex: widget.studentIndex,
                            availableBalance: 0.00,
                            screenId: 1,
                            homePhone: widget.homePhone,
                            shipper: widget.shipper,
                            destination: widget.destination,
                            inputBalance: -1,
                            productId: schoolListIndex,
                            isChecked: isChecked,
                            schoolId: widget.schoolId!,
                            classId: widget.classId!,
                            productName: widget.productName,
                            transactionType: TransactionType.sendMoney,
                            className: widget.className,
                            schoolName: widget.schoolName,
                            contactModel: ContactModel(
                              phoneNumber:
                                  '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                              name: userData?.name ?? '',
                              avatarImage:
                                  '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                            ),
                            contactModelMtn: ContactModelMtn(
                              phoneNumber:
                                  '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                              name: userData?.name ?? '',
                            ),
                            dataList: schoolList,
                            productIndex: 0,
                            studentName: widget.studentName,
                            studentCode: widget.studentCode,
                            studentId: widget.studentId!,
                            edubox_service: schoolListIndex > 0
                                ? heading
                                : 'all_school_list'.tr,
                            serviceIndex: schoolListIndex,
                            price: schoolList.isNotEmpty ? totalPrice : 0,
                          )),
                  title: 'request_credit'.tr,
                  color1: kamber300Color,
                  color2: kyellowColor,
                ),
              ],
            )
          else if (schoolListIndex == 5)
            Column(
              children: [
                _buildRichText(
                  context,
                  '${'powered_by'.tr} ',
                  'Umwalimu Sacco',
                  ''
                ),
                sizedBox10,
                _buildRichText(
                  context,
                  '${'total_all'.tr} : ',
                  '${caseTotals[schoolListIndex]}',
                  AppConstants.currency,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultButtonWidth(
                      onPress: () => Get.to(
                        () => PaidAtSchoolTransactionConfirmationScreen(
                          studentId: widget.studentId!,
                          inputBalance: -1,
                          productId: schoolListIndex,
                          isChecked: isChecked,
                          schoolId: widget.schoolId,
                          productName: widget.productName,
                          transactionType: TransactionType.sendMoney,
                          className: widget.className,
                          schoolName: widget.schoolName,
                          contactModel: ContactModel(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                            avatarImage:
                                '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                          ),
                          contactModelMtn: ContactModelMtn(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                          ),
                          dataList: schoolList,
                          productIndex: 0,
                          studentName: widget.studentName,
                          studentCode: widget.studentCode,
                          edubox_service: heading,
                          serviceIndex: 0,
                          price:
                              schoolList.isNotEmpty ? schoolList[0].amount : 0,
                        ),
                      ),
                      //              showDialog(
                      //   context: context,
                      //   builder: (context) => PaymentDialog(
                      //     accountNumber: '1234567890',
                      //     shortCode: '*123#',
                      //     phoneNumber: '*123*1*1234567890*${schoolList.isNotEmpty ? schoolList[0].amount : 0}#',
                      //   ),
                      // ),
                      title: 'pay_now'.tr,

                      color1: kamber300Color,
                      color2: kyellowColor,
                      width: 123,
                    ),
                  ],
                )
              ],
            )
          else
            Column(
              children: [
                _buildRichText(
                  context,
                  '${'total_all'.tr} : ',
                  '$totalPrice',
                  AppConstants.currency,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultButtonWidth(
                      onPress: () => Get.to(
                        () => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                          cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                          studentController: widget.studentController,
                          studentIndex: widget.studentIndex,
                          availableBalance: 0.00,
                          studentId: widget.studentId!,
                          shipper: widget.shipper,
                          homePhone: widget.homePhone,
                          destination: widget.destination,
                          inputBalance: -1,
                          productId: schoolListIndex,
                          isChecked: isChecked,
                          schoolId: widget.schoolId!,
                          classId: widget.classId!,
                          productName: widget.productName,
                          transactionType: TransactionType.sendMoney,
                          className: widget.className,
                          schoolName: widget.schoolName,
                          contactModel: ContactModel(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                            avatarImage:
                                '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                          ),
                          contactModelMtn: ContactModelMtn(
                            phoneNumber:
                                '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                            name: userData?.name ?? '',
                          ),
                          dataList: schoolList,
                          productIndex: 0,
                          studentName: widget.studentName,
                          studentCode: widget.studentCode,
                          edubox_service: schoolListIndex > 0
                              ? heading
                              : 'all_school_list'.tr,
                          serviceIndex: 0,
                          price: schoolList.isNotEmpty ? totalPrice : 0,
                        ),
                      ),
                      title: 'pay_now'.tr,
                      color1: kamber300Color,
                      color2: kyellowColor,
                      width: 123,
                    ),
                    DefaultButtonWidth(
                      onPress: () {
                        showDepositDialog(
                            inputBalanceController: inputBalanceController,
                            context: context,
                            title:
                                '${'how_much_would_you_like_to_deposit'.tr}?$schoolListModel',
                            onDeposit: (amount) {
                              final materialBalance =
                                  _calculateMaterialBalance(schoolListModel);
                              // Validate amount against balance
                              if (amount < 100 || materialBalance < 0.00) {
                                dialog.showWarningDialog(
                                  context: context,
                                  balance: materialBalance,
                                  amount: totalPrice,
                                  inputAmaount: amount,
                                );
                              } else {
                                Get.to(
                                  () => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                                    cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                                    studentController: widget.studentController,
                                    studentIndex: widget.studentIndex,
                                    availableBalance: materialBalance,
                                    studentId: widget.studentId!,
                                    shipper: widget.shipper,
                                    homePhone: widget.homePhone,
                                    destination: widget.destination,
                                    inputBalance:
                                        inputBalanceController.text == ''
                                            ? amount
                                            : double.parse(
                                                inputBalanceController.text),
                                    productId: schoolListIndex,
                                    isChecked: isChecked,
                                    schoolId: widget.schoolId!,
                                    classId: widget.classId!,
                                    productName: widget.productName,
                                    transactionType: TransactionType.sendMoney,
                                    className: widget.className,
                                    schoolName: widget.schoolName,
                                    contactModel: ContactModel(
                                      phoneNumber:
                                          '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                                      name: userData?.name ?? '',
                                      avatarImage:
                                          '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                                    ),
                                    contactModelMtn: ContactModelMtn(
                                      phoneNumber:
                                          '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                                      name: userData?.name ?? '',
                                    ),
                                    dataList: schoolList,
                                    productIndex: 0,
                                    studentName: widget.studentName,
                                    studentCode: widget.studentCode,
                                    edubox_service: schoolListIndex > 0
                                        ? heading
                                        : 'all_school_list'.tr,
                                    serviceIndex: 0,
                                    price:
                                        schoolList.isNotEmpty ? totalPrice : 0,
                                  ),
                                );
                              }
                            });
                      },
                      title: 'deposit'.tr,
                      color1: kamber300Color,
                      color2: kyellowColor,
                      width: 123,
                    ),
                  ],
                ),
                sizedBox10,
                DefaultButton2(
                  iconData: Icons.credit_card,
                  onPress: () =>
                      Get.to(() => SchoolTransactionConfirmationScreen(
<<<<<<< HEAD
=======
                        cartItems: Map(),
>>>>>>> 70f2993a9c488529ef4a6b7bd31749fa3d235e6b
                            studentController: widget.studentController,
                            studentIndex: widget.studentIndex,
                            availableBalance: 0.00,
                            homePhone: widget.homePhone,
                            destination: widget.destination,
                            screenId: 1,
                            shipper: widget.shipper,
                            inputBalance:
                                schoolList.isNotEmpty ? totalPrice : 0,
                            productId: schoolListIndex,
                            isChecked: isChecked,
                            schoolId: widget.schoolId!,
                            classId: widget.classId!,
                            productName: widget.productName,
                            transactionType: TransactionType.sendMoney,
                            className: widget.className,
                            schoolName: widget.schoolName,
                            contactModel: ContactModel(
                              phoneNumber:
                                  '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                              name: userData?.name ?? '',
                              avatarImage:
                                  '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl ?? ''}/image',
                            ),
                            contactModelMtn: ContactModelMtn(
                              phoneNumber:
                                  '${userData?.countryCode ?? ''}${userData?.phone ?? ''}',
                              name: userData?.name ?? '',
                            ),
                            dataList: schoolList,
                            productIndex: 0,
                            studentName: widget.studentName,
                            studentCode: widget.studentCode,
                            studentId: widget.studentId!,
                            edubox_service: schoolListIndex > 0
                                ? heading
                                : 'all_school_list'.tr,
                            serviceIndex: 0,
                            price: schoolList.isNotEmpty ? totalPrice : 0,
                          )),
                  title: 'request_for_credit'.tr,
                  color1: kamber300Color,
                  color2: kyellowColor,
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
          //     AppConstants.currency,
          //   );
          // }).toList(),
        ],
      ),
    );
  }

  double _calculateMaterialBalance(SchoolLists material) {
    try {
      return (material.paymentHistory?.balance != null &&
              double.tryParse(material.paymentHistory!.balance ?? '0.00')! >
                  0.00)
          ? double.parse(material.paymentHistory!.balance!)
          : double.parse('0.00');
    } catch (e) {
      return 0.00;
    }
  }

  Widget _buildRichText(
      BuildContext context, String prefix, String value, String suffix) {
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

  Widget _buildRichTextSutitle(BuildContext context, String prefix,
      String value, String suffix, String farSuffix) {
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
