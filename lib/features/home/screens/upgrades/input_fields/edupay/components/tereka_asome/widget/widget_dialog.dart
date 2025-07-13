import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/util/app_constants.dart';

class WidgetDialog {


  void showSntDialog(
      {required BuildContext context,
      required int index,
      required String title,
      required String school}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title:  Text('student_info'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.start,
              ),
              sizedBox05h,
              Text(
                school,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
              child:  Text(
                "ok".tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void showWarningDialog(
      {required BuildContext context,
      required double balance,
      required double amount,
      required double inputAmaount}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('payment_info'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
            if(inputAmaount > balance) 
             Text(
                '${'you_have_exceeded_balance_to_be_paid_of'.tr} $balance ${AppConstants.currency}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w300),
              )
            else if(balance<=0.00)
              Text(
                '${'your_payment_has_completed'.tr}, ${'thank_you_for_choosing'.tr} ${AppConstants.appName}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w300),
              )
              else if(inputAmaount<100)
                 Text(
                '${'the_minimum_amount_to_pay_start_from'.tr} , ${'thank_you_for_choosing'.tr} ${AppConstants.appName}',
               style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w300),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
  }

 void showDepositDialog({
  required BuildContext context,
  required String title,
  required Function(double) onDeposit,
  required TextEditingController inputBalanceController
}) {
  final _formKey = GlobalKey<FormState>();
 
  final _focusNode = FocusNode();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title:  Text('deposit'.tr, 
            style:const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(  // Prevents overflow
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, 
                    style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: inputBalanceController,
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixText: '${AppConstants.currency} ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'enter_amount'.tr,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_enter_an_amount'.tr;
                      }
                      final amount = double.tryParse(value);
                      if (amount == null) {
                        return 'please_enter_a_valid_number'.tr;
                      }
                      if (amount <= 0) {
                        return 'amount_must_be_greater_than_zero';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL", 
                style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final amount = double.parse(inputBalanceController.text);
                  // Navigator.pop(context); // Close dialog first
                
                    onDeposit(amount); // Execute callback after frame
                
                }
              },
              child: const Text("DEPOSIT",
                style: TextStyle(
                  color: Colors.amber, 
                  fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    },
  ).then((_) {
    // Proper disposal management
    inputBalanceController.dispose();
     _focusNode.dispose();
  });
}