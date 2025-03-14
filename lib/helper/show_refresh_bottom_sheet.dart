import 'dart:html' as html;
import 'package:flutter/material.dart';

class ShowRefreshBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0), // Margin from screen edges
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Refresh App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Do you want to refresh the app?",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Button width fills container
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    html.window.location.reload(); // Reload the app
                  },
                  child: const Text("Refresh"),
                ),
              ),
              const SizedBox(height: 10), // Space before close button
              TextButton(
                onPressed: () => Navigator.pop(context), // Close bottom sheet
                child: const Text("Cancel"),
              ),
            ],
          ),
        );
      },
    );
  }
}
