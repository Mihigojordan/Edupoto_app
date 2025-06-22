import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

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
          title: const Text('Student Info'),
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
          title:const Text('Payment Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
            if(inputAmaount > balance) 
             Text(
                'You have exceeded the Balance to be paid of $balance RWF',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w300),
              )
            else if(balance<=0.00)
            const  Text(
                'You are payment has completed, Thank you for choosing HOSOMobile',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w300),
              )
              else if(inputAmaount<100)
              const   Text(
                'The minimum amount to pay start from (100 RWF) and above , Thank you for choosing HOSOMobile',
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
}) {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
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
          title: const Text('Deposit', 
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                    controller: _amountController,
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixText: 'RWF ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Enter amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null) {
                        return 'Please enter a valid number';
                      }
                      if (amount <= 0) {
                        return 'Amount must be greater than zero';
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
                  final amount = double.parse(_amountController.text);
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
    _amountController.dispose();
     _focusNode.dispose();
  });
}