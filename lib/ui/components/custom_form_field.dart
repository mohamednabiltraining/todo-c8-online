import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomFormField extends StatelessWidget {
  String label;
  bool isPassword;
  TextInputType keyboardType ;
  MyValidator validator;
  TextEditingController controller;
  int lines;
  CustomFormField({required this.label,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.lines=1
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      minLines: lines,
      controller: controller,
      validator:validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
