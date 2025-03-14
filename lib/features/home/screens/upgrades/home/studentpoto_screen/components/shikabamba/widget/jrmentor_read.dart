
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/jr_categories.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/read_pdf.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';


class JrMentorRead extends StatelessWidget {
  const JrMentorRead({super.key});
  static const String routeName = 'JrMentorRead';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOtherColor,
      appBar: AppBar(
        title: const Text('JrMentor read'),
        backgroundColor: kyellow800Color,
        actions: const [
          // InkWell(
          //   onTap: () {
          //     //send report to school management, in case if you want some changes to your profile
          //   },
          //   child: Container(
          //     padding: EdgeInsets.only(right: kDefaultPadding / 2),
          //     child: Row(
          //       children: [
          //         Icon(Icons.upload),
          //         kHalfWidthSizedBox,
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Container(
        color: kyellow800Color,
        child: Container(
          // width: 100.w,
          decoration: const BoxDecoration(
            color: kOtherColor,
            borderRadius: kTopBorderRadius,
          ),
          child: ListView.builder(
            itemCount: dateSheet7.length,
            itemBuilder: (context, index) {
              return Container(
                // margin: EdgeInsets.only(
                //     left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //first need a row, then 3 columns
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 80,
                                width: MediaQuery.of(context).size.width/5,
                                child: IconImages(dateSheet7[index].dayName)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  // width:
                                  //     MediaQuery.of(context).size.width / 4.0,
                                  child: Text(
                                    dateSheet7[index].subjectName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: kTextBlackColor),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HomeCard3(
                                        onPress: () {
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>const JrCategories()));
                                        },
                                        icon:
                                            'Listen and Read along with Twiga',
                                        title: '',
                                        clas: '',
                                        height: 18,
                                        width: 3),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    HomeCard3(
                                        onPress: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReadPdf()));
                                        },
                                        icon: 'Read PDF Version',
                                        title: '',
                                        clas: '',
                                        height: 18,
                                        width: 3),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                         SizedBox(
                          height: 2,
                          child: Divider(
                            thickness: 1.0,
                            color: kTextBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(color: kamber300Color),
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
              color: kTextBlackColor, //                   <--- border color
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
          child: Center(
            child: Text(
              icon,
              style: ktextBlack,
            ),
          ),
        ),
      ),
    );
  }
}
