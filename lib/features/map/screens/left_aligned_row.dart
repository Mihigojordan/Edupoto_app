import 'package:flutter/material.dart';

class LeftAlignedLabelRow extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;

  const LeftAlignedLabelRow(this.label,
      {this.fontSize = 16.0, this.fontWeight = FontWeight.normal, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ],
    );
  }
}