import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
import 'package:hosomobile/features/shop/controller/shop_controller.dart';
import 'package:hosomobile/features/shop/domain/models/customer_model.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:hosomobile/features/transaction_money/controllers/transaction_controller.dart';
import 'package:hosomobile/features/transaction_money/domain/enums/suggest_type_enum.dart';
import 'package:hosomobile/helper/custom_snackbar_helper.dart';
import 'package:hosomobile/helper/normalize_phone_number.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/color_resources.dart';
import 'package:hosomobile/util/dimensions.dart';
import 'package:hosomobile/util/images.dart';
import 'package:hosomobile/util/styles.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class PaymentMethodSelector extends StatefulWidget {
  final Function(String, String, String?) onPaymentMethodSelected;
  final String initialAmount;
  final TransactionMoneyController transactionMoneyController;
  final ShopController? shopController;
  final String transactionType;
  final MtnMomoApiClient mtnMomoApiClient;
  final ContactModel contactModel;
  final String amount;
  final String purpose;
  final String pinCode;
  final ContactController contactController;
  String transactionId;
  final int studentId;
  final String amountToPay;
  final int productId;
  final String availableBalance;
  final String serviceCharge;
  final int randomNumber;
  final String edubox_service;
  final String service_charge;
  final String homePhone;
  final List<EduboxMaterialModel>? svProductList;
  final List<SchoolLists>? productList;
  final String productName;
  final List<Map<String, dynamic>>? shopList;
  final String vat;
  final double? deliveryCost;
  final String? customerNote;
  final String shippingAddress1;
  final String shippingAddress2;
  final String shippingFirstName;
  final String shippingLastName;
  final String shippingCompany;
  final String shippingCity;
  final String shippingCountry;

  PaymentMethodSelector(
      {super.key,
      this.customerNote,
      this.deliveryCost,
      required this.shippingAddress1,
      required this.shippingAddress2,
      required this.shippingFirstName,
      required this.shippingLastName,
      required this.shippingCompany,
      required this.shippingCity,
      required this.shippingCountry,
      required this.service_charge,
      this.shopList,
      required this.productName,
      this.productList,
      this.svProductList,
      required this.randomNumber,
      required this.homePhone,
      required this.edubox_service,
      required this.transactionMoneyController,
      this.shopController,
      required this.transactionId,
      required this.studentId,
      required this.amountToPay,
      required this.productId,
      required this.availableBalance,
      required this.serviceCharge,
      required this.contactController,
      required this.amount,
      required this.purpose,
      required this.pinCode,
      required this.contactModel,
      required this.mtnMomoApiClient,
      required this.transactionType,
      required this.onPaymentMethodSelected,
      required this.initialAmount,
      required this.vat});

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  int _selectedMethod = 0; // 0=MOMO, 1=Card, 2=Bank
  int? _selectedMobileProvider; // 0=MTN, 1=Airtel
  int? _selectedBankProvider; // 0=BK
  final customerId = Get.find<ShopController>().getCustomerId();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var body;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          const SizedBox(height: 20),
          Text(
            'select_payment_method'.tr,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 20),
          _buildPaymentMethodSelector(),
          const SizedBox(height: 20),
          if (_selectedMethod == 0) _buildMobileMoneyProviders(),
          if (_selectedMethod == 2) _buildBankProviders(),
          const SizedBox(height: 10),
          _buildPaymentInputField(),
          sizedBox10,
          // _customerInfo(),
          // const SizedBox(height: 30),
          // _buildConfirmButton(),
          _confirmationButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMobileMoneyProviders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_mobile_money_provider'.tr,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProviderOption(
              image: 'assets/icons1/momo.jpeg', // Replace with your asset path
              label: 'MTN',
              isSelected: _selectedMobileProvider == 0,
              onTap: () => setState(() => _selectedMobileProvider = 0),
            ),
            _buildProviderOption(
              image:
                  'assets/icons1/airtel_money.png', // Replace with your asset path
              label: 'Airtel',
              isSelected: _selectedMobileProvider == 1,
              onTap: () => setState(() => _selectedMobileProvider = 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBankProviders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_bank'.tr,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildProviderOption(
              image: 'assets/icons1/bk.jpg', // Replace with your asset path
              label: 'BK',
              isSelected: _selectedBankProvider == 0,
              onTap: () => setState(() => _selectedBankProvider = 0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderOption({
    required String image,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.account_balance, size: 40),
            ),
            const SizedBox(height: 5),
            Text(label),
          ],
        ),
      ),
    );
  }

  // ... [Keep all your existing methods (_buildDragHandle, _buildPaymentMethodSelector,
  // _buildMethodOption, _buildPaymentInputField, etc.) unchanged]

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_selectedMethod == 0 && _selectedMobileProvider == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('please_select_mobile_money_provider'.tr)));
              return;
            }
            if (_selectedMethod == 2 && _selectedBankProvider == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('please_select_bank'.tr)));
              return;
            }

            final paymentDetails = _selectedMethod == 0
                ? _phoneController.text
                : _cardController.text;

            final method = _selectedMethod == 0
                ? 'mobile_money'.tr
                : _selectedMethod == 1
                    ? 'card'.tr
                    : 'bank'.tr;

            String? provider;
            if (_selectedMethod == 0) {
              provider = _selectedMobileProvider == 0 ? 'MTN' : 'Airtel';
            } else if (_selectedMethod == 2) {
              provider = 'BK';
            }

            widget.onPaymentMethodSelected(method, paymentDetails, provider);
            Navigator.pop(context);
          }
        },
        child: Text(
          '${'pay'.tr} ${widget.initialAmount}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _confirmationButton() {
    return Column(
      children: [
        const SizedBox(height: 40.0),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Divider(height: Dimensions.dividerSizeSmall),
        ),
        sizedBox10,
        widget.transactionMoneyController.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
              )
            : Column(
                children: [
                  // Regular button for tap
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedMethod == 0 &&
                                _selectedMobileProvider == null) {
                              print(
                                  'ssssssssssssssssssssssssssss $_selectedMethod | $_selectedMobileProvider');
                              showCustomSnackBarHelper(
                                  'please_select_mobile_money_provider'.tr,
                                  isError: true);

                              return;
                            }
                            if (_selectedMethod == 2 &&
                                _selectedBankProvider == null) {
                              showCustomSnackBarHelper('please_select_bank'.tr,
                                  isError: true);

                              return;
                            }

                            final paymentDetails = _selectedMethod == 0
                                ? _phoneController.text
                                : _cardController.text;

                            final method = _selectedMethod == 0
                                ? 'mobile_money'.tr
                                : _selectedMethod == 1
                                    ? 'card'.tr
                                    : 'bank'.tr;

                            String? provider;
                            if (_selectedMethod == 0) {
                              provider = _selectedMobileProvider == 0
                                  ? 'MTN'
                                  : 'Airtel';
                            } else if (_selectedMethod == 2) {
                              provider = 'BK';
                            }

                            //*******************************TEMPORARY PAYMENT CHECK */

                            if (customerId == null) {
                              _createCustomer();
                            } else {
                             await _initiatePayment(customId: customerId);
                              // _handleSuccessfulPayment(customId: customerId);
                            }
                          }
                        },
                        child: Text(
                          'pay_now'.tr,
                          style: rubikRegular.copyWith(
                            fontSize: Dimensions.paddingSizeLarge,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Swipe confirmation
                  // ConfirmationSlider(
                  //   height: 60.0,
                  //   backgroundColor: ColorResources.getGreyBaseGray6(),
                  //   text: 'swipe_to_pay'.tr,
                  //   textStyle: rubikRegular.copyWith(
                  //       fontSize: Dimensions.paddingSizeLarge),
                  //   shadow: const BoxShadow(),
                  //   sliderButtonContent: Container(
                  //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).secondaryHeaderColor,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Image.asset(Images.slideRightIcon),
                  //   ),
                  //   onConfirmation: () async {
                  //     await _initiatePayment();
                  //   },
                  // ),
                ],
              ),
      ],
    );
  }

  Future<void> _initiatePayment({int? customId}) async {
    // Show processing message
    _selectedMobileProvider != null
        ? showCustomSnackBarHelper(
            '${'processing_payment'.tr}... ${'please_wait_to_receive_payment_prompt'.tr}.',
            isError: false,
          )
        : showCustomSnackBarHelper(
            '${'processing_payment'.tr}... ${'please_wait'.tr}.',
            isError: false,
          );

    // Initiate payment
    await widget.mtnMomoApiClient.postMtnMomo(
      transactionId: widget.randomNumber.toString(),
      amount: double.parse(widget.amount).toInt().toString(),
      message: '${'you_have_paid_for'.tr}'
          ' ${widget.edubox_service}, ${'vat'.tr} ${'inclusive'.tr}, ',
      // '${double.parse(widget.service_charge).toInt()} '
      // '${AppConstants.currency} ${'convenience_fee'.tr}',
      phoneNumber: normalizeRwandaPhoneNumber(_phoneController.text),
    );

    // Start polling for payment status
    _pollPaymentStatus(customId: customId);
  }

  void _pollPaymentStatus({int? customId}) async {
    const maxAttempts = 10; // Maximum number of polling attempts
    const interval = Duration(seconds: 3); // Poll every 3 seconds
    int attempts = 0;
    bool paymentCompleted = false;

    while (attempts < maxAttempts && !paymentCompleted) {
      await Future.delayed(interval);
      attempts++;

      try {
        final response = await widget.mtnMomoApiClient.getMtnMomo();
        final status = await widget.mtnMomoApiClient.getStatus();

        // print('Payment status check attempt $attempts: $status');

        switch (status) {
          case 'SUCCESSFUL':
            paymentCompleted = true;
            _handleSuccessfulPayment(customId: customId);
            break;

          case 'FAILED':
            paymentCompleted = true;
            showCustomSnackBarHelper(
              '${'payment_failed'.tr}: ${'insufficient_balance_or_transaction_decline'.tr}',
              isError: true,
            );
            break;

          case 'PENDING':
            // Continue polling
            break;

          default:
            // Handle unknown status
            paymentCompleted = true;
            showCustomSnackBarHelper(
              'Payment status unknown: $status',
              isError: true,
            );
        }
      } catch (e) {
        // print('Error checking payment status: $e');
        if (attempts >= maxAttempts) {
          showCustomSnackBarHelper(
            'payment_transaction_timeout'.tr,
            isError: false,
          );
        }
      }
    }

    if (!paymentCompleted) {
      showCustomSnackBarHelper(
        'payment_verification_timeout'.tr,
        isError: false,
      );
    }
  }

  void _createCustomer() async {
    final userId = Get.find<AuthController>().getUserId();

    try {
      final userData = Get.find<AuthController>().getUserData();
      final name = userData!.name!;
      final String nameWithoutSpaces = name.replaceAll(' ', '');
      final String email = '$nameWithoutSpaces$userId@gmail.com';

      final List<String> nameParts =
          name.trim().split(' ').where((part) => part.isNotEmpty).toList();

      final String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
      final String lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      // Fetch customer list
      await widget.shopController!.getCustomerData(reload: true);

      // Safely find customer by email in the list
      CustomerModel? existingCustomer;
      try {
        existingCustomer = widget.shopController!.customerList?.firstWhere(
            (customer) => customer.email.toLowerCase() == email.toLowerCase());
      } catch (e) {
        // No customer found, existingCustomer remains null
        // debugPrint('No existing customer found: $e');
      }
      // print(
      //     'ggggggggggggggggggggggggggggggggggggggg${existingCustomer!.firstName} | ${existingCustomer!.id}');
      if (existingCustomer?.id == null || existingCustomer!.id == 0) {
        // Customer doesn't exist or has invalid ID, create new one
        // debugPrint('Creating new customer with email: $email');
        final response = await widget.shopController!.customerReg(
          email: email,
          phone: _phoneController.text,
          firstName: firstName,
          lastName: lastName,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final newCustomerId = response.body['id'];
          if (newCustomerId != null && newCustomerId > 0) {
          _initiatePayment(customId: newCustomerId);
       //  _handleSuccessfulPayment(customId: newCustomerId);
            widget.shopController!.setCustomerId(newCustomerId.toString());
          } else {
            throw Exception('Received invalid customer ID: $newCustomerId');
          }
        } else {
          throw Exception('Failed to create customer: ${response.statusText}');
        }
      } else {
        // Customer exists, use existing ID
        // print(
        //     'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Using existing customer with ID: ${existingCustomer.id} name: ${existingCustomer.firstName}');
     _initiatePayment(customId: existingCustomer.id);
    // _handleSuccessfulPayment(customId: existingCustomer.id);
        widget.shopController!.setCustomerId(existingCustomer.id.toString());
      }
    } catch (e) {
      widget.shopController!.removeUserId();
      // print('cccccccccccccccccccccccccccccccccccccccccc: Customer creation error: $userId | $name | $e');
      showCustomSnackBarHelper(
        'user_creation_failed'.tr,
        isError: true,
      );
      // Consider adding retry logic or alternative flow here
    }
  }

  void _handleSuccessfulPayment({int? customId}) async {
    final userId = Get.find<AuthController>().getUserId();
    final userData = Get.find<AuthController>().getUserData();
    final name = userData!.name!;
    final phone = userData.phone;

    final List<String> nameParts =
        name.trim().split(' ').where((part) => part.isNotEmpty).toList();

    final String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    try {
      if ((widget.shopList != null && customId != null) ||
          (widget.shopList != null && customerId != null)) {
            showCustomSnackBarHelper(
            '${'your_order_is_being_processed'.tr}... ${'please_wait'.tr}.',
            isError: false,
          );
        await widget.shopController!
            .createOrder(
          billingFirstName: firstName,
          billingLastName: lastName,
          billingPhone: phone,
          billingCompany: _selectedMobileProvider == 0
              ? 'MTN'
              : _selectedMobileProvider == 1
                  ? 'Airtel'
                  : _selectedBankProvider == 0
                      ? 'BK'
                      : 'no_bank'.tr,
          products: widget.shopList ?? [],
          feeName: 'convenience_fee'.tr,
          feeAmount: '${double.parse(widget.service_charge).toInt()}',
          shippingAddress1: widget.shippingAddress1,
          shippingAddress2: widget.shippingAddress2,
          shippingFirstName: widget.shippingFirstName,
          shippingLastName: widget.shippingLastName,
          shippingCompany: widget.shippingCompany,
          shippingCity: widget.shippingCity,
          shippingCountry: widget.shippingCountry,
          currency: AppConstants.currency,
          shippingTotal: widget.deliveryCost!.toStringAsFixed(2),
          total: widget.amount,
          customerId: customerId ?? customId!,
          paymentMethod: _selectedMethod == 0
              ? 'mobile_money'.tr
              : _selectedMethod == 1
                  ? 'card'.tr
                  : _selectedMethod == 2
                      ? 'bank'.tr
                      : 'no_method'.tr,
          paymentMethodTitle: _selectedMobileProvider == 0
              ? 'MTN'
              : _selectedMobileProvider == 1
                  ? 'Airtel'
                  : _selectedBankProvider == 0
                      ? 'BK'
                      : 'no_bank'.tr,
          createdVia: 'Customer',
          customerNote: widget.customerNote ?? '',
          homePhone: widget.homePhone,
        )
            .then((onValue) {
          Get.find<ShopController>().getOrderList(true);
        });
      }

      if (widget.transactionType == "send_money") {
        // First safely parse all numeric values
        final amount = _parseDouble(widget.amount);
        final totalAmount = _parseDouble(widget.amountToPay);
        final balance = _parseDouble(widget.availableBalance);
        final charge = _parseDouble(widget.serviceCharge);

        // Process successful payment
        final transaction = await widget.transactionMoneyController.sendMoney(
          contactModel: widget.contactModel,
          amount: amount,
          purpose: widget.purpose,
          pinCode: widget.pinCode,
          onSuggest: () => widget.contactController.addToSuggestContact(
            widget.contactModel,
            type: SuggestType.sendMoney,
          ),
        );

        // final transaction = await widget.transactionMoneyController
        //     .babyeyiTransaction(
        //         userId: int.parse(userId!),
        //         price: amount,
        //         totalAmount: totalAmount,
        //         productId: widget.productId,
        //         productType: '${widget.productId}',
        //         balance: balance,
        //         charge: charge,
        //         phoneNumber: '${customerId!}',
        //         currency: AppConstants.currency,
        //         paymentMethod: _selectedMethod == 0
        //       ? 'mobile_money'.tr
        //       : _selectedMethod == 1
        //           ? 'card'.tr
        //           : _selectedMethod == 2
        //               ? 'bank'.tr
        //               : 'no_method'.tr,
        //         paymentProvider:  _selectedMobileProvider == 0
        //       ? 'MTN'
        //       : _selectedMobileProvider == 1
        //           ? 'Airtel'
        //           : _selectedBankProvider == 0
        //               ? 'BK'
        //               : 'no_bank'.tr,
        //         onSuggest: () => widget.contactController.addToSuggestContact(
        //     widget.contactModel,
        //     type: SuggestType.sendMoney,
        //   ),

        //         );

        widget.transactionId = transaction.body['transaction_id'];

        await widget.transactionMoneyController.makePayment(
          payment_method: _selectedMethod == 0
              ? 'mobile_money'.tr
              : _selectedMethod == 1
                  ? 'card'.tr
                  : _selectedMethod == 2
                      ? 'bank'.tr
                      : 'no_method'.tr,
          payment_media: _selectedMobileProvider == 0
              ? 'MTN'
              : _selectedMobileProvider == 1
                  ? 'Airtel'
                  : _selectedBankProvider == 0
                      ? 'BK'
                      : 'no_bank'.tr,
          payment_phone: _phoneController.text,
          parent_id: userId!,
          product_name: widget.edubox_service,
          sv_product_list: widget.svProductList ?? [],
          destination: widget.shippingAddress1,
          homePhone: widget.homePhone,
          shipper: widget.shippingCompany,
          studentId:
              widget.studentId == 0 ? int.parse(userId) : widget.studentId,
          amount: amount,
          totalAmount: totalAmount,
          productType: widget.productId,
          productId: widget.productId,
          balance: balance,
          phoneNumber: widget.contactModel.phoneNumber!,
          charge: charge,
        );

        showCustomSnackBarHelper('${'payment_successfully'.tr}!',
            isError: false);
      }
    } catch (e) {
      print('Error processing successful payment: $e');
      showCustomSnackBarHelper(
        '${'order_creation_failed'.tr} $customerId | $customId | ${widget.shopList}',
        isError: true,
      );
    }
  }

