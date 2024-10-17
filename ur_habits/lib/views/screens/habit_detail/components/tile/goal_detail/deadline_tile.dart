import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class DeadlineTile extends StatelessWidget {
  const DeadlineTile({
    super.key,
    required this.selectedDeadline,
    required this.onTap,
  });

  final DateTime? selectedDeadline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.goalDeadline.text,
      itemHeight: 80,
      onTap: onTap,
      mainItem: Expanded(
        child: Text(
          selectedDeadline == null
              ? TextContents.goalExistenceNo.text
              : DateFormat(TextContents.formattedDate.text)
                  .format(selectedDeadline!),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selectedDeadline == null
                ? kTextThirdBaseColor
                : Theme.of(context).primaryColor,
            fontWeight: selectedDeadline == null ? null : FontWeight.bold,
          ),
        ),
      ),
      attachAllow: true,
    );
  }
}
