import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/utils/ui/helpers/ui_helper.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
    required this.onHelpTap,
    this.normalColor = kTextBaseColor,
    this.pressedColor = kTextBaseColorBlack,
    this.padding = 8,
  });
  final Future<void> Function() onHelpTap;
  final Color normalColor;
  final Color pressedColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedHelpCircle,
        isBoldText: true,
        normalColor: normalColor,
        pressedColor: pressedColor,
        onTap: () async {
          if (UIHelper.isKeyboardVisible(context)) {
            await UIHelper.closeKeyboard(context);
            await Future.delayed(const Duration(milliseconds: 100), () {
              onHelpTap();
            });
          } else {
            onHelpTap();
          }
        },
      ),
    );
  }
}
