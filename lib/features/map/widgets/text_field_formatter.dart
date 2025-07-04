import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, 
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final newText = StringBuffer();

    // Format international numbers (+XXX XXX XXX XXX)
    if (text.startsWith('+')) {
      for (int i = 0; i < text.length; i++) {
        if (i == 0) {
          newText.write('+');
        } else if ((i - 1) % 3 == 0 && i != 1) {
          newText.write(' ${text[i]}');
        } else {
          newText.write(text[i]);
        }
      }
    } 
    // Format 10-digit numbers (XXX-XXX-XXXX)
    else if (text.length >= 3 && !text.startsWith('07')) {
      for (int i = 0; i < text.length; i++) {
        if (i == 3 || i == 6) {
          newText.write('-${text[i]}');
        } else {
          newText.write(text[i]);
        }
      }
    }
    // Format Rwandan numbers (07X XXX XXXX)
    else {
      for (int i = 0; i < text.length; i++) {
        if (i == 3 || i == 6) {
          newText.write(' ${text[i]}');
        } else {
          newText.write(text[i]);
        }
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}