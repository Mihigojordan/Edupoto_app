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