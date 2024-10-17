import 'package:flutter/material.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_text_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class MemoTile extends StatelessWidget {
  const MemoTile({
    super.key,
    required this.initialValue,
    required this.onSaved,
  });

  final String? initialValue;
  final ValueChanged<String?> onSaved;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.note.text,
      itemHeight: 90,
      mainItem: Expanded(
        child: HabitDetailTextForm(
          keyboardType: TextInputType.text,
          initialValue: initialValue,
          maxLength: 100,
          onSaved: onSaved,
        ),
      ),
      isFinal: true,
    );
  }
}