// Helper method to safely parse doubles
  double _parseDouble(String value) {
    try {
      return double.parse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (e) {
      print('Failed to parse double from: $value');
      return 0.0; // or throw an exception if you prefer
    }
  }

  Widget _buildPaymentMethodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMethodOption(
          icon: Icons.phone_android,
          label: 'mobile_money'.tr,
          index: 0,
        ),
        _buildMethodOption(
          icon: Icons.credit_card,
          label: 'card'.tr,
          index: 1,
        ),
        _buildMethodOption(
          icon: Icons.account_balance,
          label: 'bank'.tr,
          index: 2,
        ),
      ],
    );
  }

  Widget _buildMethodOption({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedMethod == index
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: _selectedMethod == index
                ? Theme.of(context).primaryColor
                : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: _selectedMethod == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700]),
            const SizedBox(height: 5),
            Text(label,
                style: TextStyle(
                    color: _selectedMethod == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInputField() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedMethod == 0
                ? 'enter_mobile_money_number'.tr
                : _selectedMethod == 1
                    ? 'enter_card_details'.tr
                    : 'enter_account_number'.tr,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller:
                _selectedMethod == 0 ? _phoneController : _cardController,
            keyboardType: _selectedMethod == 0
                ? TextInputType.phone
                : TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              if (_selectedMethod == 0)
                LengthLimitingTextInputFormatter(10), // For phone numbers
            ],
            decoration: InputDecoration(
              hintText: _selectedMethod == 0
                  ? '07X XXX XXXX'
                  : _selectedMethod == 1
                      ? 'card_number'.tr
                      : 'account_number'.tr,
              prefixIcon: _selectedMethod == 0
                  ? const Icon(Icons.phone)
                  : const Icon(Icons.credit_card),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_required_details'.tr;
              }
              if (_selectedMethod == 0 && value.length != 10) {
                return 'enter_a_valid_10_digit_number'.tr;
              }
              return null;
            },
          ),
          if (_selectedMethod == 0)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'you_will_receive_payment_request_on_this_number'.tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          _customerInfo()
        ],
      ),
    );
  }

  Widget _customerInfo() {
    final shopController = Get.find<ShopController>();
    final customerInfo = shopController.getCustomerInfo();
    final bool isLoggedIn = customerId != null;
    bool showAdditionalInfo = isLoggedIn ? false : false;
    bool isEditing = false; // Track editing state
    String email = '';

    // Initialize controllers with customer data if available
    if (customerInfo != null) {
      _emailController.text = customerInfo.email ?? '';
      _firstNameController.text = customerInfo.firstName ?? '';
      _lastNameController.text = customerInfo.lastName ?? '';
      email = customerInfo.email!;
    }
    String orderId = email.replaceAll('@gmail.com', '');

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Email field (editable when not logged in or in edit mode)
            // if (!isLoggedIn || isEditing) ...[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text('enter_your_email_to_continue'.tr),
            //     ],
            //   ),
            //   TextFormField(
            //     controller: _emailController,
            //     keyboardType: TextInputType.emailAddress,
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     decoration: InputDecoration(
            //       hintText: 'email_address'.tr,
            //       prefixIcon: const Icon(Icons.email),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       errorMaxLines: 2,
            //     ),
            //     validator: (value) {
            //       if (value == null || value.trim().isEmpty) {
            //         return 'please_enter_required_details'.tr;
            //       }
            //       final emailRegex = RegExp(
            //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
            //       if (!emailRegex.hasMatch(value.trim())) {
            //         return 'please_enter_a_valid_email'.tr;
            //       }
            //       return null;
            //     },
            //   ),
            //   const SizedBox(height: 16),
            // ],

            // Display customer info when not editing
            if (customerInfo != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'order_id'.tr}: ${orderId ?? 'N/A'}'),
                      if (customerInfo.firstName != null)
                        Text('First Name: ${customerInfo.firstName}'),
                      if (customerInfo.lastName != null)
                        Text('Last Name: ${customerInfo.lastName}'),
                    ],
                  ),
                ],
              ),

            // Edit/Save button for logged-in users
            // if (isLoggedIn)
            //   ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         isEditing = !isEditing;
            //         if (!isEditing) {
            //           // Save changes
            //           shopController.updateCustomerInfo(
            //             id: customerId!,
            //             phone: _phoneController.text,
            //             email: _emailController.text,
            //             firstName: _firstNameController.text,
            //             lastName: _lastNameController.text,
            //           );
            //         }
            //       });
            //     },
            //     child: Text(isEditing ? 'Save Changes' : 'Edit Information'),
            //   ),

            // Additional info section (for non-logged-in or editing)
            // if (!isLoggedIn || isEditing) ...[
            // Toggle button for non-logged-in users
            // if (!isLoggedIn)
            //   TextButton(
            //     onPressed: () =>
            //         setState(() => showAdditionalInfo = !showAdditionalInfo),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text(showAdditionalInfo
            //             ? 'Hide Additional Information'.tr
            //             : 'Show Additional Information'.tr),
            //         Icon(showAdditionalInfo
            //             ? Icons.keyboard_arrow_up
            //             : Icons.keyboard_arrow_down),
            //       ],
            //     ),
            //   ),

            // Additional fields (shown when expanded or editing)
            // if (showAdditionalInfo || isEditing) ...[
            //   SizedBox(height: 16),
            //   TextFormField(
            //     controller: _firstNameController,
            //     decoration: InputDecoration(
            //       hintText: 'first_name'.tr,
            //       prefixIcon: const Icon(Icons.person),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     validator: (value) {
            //       if (value == null || value.trim().isEmpty) {
            //         return 'please_enter_required_details'.tr;
            //       }
            //       return null;
            //     },
            //   ),
            //   SizedBox(height: 16),
            //   TextFormField(
            //     controller: _lastNameController,
            //     decoration: InputDecoration(
            //       hintText: 'last_name'.tr,
            //       prefixIcon: const Icon(Icons.person),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     validator: (value) {
            //       if (value == null || value.trim().isEmpty) {
            //         return 'please_enter_required_details'.tr;
            //       }
            //       return null;
            //     },
            //   ),
            // ],
            // ],
          ],
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
