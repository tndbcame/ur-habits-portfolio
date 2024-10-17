import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog({
    super.key,
    required this.routeManager,
    required this.messages,
  });
  final RouteManager routeManager;
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
                      routeManager.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: SingleChildScrollView(
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
