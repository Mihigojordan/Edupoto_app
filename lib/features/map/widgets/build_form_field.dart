import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/constants/constants.dart';
import 'package:hosomobile/features/map/widgets/text_field_formatter.dart';

TextFormField buildFormField(
  String labelText,
  TextEditingController editingController,
  TextInputType textInputType,
  String hintText, {
  String? Function(String?)? validator,
  bool isPhoneNumber = false,
  int? maxLength,
  int? maxLines = 1,
  bool enabled = true,
  ValueChanged<String>? onChanged,
}) {
  return TextFormField(
    textAlign: TextAlign.start,
    controller: editingController,
    keyboardType: textInputType,
    style: kInputTextStyle,
    validator: validator,
    maxLength: maxLength,
    maxLines: maxLines,
    minLines: 1,
    enabled: enabled,
    onChanged: onChanged,
    inputFormatters: isPhoneNumber
        ? [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
            LengthLimitingTextInputFormatter(15),
            PhoneNumberFormatter(),
          ]
        : null,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      counterText: '', // Remove default counter
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(width: 1, color: kTextLightColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(width: 1, color: kamber300Color),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: isPhoneNumber
          ? ValueListenableBuilder<TextEditingValue>(
              valueListenable: editingController,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                final isValid = _validatePhoneNumber(value.text) == null;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    isValid ? Icons.check_circle : Icons.error,
                    color: isValid ? Colors.green : Colors.red,
                    size: 20,
                  ),
                );
              },
            )
          : null,
    ),
  );
}

String? _validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) return null;
  
  final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');

  // 1. International numbers (+ prefix)
  if (cleaned.startsWith('+')) {
    return cleaned.length >= 9 && cleaned.length <= 15 
        ? null 
        : 'Enter 9-15 digits after +';
  }

  // 2. Rwandan numbers (07, 72, 73, 78)
  if (cleaned.startsWith('07') || cleaned.startsWith('72') || 
     cleaned.startsWith('73') || cleaned.startsWith('78')) {
    return cleaned.length == 10 ? null : 'Rwandan number must be 10 digits';
  }

  // 3. General 10-digit numbers (US/Canada/India etc.)
  if (cleaned.length == 9 && !cleaned.startsWith('0')) {
    return null;
  }

  return 'Enter valid 10-digit, Rwandan (07...) or international (+...) number';
}