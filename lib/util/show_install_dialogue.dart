import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:hosomobile/common/widgets/custom_image_widget.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';

void showInstallPrompt(BuildContext context) {
  // List of image paths with proper null checks
  final List<String> androidImages = [
    'assets/install_screen/go_to_menu.jpg',
    'assets/install_screen/add_to_home.jpg',
    'assets/install_screen/install.jpg',
    'assets/install_screen/access.jpg',
  ].where((path) => path != null).cast<String>().toList();

  final List<String> iosImages = [
    'assets/install_screen/go_to_menu.jpg',
    'assets/install_screen/add_to_home.jpg',
    'assets/install_screen/install.jpg',
    'assets/install_screen/access.jpg',
  ].where((path) => path != null).cast<String>().toList();

 void _showFullScreenImage(BuildContext context, String imagePath) {
    if (imagePath.isEmpty) return; // Skip if path is empty
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('how_to_install_app'.tr),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: PhotoView(
            imageProvider: AssetImage(imagePath),
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event?.cumulativeBytesLoaded?.toDouble() != null
                    ? event!.cumulativeBytesLoaded.toDouble() /
                        (event.expectedTotalBytes?.toDouble() ?? 1)
                    : null,
              ),
            ),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text('failed_to_load_image'.tr),
            ),
          ),
        ),
      ),
    );
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'how_to_install_app'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'kubona_apulikasiyo'.tr}:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Android Instructions
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '${'for_android'.tr}:\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '1. ${'open_browser'.tr} (⋮ or ⋯)\n'),
                    TextSpan(text: '2. ${'tap'.tr} "Add to Home screen"\n'),
                  ],
                ),
              ),
              sizedBox05h,
              // Android Images
              if (androidImages.isNotEmpty)
                Wrap(
                  children: androidImages.map((imagePath) {
                    return GestureDetector(
                      onTap: () => _showFullScreenImage(context, imagePath),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          imagePath,
                          height: 100,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.broken_image),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 10),

              // iOS Instructions
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '${'for_ios'.tr}:\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '1. ${'tap'.tr} the share icon (□ with ↑)\n'),
                    TextSpan(text: '2. ${'select'.tr} "Add to Home Screen"\n'),
                    TextSpan(text: '3. ${'tap'.tr} "Add" in top-right corner'),
                  ],
                ),
              ),
              sizedBox05h,
                // iOS Images
              if (iosImages.isNotEmpty)
                Wrap(
                  children: iosImages.map((imagePath) {
                    return GestureDetector(
                      onTap: () => _showFullScreenImage(context, imagePath),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          imagePath,
                          height: 100,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.broken_image),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),

              Text(
                'after_installation_note'.tr,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
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