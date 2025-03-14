
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/story_lists.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';


class SrCategories extends StatelessWidget {
  const SrCategories({super.key});
  static const String routeName = 'SrCategories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOtherColor,
      appBar: AppBar(
        title: const Text('Categories'),
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
            itemCount: srCategory.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(
                    left: kDefaultPadding / 2, right: kDefaultPadding / 2),
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, StoryLists.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //first need a row, then 3 columns
                      Text(
                        srCategory[index],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: kTextBlackColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 10),
                      ),
                       SizedBox(
                        height: 3,
                        child: Divider(
                          thickness: 1.0,
                          color: kTextBlackColor,
                        ),
                      ),
                    ],
                  ),
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
