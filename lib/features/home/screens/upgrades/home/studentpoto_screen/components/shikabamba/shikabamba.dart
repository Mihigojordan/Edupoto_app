import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/shikabamba_cmt.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';
import 'package:sizer/sizer.dart';

class Shikabamba extends StatelessWidget {
  const Shikabamba({super.key});
  static const String routeName = 'Shikabamba';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      appBar: AppBar(
        title: const Text('Shikabamba 5'),
        backgroundColor: kyellow800Color,
        actions: [
          InkWell(
            onTap: () {
              //send report to school management, in case if you want some changes to your profile
            },
            child: Container(
              padding: const EdgeInsets.only(
                  right: kDefaultPadding / 1, left: kDefaultPadding / 1),
              child: const Row(
                children: [
                  Icon(Icons.more_vert_outlined),
                ],
              ),
            ),
          ),
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
            itemCount: dateSheet5.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(
                    left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //first need a row, then 3 columns
                    InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>const ShikabambaCmt()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //1st column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 12,
                                  width:
                                      MediaQuery.of(context).size.height / 10,
                                  child: SmallImages(dateSheet5[index].images)),
                            ],
                          ),

                          //2nd one

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateSheet5[index].subjectName,
                                  // overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: kTextBlackColor,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dateSheet5[index].date.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            color: kTextBlackColor,
                                            // fontWeight: FontWeight.w900,
                                            fontSize: 8.sp,
                                          ),
                                    ),
                                    Text(dateSheet5[index].dayName,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //3rd one
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                      child: const Divider(
                        thickness: 1.0,
                      ),
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
