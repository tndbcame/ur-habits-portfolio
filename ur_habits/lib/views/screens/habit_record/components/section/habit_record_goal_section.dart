import 'package:flutter/material.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_record/components/graph/achievement_graph.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_goal_panel.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_panel.dart';

class HabitRecordGoalSection extends StatelessWidget {
  const HabitRecordGoalSection({
    super.key,
    required this.screenWidth,
    required this.habit,
    required this.accumulatedValue,
    required this.achievementRate,
    required this.dataType,
    required this.accumVal,
  });

  final double screenWidth;
  final HabitView habit;
  final String accumulatedValue;
  final double achievementRate;
  final int dataType;
  final (int?, double?, Duration?) accumVal;

  @override
  Widget build(BuildContext context) {
    if (habit.accumulationType != 3 && habit.goal != null && habit.isGoal) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kTextBaseColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: AchievementGraph(
            accumulatedValue: accumulatedValue,
            achievementRate: achievementRate,
            targetValue: habit.goal!.targetValues.str,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            HabitRecordPanel(
              children: [
                HabitRecordGoalPanel(
                  screenWidth: screenWidth,
                  title: TextContents.goalValue.text,
                  isMemo: false,
                  dispVal: habit.isGoal ? habit.goal?.targetValues.str : null,
                  unit: habit.dataType.id != 6 &&
                          habit.dataType.id != 7 &&
                          habit.goal != null &&
                          habit.isGoal
                      ? habit.unit
                      : null,
                ),
              ],
            ),
            if (habit.accumulationType != 3)
              HabitRecordPanel(
                children: [
                  HabitRecordGoalPanel(
                    screenWidth: screenWidth,
                    title: TextContents.cumulativeValue.text,
                    isMemo: false,
                    dispVal: accumulatedValue,
                    unit: habit.dataType.id != 6 && habit.dataType.id != 7
                        ? habit.unit
                        : null,
                  ),
                ],
              ),
          ],
        ),
      );
    }
  }
}
