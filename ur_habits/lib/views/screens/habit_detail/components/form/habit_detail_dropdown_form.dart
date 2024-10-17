import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitDetailDropdownForm<T> extends StatelessWidget {
  const HabitDetailDropdownForm({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.onTap,
  });

  final List<DropdownMenuItem<T>>? items;
  final T? selectedValue;
  final void Function(T?)? onChanged;
  final VoidCallback? onTap;

  /// 入力フィールドのデコレーションを設定する
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      enabledBorder: _buildOutlineInputBorder(),
      border: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
    );
  }

  /// ボーダーのスタイルを設定する
  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: kTextBaseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 1,
      decoration: _buildInputDecoration(),
      value: selectedValue,
      items: items,
      isExpanded: true,
      alignment: AlignmentDirectional.center,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
