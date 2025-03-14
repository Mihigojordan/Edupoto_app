
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/read_along.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';

class StoryLists extends StatelessWidget {
  const StoryLists({super.key});
  static const String routeName = 'StoryLists';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      appBar: AppBar(
        backgroundColor: kyellow800Color,
        title: const Text('Read along collection'),
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
      body: Column(
        children: [
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
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: dateSheet8.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: kDefaultPadding / 2,
                                right: kDefaultPadding / 2),
                            padding: const EdgeInsets.all(kDefaultPadding / 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //first need a row, then 3 columns
                                InkWell(
                                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>const ReadAlong())),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //1st column
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: SmallImages(
                                                  dateSheet8[index].images)),
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                      //2nd one
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              dateSheet8[index].subjectName,
                                              style: ktextBBlack,
                                              textAlign: TextAlign.left,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  dateSheet8[index]
                                                      .date
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          color:
                                                              kTextBlackColor,
                                                          fontSize: 8),
                                                ),
                                                sizedBox5,
                                                Text(dateSheet8[index].dayName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      //3rd one
                                      SizedBox(
                                          height: 2,
                                          width: 2,
                                          child: dateSheet8[index].icon),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),

                                const SizedBox(height: 3)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
}
