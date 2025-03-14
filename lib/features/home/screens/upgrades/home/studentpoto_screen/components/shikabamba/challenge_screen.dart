
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/challenge_accept.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/youtube_player/youtube_player.dart';


class ChallengeScreen extends StatelessWidget {
//  const ChallengeScreen({Key? key}) : super(key: key);
  static String routeName = 'ChallengeScreen';
 final String dropdownvalue = '';

// List of items in our dropdown menu
  var items = [
    'Register',
  ];

  ChallengeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          Container(
            color: const Color(0xFF1b4922),
            width: MediaQuery.of(context).size.width,
            height: 200,
            // padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.end,
              children: [
                sizedBox,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: const IconImages('assets/icons1/CHALLENGE BAR.png'),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: const IconImages('assets/icons1/tax speech.png'),
                ),
                sizedBox,
              ],
            ),
          ),

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              color:const Color(0xFF1b4922),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: const BoxDecoration(
                  color: kOtherColor,
                  borderRadius: kTopBorderRadius,
                ),
                child: SingleChildScrollView(
                  //for padding
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      sizedBox,
                      HomeCard2(
                        onPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChallengeAccept()));
                        },
                        icon: 'assets/icons1/Twiga logo.png',
                        title: 'Competition Registration',
                      ),
                      const SizedBox(
                        height: 2,
                        child: Divider(
                          thickness: 1.0,
                          color: kTextSblackColor,
                        ),
                      ),
                      HomeCard2(
                        onPress: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const YoutubePlayerWidget()));
                        },
                        icon: 'assets/icons1/Twiga logo.png',
                        title: 'See what other Learners are doing',
                      ),
                      const SizedBox(
                        height: 2,
                        child: Divider(
                          thickness: 1.0,
                          color: kTextSblackColor,
                        ),
                      ),
                      HomeCard2(
                        onPress: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const YoutubePlayerWidget()));
                        },
                        icon: 'assets/icons1/Twiga logo.png',
                        title: 'See previous challenges',
                      ),
                      const SizedBox(
                        height: 2,
                        child: Divider(
                          thickness: 1.0,
                          color: kTextSblackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
  const HomeCard2(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title});
  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 7,
              child: IconImages(icon),
            ),
          ),
          const SizedBox(
            height: 8,
            child: VerticalDivider(
              color: kTextLightColor,
              thickness: 1,
            ),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: kTextBlackColor),
          )
        ],
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
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 65),
          child: IconImages(icon),
        ),
      ),
    );
  }
}
