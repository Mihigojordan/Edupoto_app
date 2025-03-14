import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/student_data.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/datesheet_screen/data/datesheet_data.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShikabambaCmt extends StatefulWidget {
  // const ShikabambaCmt({super.key});
  static const String routeName = 'ShikabambaCmt';

  const ShikabambaCmt({super.key});
  @override
  State<ShikabambaCmt> createState() => _ShikabambaCmtState();
}

class _ShikabambaCmtState extends State<ShikabambaCmt> {
  final TextEditingController _noteController = TextEditingController();
  late YoutubePlayerController _controller;
   late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  final bool _isPlayerReady = false;

    final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override

  // the full url: https://www.youtube.com/watch?v=PQSagzssvUQ&ab_channel=NASA
  // it's an interesting video from NASA on Youtube

  // Initiate the Youtube player controller

  late TextEditingController _idController;
  late TextEditingController _seekToController;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12.0),
        ),
        title: const Text(
          'Sn 1: Ep 01',
          style: TextStyle(color: Colors.white),
        ),
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
        backgroundColor: kyellow800Color,
      ),
      body: Container(
        color: kOtherColor,
        child: Stack(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 2.4,
                        child: YoutubePlayer(controller: _controller)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dateSheet3.length,
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          child: StudentPicture(
                                              picAddress:
                                                  dateSheet3[index].images,
                                              onPress: () {
                                                // go to profile detail screen here
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoConnection()));
                                              }),
                                        ),
                                      ],
                                    ),

                                    //2nd one
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dateSheet3[index].subjectName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: kTextBlackColor,
                                                    fontSize: 8
                                                    // fontWeight: FontWeight.w900,
                                                    ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                dateSheet3[index]
                                                    .date
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      color: kTextBlackColor,
                                                      // fontWeight: FontWeight.w900,
                                                    ),
                                              ),
                                              sizedBox5,
                                              Text(dateSheet3[index].dayName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //3rd one
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     Row(
                                    //       children: [

                                    //       //  SizedBox(width: 2),
                                    //         // Text(dateSheet3[index].monthName,
                                    //         //     style: Theme.of(context)
                                    //         //         .textTheme
                                    //         //         .titleSmall!
                                    //         //         .copyWith(
                                    //         //             color:
                                    //         //                 kTextBlackColor)),
                                    //       ],
                                    //     ),
                                    //     // Text(
                                    //     //   '🕒${dateSheet3[index].time}',
                                    //     //   style: Theme.of(context)
                                    //     //       .textTheme
                                    //     //       .bodySmall,
                                    //     // ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 8),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Write a Comment',
                              ),
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _noteController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3.0, 4.0, 8.0, 4.0),
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: StudentPicture(
                              picAddress: 'assets/images1/send.jpg',
                              onPress: () {
                                //clear text
                                _noteController.clear();
                                //remove focus
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus &&
                                    currentFocus.focusedChild != null) {
                                  currentFocus.focusedChild!.unfocus();
                                }
                                // go to profile detail screen here
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(color: kamber300Color),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
