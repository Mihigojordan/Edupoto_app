import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/util/images.dart';
import 'package:url_launcher/url_launcher.dart';


class CustomHelpWidget extends StatelessWidget {
  final double? height, width;
  final double borderRadius; // New parameter for customization
  final BoxFit? fit; // Optional image fit control

  const CustomHelpWidget({
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
          Images.help,
          fit: fit, // Controls how image fills the space
        ),
      ),
    );
  }
  
}

  void showHelpOptions({required String email,required String phone,}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title:  Text('email_support'.tr),
              onTap: () {
                launchUrl(Uri.parse('mailto:$email'));
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title:  Text('call_support'.tr),
              onTap: () {
                launchUrl(Uri.parse('tel:+$phone'));
                Get.back();
              },
            ),
       ListTile(
  leading: const Icon(Icons.chat),
  title:  Text('live_chart'.tr),
  onTap: () async {
var message = 'hello_ineed_help_with_babyeyi'.tr;
final encodedMessage = Uri.encodeComponent(message);
final url = Uri.parse('https://wa.me/$phone?text=$encodedMessage');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        Get.snackbar('Error', 'whatsapp_not_installed'.tr);
      }
    } catch (e) {
      Get.snackbar('Error', 'could_not_lounch_whatsapp'.tr);
    }
    Get.back();
  },
),
          ],
        ),
      ),
    );
  }