import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final String text;
  final Widget icon;
  final TextEditingController controller;
  final bool obscureText;

  const SignUpForm(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      cursorColor: Colors.blueGrey.shade700,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $text';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey.shade500,
          ),
        ),
        prefixIcon: (icon),
      ),
    );
  }
}

class SignUpInkwell extends StatelessWidget {
  final String text;
  final Function() onTap;

  const SignUpInkwell({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey.shade900,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
