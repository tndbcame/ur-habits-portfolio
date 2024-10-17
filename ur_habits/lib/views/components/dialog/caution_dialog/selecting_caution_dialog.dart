import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';

class SelectingCautionDialog extends StatelessWidget {
  const SelectingCautionDialog({
    super.key,
    required this.routeManager,
    this.dialogPaddingHorizontal,
    required this.message,
    this.messageFontSize,
    required this.confirmButtonText,
    required this.confirmButtonColor,
  });

  final RouteManager routeManager;
  final double? dialogPaddingHorizontal;
  final String message;
  final double? messageFontSize;
  final String confirmButtonText;
  final Color confirmButtonColor;

  /// ダイアログのメッセージ部分
  Widget _buildMessage() {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: messageFontSize ?? 20),
      ),
    );
  }

  /// ダイアログのボタン部分
  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton(
          context,
          label: TextContents.cancel.text,
          onPressed: () {
            routeManager.pop(context);
          },
          buttonColor: kDialogTextColor,
          height: 100,
        ),
        _buildDialogButton(
          context,
          label: confirmButtonText,
          onPressed: () {
            routeManager.pop<bool>(context, true);
          },
          buttonColor: confirmButtonColor,
          height: 50,
        ),
      ],
    );
  }

  /// ボタンの共通処理
  Widget _buildDialogButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required Color buttonColor,
    required double height,
  }) {
    return SpringButton(
      onTap: onPressed,
      child: SizedBox(
        width: height,
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color: buttonColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: kTextBaseColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: dialogPaddingHorizontal ?? 80.0,
        vertical: 24.0,
      ),
      shadowColor: kTextBaseColorBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            _buildMessage(),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              thickness: 1,
              color: kLightGray9,
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }
}
