import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/button/input_dialog_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/tile/input_dialog_tile.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/routers/route_manager.dart';

class CheckboxDialog extends StatefulWidget {
  const CheckboxDialog({
    super.key,
    required this.routeManager,
    required this.dialogTitle,
    this.values,
    this.onDelete,
    this.date,
  });
  final RouteManager routeManager;
  final String dialogTitle;
  final Map<DateTime, HabitValues>? values;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<CheckboxDialog> createState() => _CheckboxDialog();
}

class _CheckboxDialog extends State<CheckboxDialog> {
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
      if (_isUpdate && int.parse(widget.values![date]!.str) == 1) {
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

  /// チェックの状態を表示するウィジェットを作成する
  Widget _buildSelectionDisplay(int selectedValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          selectedValue == 1
              ? TextContents.taskDone.text
              : TextContents.taskNotDone.text,
          style: TextStyle(
            color: _buttonColor,
            fontSize: 20,
          ),
        ),
        Icon(
          selectedValue == 1
              ? HugeIcons.strokeRoundedTick01
              : HugeIcons.strokeRoundedCheckUnread01,
          color: _buttonColor,
        ),
      ],
    );
  }

  /// メインのアイテムリストを構築する
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      Center(
        child: SpringButton(
          onTap: _toggleSelection,
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: 200,
            decoration: BoxDecoration(border: Border.all(color: _buttonColor)),
            child: _buildSelectionDisplay(_selectedValue),
          ),
        ),
      ),
      const SizedBox(height: 16),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return InputDialogTile(
      routeManager: widget.routeManager,
      mainAxisAlignment: MainAxisAlignment.center,
      dialogTitle: widget.dialogTitle,
      mainItems: _buildMainItems(),
      subItem: InputDialogButton(
        routeManager: widget.routeManager,
        onOkPressed: () {
          widget.routeManager.pop<(String, DateTime?)>(
              context, (_selectedValue.toString(), _selectedDate));
        },
        buttonColor: Theme.of(context).primaryColor,
      ),
      isUpdate: _isUpdate,
      onChangeDate: _handleDateChange,
      setDate: _setDate,
      onDelete: widget.onDelete,
      date: _selectedDate,
    );
  }
}
