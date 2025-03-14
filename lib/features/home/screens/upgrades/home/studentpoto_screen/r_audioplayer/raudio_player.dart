
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/home_screen_update/home_screen_upgrade.dart';

//void main() => runApp(MyApp());

class AudioPlayers extends StatefulWidget {
  static String routeName = 'AudioPlayers';

  const AudioPlayers({super.key});
  @override
  _AudioPlayersState createState() => _AudioPlayersState();
}

class _AudioPlayersState extends State<AudioPlayers>
    with SingleTickerProviderStateMixin {
  late AnimationController
      iconController; // make sure u have flutter sdk > 2.12.0 (null safety)
 late AudioPlayer player = AudioPlayer();
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    iconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

        player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('assets/audio/somethinglikethis.mp3'));
      await player.resume();
    });
  }

    @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextWhiteColor,
      appBar: AppBar(
        backgroundColor: kyellow800Color,
        centerTitle: true,
        title: const Text("Listenning the Story"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://i.pinimg.com/originals/f7/3a/5b/f73a5b4b7262440684a2b5c39e684304.jpg",
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const Icon(CupertinoIcons.backward_fill),
                  onTap: () {
                    player.seek(const Duration(seconds: -10));
                  },
                ),
                GestureDetector(
                  onTap: () {
                    AnimateIcon();
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: iconController,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  child: const Icon(CupertinoIcons.forward_fill),
                  onTap: () {
                    player.seek(const Duration(seconds: 10));
                    player.seek(const Duration(seconds: 10));
                   
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(color: kamber300Color),
    );
  }

  void AnimateIcon() {
    setState(() {
      isAnimated = !isAnimated;

      if (isAnimated) {
        iconController.forward();
        player.resume();
      } else {
        iconController.reverse();
        player.pause();
      }
    });
  }


}
