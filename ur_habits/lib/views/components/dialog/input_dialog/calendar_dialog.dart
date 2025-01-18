import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/calender/calender_page_view.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_view.dart';

class CalendarDialog extends StatelessWidget {
  const CalendarDialog({
    super.key,
    this.selectedDate,
  });
  final DateTime? selectedDate;

  /// ダイアログのタイトル部分を作成する
  Widget _buildDialogTitle() {
    return SizedBox(
      height: 20,
      child: Text(
        TextContents.tapToEnterDate.text,
        style: const TextStyle(
          fontSize: 16,
          color: kTextThirdBaseColor,
        ),
      ),
    );
  }

  /// カレンダービューを作成する
  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CalenderPageView(
        height: 290,
        initialPage: 1200,
        useInputToday: false,
        notUseBeforeToday: false,
        notUseAfterToday: true,
        useAsInput: true,
        useAsDialog: true,
        onDaySelected: (context, selectedDay) {
          context.pop<DateTime>(selectedDay);
        },
        selectedDate: selectedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kTextBaseColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 180),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: UrHabitsScrollView(
        child: Column(
          children: [
            _buildDialogTitle(),
            _buildCalendar(),
          ],
        ),
      ),
    );
  }
}
