import 'package:flutter/material.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class InputValueTile extends StatelessWidget {
  const InputValueTile({
    super.key,
    required this.title,
    required this.inputField,
    this.isRequiredMark = false,
  });

  final String title;
  final Widget inputField;
  final bool isRequiredMark;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: title,
      itemHeight: 90,
      isRequiredMark: isRequiredMark,
      mainItem: Expanded(
        child: inputField,
      ),
    );
  }
}
