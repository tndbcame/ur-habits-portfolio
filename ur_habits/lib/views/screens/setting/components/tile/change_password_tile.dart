import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/tile/auth_list_tile.dart';
//import 'package:ur_habits/views/screens/auth/re_paswords.dart';

class ChangePasswordTile extends StatelessWidget {
  const ChangePasswordTile({
    super.key,
    required this.email,
    required this.routeManager,
  });

  final RouteManager routeManager;
  final String email;

  /// パスワード変更処理の画面へ遷移する
  Future<void> _navigateToRePasswordScreen(BuildContext context) async {
    // await routeManager.push<String>(
    //   context,
    //   RePasswordScreen(
    //     routeManager: routeManager,
    //     email: email,
    //     title: TextContents.changePassword.text,
    //     cationText: TextContents.passwordResetEmailDescription.text +
    //         TextContents.enterCurrentEmail.text,
    //   ),
    // );
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
