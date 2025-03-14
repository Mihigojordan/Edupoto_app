import 'dart:js_interop';
import 'package:flutter/material.dart';


void showInstallPrompt(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Install App'),
        content: const Text('Add this app to your home screen for easy access.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Not Now'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              // Trigger the native install prompt
              _triggerInstall();
            },
            child: const Text('Install'),
          ),
        ],
      );
    },
  );
}

// Define the JavaScript function
@JS('triggerInstall')
external void triggerInstall();

void _triggerInstall() {
  triggerInstall(); // Call the JavaScript function
}
