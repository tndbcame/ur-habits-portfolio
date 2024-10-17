import 'package:flutter/material.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_dropdown_form.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail_list_tile.dart';

class DataTypeTile extends StatelessWidget {
  const DataTypeTile({
    super.key,
    required this.isUpdate,
    required this.selectedDataType,
    required this.dataTypes,
    required this.onChangedDataType,
    this.onTap,
    required this.showOverlayDialog,
  });

  final bool isUpdate;
  final DataType selectedDataType;
  final List<DataType> dataTypes;
  final ValueChanged<DataType?> onChangedDataType;
  final VoidCallback? onTap;
  final VoidCallback showOverlayDialog;

  @override
  Widget build(BuildContext context) {
    return HabitDetailListTile(
      title: TextContents.dataType.text,
      itemHeight: 80,
      onTap: isUpdate ? showOverlayDialog : null,
      isRequiredMark: true,
      isDropDown: true,
      mainItem: Expanded(
        child: isUpdate
            ? Text(
                selectedDataType.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kTextThirdBaseColor,
                ),
                textAlign: TextAlign.center,
              )
            : Center(
                child: HabitDetailDropdownForm(
                  items: dataTypes.map((dataType) {
                    return DropdownMenuItem<DataType>(
                      value: dataType,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        dataType.name,
                        style: const TextStyle(color: kTextThirdBaseColor),
                      ),
                    );
                  }).toList(),
                  selectedValue: selectedDataType,
                  onChanged: onChangedDataType,
                  onTap: onTap,
                ),
              ),
      ),
    );
  }
}
