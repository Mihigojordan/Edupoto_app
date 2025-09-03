
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/drop_down.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:hosomobile/util/images.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Edupay extends StatelessWidget { 
  static String  routeName='Edupay';

  const Edupay({super.key});
  @override  
  Widget build(BuildContext context) {  

return  Scaffold(
      backgroundColor: kOtherColor,
      
      
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40.h,
                width: 100.w,
                color: kyellowColor,
                child: const Stack(
                  children: [
                    ImagesUp(Images.launch_page),
             // Positioned(left:120,right:120,top:8.h,child: SizedBox(height: 40,width:60,child: IconImages('assets/icons1/TEREKA OSOME logo.png'),))
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

class _HomeCard1State extends State<HomeCard1>with TickerProviderStateMixin {
  bool? isTeacherLoggedIn = false;
  bool? isParentLoggedIn = false;
  bool? isUserLoggedIn = false;
  
  String productValue='I want to subscribe for';
  String monthsValue='For the month of';
  String ourpartnerValue='Choose school fees payment partner';


 TextEditingController cardEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
 TextEditingController productEditingController = TextEditingController();

 late TabController _controller;
@override
  initState()
{
    _controller = TabController(vsync: this, length: 2);
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
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
          TabBar(  
              controller:_controller,
                indicatorColor: kamber300Color,
  labelColor: Colors.black,
  unselectedLabelColor: Colors.grey,
              tabs: const [  
                Tab( text: "School Fees"),  
                Tab(text: "Subscriptions")  
              ],  
            ),
            sizedBox15,
        SizedBox(height:52.h,child:    TabBarView(  
            controller: _controller,
            children: [  
              feesField(),  
              subscriptionsField(),  
            ],  
          ), ),
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

Widget feesField(){
  return Column(
    children:
    [
      DropDown(onChanged: (value){setState(() {
             ourpartnerValue=value!;
           });}, itemLists:const [{'name':'Stanbic Bank'}], title: ourpartnerValue, isExpanded: true), 
         
 
              
              const Spacer(),
                     DefaultButton2(
                      color1: kamber300Color,
                      color2: kyellowColor,
                      onPress: ()=>Navigator.pushNamed(context, NoConnection.routeName),
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
    ]
  );
}
Widget subscriptionsField(){
  return Column(
    children:
    [
       DropDown(onChanged: (value){setState(() {
             productValue=value!;
           });}, itemLists: const [
    {'name': 'JrMentor Magazine', 'none': ''},
    {'name': 'Bingwa Kids Magazine', 'none': ''},
    {'name': 'SrMentor', 'none': ''}
]
, title: productValue, isExpanded: true), 
           sizedBox15,
           
                DropDown(onChanged: (value){setState(() {
             monthsValue=value!;
           });}, itemLists: const [
    {'name': 'January', 'none': ''},
    {'name': 'February', 'none': ''},
    {'name': 'March', 'none': ''},
    {'name': 'April', 'none': ''},
    {'name': 'May', 'none': ''},
    {'name': 'June', 'none': ''},
    {'name': 'July', 'none': ''},
    {'name': 'August', 'none': ''},
    {'name': 'September', 'none': ''},
    {'name': 'October', 'none': ''},
    {'name': 'November', 'none': ''},
    {'name': 'December', 'none': ''}
]
, title: monthsValue, isExpanded: true), 
            sizedBox15,
             buildFormField(  'Amount to be paid',numberEditingController,TextInputType.number,),
             sizedBox15,
              buildFormField(  'Enter paying phone number',amountEditingController,TextInputType.number,),
              
              const Spacer(),
                     DefaultButton2(
                      color1: kamber300Color,
                      color2: kyellowColor,
                      onPress: ()=>Navigator.pushNamed(context, NoConnection.routeName),
                      title: 'NEXT',
                      iconData: Icons.arrow_forward_outlined,
                    ),
              
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
    ]
  );
}
}


