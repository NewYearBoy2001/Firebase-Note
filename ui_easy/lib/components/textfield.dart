import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
