import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

class InstallmentPayment extends StatefulWidget {
  const InstallmentPayment({super.key, required this.totalAmount,this.student,this.classes,this.product,this.material});
  final String totalAmount;
  final String? student;
final String? product;
final String? material;
final String? classes;
 
  @override
  _InstallmentPaymentState createState() => _InstallmentPaymentState();
}

class _InstallmentPaymentState extends State<InstallmentPayment> {
 
  String selectedFrequency = 'Weekly';
  DateTime startDate = DateTime.now();
  List<DateTime> paymentDates = [];

  final Map<String, Duration> frequencies = {
    'Weekly': const Duration(days: 7),
    'Monthly': const Duration(days: 30),
  };

  void generatePaymentDates() {
    paymentDates.clear();
    DateTime currentDate = startDate;

    while (currentDate.isBefore(startDate.add(const Duration(days: 90)))) {
      paymentDates.add(currentDate);
      currentDate = currentDate.add(frequencies[selectedFrequency]!);
    }

    if (paymentDates.last.isAfter(startDate.add(const Duration(days: 90)))) {
      paymentDates.removeLast();
    }
  }

  double calculateInstallmentAmount(double totalAmount) {
    return totalAmount / paymentDates.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Macye Macye'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Container(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                  onPressed: (){},
                  child:RichText(
  text: TextSpan(
    text: 'You are paying a per installement of ',
style: Theme.of(context).textTheme.titleMedium,
    children: <TextSpan>[
            TextSpan(
        text: '${widget.totalAmount} FRW ',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: kTextBlackColor,
              fontWeight: FontWeight.bold, // Regular weight for the rest of the text
            ),
      ),
            TextSpan(
        text: '  for ',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: kTextBlackColor,
          fontWeight: FontWeight.normal, )
      ),
      TextSpan(
        text: '${widget.product}, ${widget.material}.',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: kTextBlackColor,
              fontWeight: FontWeight.bold, // Regular weight for the rest of the text
            ),
      ),
         TextSpan(
        text: ' of Student ',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: kTextBlackColor,
          fontWeight: FontWeight.normal, )
      ),
          TextSpan(
        text: '${widget.student}, ${widget.classes}.',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: kTextBlackColor,
              fontWeight: FontWeight.bold, // Regular weight for the rest of the text
            ),
      ),
       TextSpan(
        text: '   for a period not exceding ',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: kTextBlackColor,
          fontWeight: FontWeight.normal, )
      ),
            TextSpan(
        text: 'three months.',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: kTextBlackColor,
              fontWeight: FontWeight.bold, // Regular weight for the rest of the text
            ),
      ),
    ],
  ),
)
),
            ),
            const Divider(),
        sizedBox10,
         Text('Select Installment Plan',
              style: Theme.of(context).textTheme.titleLarge
         ),
            sizedBox10,
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedFrequency,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFrequency = newValue!;
                      generatePaymentDates();
                    });
                  },
                  items: frequencies.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                
                  hint: const Text('select'),
                ), const SizedBox(width: 5,),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    generatePaymentDates();
                  });
                },
                child: const Text('Generate Payment Schedule',
                overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
              ],
            ),
         
            const SizedBox(height: 20),
            if (widget.totalAmount.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: paymentDates.length,
                  itemBuilder: (context, index) {
                    double installmentAmount = calculateInstallmentAmount(
                        double.parse(widget.totalAmount));
                    return ListTile(
                      title: Text(
                        'Macye Macye ${index + 1}: ${installmentAmount.toStringAsFixed(2)} RWF',
                      ),
                      subtitle: Text(
                        'Due Date: ${paymentDates[index].toLocal()}',
                      ),
                    );
                  },
                ),
              ),
                       DefaultButton2(
              color1: kamber300Color,
              color2: kyellowColor,
              onPress: () =>showSuccessDialog(context),
                  // Navigator.push(context,MaterialPageRoute(builder:(context)=> PaymentMethod(amountTotal: totalAmount,))),
              title: 'Apply',
              iconData: Icons.arrow_forward_outlined,
            ), 
          ],
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text("Payment Successful!"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              "Your payment was processed successfully.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Closes the dialog
            },
            child:  Text("OK",style: TextStyle(color: kTextBlackColor),),
          ),
        ],
      );
    },
  );
}

}

