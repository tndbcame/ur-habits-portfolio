import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/calender/calender_page_view.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_view.dart';

class DeadlineScreen extends StatefulWidget {
  const DeadlineScreen({
    super.key,
    this.selectedDate,
  });

  final DateTime? selectedDate;
  @override
  State<DeadlineScreen> createState() => _DeadlineScreenState();
}

class _DeadlineScreenState extends State<DeadlineScreen> {
  /// キャンセルボタン押下時に画面を戻す処理
  void _onCancelPressed(BuildContext context) {
    context.pop();
  }

  /// 日付が選択された時の処理
  void _onDaySelected(BuildContext context, DateTime selectedDay) {
    context.pop<DateTime>(selectedDay);
  }

  /// アップバー
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 110,
      leading: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedArrowLeft01,
        labelText: TextContents.cancel.text,
        isBoldText: false,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: () => _onCancelPressed(context),
      ),
      title: Text(
        TextContents.goalDeadline.text,
        style: const TextStyle(
          color: kTextThirdBaseColor,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: kLightGray3,
    );
  }

  /// ボディ部分
  Widget _buildBody() {
    return UrHabitsScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CalenderPageView(
          height: 356,
          initialPage: 1200,
          useInputToday: false,
          notUseBeforeToday: true,
          notUseAfterToday: false,
          useAsInput: true,
          useAsDialog: false,
          onDaySelected: (context, selectedDay) {
            _onDaySelected(context, selectedDay);
          },
          selectedDate: widget.selectedDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}
