import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/calender/calender_page.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';

class CalenderPageView extends StatefulWidget {
  const CalenderPageView({
    super.key,
    required this.height,
    required this.initialPage,
    required this.useInputToday,
    required this.notUseBeforeToday,
    required this.notUseAfterToday,
    required this.useAsInput,
    required this.useAsDialog,
    required this.onDaySelected,
    this.onTodaySelected,
    this.onDateChanged,
    this.habit,
    this.selectedDate,
  });

  final double height;
  final int initialPage;
  final bool notUseBeforeToday;
  final bool notUseAfterToday;
  final bool useInputToday;
  final bool useAsInput;
  final bool useAsDialog;
  final void Function(BuildContext context, DateTime selectedDay) onDaySelected;
  final void Function(BuildContext context, DateTime nowDate)? onTodaySelected;
  final void Function(BuildContext context, DateTime date)? onDateChanged;
  final HabitView? habit;
  final DateTime? selectedDate;

  @override
  State<CalenderPageView> createState() => _CalenderPageViewState();
}

class _CalenderPageViewState extends State<CalenderPageView> {
  late int currentIndex;
  late DateTime selectedDate;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialPage;
    selectedDate = widget.selectedDate ?? now;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerDateChanged(selectedDate);
    });
  }

  /// 日付変更時の処理
  void _triggerDateChanged(DateTime date) {
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(context, date);
    }
  }

  /// 日付取得処理
  DateTime _getActiveDate(int index, int initialPage) {
    int n = index - initialPage;
    if (widget.selectedDate != null) {
      return DateTime(
          widget.selectedDate!.year, widget.selectedDate!.month + n);
    }
    return DateTime(now.year, now.month + n);
  }

  /// ページ変更時の処理
  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      selectedDate = _getActiveDate(index, widget.initialPage);
    });
    _triggerDateChanged(selectedDate);
  }

  /// ナビゲーションバー
  Widget _buildNavigationRow(PageController controller) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigationButton(
              controller, HugeIcons.strokeRoundedArrowLeft01, -1),
          Text(
            DateFormat(TextContents.dateFormat.text).format(selectedDate),
            style: TextStyle(
              fontSize: 18,
              color: widget.useAsInput ? kTextThirdBaseColor : kTextBaseColor,
            ),
          ),
          _buildNavigationButton(
              controller, HugeIcons.strokeRoundedArrowRight01, 1),
        ],
      ),
    );
  }

  /// ナビゲーションボタン
  Widget _buildNavigationButton(
      PageController controller, IconData icon, int direction) {
    return IconButton(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(8, 8),
      ),
      onPressed: () => controller.animateToPage(
        currentIndex + direction,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      icon: Icon(
        icon,
        color: widget.useAsInput ? kTextThirdBaseColor : kTextBaseColor,
      ),
    );
  }

  /// PageViewのビルド
  Widget _buildPageView(PageController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        padding: EdgeInsets.all(widget.useAsInput ? 8 : 16),
        decoration: BoxDecoration(
          color: widget.useAsInput ? kLightGray6 : kTextBaseColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: widget.height,
        child: PageView.builder(
          controller: controller,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            return CalendarPage(
              activeDate: _getActiveDate(index, widget.initialPage),
              onDaySelected: widget.onDaySelected,
              notUseBeforeToday: widget.notUseBeforeToday,
              notUseAfterToday: widget.notUseAfterToday,
              useInputToday: widget.useInputToday,
              useAsInput: widget.useAsInput,
              useAsDialog: widget.useAsDialog,
              habit: widget.habit,
              selectedDate: widget.selectedDate,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      viewportFraction: 1,
      initialPage: widget.initialPage,
    );
    return Column(
      children: [
        _buildNavigationRow(controller),
        _buildPageView(controller),
      ],
    );
  }
}
