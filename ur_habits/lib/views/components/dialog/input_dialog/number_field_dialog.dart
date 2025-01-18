import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/validators/habit_validator.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/button/input_dialog_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/tile/input_dialog_tile.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';

class NumberFiledDialog extends StatefulWidget {
  const NumberFiledDialog({
    super.key,
    required this.dataType,
    this.values,
    this.onDelete,
    this.date,
  });

  final DataType dataType;
  final Map<DateTime, String>? values;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<NumberFiledDialog> createState() => _NumberFiledDialogState();
}

class _NumberFiledDialogState extends State<NumberFiledDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String _enteredVal = '';
  bool isUpdate = false;

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
      _enteredVal = '';
      if (widget.values != null) {
        isUpdate = widget.values!.containsKey(date);
      }
      if (isUpdate) {
        _enteredVal = widget.values![date]!;
      }
      _controller = TextEditingController(text: _enteredVal);
    });
  }

  /// 入力された値を保存する
  void _saveItem() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      context.pop<(String, DateTime?)>((_enteredVal, _selectedDate));
    }
  }

  /// メインアイテムのリストを作成する
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextFormField(
              controller: _controller,
              style: const TextStyle(color: kDialogTextColor, fontSize: 16),
              cursorColor: kDialogTextColor,
              cursorErrorColor: kDialogTextColor,
              decoration: InputDecoration(
                hintText: widget.dataType.id == 2
                    ? TextContents.zeroFew.text
                    : TextContents.zero.text,
                hintStyle: const TextStyle(color: kLightGray4),
                focusColor: kDialogTextColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              autocorrect: false,
              enableSuggestions: false,
              maxLength: 8,
              validator: (val) {
                return HabitValidator.validRecordTextForm(val, widget.dataType);
              },
              onSaved: (val) {
                _enteredVal = UITrimmer.formatNumericValue(val!);
              },
            ),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InputDialogTile(
        mainAxisAlignment: MainAxisAlignment.start,
        dialogTitle: '${widget.dataType.name}を入力',
        mainItems: _buildMainItems(),
        subItem: InputDialogButton(
          onOkPressed: _saveItem,
          buttonColor: Theme.of(context).primaryColor,
        ),
        isUpdate: isUpdate,
        onChangeDate: _handleDateChange,
        setDate: _setDate,
        onDelete: widget.onDelete,
        date: _selectedDate,
        borderBottom: true,
      ),
    );
  }
}
