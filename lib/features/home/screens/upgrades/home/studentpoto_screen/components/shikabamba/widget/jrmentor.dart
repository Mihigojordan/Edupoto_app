
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';


class JrMentorWidget extends StatelessWidget {
  // const TeacherScreen({Key? key}) : super(key: key);
  static String routeName = 'JrMentorWidget';
  String dropdownvalue = '';

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

// List of items in our dropdown menu
  var items = [
    'Register',
  ];

  JrMentorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kyellow800Color,
        title: const Text('Issues'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: kTextWhiteColor,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: ktextBlack,
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  dropdownvalue = newValue!;
                  if (dropdownvalue == 'Register') {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection()));
                  } else if (dropdownvalue == 'Teacher Jobs') {
                    Navigator.pushNamed(context, NoConnection.routeName);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kTextWhiteColor,
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            color: kyellow800Color,
            width: MediaQuery.of(context).size.width,
            //  height: 40.h,
            // padding: EdgeInsets.all(kDefaultPadding),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard3(
                        onPress: () {},
                        icon: 'Read along with\nTwiga normal text',
                        title: '',
                        clas: '',
                        height: 12,
                        width: 0),
                    sizedBox,
                    HomeCard3(
                        onPress: () {},
                        icon: 'PDF version',
                        title: '',
                        clas: '',
                        height: 12,
                        width: 0),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(color: kamber300Color),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      controller: emailEditingController,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: const InputDecoration(
        labelText: 'Student ID',
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
              //  color: kTextLightColor,
              border: Border.all(
                color: kTextBlackColor, //                   <--- border color
                width: 1.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: MediaQuery.of(context).size.height / height,
          width: MediaQuery.of(context).size.width / width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Text(
                 icon,
                textAlign: TextAlign.center,
               
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: kTextBlackColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
