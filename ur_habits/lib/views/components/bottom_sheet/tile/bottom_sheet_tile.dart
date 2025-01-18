import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/views/components/button/color_changing_box_button.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/cursor/custom_cursor.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/selecting_caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/calendar_dialog.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';

class BottomSheetTile extends StatelessWidget {
  const BottomSheetTile({
    super.key,
    required this.mainItem,
    required this.isUpdate,
    required this.value,
    required this.onChangeDate,
    this.onChangeDateForTime,
    required this.setDate,
    required this.onDelete,
    required this.onOkPressed,
    required this.date,
    this.animeType = 1,
  });

  final Widget mainItem;
  final bool isUpdate;
  final String value;
  final void Function(DateTime? date) onChangeDate;
  final void Function(bool isChanged, DateTime? date)? onChangeDateForTime;
  final void Function(DateTime? date) setDate;
  final void Function(BuildContext context, DateTime date)? onDelete;
  final VoidCallback onOkPressed;
  final DateTime? date;
  final int animeType;

  /// 日付選択用のダイアログを表示する
  Future<void> _showDatePickerDialog(BuildContext context) async {
    DateTime? selectedDate = await DialogHelper.showAnimationDialog<DateTime>(
      context,
      CalendarDialog(
        selectedDate: date,
      ),
      animaType: animeType,
    );
    selectedDate ??= date;
    setDate(selectedDate);
    if (onChangeDateForTime == null) {
      onChangeDate(selectedDate);
    } else {
      onChangeDateForTime!(true, selectedDate);
    }
  }

  /// 削除確認ダイアログを表示する
  Future<void> _showDeleteDialog(BuildContext context) async {
    bool? isDelete = await DialogHelper.showAnimationDialog(
      context,
      SelectingCautionDialog(
        message: TextContents.confirmDelete.text,
        confirmButtonText: TextContents.delete.text,
        confirmButtonColor: kSecondBaseColor,
      ),
      animaType: 1,
    );
    if (isDelete == true && context.mounted) {
      onDelete!(context, date!);
      context.pop();
    }
  }

  /// 日付ラベルのフォーマットを取得する
  String _formatDate() {
    return DateFormat('yyyy/M/d(${weekdays[date!.weekday - 1]})').format(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDialogBackgroudColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColorChangingTextButton(
                  normalColor: kTextBaseColorBlack,
                  pressedColor: kTextBaseColorBlack.withAlpha(150),
                  onTap: () => context.pop(),
                  isBoldText: false,
                  leftIcon: HugeIcons.strokeRoundedCancel01,
                  leftIconSize: 30,
                ),
                Text(
                  TextContents.createRecord.text,
                  style: const TextStyle(color: kDialogTextColor, fontSize: 20),
                ),
                if (isUpdate) ...{
                  ColorChangingTextButton(
                    normalColor: kSecondBaseColor,
                    pressedColor: kSecondBaseColor.withAlpha(150),
                    onTap: () => _showDeleteDialog(context),
                    isBoldText: false,
                    leftIcon: HugeIcons.strokeRoundedDelete02,
                    leftIconSize: 30,
                  ),
                } else ...{
                  const SizedBox(
                    width: 40,
                  )
                }
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: kTextBaseColor,
                    border: Border(bottom: BorderSide(color: kLightGray3)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TextContents.date.text,
                          style: const TextStyle(
                              fontSize: 20, color: kDialogTextColor),
                        ),
                        ColorChangingTextButton(
                          normalColor: Theme.of(context).primaryColor,
                          pressedColor:
                              Theme.of(context).primaryColor.withAlpha(150),
                          onTap: () => _showDatePickerDialog(context),
                          isBoldText: false,
                          leftIcon: HugeIcons.strokeRoundedCalendar03,
                          labelText: _formatDate(),
                          textSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: kTextBaseColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TextContents.value.text,
                          style: const TextStyle(
                            fontSize: 20,
                            color: kDialogTextColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              value,
                              style: const TextStyle(
                                fontSize: 20,
                                color: kDialogTextColor,
                              ),
                            ),
                            const CustomCursor(
                              cursorColor: kDialogTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ColorChangingBoxButton(
                    labelText: TextContents.save.text,
                    textSize: 24,
                    textPadding: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    normalColor: Theme.of(context).primaryColor,
                    normalTextColor: kTextBaseColor,
                    pressedColor: Theme.of(context).primaryColor.withAlpha(150),
                    pressedTextColor: kTextBaseColor,
                    onTap: onOkPressed,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
              ),
              mainItem
            ],
          ),
        ],
      ),
    );
  }
}
