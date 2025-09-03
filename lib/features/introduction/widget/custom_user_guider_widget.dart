
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/util/images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
 import 'package:flutter/foundation.dart'; // Add this import

class CustomUserGuideWidget extends StatelessWidget {
  final double? height, width;
  final double borderRadius; // New parameter for customization
  final BoxFit? fit; // Optional image fit control

  const CustomUserGuideWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 5.0, // Default value
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent, // Ensures background doesn't cover image
        ),
        child: Image.asset(
          Images.user_guide,
          fit: fit, // Controls how image fills the space
        ),
      ),
    );
  }
}



void playYoutubeVideo() {
  const youtubeUrl = 'https://youtu.be/8Eb0BQc7JIQ';
  
  if (kIsWeb) {
    // For web, use url_launcher to open in browser
    launchUrl(
      Uri.parse(youtubeUrl),
      mode: LaunchMode.externalApplication,
    );
  } else {
    // For mobile/desktop, use youtube_player_flutter
    final videoId = YoutubePlayer.convertUrlToId(youtubeUrl);
    if (videoId != null) {
      Get.bottomSheet(
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                enableCaption: false,
                disableDragSeek: true,
              ),
            ),
            aspectRatio: 16/9, // Important for proper sizing
          ),
          builder: (context, player) {
            return Container(
              height: Get.height * 0.5, // Increased height for better visibility
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(child: player), // Use Expanded for proper scaling
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            );
          },
        ),
        isScrollControlled: true, // Allows full expansion
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
      );
    } else {
      Get.snackbar('Error', 'Could not load video');
    }
  }
}