import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hosomobile/common/widgets/rotation_transition_widget.dart';




class DialogHelper {
  static void showAnimatedDialog(BuildContext context, Widget dialog, {bool isFlip = false, bool dismissible = true}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation1, animation2) => dialog,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        if (isFlip) {
          return RotationTransitionWidget(
            alignment: Alignment.center,
            turns: Tween<double>(begin: math.pi, end: 2.0 * math.pi).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 1.0, curve: Curves.linear),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
                ),
              ),
              child: child,
            ),
          );
        } else {
          return Transform.scale(
            scale: animation.value,
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          );
        }
      },
    );
  }
}



class CustomDialogWidget1 extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSingleButton;
  final bool isFailed;

  const CustomDialogWidget1({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isSingleButton = false,
    this.isFailed = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Icon(icon, size: 50, color: isFailed ? Colors.red : Colors.green),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          if (isSingleButton)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // This will close the dialog
              },
              child: const Text('OK'),
            ),
        ],
      ),
    );
  }
}
