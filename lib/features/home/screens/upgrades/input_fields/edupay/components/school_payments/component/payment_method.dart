import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/domain/models/edubox_material_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school/domain/models/school_list_model.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentMethod extends StatefulWidget {
  static String routeName = 'PaymentMethod';
  PaymentMethod(
      {super.key,
      required this.amountTotal,
      required this.studentName,
      required this.studentCode,
      this.material,
      this.product,
      this.parent,
      required this.className,
      required this.schoolName});
  final String amountTotal;
  final String studentName;
  final String studentCode;
  String? product;
  List<EduboxMaterialModel>? material;
  final String className;
  final String schoolName;
  String? parent;
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  late String videoTitle;
  // Url List
  final List<String> _videoUrlList = [
    'https://youtu.be/dWs3dzj4Wng',
    'https://www.youtube.com/watch?v=668nUCeBHyY',
    '8ElxB_w0Bk0',
    'https://youtu.be/S3npWREXr8s',
  ];

  Map<String, dynamic> cStates = {};
  //changes current state

  bool? isUserLoggedIn = false;

  showDetails() async {}

  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.BsT7.edupoto",
  //   );
  //   final  status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status!,
  //     dialogTitle: "UPDATE!!!",
  //     dismissButtonText: "Skip",
  //     dialogText: "Please update the app from " +
  //         "${status.localVersion}" +
  //         " to " +
  //         "${status.storeVersion}",
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "Lets update",
  //   );

  //   print("DEVICE : " + status.localVersion);
  //   print("STORE : " + status.storeVersion);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _checkVersion();

    showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return UpgradeAlert(
        child: Scaffold(
      backgroundColor: kOtherColor,
      // drawer: NavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight / 3,
                width: screenWidth,
                color: kyellowColor,
                child: Stack(
                  children: [
                    // SizedBox(
                    //   // height: 0,
                    //   child: ImagesUp(Images.launch_page),
                    // ),
                    Column(
                      children: [
                        sizedBox,
                        sizedBox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: screenHeight >= 700 ? 40 : 35,
                                width: screenHeight >= 700 ? 180 : 160,
                                child: const IconImages(
                                    'assets/image/HOSO MOBILE.png')),
                          ],
                        ),
                      ],
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
          Positioned(
              top: 150,
              left: 20,
              right: 20,
              child: HomeCard1(
                  icon: 'icon',
                  parent: 'Parent',
                  studentName: widget.studentName,
                  studentCode: widget.studentCode,
                  schoolName: widget.schoolName,
                  className: widget.className,
                  material: widget.material!,
                  product: widget.product!,
                  amount: widget.amountTotal)),
        ],
      ),

      //   bottomNavigationBar: BottomNav(
      //   color: kamber300Color,
      // ),
    ));
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.clas});
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: kTextWhiteColor, //                   <--- border color
                width: 1.0,
              ),
            ),
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ButtonImages(icon),
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: ktextWhite,
          )
        ],
      ),
    );
  }
}

class HomeCard1 extends StatefulWidget {
  const HomeCard1(
      {super.key,
      required this.icon,
      required this.parent,
      required this.studentName,
      required this.studentCode,
      required this.className,
      required this.schoolName,
      required this.material,
      required this.product,
      required this.amount});

  final String icon;
  final String parent;
  final String studentName;
  final String product;
  final List<EduboxMaterialModel> material;
  final String schoolName;
  final String studentCode;
  final String className;
  final String amount;
  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  String studentCardValue = 'Choose from a list of partiner school';
  String classValue = 'Choose your Bank';
  bool isSelected = false;
  String selectedFrequency = 'Daily';
  DateTime startDate = DateTime.now();
  List<DateTime> paymentDates = [];

