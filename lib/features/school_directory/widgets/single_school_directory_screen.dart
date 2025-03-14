import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/models/contact_model.dart';
import 'package:hosomobile/common/widgets/custom_back_button_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/school_directory/widgets/single_school_selection.dart';
import 'package:hosomobile/features/transaction_money/controllers/contact_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SingleSchoolDirectoryScreen extends StatefulWidget {
  static String routeName = 'SingleSchoolDirectoryScreen';
  final String  title;
  const SingleSchoolDirectoryScreen({super.key, required this.title});

  @override
  SchoolDirectoryScreenState createState() => SchoolDirectoryScreenState();
}

class SchoolDirectoryScreenState extends State<SingleSchoolDirectoryScreen> {
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
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};


  @override
  void initState() {
    // TODO: implement initState
    // _checkVersion();

    // showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
        child: Scaffold(
      backgroundColor: kOtherColor,
      // drawer: NavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                color: kyellowColor,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:50),
                          child: RichText(
                                                    text: TextSpan(
                                                      text: widget.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                      
                                                    ),
                                                  ),
                        ),
                      ],
                    ),
       
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kamber300Color,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height,
                    //   padding: EdgeInsets.symmetric(vertical: 5),
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
       const       Positioned(
      top:10,
         left:10,

            child:CustomBackButton(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: 20,
            right: 20,
            child: HomeCard1(
                phoneNumber: 'assets/icons1/edupotoERP.png',
                title: widget.title,
                fromEdit: false),
          ),
        ],
      ),

      //   bottomNavigationBar: BottomNav(
      //   color: kamber300Color,
      // ),
    ));
  }
}



class HomeCard1 extends StatefulWidget {
  const HomeCard1(
      {super.key,
      required this.phoneNumber,
      required this.title,
      required this.fromEdit});

  final String phoneNumber;
  final String title;
  final bool? fromEdit;
  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;

  String? phoneNumber;
  String studentcardValue = 'Choose student\'s card to fund';
  String productValue = 'Choose product to save for';
  String transactionType = 'add_money';
  final TextEditingController _inputAmountController = TextEditingController();
  String? _selectedMethodId;

  final Map<String?, TextEditingController> _textControllers = {};
  final Map<String?, TextEditingController> _gridTextController = {};

  late ContactController contactController;
  TextEditingController cardEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController productEditingController = TextEditingController();
  ContactModel? _contact;


  @override
  void initState() {
    final ContactController contactController = Get.find<ContactController>();

    // _countryCode = CountryCode.fromCountryCode(
    //         Get.find<SplashController>().configModel!.country!)
    //     .dialCode;

    contactController.onSearchContact(searchTerm: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
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
      height: MediaQuery.of(context).size.height/1.3,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.title=='Headteacher Messages'?headteacherMessage(context):
    widget.title=='School Burser'?schoolBurser(context):
    widget.title=='School Requirements'?schoolBurser(context):
    widget.title=='School Prospectus'? schoolProspectus(context): 
    widget.title=='School News'? schoolNews(context):
    widget.title=='Admissions'? schoolAdmissions(context):
    widget.title=='Download'? schoolDownloads(context):
  const  Text('No Data Available'),),);
  }
 


}

