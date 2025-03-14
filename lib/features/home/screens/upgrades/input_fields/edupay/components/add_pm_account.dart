
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/util/images.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class AddPmAccount extends StatefulWidget {
  static String routeName = 'AddPmAccount';

  const AddPmAccount({super.key});

  @override
  _AddPmAccountState createState() => _AddPmAccountState();
}

class _AddPmAccountState extends State<AddPmAccount> {
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
              Positioned(left:30,right:30,top:8.h,child: const SizedBox(height: 40,width:120,child: IconImages(Images.page_logo)))
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
  bool isSelected=false;
  String studentCardValue='Choose from a list of partiner school';
  String classValue='Class';

 TextEditingController classEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController dayEditingController = TextEditingController();
   TextEditingController nameEditingController = TextEditingController();
TextEditingController schoolNameEditingController=TextEditingController();
  showDetails() async {

  }

selectedValue(){
  setState(() {
    isSelected=!isSelected;
  });
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
        child: ListView(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  Text('Fund your child\'s pocket Money Card',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kTextBlackColor,fontSize: 14,fontWeight: FontWeight.bold),),
             Container(
        alignment: Alignment.bottomLeft,
         child: TextButton(
          
          onPressed:()=>selectedValue(),child: Text('Click to Enter your School',textAlign:TextAlign.left, style: Theme.of(context).textTheme.titleSmall!.copyWith(decoration:TextDecoration.underline, color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
       ),
            
          //  buildFormField(  'Choose student\'s card to fund',cardEditingController,TextInputType.text,),
          !isSelected?DropDown(onChanged: (onChanged){
            setState(() {
              studentCardValue=onChanged!;
            });
          }, itemLists: participantLists, title: studentCardValue, isExpanded: true): buildFormField(  'Enter your School Name',schoolNameEditingController,TextInputType.name,),
            sizedBox15,
             buildFormField(  'Student Name',nameEditingController,TextInputType.name,),
             sizedBox15,
              buildFormField(  'Student Card Number',numberEditingController,TextInputType.number,),
                sizedBox15,
               DropDown(onChanged: (onChanged){
            setState(() {
              classValue=onChanged!;
            });
          }, itemLists: const [
    {'name': 'Std I', 'none': ''},
    {'name': 'Std II', 'none': ''},
    {'name': 'Std III', 'none': ''},
    {'name': 'Std IV', 'none': ''},
    {'name': 'Std V', 'none': ''},
    {'name': 'Std VI', 'none': ''},
    {'name': 'Std VII', 'none': ''},
    {'name': 'Std VIII', 'none': ''},
    {'name': 'Form I', 'none': ''},
    {'name': 'Form II', 'none': ''},
    {'name': 'Form III', 'none': ''},
    {'name': 'Form IV', 'none': ''}
]
, title: classValue, isExpanded: true),
                sizedBox15,
              buildFormField(  'Student Birthday',dayEditingController,TextInputType.text,),
         sizedBox15,
                             DefaultButton2(
                      color1: kamber300Color,
                      color2: kyellowColor,
                      onPress: (){}, //Navigator.push(context,MaterialPageRoute(builder:(context)=> const SingleSchool())),
                      title: 'NEXT',
                      iconData: Icons.arrow_forward_outlined,
                    ),
        
         const SizedBox(height: 200,)
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
