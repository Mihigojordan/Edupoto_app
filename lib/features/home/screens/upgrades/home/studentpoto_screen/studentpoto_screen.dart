
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_app_bar.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/challenge_screen.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/jrmentor.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/srmentor.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/upload_story.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';

late bool _passwordVisible;
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
String dropdownvalues = '';

class StudentpotoScreen extends StatefulWidget {
  static String routeName = 'StudentpotoScreen';

  const StudentpotoScreen({super.key});

  @override
  _StudentpotoScreenState createState() => _StudentpotoScreenState();
}

class _StudentpotoScreenState extends State<StudentpotoScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  //changes current state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getBottomNavItem() {
    // HelperFunctions.getBottomNavItemSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF1b4922),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height / 1.37,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  CustomAppBar(
                      color: kyellow800Color,
                      onChanged: (valueChange) {
                        dropdownvalues = valueChange!;
                        if (dropdownvalues == 'Upload story') {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>const UploadStory()));
                      
                        } else if (dropdownvalues == 'My Profile') {
                       Navigator.push(context, MaterialPageRoute(builder:(context)=>const NoConnection()));
                        } else if (dropdownvalues == 'Register') {
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>const NoConnection()));
                        }
                      },
                      itemLists: const ['Register', 'My Profile', 'Upload story'],
                      title: 'Mentor'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height / 00,
                    decoration: const BoxDecoration(
                      color: kyellow800Color,
                      //reusable radius,
                    ),

                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizedBox,
                        sizedBox,
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: const IconImages(
                                'assets/icons1/Mentor White Icon.png')),
                        sizedBox,
                        sizedBox,
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: kyellow800Color,
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5,top: 5),
                        decoration: const BoxDecoration(
                          color: kTextWhiteColor,
                          //reusable radius,
                          borderRadius: kTopBorderRadius,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HomeCard(
                                icon: 'assets/icons1/Jr Mentor.png',
                                title: 'Magazine',
                                sub: ': Primary Level',
                                height: 17,
                                width: 2.2,
                                onPress: () {
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=>JrMentor()));
                                },
                              ),
                              HomeCard(
                                icon: 'assets/icons1/Sr Mentor.png',
                                title: 'Magazine',
                                sub: ': Adolescents',
                                height: 17,
                                width: 2.2,
                                onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>SrMentor()));
                                },
                              ),
                              // HomeCard(
                              //   icon: 'assets/icons1/Mentor TV logo.png',
                              //   title: 'Mentor TV',
                              //   sub: ': General',
                              //   height: 17,
                              //   width: 3.0,
                              //   onPress: () {
                              //   Navigator.push(context, MaterialPageRoute(builder:(context)=>YoutubePlayerWidget()));
                              //   },
                              // ),
                              // HomeCard(
                              //   icon: 'assets/icons1/Eduflix Final logo.png',
                              //   title: 'Eduflix',
                              //   sub: ': General',
                              //   height: 17,
                              //   width: 2.5,
                              //   onPress: () {
                              //   Navigator.push(context, MaterialPageRoute(builder:(context)=>YoutubePlayerWidget()));
                              //   },
                              // ),
                              // HomeCard(
                              //   icon: 'assets/icons1/Nia hao Kids.png',
                              //   title: 'Nia hao Kids',
                              //   sub: ': General',
                              //   height: 15,
                              //   width: 2.0,
                              //   onPress: () {
                              //    Navigator.push(context, MaterialPageRoute(builder:(context)=>YoutubePlayerWidget()));
                              //   },
                              // ),
                              // HomeCard(
                              //   icon: 'assets/icons1/Latern ebooks logo.png',
                              //   title: 'Latern ebooks',
                              //   sub: ': General',
                              //   height: 20,
                              //   width: 1.6,
                              //   onPress: () {
                              //     Navigator.pushNamed(
                              //         context, NoConnection.routeName);
                              //   },
                              // ),
                              // HomeCard(
                              //   icon: 'assets/icons1/world of Bingwa.png',
                              //   title: 'World of Bingwa',
                              //   sub: ': General',
                              //   height: 11,
                              //   width: 2.6,
                              //   onPress: () {
                              //     Navigator.pushNamed(
                              //         context, NoConnection.routeName);
                              //   },
                              // ),
                              HomeCard(
                                icon: 'assets/icons1/Mitikids logo.png',
                                title: 'Climate Change Campaign',
                                sub: ': General',
                                height: 12,
                                width: 2.8,
                                onPress: () {
                                  Navigator.pushNamed(
                                      context, NoConnection.routeName);
                                },
                              ),
                              sizedBox,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: SliverFixedExtentList(
              itemExtent: MediaQuery.of(context).size.height,
              delegate: SliverChildBuilderDelegate(
                (builder, index) {
                  return ChallengeScreen(); 
                },
                childCount: 1,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomNav(
        color: kamber300Color,
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title,
      required this.sub,
      required this.height,
      required this.width});
  final VoidCallback onPress;
  final String icon;
  final String title;
  final String sub;
  final num height;
  final num width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(top: 1),
        // width: 40.w,
        height: MediaQuery.of(context).size.height / 8,
        decoration: const BoxDecoration(
          color: kTextWhiteColor,
          //  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          border: Border(
            bottom: BorderSide(width: 1.0, color: kgrey800Color),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: kamber300Color,
          //     offset: const Offset(
          //       2.0,
          //       3.0,
          //     ),
          //     blurRadius: 5.0,
          //     spreadRadius: 1.0,
          //   ), //BoxShadow
          //   BoxShadow(
          //     color: Colors.white,
          //     offset: const Offset(0.0, 0.0),
          //     blurRadius: 0.0,
          //     spreadRadius: 0.0,
          //   ), //BoxShadow
          // ],
          //BoxDecor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / height,
                    width: MediaQuery.of(context).size.width / width,
                    child: IconImages(icon)),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text(
                      title,
                      style: ktextBlack,
                    ),
                    Text(
                      sub,
                      style: ktextGrey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
