import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_app_bar.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/upload_story.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';

class SrMentor extends StatelessWidget {
  // const TeacherScreen({Key? key}) : super(key: key);
  static String routeName = 'SrMentor';
  String dropdownvalue = '';

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  String dropdownvalues = '';
// List of items in our dropdown menu
  var items = [
    'Register',
  ];

  SrMentor({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
            color: kyellow800Color,
            onChanged: (valueChange) {
              dropdownvalues = valueChange!;
              if (dropdownvalues == 'Upload story') {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const UploadStory()));
              } else if (dropdownvalues == 'My Profile') {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection()));
              } else if (dropdownvalues == 'Register') {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection()));
              }
            },
            itemLists: const ['Register', 'My Profile', 'Upload story'],
            title: 'Sr Mentor'),
      ),
      backgroundColor: kTextWhiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              //we will divide the screen into two parts
              //fixed height for first half
              Container(
                color: kyellow800Color,
                width: MediaQuery.of(context).size.width,
                height: 200,
                // padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Welcome to',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: const IconImages('assets/icons1/SRMENTOR.png'),
                    ),
                    sizedBox
                  ],
                ),
              ),

              //other will use all the remaining height of screen
              Expanded(
                child: Container(
                  color: kyellow800Color,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: kOtherColor,
                      borderRadius: kTopBorderRadius,
                    ),
                    child: SingleChildScrollView(
                      //for padding
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildEmailField(),
                              ),
                              // SizedBox(
                              //   height: 10.h,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10.0,
            left: 11.0,
            right: 11.0,
            child: DefaultButton2(
              onPress: () =>
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection())),
              title: 'NEXT',
              iconData: Icons.arrow_forward_outlined,
              color1: kyellow800Color,
              color2: kamber300Color,
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNav(color: kamber300Color),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: emailEditingController,
      cursorColor: kTextBlackColor,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'Student ID',
        // labelStyle: TextStyle(color: kTextBlackColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        RegExp regExp = RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Please enter some value';
          //if it does not matches the pattern, like
          //it not contains @
        }
        return null;
      },
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.onPress,
    required this.icon,
  });
  final VoidCallback onPress;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 17,
        width: MediaQuery.of(context).size.width / 2.1,
        child: IconImages(icon),
      ),
    );
  }
}

class HomeCard2 extends StatelessWidget {
  const HomeCard2({
    super.key,
    required this.onPress,
    required this.icon,
  });
  final VoidCallback onPress;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width / 2.1,
        child: IconImages(icon),
      ),
    );
  }
}

class HomeCard3 extends StatelessWidget {
  const HomeCard3(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.clas,
      required this.height,
      required this.width});
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String clas;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            //  color: kTextLightColor,
            border: Border.all(
              color: kTextWhiteColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 50),
          child: IconImages(icon),
        ),
      ),
    );
  }
}
