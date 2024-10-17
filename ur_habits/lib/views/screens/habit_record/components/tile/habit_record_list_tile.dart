import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';

class HabitRecordListTile extends StatefulWidget {
  const HabitRecordListTile({
    super.key,
    required this.toggleStatus,
    required this.date,
    required this.valStr,
    required this.unit,
    required this.onTap,
    this.icon,
  });

  final int toggleStatus;
  final DateTime date;
  final String valStr;
  final String unit;
  final void Function(BuildContext, DateTime) onTap;
  final IconData? icon;

  @override
  State<HabitRecordListTile> createState() => _HabitRecordListTileState();
}

class _HabitRecordListTileState extends State<HabitRecordListTile> {
  Color? backgroundColor;

  /// 背景色を更新するための共通
  void _updateBackgroundColor(Color? color) {
    setState(() {
      backgroundColor = color;
    });
  }

  /// 日付フォーマットを取得する
  String _getFormattedDate() {
    return DateFormat(widget.toggleStatus == 0
            ? 'M/d(${weekdays[widget.date.weekday - 1]})'
            : 'yyyy/M/d(${weekdays[widget.date.weekday - 1]})')
        .format(widget.date);
  }

  /// バリューテキストを取得する
  Widget _buildValueText() {
    return Text(
      '${widget.valStr}${widget.unit}',
      style: const TextStyle(
        fontSize: 16,
        color: kTextBaseColorBlack,
      ),
    );
  }

  /// アイコンを表示するかを判断する
  Widget _buildIcon() {
    return widget.icon != null ? Icon(widget.icon) : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _updateBackgroundColor(kLightGray8),
      onTapUp: (_) => _updateBackgroundColor(null),
      onTapCancel: () => _updateBackgroundColor(null),
      onTap: () => widget.onTap(context, widget.date),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: const Border(
            bottom: BorderSide(
              width: 1.0,
              color: kLightGray2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getFormattedDate(),
              style: const TextStyle(
                fontSize: 16,
                color: kTextBaseColorBlack,
              ),
            ),
            Row(
              children: [
                _buildValueText(),
                _buildIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
