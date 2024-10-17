import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class AuthFormContainer extends StatelessWidget {
  const AuthFormContainer({
    super.key,
    required this.children,
    this.backgroundColor,
  });

  final List<Widget> children;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? kTextBaseColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
