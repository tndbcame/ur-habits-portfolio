import 'package:flutter/material.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_goal_panel.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_panel.dart';

class HabitRecordMemoPanel extends StatelessWidget {
  final double screenWidth;
  final int toggleStatus;
  final HabitView habit;

  const HabitRecordMemoPanel({
    super.key,
    required this.screenWidth,
    required this.toggleStatus,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    if (toggleStatus == 1 && habit.goal?.memo?.isNotEmpty == true) {
      return HabitRecordPanel(
        children: [
          HabitRecordGoalPanel(
            screenWidth: screenWidth,
            title: TextContents.note.text,
            isMemo: true,
            dispVal: habit.goal?.memo,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
