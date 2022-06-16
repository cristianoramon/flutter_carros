// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String? label;
  String? hint;
  bool passwd = false;
  TextEditingController? contro;
  FormFieldValidator? validator;

  AppText({
    this.label,
    this.hint,
    required this.passwd,
    this.contro,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contro,
      obscureText: passwd,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
