import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';

import 'package:ur_habits/views/components/tile/auth_list_tile.dart';

class ChangePasswordTile extends StatelessWidget {
  const ChangePasswordTile({
    super.key,
    required this.email,
  });

  final String email;

  /// パスワード変更処理の画面へ遷移する
  Future<void> _navigateToRePasswordScreen(BuildContext context) async {
    await context.push(
      RouterEnums.repassword.paths,
      extra: RepasswordsData(
        title: TextContents.changePassword.text,
        cationText: TextContents.passwordResetEmailDescription.text +
            TextContents.enterCurrentEmail.text,
        email: email,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthListTile(
      title: const Icon(
        HugeIcons.strokeRoundedForgotPassword,
        color: kTextThirdBaseColor,
      ),
      itemHeight: 70,
      itemWidth: double.infinity,
      mainAxisAlignment: MainAxisAlignment.center,
      useArrow: true,
      onTap: () async {
        await _navigateToRePasswordScreen(context);
      },
      mainItem: [
        Text(
          TextContents.updatePassword.text,
          style: const TextStyle(
            fontSize: 16,
            color: kTextThirdBaseColor,
          ),
        ),
      ],
    );
  }
}
