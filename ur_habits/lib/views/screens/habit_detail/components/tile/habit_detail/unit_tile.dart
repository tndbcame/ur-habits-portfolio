import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_text_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class UnitTile extends StatelessWidget {
  const UnitTile({
    super.key,
    required this.isNotInputUnit,
    required this.unit,
    required this.onSaved,
    required this.showOverlayDialog,
  });

  final bool isNotInputUnit;
  final String unit;
  final ValueChanged<String?> onSaved;
  final VoidCallback showOverlayDialog;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.unit.text,
      itemHeight: 90,
      mainItem: Expanded(
        child: isNotInputUnit
            ? Text(
                unit,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextThirdBaseColor,
                ),
                textAlign: TextAlign.center,
              )
            : HabitDetailTextForm(
                hintText: '例）$unit',
                keyboardType: TextInputType.name,
                maxLength: 5,
                initialValue: unit,
                onSaved: onSaved,
              ),
      ),
      onTap: isNotInputUnit ? showOverlayDialog : null,
    );
  }
}
