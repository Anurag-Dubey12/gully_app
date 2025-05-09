import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_text_field.dart';

class FormInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final TextInputType? textInputType;
  final bool? filled;
  final bool? readOnly;
  final bool? enabled;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final int? maxLength;
//ontap
  final Function()? onTap;
  final int? maxLines;
  const FormInput(
      {super.key,
      this.controller,
      this.label,
      this.autofocus,
      this.textInputType,
      this.filled,
      this.readOnly,
      this.enabled,
      this.validator,
      this.onTap,
      this.maxLines,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label ?? '',
              style: Get.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16)),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
            filled: true,
            onTap: onTap,
            autoFocus: autofocus,
            readOnly: readOnly,
            maxLen: maxLength,
            enabled: enabled,
            validator: validator,
            maxLines: maxLines,
            controller: controller,
            textInputType: textInputType,
          ),
        ],
      ),
    );
  }
}
