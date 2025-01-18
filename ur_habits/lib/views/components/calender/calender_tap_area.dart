import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/color_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/calender/calender_date_button.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_manager.dart';

class CalendarTapArea extends StatefulWidget {
  final bool useAsDialog;
  final bool useAsInput;
  final bool isDeadline;
  final bool isSelectedDate;
  final bool isToday;
  final bool isOldToday;
  final bool isFutureToday;
  final bool isOtherMonth;
  final DateTime date;
  final HabitView? habit;
  final void Function(BuildContext context, DateTime date) onDaySelected;
  final Color Function(BuildContext context, DateTime date) dateTextColor;

  const CalendarTapArea({
    super.key,
    required this.useAsDialog,
    required this.useAsInput,
    required this.isDeadline,
    required this.isSelectedDate,
    required this.isToday,
    required this.isOldToday,
    required this.isFutureToday,
    required this.isOtherMonth,
    required this.date,
    required this.habit,
    required this.onDaySelected,
    required this.dateTextColor,
  });

  @override
  State<CalendarTapArea> createState() => _CalendarTapAreaState();
}

class _CalendarTapAreaState extends State<CalendarTapArea>
    with TickerProviderStateMixin {
  final OverlayManager _overlayManager = OverlayManager();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        CalenderDateButton(
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
          normalColor: widget.isDeadline
              ? kYellow2
              : (widget.isSelectedDate
                  ? Theme.of(context).primaryColor
                  : kTextBaseColor),
          pressedColor: widget.isDeadline
              ? kYellow3
              : (widget.isSelectedDate
                  ? Theme.of(context).primaryColor.applyOpacity(0.3)
                  : kLightGray3),
          borderRadius: BorderRadius.circular(10),
          border: widget.useAsInput && widget.isToday
              ? Border.all(width: 1, color: kRed)
              : null,
          onTap: () {
            if (!widget.isToday &&
                (widget.isOldToday || widget.isFutureToday)) {
              String message = widget.isOldToday
                  ? TextContents.pastDateError.text
                  : TextContents.futureDateError.text;
              _overlayManager.showOverlayDialog(context, this, message);
              return;
            }
            if (!context.mounted) return;
            widget.onDaySelected(context, widget.date);
          },
          child: widget.habit != null &&
                  widget.habit!.records != null &&
                  widget.habit!.records!.containsKey(widget.date)
              ? Column(
                  children: [
                    const SizedBox(height: 15),
                    Icon(HugeIcons.strokeRoundedTick01,
                        color: Theme.of(context).primaryColor),
                  ],
                )
              : widget.useAsInput
                  ? _buildDayText(context)
                  : null,
        ),
        if (!widget.useAsInput && !widget.isToday)
          Positioned(
            top: -2,
            child: IgnorePointer(
              child: _buildDayText(context),
            ),
          ),
        if (!widget.useAsInput && widget.isToday)
          Positioned(
            top: -2,
            child: IgnorePointer(
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: kToday.applyOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    widget.date.day.toString(),
                    style: const TextStyle(fontSize: 16, color: kTextBaseColor),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDayText(BuildContext context) {
    return Text(
      widget.date.day.toString(),
      style: TextStyle(
        fontSize: 16,
        color: widget.isSelectedDate
            ? kTextBaseColor
            : !widget.isToday && widget.isOldToday
                ? kDarkGray
                : widget.isOtherMonth
                    ? kLightGray
                    : widget.dateTextColor(context, widget.date),
      ),
    );
  }
}
