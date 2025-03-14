import 'package:flutter/material.dart';
import 'package:hosomobile/common/widgets/invoice_widget.dart';
import 'package:hosomobile/features/home/domain/models/all_school_model.dart';
import 'package:hosomobile/features/home/domain/models/school_requirement_model.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

import 'package:upgrader/upgrader.dart';

class PaymentInvoice extends StatefulWidget {
  static String routeName = 'PaymentInvoice';
  const PaymentInvoice({super.key,required this.schoolId,required this.classId, required this.schoolRequirementList, required this.isReqChecked});
final List <SchoolRequirementModel>schoolRequirementList; 
final List<bool>isReqChecked;
final AllSchoolModel schoolId;
final ClassDetails classId;

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentInvoice> {
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


  @override
  void initState() {
    // TODO: implement initState
    // _checkVersion();

    showDetails();
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
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: kyellowColor,
                child:const Stack(
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
                                    height:50,
                                    width:150,
                                    child:IconImages('assets/image/edubox.png')
                                  ),
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
              top:150,
              left: 20,
              right: 20,
              child: InvoiceWidget(
                schoolId:widget.schoolId,
                classId: widget.classId,
                  icon: 'assets/icons1/edupotoERP.png',
                  title: 'title',
                  schoolRequirementList: widget.schoolRequirementList,
                  isReqChecked: widget.isReqChecked,
                  )),
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






