import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showInstallPrompt(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
  title:  Text(
    'install_app'.tr,
    style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  ),
  content: SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          '${'kubona_apulikasiyo'.tr}:',
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        
        // Android Instructions
        RichText(
          text:  TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: '${'for_android'.tr}:\n',
                style:const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '1. ${'open_browser'.tr} (⋮ or ⋯)\n'),
              TextSpan(text: '2. ${'tap'.tr} "Add to Home screen"\n'),
            ],
          ),
        ),
        // Placeholder for Android instruction image
        // Image.asset('assets/android_install_steps.png'),
        const SizedBox(height: 10),
        
        // iOS Instructions
        RichText(
          text:  TextSpan(
            style:const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: 'For iOS:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '1. ${'tap'.tr} the share icon (□ with ↑)\n'),
              TextSpan(text: '2. Select "Add to Home Screen"\n'),
              TextSpan(text: '3. Tap "Add" in top-right corner'),
            ],
          ),
        ),
        // Placeholder for iOS instruction image
        // Image.asset('assets/ios_install_steps.png'),
        const SizedBox(height: 20),
        
        const Text(
          'After installation, you can launch the app like a regular application!',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  ),
  actions: [
    // TextButton(
    //   onPressed: () => Navigator.pop(context),
    //   child: const Text('NOT NOW'),
    // ),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
        // _triggerInstall();
      },
      child: const Text('Ok'),
    ),
  ],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  scrollable: true,
);
    },
  );
}


