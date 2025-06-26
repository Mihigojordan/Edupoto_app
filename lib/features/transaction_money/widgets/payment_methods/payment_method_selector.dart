import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/data/api/mtn_momo_api_client.dart';
import 'package:hosomobile/features/auth/controllers/auth_controller.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';
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
  final String destination;
  final String homePhone;
  final String shipper;
  final List<EduboxMaterialModel>? svProductList;
  final List<SchoolLists>? productList;
  final String productName;
  final List<String>? shopList;

  PaymentMethodSelector({
    super.key,
    required this.shipper,
    required this.service_charge,
    this.shopList,
    required this.productName,
    this.productList,
    this.svProductList,
    required this.randomNumber,
    required this.destination,
    required this.homePhone,
    required this.edubox_service,
    required this.transactionMoneyController,
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
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  int _selectedMethod = 0; // 0=MOMO, 1=Card, 2=Bank
  int? _selectedMobileProvider; // 0=MTN, 1=Airtel
  int? _selectedBankProvider; // 0=BK
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          const SizedBox(height: 30),
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
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
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
            : ConfirmationSlider(
                height: 60.0,
                backgroundColor: ColorResources.getGreyBaseGray6(),
                text: 'swipe_to_pay'.tr,
                textStyle: rubikRegular.copyWith(
                    fontSize: Dimensions.paddingSizeLarge),
                shadow: const BoxShadow(),
                sliderButtonContent: Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(Images.slideRightIcon),
                ),
                onConfirmation: () async {
                   _selectedMobileProvider!=null?   showCustomSnackBarHelper(
        '${'processing_payment'.tr}... ${'please_wait_to_receive_payment_prompt'.tr}.',
        isError: false,
      ):showCustomSnackBarHelper(
        '${'processing_payment'.tr}... ${'please_wait'.tr}.',
        isError: false,
      );
                  // Initiate payment
                  await widget.mtnMomoApiClient.postMtnMomo(
                      transactionId: widget.randomNumber.toString(),
                      amount: double.parse(widget.amount).toInt().toString(),
                      message:
                          '${'you_have_paid_for'.tr} ${widget.edubox_service} ${'vat'.tr} , ${double.parse(widget.service_charge).toInt()} ${AppConstants.currency} ${'convenience_fee'.tr}',
                      phoneNumber:
                          normalizeRwandaPhoneNumber(_phoneController.text));

                  // Start polling for payment status
                  _pollPaymentStatus();
                },
              ),
      ],
    );
  }

  void _pollPaymentStatus() async {
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

        print('Payment status check attempt $attempts: $status');
  
        switch (status) {
          case 'SUCCESSFUL':
            paymentCompleted = true;
        _handleSuccessfulPayment();  
            break;

          case 'FAILED':
            paymentCompleted = true;
            showCustomSnackBarHelper(
              'Payment failed: Insufficient balance or transaction declined',
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
        print('Error checking payment status: $e');
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

  void _handleSuccessfulPayment() async {
       final  userId = Get.find<AuthController>().getUserId();
      
    try {
      if (widget.transactionType == "send_money") {
        // Process successful payment
        final transaction = await widget.transactionMoneyController.sendMoney(
            contactModel: widget.contactModel,
            amount: double.parse(widget.amount),
            purpose: widget.purpose,
            pinCode: widget.pinCode,
            onSuggest: () => widget.contactController.addToSuggestContact(
                  widget.contactModel,
                  type: SuggestType.sendMoney,
                ));

        widget.transactionId = transaction.body['transaction_id'];

        await widget.transactionMoneyController.makePayment(
           payment_method:_selectedMethod==0?'mobile_money'.tr:_selectedMethod==1?'card'.tr:_selectedMethod==2?'bank'.tr:'no_method'.tr,
          payment_media:_selectedMobileProvider==0?'MTN':_selectedMobileProvider==1?'Airtel':_selectedBankProvider==0?'BK':'no_bank'.tr,
          payment_phone: _phoneController.text,
           parent_id: userId!,
           product_name: widget.edubox_service,
           sv_product_list:widget.svProductList!,
           destination:widget.destination,
           homePhone:widget.homePhone,
           shipper:widget.shipper,
           studentId: widget.studentId == 0 ? int.parse(userId ): widget.studentId,
            amount: double.parse(widget.amount),
            totalAmount: double.parse(widget.amountToPay),
            productType: widget.productId, //widget.dataList![widget.productIndex!].id!,
            productId: widget.productId,
            balance: double.parse(widget.availableBalance),
            phoneNumber: widget.contactModel.phoneNumber!,
            charge: double.parse(widget.serviceCharge),
            );

        showCustomSnackBarHelper('${'payment_successfully'.tr}!', isError: false);
      }
    } catch (e) {
      print('Error processing successful payment: $e');
      showCustomSnackBarHelper(
        'payment_verification_failed'.tr,
        isError: true,
      );
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
        ],
      ),
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
