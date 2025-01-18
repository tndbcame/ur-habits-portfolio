import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';

import 'package:ur_habits/views/components/button/color_changing_text_button.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    super.key,
    required this.backgroundColor,
  });

  final Color backgroundColor;

  /// ログインパネル全体のコンテナを構築
  Widget _buildLoginContainer(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLoginText(),
          _buildButtonRow(context),
        ],
      ),
    );
  }

  /// コンテナのデコレーション設定
  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildLoginText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(TextContents.pleaseLogin.text),
    );
  }

  /// ボタンを配置する行ウィジェット
  Widget _buildButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLoginButton(context),
        ],
      ),
    );
  }

  /// ログインボタンを構築
  Widget _buildLoginButton(BuildContext context) {
    return ColorChangingTextButton(
      normalColor: Theme.of(context).primaryColor,
      pressedColor: Theme.of(context).primaryColor.withAlpha(150),
      isBoldText: false,
      onTap: () => _navigateToTitleScreen(context),
      leftIcon: HugeIcons.strokeRoundedLoginCircle01,
      labelText: TextContents.login.text,
      textSize: 14,
    );
  }

  /// タイトル画面への遷移処理
  Future<void> _navigateToTitleScreen(BuildContext context) async {
    await context.push(RouterEnums.title.paths, extra: TitlesData());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildLoginContainer(context),
    );
  }
}
