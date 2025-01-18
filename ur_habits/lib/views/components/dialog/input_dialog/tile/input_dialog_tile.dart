import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/selecting_caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/calendar_dialog.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';

class InputDialogTile extends StatelessWidget {
  const InputDialogTile({
    super.key,
    required this.mainAxisAlignment,
    required this.dialogTitle,
    required this.mainItems,
    required this.subItem,
    required this.isUpdate,
    required this.onChangeDate,
    required this.setDate,
    required this.onDelete,
    required this.date,
    this.borderBottom,
    this.onChangeDateForTime,
    this.animeType = 1,
  });

  final MainAxisAlignment mainAxisAlignment;
  final String dialogTitle;
  final List<Widget> mainItems;
  final Widget subItem;
  final bool isUpdate;
  final void Function(DateTime? date) onChangeDate;
  final void Function(DateTime? date) setDate;
  final void Function(BuildContext context, DateTime date)? onDelete;
  final DateTime? date;
  final bool? borderBottom;
  final void Function(bool isChanged, DateTime? date)? onChangeDateForTime;
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

  /// 更新ボタンのセットを生成する
  List<Widget> _buildUpdateButtons(BuildContext context) {
    return [
      ColorChangingTextButton(
        normalColor: Theme.of(context).primaryColor,
        pressedColor: Theme.of(context).primaryColor.withAlpha(150),
        onTap: () => _showDatePickerDialog(context),
        isBoldText: false,
        leftIcon: HugeIcons.strokeRoundedCalendar03,
        labelText: _formatDate(),
      ),
      if (isUpdate) const SizedBox(width: 10),
      if (isUpdate)
        ColorChangingTextButton(
          normalColor: kSecondBaseColor,
          pressedColor: kSecondBaseColor.withAlpha(150),
          onTap: () => _showDeleteDialog(context),
          isBoldText: false,
          leftIcon: HugeIcons.strokeRoundedDelete02,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Dialog(
          elevation: 1,
          backgroundColor: kTextBaseColor,
          surfaceTintColor: null,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          shadowColor: kTextBaseColorBlack,
          insetPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dialogTitle,
                      style: const TextStyle(color: kDialogTextColor),
                    ),
                    if (date != null)
                      Row(children: _buildUpdateButtons(context)),
                  ],
                ),
                ...mainItems,
                if (borderBottom == null)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: kLightGray9,
                  ),
                subItem,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
