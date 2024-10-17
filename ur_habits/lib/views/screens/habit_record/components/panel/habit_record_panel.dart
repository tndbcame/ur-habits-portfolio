import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitRecordPanel extends StatelessWidget {
  final List<Widget> children;

  const HabitRecordPanel({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kTextBaseColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
