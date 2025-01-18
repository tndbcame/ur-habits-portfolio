import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_view.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog({
    super.key,
    required this.messages,
  });

  final List<Widget> messages;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: kTextBaseColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      shadowColor: kTextBaseColorBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: ColorChangingTextButton(
                    leftIcon: HugeIcons.strokeRoundedCancel01,
                    isBoldText: true,
                    normalColor: kTextBaseColorBlack,
                    pressedColor: kTextBaseColorBlack.withAlpha(150),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: UrHabitsScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: messages,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
