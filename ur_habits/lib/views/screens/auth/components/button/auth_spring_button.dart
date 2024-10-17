import 'package:flutter/material.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';
import 'package:ur_habits/resources/colors.dart';

class AuthSpringButton extends StatelessWidget {
  const AuthSpringButton({
    super.key,
    required this.label,
    required this.buttonColor,
    required this.onTap,
    this.height,
    this.width,
  });
  final String label;
  final Color buttonColor;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      duration: const Duration(milliseconds: 100),
      end: 0.8,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: kTextBaseColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
