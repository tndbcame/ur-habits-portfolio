import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_manager.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    super.key,
    required this.activeDate,
    required this.onDaySelected,
    required this.notUseBeforeToday,
    required this.notUseAfterToday,
    required this.useInputToday,
    required this.useAsDialog,
    required this.useAsInput,
    this.habit,
    this.selectedDate,
  });

  final DateTime activeDate;
  final void Function(
    BuildContext context,
    DateTime selectedDay,
  ) onDaySelected;
  final bool notUseBeforeToday;
  final bool notUseAfterToday;
  final bool useInputToday;
  final bool useAsDialog;
  final bool useAsInput;
  final HabitView? habit;
  final DateTime? selectedDate;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  final OverlayManager _overlayManager = OverlayManager();

  /// 日付に応じたテキストの色を決定
  Color _dateTextColor(DateTime date, {bool? isSelectedDate}) {
    if (isSelectedDate ?? false) {
      return kTextBaseColor;
    }
    switch (date.weekday) {
      case DateTime.sunday:
        return kSecondBaseColor;
      case DateTime.saturday:
        return kSaturday2;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  /// 日付のテキストを生成する
  Widget _buildDayText(DateTime date, bool isOtherMonth, bool isToday,
      bool isOldToday, bool isSelectedDate) {
    return Text(
      date.day.toString(),
      style: TextStyle(
        fontSize: 16,
        color: !isToday && isOldToday
            ? kDarkGray
            : isOtherMonth
                ? kLightGray
                : _dateTextColor(date, isSelectedDate: isSelectedDate),
      ),
    );
  }

  /// 選択された日付が別の月かどうか
  bool _isOtherMonth(DateTime date, DateTime selectedDate) {
    return selectedDate.month != date.month;
  }

  /// 現在の日付かどうか
  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 過去の日付かどうか
  bool _isOldToday(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// 未来の日付かどうか
  bool _isFutureToday(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// 締め切りの日かどうか
  bool _isDeadline(DateTime date, HabitView? habit) {
    return habit != null &&
        habit.goal != null &&
        habit.goal!.deadline != null &&
        habit.goal!.deadline!.compareTo(date) == 0;
  }

  /// 選択してある日付と一緒かどうか
  bool _isSelectedDate(DateTime date) {
    return widget.selectedDate == date;
  }

  /// 日付ウィジェットのスタックを描画
  Widget _buildStack(
      BuildContext context,
      DateTime date,
      bool isToday,
      bool isOtherMonth,
      bool isOldToday,
      bool isDeadline,
      bool isSelectedDate,
      HabitView? habit) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: widget.useAsDialog
              ? 30
              : widget.useAsInput
                  ? 40
                  : 45,
          width: widget.useAsDialog
              ? 30
              : widget.useAsInput
                  ? 40
                  : null,
          padding: const EdgeInsets.all(1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDeadline
                ? kYellow2
                : (isSelectedDate
                    ? Theme.of(context).primaryColor
                    : !isToday && isOldToday
                        ? kLightGray8
                        : kTextBaseColor),
            borderRadius: BorderRadius.circular(10),
            border: widget.useAsInput && isToday
                ? Border.all(width: 1, color: kRed)
                : null,
          ),
          child: habit != null &&
                  habit.records != null &&
                  habit.records!.containsKey(date)
              ? Column(
                  children: [
                    const SizedBox(height: 15),
                    Icon(HugeIcons.strokeRoundedTick01,
                        color: Theme.of(context).primaryColor),
                  ],
                )
              : widget.useAsInput
                  ? _buildDayText(
                      date, isOtherMonth, isToday, isOldToday, isSelectedDate)
                  : null,
        ),
        if (!widget.useAsInput && !isToday)
          Positioned(
            top: -2,
            child: _buildDayText(
                date, isOtherMonth, isToday, isOldToday, isSelectedDate),
          ),
        if (!widget.useAsInput && isToday)
          Positioned(
            top: -2,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: kToday.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(fontSize: 16, color: kTextBaseColor),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// 日付のウィジェットを生成
  Widget _dayWidget(
    BuildContext context,
    DateTime date,
    bool addWeekDayStr,
    DateTime selectedDate,
  ) {
    const double padDefault = 5;
    double padLeft = date.weekday == DateTime.sunday ? 0 : padDefault;
    double padRight = date.weekday == DateTime.saturday ? 0 : padDefault;
    List<Widget> dayColumn = [];

    bool isOtherMonth = _isOtherMonth(date, selectedDate);
    bool isToday = _isToday(date);
    bool isOldToday = _isOldToday(date);
    bool isFutureToday = _isFutureToday(date);
    bool isDeadline = _isDeadline(date, widget.habit);
    bool isSelectedDate = _isSelectedDate(date);

    if (!widget.notUseBeforeToday) isOldToday = false;
    if (!widget.notUseAfterToday) isFutureToday = false;

    if (addWeekDayStr) {
      if (widget.useAsInput) {
        dayColumn.add(const SizedBox(height: 10));
      }
      dayColumn.add(Text(
        weekdays[date.weekday - 1],
        style: TextStyle(color: _dateTextColor(date)),
      ));
      dayColumn.add(SizedBox(height: widget.useAsInput ? 15 : 30));
    }

    dayColumn.addAll([
      InkWell(
        onTap: () {
          if (!isToday && (isOldToday || isFutureToday)) {
            String message = isOldToday
                ? TextContents.pastDateError.text
                : TextContents.futureDateError.text;
            _overlayManager.showOverlayDialog(context, this, message);
            return;
          }
          if (!context.mounted) return;
          widget.onDaySelected(context, date);
        },
        child: _buildStack(context, date, isToday, isOtherMonth, isOldToday,
            isDeadline, isSelectedDate, widget.habit),
      ),
      const SizedBox(height: 4),
    ]);

    return Container(
      padding: EdgeInsets.only(left: padLeft, right: padRight, bottom: 5),
      child: Column(children: dayColumn),
    );
  }

  /// 1週間分の日付ウィジェットを生成
  List<Widget> _generateWeekDays(List<DateTime> oneWeek, DateTime selectedDate,
      BuildContext context, bool isFirstWeek) {
    return oneWeek
        .map((DateTime d) => _dayWidget(context, d, isFirstWeek, selectedDate))
        .toList();
  }

  /// 月の最初の週かどうかを判定
  bool _isFirstWeek(List<DateTime> oneWeek, DateTime selectedDate) {
    return oneWeek[0].day == 1 && oneWeek[0].month == selectedDate.month;
  }

  /// 前の月の日付を生成
  List<DateTime> _generateAdditionalDates(
      DateTime startDate, int requiredDays) {
    List<DateTime> additionalDates = [];
    DateTime additionalDate = startDate.subtract(const Duration(days: 1));

    while (additionalDates.length < requiredDays) {
      additionalDates.add(additionalDate);
      additionalDate = additionalDate.subtract(const Duration(days: 1));
    }

    return additionalDates.reversed.toList();
  }

  /// 指定した月のすべての日付を生成
  List<List<DateTime>> _generateDatesInMonth(int year, int month) {
    List<List<DateTime>> datesInMonth = [];
    List<DateTime> datesInWeek = [];
    DateTime date = DateTime(year, month, 1);

    for (int i = 0; i < 6;) {
      datesInWeek.add(date);
      // 土曜日で区切る
      if (date.weekday == DateTime.saturday) {
        i++;
        datesInMonth.add(datesInWeek);
        datesInWeek = [];
      }
      date = date.add(
        const Duration(days: 1),
      );
    }
    return datesInMonth;
  }

  /// 週ごとのウィジェットを生成
  TableRow _generateWeekWidget(
      List<DateTime> oneWeek, DateTime selectedDate, BuildContext context) {
    List<Widget> widgets = [];
    int startWeekDay = oneWeek[0].weekday;
    bool isFirstWeek = _isFirstWeek(oneWeek, selectedDate);

    if (startWeekDay == DateTime.sunday) {
      // ２周目以降
      widgets = _generateWeekDays(oneWeek, selectedDate, context, isFirstWeek);
    } else {
      // 月初めの週が日曜でないとき
      int additionalDays = DateTime.daysPerWeek - oneWeek.length;
      List<DateTime> additionalDates =
          _generateAdditionalDates(oneWeek[0], additionalDays);

      widgets.addAll(additionalDates
          .map((d) => _dayWidget(context, d, isFirstWeek, selectedDate)));
      widgets.addAll(
          _generateWeekDays(oneWeek, selectedDate, context, isFirstWeek));
    }

    return TableRow(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    List<List<DateTime>> drawnDates =
        _generateDatesInMonth(widget.activeDate.year, widget.activeDate.month);
    return Table(
        children: drawnDates
            .map((List<DateTime> week) =>
                _generateWeekWidget(week, widget.activeDate, context))
            .toList());
  }
}
