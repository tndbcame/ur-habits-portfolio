import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';

class HabitRecordGoalPanel extends StatelessWidget {
  final double screenWidth;
  final String title;
  final bool isMemo;
  final String? dispVal;
  final String? unit;
  const HabitRecordGoalPanel({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.isMemo,
    required this.dispVal,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Divider(
          height: 1,
          thickness: 1,
          color: kLightGray,
        ),
        SizedBox(height: screenWidth * 0.03),
        Text(
          dispVal ?? TextContents.goalExistenceNo.text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: isMemo ? 16 : 24,
          ),
        ),
        if (unit != null)
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              unit!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: kTextBaseColorBlack,
                fontSize: 18,
              ),
            ),
          ),
      ],
    );
  }
}
