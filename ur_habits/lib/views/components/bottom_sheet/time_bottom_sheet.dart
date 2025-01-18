import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/bottom_sheet/tile/bottom_sheet_tile.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/controller/time_dialog_controller.dart';
import 'package:ur_habits/resources/colors.dart';

class TimeBottomSheet extends StatefulWidget {
  const TimeBottomSheet({
    super.key,
    required this.unit,
    required this.hourSize,
    required this.isSecond,
    this.values,
    this.val,
    this.onDelete,
    this.date,
  });

  final String unit;
  final int hourSize;
  final bool isSecond;
  final Map<DateTime, Duration>? values;
  final Duration? val;
  final void Function(
    BuildContext context,
    DateTime date,
  )? onDelete;
  final DateTime? date;

  @override
  State<TimeBottomSheet> createState() => _TimeBottomSheetState();
}

class _TimeBottomSheetState extends State<TimeBottomSheet> {
  late DateTime? _selectedDate;
  late TimeDialogController _controller;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    _initializeDialog();
  }

  /// ダイアログの初期化処理
  void _initializeDialog() {
    _selectedDate = widget.date;
    _updateTimeFromDate(false, _selectedDate);
    _controller = TimeDialogController(
      initialHour: _selectedHour,
      initialMinute: _selectedMinute,
      initialSecond: _selectedSecond,
    );
  }

  /// 日付をセットする
  void _setDate(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  /// 時刻を更新する
  void _updateTimeFromDate(bool isChanged, DateTime? date) {
    setState(() {
      _resetTime();
      _applyTimeFromWidgetValues(date);
      if (isChanged) {
        _controller.setTime(
          DateTime(
            date!.year,
            date.month,
            date.day,
            _selectedHour,
            _selectedMinute,
            _selectedSecond,
          ),
        );
      }
    });
  }

  /// 時間、分、秒をリセット
  void _resetTime() {
    _selectedHour = 0;
    _selectedMinute = 0;
    _selectedSecond = 0;
  }

  /// widgetから値を適用
  void _applyTimeFromWidgetValues(DateTime? date) {
    if (widget.val != null) {
      _selectedHour = widget.val!.inHours;
      _selectedMinute = widget.val!.inMinutes % 60;
      _selectedSecond = widget.val!.inSeconds % 60;
    }
    if (widget.values != null) {
      isUpdate = widget.values!.containsKey(date);
    }
    if (isUpdate) {
      Duration val = widget.values![date]!;
      _selectedHour = val.inHours;
      _selectedMinute = val.inMinutes % 60;
      _selectedSecond = val.inSeconds % 60;
    }
  }

  /// メインのウィジェット項目を構築
  Widget _buildMainItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          color: kTextBaseColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimePickers(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTextButton(() => _controller.setTime(DateTime(0)),
                      '  ${TextContents.clear.text}'),
                  _buildTextButton(
                    () => _controller.setTime(DateTime.now()),
                    TextContents.currentTime.text,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 時間、分、秒のテキスト
  String _buildTimeText() {
    return widget.isSecond
        ? '${_selectedHour.toString().padLeft(2, TextContents.zero.text)}:'
            '${_selectedMinute.toString().padLeft(2, TextContents.zero.text)}:'
            '${_selectedSecond.toString().padLeft(2, TextContents.zero.text)}'
        : '${_selectedHour.toString().padLeft(2, TextContents.zero.text)}:'
            '${_selectedMinute.toString().padLeft(2, TextContents.zero.text)}';
  }

  Widget _buildTimePickers() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPicker(
            widget.hourSize,
            TextContents.hour.text,
            (val) => setState(() {
              _selectedHour = val;
            }),
            _controller.hourController,
          ),
          _buildPicker(
            60,
            TextContents.minute.text,
            (val) => setState(() {
              _selectedMinute = val;
            }),
            _controller.minuteController,
          ),
          if (widget.isSecond)
            _buildPicker(
              60,
              TextContents.second.text,
              (val) => setState(() {
                _selectedSecond = val;
              }),
              _controller.secondController,
            ),
        ],
      ),
    );
  }

  Widget _buildTextButton(
    VoidCallback onPressed,
    String labelName,
  ) {
    return ColorChangingTextButton(
      labelText: labelName,
      textSize: 24,
      normalColor: Theme.of(context).primaryColor,
      pressedColor: Theme.of(context).primaryColor.withAlpha(150),
      onTap: onPressed,
      isBoldText: false,
    );
  }

  void _handleOkButton() {
    context.pop<(Duration, DateTime?)>(
      (
        Duration(
          hours: _selectedHour,
          minutes: _selectedMinute,
          seconds: _selectedSecond,
        ),
        _selectedDate,
      ),
    );
  }

  /// Pickerウィジェットを構築
  Widget _buildPicker(
    int size,
    String unit,
    void Function(int) onSelectedItemChanged,
    FixedExtentScrollController controller,
  ) {
    return SizedBox(
      width: 100,
      height: 150,
      child: CupertinoPicker(
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
        ),
        scrollController: controller,
        offAxisFraction: 0,
        itemExtent: 32,
        useMagnifier: false,
        magnification: 1,
        squeeze: 1.25,
        looping: true,
        onSelectedItemChanged: onSelectedItemChanged,
        children: _buildPickerItems(size, unit),
      ),
    );
  }

  List<Widget> _buildPickerItems(int size, String unit) {
    return List.generate(size, (int index) {
      return Center(
        child: SizedBox(
          child: _buildTimeLabel(context, index, unit),
        ),
      );
    });
  }

  Widget _buildTimeLabel(BuildContext context, int number, String unit) {
    return Text(
      '${number.toString().padLeft(2, TextContents.zero.text)}$unit',
      style: const TextStyle(
        color: kDialogTextColor,
        fontSize: 22,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTile(
      mainItem: _buildMainItem(),
      value: _buildTimeText(),
      onOkPressed: _handleOkButton,
      isUpdate: isUpdate,
      onChangeDate: (_) {},
      setDate: _setDate,
      onDelete: widget.onDelete,
      date: _selectedDate,
      onChangeDateForTime: _updateTimeFromDate,
    );
  }
}
