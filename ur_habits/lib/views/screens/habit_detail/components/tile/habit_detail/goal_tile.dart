import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class GoalTile extends StatelessWidget {
  const GoalTile({
    super.key,
    required this.isGoal,
    this.habitGoalTitle,
    required this.onTapIsGoal,
    this.onTapGoalItem,
  });

  final bool isGoal;
  final String? habitGoalTitle;
  final VoidCallback onTapIsGoal;
  final VoidCallback? onTapGoalItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HabitDetailListTile(
          title: TextContents.goalExistence.text,
          itemHeight: 80,
          mainItem: Expanded(
            child: Text(
              isGoal
                  ? TextContents.goalExistenceYes.text
                  : TextContents.goalExistenceNo.text,
              textAlign: TextAlign.center,
              style: isGoal
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
          ),
          onTap: onTapIsGoal,
          isFinal: !isGoal,
        ),
        if (isGoal)
          HabitDetailListTile(
            title: TextContents.goal.text,
            itemHeight: 80,
            onTap: onTapGoalItem,
            mainItem: Expanded(
              child: Text(
                habitGoalTitle ?? TextContents.goalNotSet.text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kTextThirdBaseColor),
              ),
            ),
            isFinal: true,
          ),
      ],
    );
  }
}
