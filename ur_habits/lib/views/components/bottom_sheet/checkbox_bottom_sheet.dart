import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/bottom_sheet/tile/bottom_sheet_tile.dart';
import 'package:ur_habits/resources/colors.dart';

class CheckboxBottomSheet extends StatefulWidget {
  const CheckboxBottomSheet({
    super.key,
    this.values,
    this.onDelete,
    this.date,
  });

  final Map<DateTime, HabitValues>? values;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<CheckboxBottomSheet> createState() => _CheckboxBottomSheet();
}

class _CheckboxBottomSheet extends State<CheckboxBottomSheet> {
  late DateTime? _selectedDate;
  late Color _buttonColor; // late を使用して初期化を遅延させる
  bool _isUpdate = false;
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  /// didChangeDependencies でテーマを参照する
  /// Theme.of(context)がInheritedWidgetに依存しているためdidChangeDependenciesで初期化
  /// themeが変更されるたびに呼ばれる
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleDateChange(_selectedDate); // Theme.of() をここで初期化
  }

  /// 日付を設定する
  void _setDate(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  /// 日付変更時の処理を行う
  void _handleDateChange(DateTime? date) {
    setState(() {
      _selectedValue = 0;
      _buttonColor = kLightGray9;
      if (widget.values != null && widget.values![date] != null) {
        _isUpdate = widget.values!.containsKey(date);
      }
      if (widget.values!.containsKey(date) &&
          int.parse(widget.values![date]!.str) == 1) {
        _toggleSelection();
      }
    });
  }

  /// チェックの選択状態を変更する
  void _toggleSelection() {
    setState(() {
      if (_selectedValue == 0 && _buttonColor == kLightGray9) {
        _selectedValue = 1;
        _buttonColor = Theme.of(context).primaryColor;
      } else {
        _selectedValue = 0;
        _buttonColor = kLightGray9;
      }
    });
  }

  /// メインのアイテムリストを構築する
  Widget _buildMainItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
      child: GestureDetector(
        onTap: _toggleSelection,
        child: Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: kLightGray2,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _selectedValue == 1
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 175,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: kTextBaseColorBlack.applyOpacity(0.2),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    TextContents.taskNotDoneNewLine.text,
                    style: const TextStyle(
                      color: kTextBaseColor,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    TextContents.taskDone.text,
                    style: const TextStyle(
                      color: kTextBaseColor,
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTile(
      mainItem: _buildMainItem(),
      isUpdate: _isUpdate,
      value: _selectedValue == 1
          ? TextContents.taskDone.text
          : TextContents.taskNotDone.text,
      onChangeDate: _handleDateChange,
      setDate: _setDate,
      onDelete: widget.onDelete,
      onOkPressed: () {
        context.pop<(String, DateTime?)>(
            (_selectedValue.toString(), _selectedDate));
      },
      date: _selectedDate,
    );
  }
}
