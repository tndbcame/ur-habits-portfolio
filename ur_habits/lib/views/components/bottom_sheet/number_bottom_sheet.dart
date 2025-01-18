import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';
import 'package:ur_habits/views/components/bottom_sheet/tile/bottom_sheet_tile.dart';
import 'package:ur_habits/views/components/tenkey/custom_tenkey.dart';

class NumberBottomSheet extends StatefulWidget {
  const NumberBottomSheet({
    super.key,
    this.values,
    this.onDelete,
    this.date,
    this.useDecimal = true,
  });

  final Map<DateTime, String>? values;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;
  final bool useDecimal;

  @override
  State<NumberBottomSheet> createState() => _NumberBottomSheetState();
}

class _NumberBottomSheetState extends State<NumberBottomSheet> {
  late DateTime? _selectedDate;
  bool _isUpdate = false;
  String _selectedValue = '0';

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
      _selectedValue = '';
      if (widget.values != null) {
        _isUpdate = widget.values!.containsKey(date);
      }
      if (_isUpdate) {
        _selectedValue = widget.values![date]!;
      }
    });
  }

  void _handleTenkeyPress(TenkeyNumber number) {
    setState(() {
      switch (number) {
        case TenkeyNumber.one:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '1';
          break;
        case TenkeyNumber.two:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '2';
          break;
        case TenkeyNumber.three:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '3';
          break;
        case TenkeyNumber.four:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '4';
          break;
        case TenkeyNumber.five:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '5';
          break;
        case TenkeyNumber.six:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '6';
          break;
        case TenkeyNumber.seven:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '7';
          break;
        case TenkeyNumber.eight:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '8';
          break;
        case TenkeyNumber.nine:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '9';
          break;
        case TenkeyNumber.zero:
          if (_selectedValue.length >= 7) return;
          if (!widget.useDecimal && _selectedValue.isEmpty) break;
          _selectedValue += '0';
          break;
        case TenkeyNumber.zeroDouble:
          if (_selectedValue.length >= 7) return;
          if (!widget.useDecimal && _selectedValue.isEmpty) break;
          if (_selectedValue.length >= 6) {
            _selectedValue += '0';
            break;
          }
          _selectedValue += '00';
          break;
        case TenkeyNumber.decimal:
          if (_selectedValue.length >= 7) return;
          _selectedValue += '.';
          break;
        case TenkeyNumber.clear:
          _selectedValue = '';
          break;
        case TenkeyNumber.delete:
          if (_selectedValue.isNotEmpty) {
            _selectedValue =
                _selectedValue.substring(0, _selectedValue.length - 1);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTile(
      mainItem: CustomTenkey(
        onTenkeyPressed: _handleTenkeyPress,
        useDecimal: widget.useDecimal,
      ),
      value: _selectedValue,
      onOkPressed: () {
        if (_selectedValue.isEmpty) return;
        _selectedValue = UITrimmer.formatNumericValue(_selectedValue);
        context.pop<(String, DateTime?)>((_selectedValue, _selectedDate));
      },
      isUpdate: _isUpdate,
      onChangeDate: _handleDateChange,
      setDate: _setDate,
      onDelete: widget.onDelete,
      date: _selectedDate,
    );
  }
}
