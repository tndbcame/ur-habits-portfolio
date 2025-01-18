import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/views/components/bottom_sheet/tile/bottom_sheet_tile.dart';
import 'package:ur_habits/resources/colors.dart';

class StarBottomSheet extends StatefulWidget {
  const StarBottomSheet({
    super.key,
    this.values,
    this.val,
    this.onDelete,
    this.date,
  });

  final Map<DateTime, String>? values;
  final double? val;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<StarBottomSheet> createState() => _StarBottomSheetState();
}

class _StarBottomSheetState extends State<StarBottomSheet> {
  late DateTime? _selectedDate;
  double _selectedValue = 0.0;
  bool _isUpdate = false;

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

  /// 日付変更時の処理を行う
  void _handleDateChange(DateTime? date) {
    setState(() {
      _selectedValue = widget.val ?? 0.0;
      if (widget.values != null) {
        _isUpdate = widget.values!.containsKey(date);
      }
      if (_isUpdate) {
        _selectedValue = double.parse(widget.values![date]!);
      }
    });
  }

  /// メインの評価バーを構築する
  Widget _buildMainItem() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: kTextBaseColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: RatingBar.builder(
          initialRating: _selectedValue,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: kDarkYellowGray,
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: kYellow,
          ),
          onRatingUpdate: (val) {
            setState(() {
              _selectedValue = val;
            });
          },
          updateOnDrag: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTile(
      mainItem: _buildMainItem(),
      isUpdate: _isUpdate,
      value: _selectedValue.toString(),
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
