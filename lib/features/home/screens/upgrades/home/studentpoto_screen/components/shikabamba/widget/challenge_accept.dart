
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_buttons.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChallengeAccept extends StatefulWidget {
  // const ChallengeAccept({super.key});
  static const String routeName = 'ChallengeAccept';

  const ChallengeAccept({super.key});
  @override
  State<ChallengeAccept> createState() => _ChallengeAcceptState();
}

class _ChallengeAcceptState extends State<ChallengeAccept> {
  final TextEditingController _noteController = TextEditingController();

  @override

  // the full url: https://www.youtube.com/watch?v=PQSagzssvUQ&ab_channel=NASA
  // it's an interesting video from NASA on Youtube

  // Initiate the Youtube player controller

  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  final bool _isPlayerReady = false;

  final List<String> _ids = [
    'wq4ImuCTDDo',
    'iC5HbtoP_DE',
    'bc2-fnJxt00',
    '_kqxRIzjwOs',
    'NM0ROzNOPt4',
    '0M4e58e55BE',
    'TiWdVrmUgKk',
    'zzRAV_oyBXg',
    '19X9x1mN7nI',
  ];

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
          'About challenge',
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
                        child: YoutubePlayer(controller: _controller)
                                ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Text(
                        'Mentor Shikakamba Talent Challenge\nRules and Regulations\nThe Kids Got Talent Contest is open to all youth ages 4-17 years old\nMentor Shikakamba Talent Challenge will be climaxed on Easter Weekend of 2023 at the Jakaya Kikwete Youth Centre. All contestants entering the Contest must be willing to perform in the live show if selected.\nHOW TO ENTER Create a video showcasing your talent: singing, dancing, magic etc and post through the Mentor challenge on Shulepoto App. Entrants must submit their submission video to our submission platform, along with their name, address, birthday and daytime phone number. Entrants must also provide a parent and/or legal guardian’s contact information (name, phone number and email) in their submission. Entries for the Contest shall run from Saturday, November 26, April 5, 2023. Only entries submitted to our submission platform will be considered. All entries must be 4 minutes or less. To qualify, all entries must be received through our submission platform.\n VIDEO SUBMISSIONS: Conditions: By participating in this Contest, contestants agree that their name, photograph, voice and/or image may be used in any and all forms of media, without any further compensation organizers No profanity or vulgarity in any vocal, dance, or any other performance will be allowed. No weapons, fire, smoke machines etc. This is a family, friendly, and safe environment; please be respectful.',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kTextBlackColor, fontSize: 10),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultButton2(
                          onPress: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>const NoConnection())),
                          title: 'I do accept the challenge',
                          iconData: Icons.arrow_forward,
                          color1: kyellow800Color,
                          color2: kamber300Color),
                    ),
                  ],
                ),
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       color: Colors.white.withOpacity(0.8),
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 10.0),
            //               child: TextField(
            //                   style: TextStyle(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.normal,
            //                       fontSize: 8.sp),
            //                   decoration: InputDecoration(
            //                     border: InputBorder.none,
            //                     labelText: 'Write a Comment',
            //                   ),
            //                   autofocus: false,
            //                   keyboardType: TextInputType.multiline,
            //                   maxLines: null,
            //                   controller: _noteController),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.fromLTRB(3.0, 4.0, 8.0, 4.0),
            //             child: Container(
            //               height: 45,
            //               width: 45,
            //               child: StudentPicture(
            //                   picAddress: 'assets/images1/send.jpg',
            //                   onPress: () {
            //                     //clear text
            //                     _noteController.clear();
            //                     //remove focus
            //                     FocusScopeNode currentFocus =
            //                         FocusScope.of(context);
            //                     if (!currentFocus.hasPrimaryFocus &&
            //                         currentFocus.focusedChild != null) {
            //                       currentFocus.focusedChild!.unfocus();
            //                     }
            //                     // go to profile detail screen here
            //                   }),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
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
