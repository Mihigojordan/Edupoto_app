
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/custom_app_bar.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/studentpoto_screen/components/shikabamba/widget/widget2/upload_story.dart';
import 'package:hosomobile/features/home/screens/upgrades/no_connection/no_connection.dart';


late bool _passwordVisible;

class ReadAlong extends StatefulWidget {
  static String routeName = 'ReadAlong';

  const ReadAlong({super.key});

  @override
  _ReadAlongState createState() => _ReadAlongState();
}

class _ReadAlongState extends State<ReadAlong> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  String getUserID = "", getUserName = "";

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  late AudioPlayer player = AudioPlayer();
  bool isLoading = false;

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      print(getUserID);

      Navigator.pushNamedAndRemoveUntil(
          context, NoConnection.routeName, (route) => false);
      // await HelperFunctions.getUserIDSharedPreference().then((value) {
      //   setState(() {
      //     getUserID = value!;
      //   });
      // });
      // await HelperFunctions.getUserNameSharedPreference().then((value) {
      //   setState(() {
      //     getUserName = value!;
      //   });
      // });

      // if (getUserID != passwordEditingController.text) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, ParentScreen.routeName, (route) => false);
      // } else if (getUserName != passwordEditingController.text) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, TeacherScreen.routeName, (route) => false);
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text("Already a user sign in"),
      //   ));
      //}
    } else {
      setState(() {
        isLoading = false;
        //show snackbar
      });
    }
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  String dropdownvalues = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kOtherColor,
        appBar: PreferredSize(
            preferredSize: preferredSize,
            child: CustomAppBar(
                color: kyellow800Color,
                onChanged: (valueChange) {
                  dropdownvalues = valueChange!;
                  if (dropdownvalues == 'Upload story') {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const UploadStory()));
                  }
                },
                itemLists: const ['Upload story'],
                title: 'Read along ')),
        body: Column(
          children: [
            Container(
              color: kyellow800Color,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: const BoxDecoration(
                  color: kOtherColor,
                  //reusable radius,
                  borderRadius: kTopBorderRadius,
                ),
                child: const Column(
                  children: [
                    sizedBox,
                    HomeCard(),
                  ],
                ),
              ),
            ),
            sizedBox,
          ],
        ),
        bottomNavigationBar: const BottomNav(color: kamber300Color),
      ),
    );
  }
}

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});

 // const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController
      iconController; // make sure u have flutter sdk > 2.12.0 (null safety)

  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;

AudioPlayer player = AudioPlayer();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    iconController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

            player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('assets/audio/cleverrabbit.mp3'));
      await player.resume();
    });
  }
  // final Function userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height/1.45,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: kamber300Color,
              offset: Offset(
                2.0,
                3.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              player.stop();
              AnimateIcon();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.audiotrack),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Icon(
                  CupertinoIcons.backward_fill,
                  size: 15,
                ),
                onTap: () {
                  player.seek(const Duration(seconds: -10));
                },
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  AnimateIcon();
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: iconController,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                child: const Icon(
                  CupertinoIcons.forward_fill,
                  size: 15,
                ),
                onTap: () {
                  player.seek(const Duration(seconds: 10));
                  // player.seek(Duration(seconds: 10));
                  // player.next();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
            child: Divider(
              thickness: 1.0,
              color: kTextLightColor,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Text(
                  'The story of Rabbit',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kTextBlackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Once upon a time, deep in the jungle, there was a tiger who hunted for his dinner day and night.The rest of the animals lived in fear of the tiger because he was the biggest and most powerful animalof them all. Day and night they feared that they would be hunted down and gobbled up by the big,fierce tiger. The antelope were scared, the pigs were scared, even the monkeys were scared but nothingcould be done about the fierce tiger.The only animal who was not scared of the big, fierce tiger was the clever rabbit. He lived in a burrowbeneath the ground and only came out for food when he was sure that the tiger was asleep and thejungle was safe. But the rabbit was also kind and generous, and he felt sorry for the animals of thejungle that were forced to live in fear of the tiger.One evening, all of the animals were gathered together at the meeting place.‘What can we do about the tiger?’ asked the monkeys.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: kTextBlackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 200,
                  width: 100,
                  child: IconImages('assets/icons1/tiger.jpg'),
                )
              ],
            ),
          ),
          sizedBox,
        ],
      ),
    );
  }

  void AnimateIcon() => setState(() {
        isAnimated = !isAnimated;

        if (isAnimated) {
          iconController.forward();
          player.resume();
        } else {
          iconController.reverse();
          player.pause();
        }
      });

  @override
  void dispose() {
    // TODO: implement dispose
    iconController.dispose();
    player.dispose();
    super.dispose();
  }
}
