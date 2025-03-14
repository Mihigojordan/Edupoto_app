
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';


class ReadPdf extends StatelessWidget {
  const ReadPdf({super.key});
  static const String routeName = 'ReadPdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOtherColor,
      appBar: AppBar(
        title: const Text('Read Pdf'),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection()));
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
                                      MediaQuery.of(context).size.height / 14,
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: IconImages(dateSheet7[index].time)),
                            ],
                          ),
                          const SizedBox(width: 5),
                          //2nd one

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateSheet7[index].subjectName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: kTextBlackColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 10),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dateSheet7[index].date.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: kTextBlackColor,
                                              fontSize: 8),
                                    ),
                                    sizedBox5,
                                    Text(dateSheet7[index].dayName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          //3rd one
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
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
