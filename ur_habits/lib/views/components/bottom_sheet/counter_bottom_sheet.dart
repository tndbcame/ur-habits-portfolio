import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/components/bottom_sheet/tile/bottom_sheet_tile.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';

class CounterBottomSheet extends StatefulWidget {
  const CounterBottomSheet({
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
  State<CounterBottomSheet> createState() => _CounterBottomSheetState();
}

class _CounterBottomSheetState extends State<CounterBottomSheet> {
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
      duration: const Duration(milliseconds: 80),
      end: 0.8,
      onTap: () {
        _adjustCounterValue(isAdd);
      },
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          isAdd
              ? HugeIcons.strokeRoundedPlusSign
              : HugeIcons.strokeRoundedMinusSign,
          color: kTextBaseColor,
          size: 100,
        ),
      ),
    );
  }

  /// メインアイテムを構築する
  Widget _buildMainItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: _buildSpringButton(false)),
        const SizedBox(width: 8),
        Expanded(child: _buildSpringButton(true)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTile(
      mainItem: _buildMainItem(),
      value: _selectedValue.toString(),
      onOkPressed: () {
        context.pop<(String, DateTime?)>(
            (_selectedValue.toString(), _selectedDate));
      },
      isUpdate: _isUpdate,
      onChangeDate: _handleDateChange,
      setDate: _setDate,
      onDelete: widget.onDelete,
      date: _selectedDate,
    );
  }
}
