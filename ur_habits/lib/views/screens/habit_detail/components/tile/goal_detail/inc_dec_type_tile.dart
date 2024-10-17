import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_dropdown_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class IncDecTypeTile extends StatelessWidget {
  const IncDecTypeTile({
    super.key,
    required this.accumulationType,
    required this.selectedIncDecVal,
    required this.onIncDecTypeChanged,
  });

  final int accumulationType;
  final int selectedIncDecVal;
  final void Function(int?) onIncDecTypeChanged;

  ///目標の度合い選択のテキスト表示
  Widget _buildIncDecTypeText() {
    return Text(
      accumulationType == 1
          ? TextContents.greaterThanCurrentValue.text
          : TextContents.lessThanCurrentValue.text,
      style: const TextStyle(fontSize: 16, color: kTextThirdBaseColor),
      textAlign: TextAlign.center,
    );
  }

  ///目標の度合い選択のドロップダウン
  Widget _buildIncDecTypeDropdown() {
    return Center(
      child: HabitDetailDropdownForm(
        items: [
          for (final incDecType in incDecTypes.entries)
            DropdownMenuItem<int>(
              value: incDecType.key,
              alignment: AlignmentDirectional.center,
              child: Text(
                incDecType.value,
                style: const TextStyle(color: kTextThirdBaseColor),
              ),
            ),
        ],
        selectedValue: selectedIncDecVal,
        onChanged: onIncDecTypeChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.goalProgress.text,
      itemHeight: 80,
      isDropDown: true,
      isRequiredMark: true,
      mainItem: Expanded(
        child: accumulationType == 1 || accumulationType == 2
            ? _buildIncDecTypeText()
            : _buildIncDecTypeDropdown(),
      ),
    );
  }
}