  TextEditingController classEditingController = TextEditingController();
  TextEditingController cardEditingController = TextEditingController();
  TextEditingController dayEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController schoolNameEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDetails() async {}
  selectedVale() {
    setState(() {
      isSelected = !isSelected;
      print(isSelected);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    showDetails();
    super.initState();
  }

  final Map<String, Duration> frequencies = {
    'Daily': const Duration(days: 1),
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
    return Form(
      key:_formKey,
      child: Container(
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
        height: MediaQuery.of(context).size.height / 1.5,
        width: 340,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                    onPressed: () => selectedVale(),
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Dear ${widget.parent} You are requesting credit facility',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: <TextSpan>[
                                TextSpan(
                            text: ' of ${widget.amount} FRW ',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold, // Regular weight for the rest of the text
                                ),
                          ),
                     
                          TextSpan(
                              text: '  for  ${widget.product},',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                                  TextSpan(
                              text: '  Contain  ${widget.material.length} Materials,',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )), 
                                    
                          TextSpan(
                            text:
                                ' for student: Code:${widget.studentCode} Name:${widget.studentName}, (Class:${widget.className} School:${widget.schoolName})',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .w500, // Regular weight for the rest of the text
                                    ),
                          ),
                        ],
                      ),
                    )),
              ),
                  // Wrap(
                  //                   spacing: 8.0, // Horizontal space between items
                  //                   runSpacing: 4.0, // Vertical space between lines
                  //                   children: widget.material.map((entry) {
                  //                     final product = entry;
                  //                     final quantity = entry;
                  //                     return Text(
                  //                       '${product.transactionId} (${product.amount} RWF) x $quantity, ',
                  //                     );
                  //                   }).toList(),
                  //                 ),
              sizedBox10,
              DropDownPayment(
                  onChanged: (onChanged) {
                    setState(() {
                      classValue = onChanged!;
                    });
                  },
                  itemLists: const [
                    {'no': '1', 'name': 'BK'},
                    {'no': '2', 'name': 'EQUITY BANK'},
                    {'no': '3', 'name': 'UMWALIMU SACCO'},
                    {'no': '4', 'name': 'MUGANGA SACCO'},
                    {'no': '5', 'name': 'ZIGAMA CSS'},
                    {'no': '6', 'name': 'GASABO DISTRICT SACCO'},
                    {'no': '7', 'name': 'KICUKIRO DISTRICT SACCO '},
                    {'no': '8', 'name': 'NYARUGENGE DISTRICT SACCO'},
                    {'no': '9', 'name': 'UMURENGE SACCO'},
                  ],
                  title: classValue,
                  isExpanded: true),
              sizedBox10,
              buildFormField(
                'Enter Account Number',
                cardEditingController,
                TextInputType.text,
              ),
              sizedBox10,
              buildFormField(
                'Enter National ID Number',
                cardEditingController,
                TextInputType.text,
              ),
              sizedBox10,
              Text('Select Installment Plan',
                  style: Theme.of(context).textTheme.titleLarge),
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
                    items: frequencies.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('select'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          generatePaymentDates();
                        });
                      },
                      child: const Text(
                        'Generate Payment Schedule',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DefaultButton2(
                color1: kamber300Color,
                color2: kyellowColor,
                onPress: () => showSuccessDialog(context),
                title: 'REQUEST',
                iconData: Icons.arrow_forward_outlined,
              ),
              if (widget.amount.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: paymentDates.length,
                    itemBuilder: (context, index) {
                      double installmentAmount =
                          calculateInstallmentAmount(double.parse(widget.amount));
                      return ListTile(
                        title: Text(
                          'Installment ${index + 1}: ${installmentAmount.toStringAsFixed(2)} RWF',
                        ),
                        subtitle: Text(
                          'Due Date: ${paymentDates[index].toLocal()}',
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildFormField(String labelText,
      TextEditingController editingController, TextInputType textInputType) {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      keyboardType: textInputType,
      style: kInputTextStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13, horizontal: 15), // Customize as needed
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kamber300Color),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: kTextLightColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Request Successful!"),
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
                "Your request was processed successfully.",
                textAlign: TextAlign.center,
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

  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HomeCard2 extends StatefulWidget {
  const HomeCard2({
    super.key,
  });

  @override
  State<HomeCard2> createState() => _HomeCard2State();
}

class _HomeCard2State extends State<HomeCard2> {
  List orderLists = [], announcement = [];
  bool isLoading = false;
  var getUserId;

  Future listOrder() async {
    var url = 'https://roya.shulepoto.cloud/api/ads';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        orderLists = json.decode(response.body)['ads'];
        isLoading = true;
      });
      print('wayaa: $orderLists');
    } else {
      print('fail');
    }
  }

  @override
  void initState() {
    listOrder();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? Container(
            height: MediaQuery.of(context).size.height / 3,
            color: kTextLightColor.withOpacity(0.7),
            child: const Center(child: CircularProgressIndicator()))
        : CarouselSlider.builder(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 3,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              initialPage: 1,
            ),
            itemCount: orderLists.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              return orderLists[index] == []
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Center(
                        child: Text(
                          'No Ads for now',
                          style: ktextLight,
                        ),
                      ))
                  : FadeInImage.assetNetwork(
                      image: orderLists[index]['ads_banner'] == null
                          ? "https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg"
                          : "https://roya.shulepoto.cloud/storage/ads_banner/${orderLists[index]['ads_banner']}",

                      placeholder:
                          "assets/icons1/noads.webp", // your assets image path
                      fit: BoxFit.fill,
                    );
            },
          );
  }
}
