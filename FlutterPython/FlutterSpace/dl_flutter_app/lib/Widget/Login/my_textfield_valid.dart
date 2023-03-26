import 'package:dl_flutter_app/Style/custom_colors.dart';
import 'package:flutter/material.dart';

class ValidTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final GlobalKey<FormState> formKey;
  final String warningText;
  final String regexValid;

  const ValidTextfield({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    required this.formKey,
    required this.warningText,
    required this.regexValid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: ((value) {
            formKey.currentState?.validate();
          }),
          validator: (value) {
            if (value!.isEmpty) {
              return "$hintText을 입력해주세요";
            } else if (!RegExp(regexValid).hasMatch(value)) {
              return warningText;
            }
            return null;
          },
          decoration: InputDecoration(
              //선택 비선택시 테두리색깔
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.mainColor,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.mainColor),
                borderRadius: BorderRadius.circular(30.0),
              ),
              fillColor: CustomColors.greyColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500])),
        ),
      ),
    );
  }
}
