import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';

class CautionDialog extends StatelessWidget {
  const CautionDialog({
    super.key,
    required this.message,
    this.messageFontSize,
    this.confirmButtonColor,
    required this.onConfirm,
  });

  final String message;
  final double? messageFontSize;
  final Color? confirmButtonColor;
  final VoidCallback? onConfirm;

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
            const SizedBox(height: 16),
            Center(
              child: Text(
                message,
                style: TextStyle(fontSize: messageFontSize ?? 16),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              thickness: 1,
              color: kLightGray9,
            ),
            SpringButton(
              onTap: onConfirm ?? () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    TextContents.ok.text,
                    style: TextStyle(
                      color: confirmButtonColor ?? kSecondBaseColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
