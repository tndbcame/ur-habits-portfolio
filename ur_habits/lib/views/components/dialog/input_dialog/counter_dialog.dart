import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/button/input_dialog_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/tile/input_dialog_tile.dart';

class CounterDialog extends StatefulWidget {
  const CounterDialog({
    super.key,
    this.values,
    this.onDelete,
    this.date,
  });

  final Map<DateTime, String>? values;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<CounterDialog> createState() => _CounterDialogState();
}

class _CounterDialogState extends State<CounterDialog> {
  late DateTime? _selectedDate;

  bool _isUpdate = false;
  int _selectedValue = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
    _handleDateChange(_selectedDate);
  }

  /// 日付を設定する
  void _setDate(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  /// 日付変更時に呼び出される
  void _handleDateChange(DateTime? date) {
    setState(() {
      _selectedValue = 0;
      if (widget.values != null) {
        _isUpdate = widget.values!.containsKey(date);
      }
      if (_isUpdate) {
        _selectedValue = int.parse(widget.values![date]!);
      }
    });
  }

  /// カウンターの値を増減する
  void _adjustCounterValue(bool isAdd) {
    setState(() {
      if (isAdd) {
        _selectedValue++;
      } else {
        _selectedValue--;
      }
    });
  }

  /// SpringButtonのウィジェットを作成する
  Widget _buildSpringButton(bool isAdd) {
    return SpringButton(
      onTap: () => _adjustCounterValue(isAdd),
      duration: const Duration(milliseconds: 10),
      end: 0.97,
      child: Icon(
        isAdd
            ? HugeIcons.strokeRoundedPlusSignCircle
            : HugeIcons.strokeRoundedMinusSignCircle,
        color: Theme.of(context).primaryColor,
        size: 50,
      ),
    );
  }

  /// メインアイテムリストを構築する
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSpringButton(true),
          Center(
            child: Text(
              _selectedValue.toString(),
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          _buildSpringButton(false),
        ],
      ),
      const SizedBox(height: 16),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return InputDialogTile(
      mainAxisAlignment: MainAxisAlignment.center,
      dialogTitle: TextContents.tapToEnter.text,
      mainItems: _buildMainItems(),
      subItem: InputDialogButton(
        onOkPressed: () {
          context.pop<(String, DateTime?)>(
              (_selectedValue.toString(), _selectedDate));
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
