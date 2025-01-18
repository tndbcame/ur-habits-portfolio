import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/views/components/calender/calender_tap_area.dart';

class CalendarPage extends StatelessWidget {
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

  /// 日付に応じたテキストの色を決定
  Color _dateTextColor(BuildContext context, DateTime date) {
    switch (date.weekday) {
      case DateTime.sunday:
        return kSecondBaseColor;
      case DateTime.saturday:
        return kSaturday2;
      default:
        return Theme.of(context).primaryColor;
    }
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
    return selectedDate == date;
  }

  /// 日付のウィジェットを生成
  Widget _buildDayWidget(
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
    bool isDeadline = _isDeadline(date, habit);
    bool isSelectedDate = _isSelectedDate(date);

    if (!notUseBeforeToday) isOldToday = false;
    if (!notUseAfterToday) isFutureToday = false;

    if (addWeekDayStr) {
      if (useAsInput) {
        dayColumn.add(const SizedBox(height: 10));
      }
      dayColumn.add(Text(
        weekdays[date.weekday - 1],
        style: TextStyle(color: _dateTextColor(context, date)),
      ));
      dayColumn.add(SizedBox(height: useAsInput ? 15 : 30));
    }
    dayColumn.add(CalendarTapArea(
      date: date,
      useAsDialog: useAsDialog,
      useAsInput: useAsInput,
      isToday: isToday,
      isOtherMonth: isOtherMonth,
      isOldToday: isOldToday,
      isDeadline: isDeadline,
      isSelectedDate: isSelectedDate,
      isFutureToday: isFutureToday,
      onDaySelected: onDaySelected,
      habit: habit,
      dateTextColor: _dateTextColor,
    ));
    dayColumn.add(const SizedBox(height: 4));

    return Padding(
      padding: EdgeInsets.only(left: padLeft, right: padRight, bottom: 5),
      child: Column(children: dayColumn),
    );
  }

  /// 1週間分の日付ウィジェットを生成
  List<Widget> _generateWeekDays(List<DateTime> oneWeek, DateTime selectedDate,
      BuildContext context, bool isFirstWeek) {
    return oneWeek
        .map((DateTime d) =>
            _buildDayWidget(context, d, isFirstWeek, selectedDate))
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
          .map((d) => _buildDayWidget(context, d, isFirstWeek, selectedDate)));
      widgets.addAll(
          _generateWeekDays(oneWeek, selectedDate, context, isFirstWeek));
    }

    return TableRow(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    List<List<DateTime>> drawnDates =
        _generateDatesInMonth(activeDate.year, activeDate.month);
    return Table(
        children: drawnDates
            .map((List<DateTime> week) =>
                _generateWeekWidget(week, activeDate, context))
            .toList());
  }
}
