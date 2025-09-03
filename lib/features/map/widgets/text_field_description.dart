import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/common/controllers/share_controller.dart';

class ShortDescriptionInput extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const ShortDescriptionInput({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.maxLength = 200,
    this.maxLines = 3,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText ?? 'short_description'.tr,
        hintText: hintText ?? 'enter_a_brief_description'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        counterText: '',
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      validator: validator ?? _defaultValidator,
      onChanged: onChanged,
      enabled: enabled,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_a_description'.tr;
    }
    if (value.length > (maxLength ?? 200)) {
      return '${'description_too_long'.tr} (${'max'.tr} $maxLength ${'characters'.tr})';
    }
    return null;
  }
}