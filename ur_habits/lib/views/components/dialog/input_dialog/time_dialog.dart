import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/color_changing_box_button.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/controller/time_dialog_controller.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/tile/input_dialog_tile.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/routers/route_manager.dart';

class TimeDialog extends StatefulWidget {
  const TimeDialog({
    super.key,
    required this.routeManager,
    required this.dialogTitle,
    required this.unit,
    required this.hourSize,
    required this.isSecond,
    this.values,
    this.val,
    this.onDelete,
    this.date,
  });
  final RouteManager routeManager;
  final String dialogTitle;
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
  State<TimeDialog> createState() => _TimeDialogState();
}

class _TimeDialogState extends State<TimeDialog> {
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
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      _buildTimeDisplay(),
      const SizedBox(height: 16),
      _buildTimePickers(),
      _buildCurrentTimeButton(),
      const SizedBox(height: 16),
    ];
  }

  Widget _buildTimeDisplay() {
    return Center(
      child: SizedBox(
        width: widget.isSecond ? 180 : 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildTimeText(),
        ),
      ),
    );
  }

  /// 時間、分、秒のテキスト表示
  List<Widget> _buildTimeText() {
    return [
      Text(
        '${_selectedHour.toString().padLeft(2, TextContents.zero.text)}時間',
        style: const TextStyle(fontSize: 20, color: kDialogTextColor),
      ),
      Text(
        '${_selectedMinute.toString().padLeft(2, TextContents.zero.text)}分',
        style: const TextStyle(fontSize: 20, color: kDialogTextColor),
      ),
      if (widget.isSecond)
        Text(
          '${_selectedSecond.toString().padLeft(2, TextContents.zero.text)}秒',
          style: const TextStyle(fontSize: 20, color: kDialogTextColor),
        ),
    ];
  }

  Widget _buildTimePickers() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildPickers(),
      ),
    );
  }

  List<Widget> _buildPickers() {
    return [
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
    ];
  }

  Widget _buildCurrentTimeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColorChangingTextButton(
          labelText: TextContents.currentTime.text,
          normalColor: Theme.of(context).primaryColor,
          pressedColor: Theme.of(context).primaryColor.withAlpha(150),
          onTap: () => _controller.setTime(DateTime.now()),
          isBoldText: false,
        ),
      ],
    );
  }

  /// サブのボタン項目を構築
  Widget _buildSubItems() {
    return Center(
      child: SizedBox(
        width: 330,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _buildSubButtons(),
        ),
      ),
    );
  }

  List<Widget> _buildSubButtons() {
    return [
      _buildTextButton(() => _controller.setTime(DateTime(0)),
          TextContents.clear.text, false),
      _buildTextButton(() => widget.routeManager.pop(context),
          TextContents.cancel.text, true),
      _buildTextButton(() => _handleOkButton(), TextContents.ok.text, true),
    ];
  }

  void _handleOkButton() {
    widget.routeManager.pop<(Duration, DateTime?)>(
      context,
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
      width: 90,
      height: 150,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
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
          child: _buildLabel(context, index, unit),
        ),
      );
    });
  }

  Widget _buildLabel(BuildContext context, int number, String unit) {
    return Text(
      '${number.toString().padLeft(2, TextContents.zero.text)}$unit',
      style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextButton(
    VoidCallback onPressed,
    String labelName,
    bool hasLeftBorder,
  ) {
    return ColorChangingBoxButton(
      height: 70,
      width: 110,
      hasLeftBorder: hasLeftBorder,
      hasTopBorder: true,
      borderColor: kLightGray9,
      normalColor: kTextBaseColor,
      normalTextColor: Theme.of(context).primaryColor,
      pressedColor: kLightGray5,
      pressedTextColor: Theme.of(context).primaryColor,
      onTap: onPressed,
      labelText: labelName,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputDialogTile(
      routeManager: widget.routeManager,
      mainAxisAlignment: MainAxisAlignment.center,
      dialogTitle: widget.dialogTitle,
      mainItems: _buildMainItems(),
      subItem: _buildSubItems(),
      isUpdate: isUpdate,
      onChangeDate: (_) {},
      setDate: _setDate,
      onDelete: widget.onDelete,
      date: _selectedDate,
      onChangeDateForTime: _updateTimeFromDate,
      borderBottom: false,
    );
  }
}
