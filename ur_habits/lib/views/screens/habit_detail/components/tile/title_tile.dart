import 'package:flutter/material.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/validators/habit_validator.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_text_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class TitleTile extends StatelessWidget {
  final String enteredTitle;
  final ValueChanged<String?> onSaved;
  final String hintText;

  const TitleTile({
    super.key,
    required this.enteredTitle,
    required this.onSaved,
    required this.hintText,
    this.maxLength = 10,
  });

  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.title.text,
      itemHeight: 90,
      mainItem: Expanded(
        child: HabitDetailTextForm(
          hintText: hintText,
          keyboardType: TextInputType.name,
          maxLength: maxLength,
          initialValue: enteredTitle,
          onSaved: onSaved,
          validator: (val) {
            return HabitValidator.validTitle(val);
          },
        ),
      ),
    );
  }
}
