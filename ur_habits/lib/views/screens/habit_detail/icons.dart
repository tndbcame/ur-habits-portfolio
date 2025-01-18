import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/views/components/button/color_changing_box_button.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/colors.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({
    super.key,
    required this.iconId,
  });

  final int iconId;

  /// キャンセルボタンが押された時の処理
  void _onCancelPressed(BuildContext context) {
    context.pop();
  }

  /// アイコンが選択された時の処理
  void _onIconSelected(BuildContext context, int iconKey) {
    context.pop<int>(iconKey);
  }

  /// アップバー
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 110,
      leading: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedArrowLeft01,
        labelText: TextContents.cancel.text,
        isBoldText: false,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: () => _onCancelPressed(context),
      ),
      title: Text(
        TextContents.iconList.text,
        style: const TextStyle(
          color: kTextThirdBaseColor,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: kLightGray3,
    );
  }

  /// アイコンのグリッド
  Widget _buildIconGrid(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        for (final habitIcon in habitIcons.entries)
          ColorChangingBoxButton(
            mainAxisAlignment: MainAxisAlignment.center,
            normalColor: iconId == habitIcon.key
                ? Theme.of(context).primaryColor
                : kTextBaseColor,
            normalTextColor: iconId == habitIcon.key
                ? kTextBaseColor
                : Theme.of(context).primaryColor,
            pressedColor: iconId == habitIcon.key
                ? Theme.of(context).primaryColor.withAlpha(150)
                : kLightGray5,
            pressedTextColor: iconId == habitIcon.key
                ? kTextBaseColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            onTap: () => _onIconSelected(context, habitIcon.key),
            leftIcon: habitIcon.value,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: _buildAppBar(context),
      body: _buildIconGrid(context),
    );
  }
}
