import 'package:flutter/material.dart';
import 'package:ur_habits/resources/colors.dart';

class AuthInputListTile extends StatelessWidget {
  const AuthInputListTile({
    super.key,
    required this.textForm,
    required this.title,
    this.backgroundColor,
    this.isFinal = false,
  });
  final Color? backgroundColor;
  final Widget textForm;
  final String title;
  final bool isFinal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: backgroundColor ?? kTextBaseColor,
        border: isFinal
            ? null
            : const Border(
                bottom: BorderSide(width: 1, color: kThirdBaseColor),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTitleBox(title),
            Expanded(child: textForm),
          ],
        ),
      ),
    );
  }

  /// タイトルボックスを構築する
  Widget _buildTitleBox(String title) {
    return SizedBox(
      width: 125,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 16, color: kTextBaseColorBlack),
      ),
    );
  }
}
