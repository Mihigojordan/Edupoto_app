  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void showHelpOptions() {
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
                launchUrl(Uri.parse('mailto:support@example.com'));
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title:  Text('call_support'.tr),
              onTap: () {
                launchUrl(Uri.parse('tel:+250793903844'));
                Get.back();
              },
            ),
       ListTile(
  leading: const Icon(Icons.chat),
  title:  Text('live_chart'.tr),
  onTap: () async {
var message = 'hello_ineed_help_with_babyeyi'.tr;
final encodedMessage = Uri.encodeComponent(message);
final url = Uri.parse('https://wa.me/250793903844?text=$encodedMessage');
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