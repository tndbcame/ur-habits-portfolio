import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitDetailTextForm extends StatelessWidget {
  const HabitDetailTextForm({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLength,
    this.initialValue,
    this.onTap,
    this.validator,
    this.onSaved,
  });

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int? maxLength;
  final String? initialValue;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  /// テキストフィールドのデコレーションを作成する
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: kLightGray4,
      ),
      focusColor: kLightGray4,
      border: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
      enabledBorder: _buildOutlineInputBorder(),
      errorBorder: _buildOutlineInputBorder(),
      focusedErrorBorder: _buildOutlineInputBorder(),
      disabledBorder: _buildOutlineInputBorder(),
    );
  }

  /// ボーダーのスタイルを設定する
  OutlineInputBorder _buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: kLightGray4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: kTextThirdBaseColor,
      ),
      controller: controller,
      cursorColor: kTextThirdBaseColor,
      cursorErrorColor: kTextThirdBaseColor,
      decoration: _buildInputDecoration(),
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      initialValue: initialValue,
      onTap: onTap,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
