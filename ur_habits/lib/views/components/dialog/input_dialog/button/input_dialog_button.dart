import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/spring_button.dart';

class InputDialogButton extends StatelessWidget {
  const InputDialogButton({
    super.key,
    required this.onOkPressed,
    required this.buttonColor,
  });

  final VoidCallback onOkPressed;

  final Color buttonColor;

  /// キャンセルボタンを作成する
  Widget _buildCancelButton(BuildContext context) {
    return _buildTextButton(
      context,
      onPressed: () {
        context.pop();
      },
      labelName: TextContents.cancel.text,
      color: buttonColor,
    );
  }

  /// OKボタンを作成する
  Widget _buildOkButton(BuildContext context) {
    return _buildTextButton(
      context,
      onPressed: onOkPressed,
      labelName: TextContents.ok.text,
      color: buttonColor,
    );
  }

  /// ボタンの共通ウィジェットを作成する
  Widget _buildTextButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required String labelName,
    required Color color,
  }) {
    return SpringButton(
      onTap: onPressed,
      child: SizedBox(
        width: 100,
        height: 50,
        child: Center(
          child: Text(
            labelName,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCancelButton(context),
        _buildOkButton(context),
      ],
    );
  }
}
