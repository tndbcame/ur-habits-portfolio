import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_dropdown_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class AccumulationTile extends StatelessWidget {
  const AccumulationTile({
    super.key,
    required this.isUpdate,
    required this.selectedAccumulationType,
    required this.accumulationTypes,
    required this.onChangedAccumulationType,
    required this.showOverlayDialog,
    required this.onTap,
    required this.selectedDataTypeId,
  });

  final bool isUpdate;
  final int selectedAccumulationType;
  final Map<int, String> accumulationTypes;
  final ValueChanged<int?> onChangedAccumulationType;
  final VoidCallback showOverlayDialog;
  final VoidCallback onTap;
  final int selectedDataTypeId;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.cumulative.text,
      itemHeight: 80,
      isDropDown: true,
      mainItem: Expanded(
        child: isUpdate
            ? Text(
                accumulationTypes[selectedAccumulationType]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextThirdBaseColor,
                ),
                textAlign: TextAlign.center,
              )
            : Center(
                child: HabitDetailDropdownForm(
                  items: accumulationTypes.entries
                      .where((entry) =>
                          !((selectedDataTypeId == 3 ||
                                  selectedDataTypeId == 4) &&
                              entry.key == 2) &&
                          !(selectedDataTypeId == 6 && entry.key == 3))
                      .map((entry) => DropdownMenuItem<int>(
                            value: entry.key,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              entry.value,
                              style:
                                  const TextStyle(color: kTextThirdBaseColor),
                            ),
                          ))
                      .toList(),
                  selectedValue: selectedAccumulationType,
                  onChanged: onChangedAccumulationType,
                  onTap: onTap,
                ),
              ),
      ),
      onTap: isUpdate ? showOverlayDialog : null,
    );
  }
}
