
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:hosomobile/util/images.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_pm_account.dart';

class PocketmoneyCard extends StatefulWidget {
  static String routeName = 'PocketmoneyCard';

  const PocketmoneyCard({super.key});

  @override
  _PocketmoneyCardState createState() => _PocketmoneyCardState();
}

class _PocketmoneyCardState extends State<PocketmoneyCard> {
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

  bool? isUserLoggedIn = false;

  showDetails() async {
  }

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
    return UpgradeAlert(
        child: Scaffold(
      backgroundColor: kOtherColor,
      // drawer: NavDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40.h,
                width: 100.w,
                color: kyellowColor,
                child: Stack(
                  children: [
                    const ImagesUp(Images.launch_page),
              Positioned(left:30,right:30,top:8.h,child: const SizedBox(height: 40,width:120,child: IconImages('assets/icons1/Pocket Money.png'),)),
                Positioned(right:10,top:12.h,child: Row(
                children: [
                  Text('Add Account',style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize:14,color:Colors.black,fontWeight:FontWeight.bold),),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AddPmAccount.routeName),
                    child: const CircleAvatar(radius: 18,
      backgroundColor: kTextWhiteColor,child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.add,color: Colors.black,size: 25,),
                    ),
                    ),
                  ),
                ],
              ))
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
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
                    ),
                  
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 20.h,
              left: 8.w,
              right: 8.w,
              child: const HomeCard1(
                  icon: 'assets/icons1/edupotoERP.png',
                  title: 'title',
                  clas: 'clas')),
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
            width: MediaQuery.of(context).size.width / 7,
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
      {super.key, required this.icon, required this.title, required this.clas});

  final String icon;
  final String title;
  final String clas;
  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  String studentCardValue='Choose student\'s card to fund';

 TextEditingController cardEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  showDetails() async {
  }

  @override
  void initState() {
    // TODO: implement initState
    showDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fund your child\'s pocket Money Card',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
            const SizedBox(height: 40,),
            
          //  buildFormField(  'Choose student\'s card to fund',cardEditingController,TextInputType.text,),
          DropDown(onChanged: (onChanged){
            setState(() {
              studentCardValue=onChanged!;
            });
          }, itemLists: const [
    {'name': 'Esseh Nankinga(Ndejje SSS)', 'none': ''},
    {'name': 'Elaine Nalweyiso(Kuteezi Learning Centre)', 'none': ''}
]
, title: studentCardValue, isExpanded: true),
            sizedBox15,
             buildFormField(  'Enter Funding phone number',numberEditingController,TextInputType.number,),
             sizedBox15,
              buildFormField(  'Enter amount',amountEditingController,TextInputType.number,),
              const Spacer(),
                             DefaultButton2(
                      color1: kamber300Color,
                      color2: kyellowColor,
                      onPress: ()=>_launchURL('tel:*182*1*1*0795922165*${amountEditingController.text}#'),
                      title: 'PAY',
                      iconData: Icons.arrow_forward_outlined,
                    ),
              sizedBox10,
              Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, NoConnection.routeName),
            child: const Column(children: [
            Icon(Icons.person,color: kgrey800Color,),
            Text('Beneficiary Profile',style: ktextGrey,)
            ],),
          ),
          InkWell(
            onTap: ()=>Navigator.pushNamed(context, NoConnection.routeName),
            child: const Column(children: [
            Icon(Icons.description,color: kgrey800Color,),
            Text('Transactions',style: ktextGrey,)
            ],),
          )
            ],),
          ),
          sizedBox10,
          ],
        ),
      ),
    );
  }
TextFormField buildFormField(String labelText,TextEditingController editingController,TextInputType textInputType){
    return TextFormField(
      textAlign: TextAlign.start,
      controller: editingController,
      keyboardType: textInputType,
      style: kInputTextStyle,

      decoration: InputDecoration(
             contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal: 15), //Change this value to custom as you like
    isDense: true, 
        focusedBorder: OutlineInputBorder( 
       ////<-- SEE HERE
      borderSide: const BorderSide(
          width: 1, color: kamber300Color), 
          borderRadius: BorderRadius.circular(20.0),
    ),

    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1, color: kTextLightColor),
          borderRadius: BorderRadius.circular(20.0),
            
    ), 

    errorBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: const BorderSide(
          width: 1, color: Colors.redAccent), 
        borderRadius: BorderRadius.circular(20.0),  
     //<-- SEE HERE
    ),
     
 
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        // RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
        //  else if (!regExp.hasMatch(value)) {
        //   return 'Please enter a valid Email';
        // }
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
        ? Container(height:20.h,color:kTextLightColor.withOpacity(0.7), child: const Center(child: CircularProgressIndicator()))

        : CarouselSlider.builder(
            options: CarouselOptions(
              height: 20.h,
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

              return orderLists[index]==[]?SizedBox(height:20.h,child:const Center(child:Text('No Ads for now',style: ktextLight,),)):FadeInImage.assetNetwork(
                image:orderLists[index]['ads_banner']==null?"https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg":
                    "https://roya.shulepoto.cloud/storage/ads_banner/${orderLists[index]['ads_banner']}",

                placeholder: "assets/icons1/noads.webp", // your assets image path
                fit: BoxFit.fill,
              );
            },
          );
  }
   
}
