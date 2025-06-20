import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/school_requirement_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/input_fields/edupay/components/school_payments/component/payment_method.dart';

class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget(
      {super.key,required this.schoolId,required this.classId, required this.icon, required this.title, required this.schoolRequirementList,required this.isReqChecked});

  final String icon;
  final ClassDetails classId;
  final AllSchoolModel schoolId;
  final String title;
  final List<SchoolRequirementModel> schoolRequirementList;
  final List<bool> isReqChecked;

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  bool isSelected = false;
  double totalPrice = 0.0;
   double calculatedTotal = 0.0;
 String? totalAmounts;
  // VAT and Service charge percentages
  final double vatPercentage = 18.0; // Example VAT percentage
  final double serviceChargePercentage = 1.0; // Example service charge percentage
 final String data =
      'Amafaranga y’ishuri ,/School fees ni 65.500 Frw/ku gihembwe.\n'
      'Aya ni amafaranga y’ishuri akubiyemo ( Ramede papier ( Impapuro)),\n'
      'Indangamanota, Umukoro wo mu kiruhuko, Impapuro z’isuku ( Toilet papers)\n'
      'Ntamubyeyi zongera kubibazwa.\n'
      'Amafaranga y’ifunguro rya saa sita ni 13.000 Frw /ku kwezi.';

  // Method to calculate the total price
void calculateTotalPrice() {
  // Reset calculatedTotal to avoid adding multiple times
  calculatedTotal = 0.0;

  for (int i = 0; i < widget.schoolRequirementList.length; i++) {
    if (widget.isReqChecked[i]) {
      calculatedTotal += double.parse(widget.schoolRequirementList[i].price!) ?? 0.0; // Ensure price is not null
    }
  }

  setState(() {
    totalPrice = calculatedTotal;
  });
}


  double calculateVAT(double amount) {
    return (amount * vatPercentage) / 100;
  }

  double calculateServiceCharge(double amount) {
    return (amount * serviceChargePercentage) / 100;
  }

  double calculateTotal(double amount) {
    double vat = calculateVAT(calculatedTotal);
    double serviceCharge = calculateServiceCharge(calculatedTotal);
    return amount + vat + serviceCharge;
  }

 @override
  void initState() {
    // TODO: implement initState
    calculateTotalPrice();
   
    super.initState();
  }

  void selectedVale() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
   totalAmounts  =calculateTotal(double.parse('$calculatedTotal')).toStringAsFixed(2);
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3)),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: MediaQuery.of(context).size.height/1.3,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: selectedVale,
                child: RichText(
                  text: TextSpan(
                    text: 'You are paying School requirements for ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${widget.schoolId.schoolName} ${widget.classId.className} ',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
       
            const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice No:35963402',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  invoiceLists(schoolRequirementList:widget.schoolRequirementList,isReqChecked: widget.isReqChecked),
             sizedBox10,
                  Text('Amount: $totalPrice RWF'),
                  Text(
                      'VAT (${vatPercentage.toStringAsFixed(1)}%): ${calculateVAT(double.parse('$totalPrice')).toStringAsFixed(2)} RWF'),
                  Text(
                      'Service Charge (${serviceChargePercentage.toStringAsFixed(1)}%): ${calculateServiceCharge(double.parse('$totalPrice')).toStringAsFixed(2)} RWF'),
                  const Divider(),
                  Text(
                    'Total: $totalAmounts RWF',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            const SizedBox(height: 15),
          // DefaultButton2(
          //     color1: kamber300Color,
          //     color2: kyellowColor,
          //     onPress: () =>Get.to(PaymentMethod(amountTotal: totalAmounts!)),
          //     title: 'Next',
          //     iconData: Icons.arrow_forward_outlined,
          //   ),
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }



  Widget invoiceLists({required List<SchoolRequirementModel> schoolRequirementList,required List<bool> isReqChecked}){
  // Split the text into paragraphs
    // List<String> paragraphs = data.split('\n');
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radial icon
                Container(
                  margin: const EdgeInsets.only(right: 8, top: 6),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                // Text
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: schoolRequirementList.length,
                        itemBuilder: (context, index) {
                            
                          return ListTile(
                            leading: Checkbox(
                              value: isReqChecked[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  isReqChecked[index] = value!;
                                  calculateTotalPrice();
                                });
                              },
                            ),
                            title: Text('${schoolRequirementList[index].name!} ${schoolRequirementList[index].price!}'),
                          );
                        
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      );
  }

  Widget buildFormField(String label, TextEditingController controller,
      TextInputType keyboardType) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}