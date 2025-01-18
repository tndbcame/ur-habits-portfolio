import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_bar.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_panel.dart';

class HabitRecordSection extends StatelessWidget {
  const HabitRecordSection({
    super.key,
    required this.screenWidth,
    required this.toggleStatus,
    required this.activeDate,
    required this.habit,
    required this.recordList,
  });

  final double screenWidth;
  final int toggleStatus;
  final DateTime activeDate;
  final HabitView habit;
  final List<Widget> recordList;

  @override
  Widget build(BuildContext context) {
    return HabitRecordPanel(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toggleStatus == 0
                  ? DateFormat(TextContents.recordForMonth.text)
                      .format(activeDate)
                  : TextContents.record.text,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
            ),
            if (toggleStatus == 1 && habit.goal?.deadline != null)
              Row(
                children: [
                  const Icon(
                    HugeIcons.strokeRoundedCheckmarkCircle01,
                    color: kSecondBaseColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat(TextContents.dateFormatYMD.text)
                        .format(habit.goal!.deadline!),
                    style: const TextStyle(
                      fontSize: 16,
                      color: kSecondBaseColor,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const Divider(height: 1, thickness: 1, color: kLightGray),
        if (habit.records != null)
          SizedBox(
            height: screenWidth * 0.65,
            child: UrHabitsScrollBar(
              thumbColor: Theme.of(context).primaryColor.applyOpacity(0.3),
              thickness: 5,
              child: ListView.builder(
                itemCount: recordList.length,
                itemBuilder: (context, index) => recordList[index],
                itemExtent: 40,
              ),
            ),
          ),
      ],
    );
  }
}
