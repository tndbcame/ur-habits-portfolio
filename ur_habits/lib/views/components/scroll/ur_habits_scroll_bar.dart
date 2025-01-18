import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';

class UrHabitsScrollBar extends StatelessWidget {
  const UrHabitsScrollBar({
    super.key,
    required this.child,
    this.thickness = 7,
    this.thumbColor,
  });

  final Widget child;
  final double thickness;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thickness: thickness,
      thumbColor: thumbColor ?? kTextBaseColor.applyOpacity(0.3),
      child: child,
    );
  }
}
