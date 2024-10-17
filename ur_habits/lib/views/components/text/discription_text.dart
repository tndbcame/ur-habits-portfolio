import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class DiscriptionText extends StatelessWidget {
  const DiscriptionText({
    super.key,
    required this.text,
    this.size = 14,
  });
  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: kTextBaseColorBlack,
      ),
    );
  }
}
