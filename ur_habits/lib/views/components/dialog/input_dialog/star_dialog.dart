import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/button/input_dialog_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/tile/input_dialog_tile.dart';
import 'package:ur_habits/resources/colors.dart';

class StarDialog extends StatefulWidget {
  const StarDialog({
    super.key,
    required this.routeManager,
    required this.dialogTitle,
    this.values,
    this.val,
    this.onDelete,
    this.date,
  });
  final RouteManager routeManager;
  final String dialogTitle;
  final Map<DateTime, String>? values;
  final double? val;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<StarDialog> createState() => _StarDialogState();
}

class _StarDialogState extends State<StarDialog> {
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
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      Center(
        child: RatingBar.builder(
          initialRating: _selectedValue,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: kDarkYellowGray,
          itemCount: 5,
          itemSize: 40.0,
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
