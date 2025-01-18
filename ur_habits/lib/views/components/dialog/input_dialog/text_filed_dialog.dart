import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/validators/habit_validator.dart';
import 'package:ur_habits/utils/ui/validators/input_validator.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/button/input_dialog_button.dart';

class TextFiledDialog extends StatefulWidget {
  const TextFiledDialog({
    super.key,
    required this.titleText,
    required this.hintText,
  });

  final String titleText;
  final String hintText;

  @override
  State<TextFiledDialog> createState() => _TextFiledDialogState();
}

class _TextFiledDialogState extends State<TextFiledDialog> {
  final _formKey = GlobalKey<FormState>();
  final HabitValidator validator = HabitValidator();
  String _enteredValue = '';

  /// 入力値を保存する
  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.pop<String>(_enteredValue);
    }
  }

  /// メインの項目を作成する
  List<Widget> _buildMainItems() {
    return [
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.titleText,
              style: const TextStyle(
                color: kDialogTextColor,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextFormField(
              style: const TextStyle(color: kDialogTextColor),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: kLightGray4),
                focusColor: kDialogTextColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kDialogTextColor),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              textAlign: TextAlign.center,
              maxLength: 35,
              validator: (val) {
                if (!InputValidator.isNotEmpty(val)) {
                  return TextContents.enterValue.text;
                }
                return null;
              },
              onSaved: (val) {
                _enteredValue = val!;
              },
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Dialog(
            insetPadding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
            shadowColor: kTextBaseColorBlack,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._buildMainItems(),
                InputDialogButton(
                  onOkPressed: _saveItem,
                  buttonColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
