import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/router_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/routers/router_data.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/screens/auth/components/button/auth_spring_button.dart';

class TitleScreen extends ConsumerStatefulWidget {
  const TitleScreen({super.key});

  @override
  ConsumerState<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends ConsumerState<TitleScreen> {
  @override
  void initState() {
    super.initState();
  }

  /// 戻るボタンのウィジェットを生成
  Widget _buildBackButton() {
    return ColorChangingTextButton(
      leftIcon: HugeIcons.strokeRoundedArrowLeft01,
      labelText: TextContents.back.text,
      isBoldText: false,
      normalColor: kTextBaseColorBlack,
      pressedColor: kTextBaseColorBlack.withAlpha(150),
      onTap: () => context.pop(),
    );
  }

  /// ログインボタンの生成
  Widget _buildLoginButton() {
    return AuthSpringButton(
      label: TextContents.login.text,
      buttonColor: Theme.of(context).primaryColor,
      onTap: () async {
        await context.push(RouterEnums.login.paths,
            extra: LoginsData(isLogin: true));
      },
      height: 50,
      width: 300,
    );
  }

  /// 新規登録ボタンの生成
  Widget _buildSignUpButton() {
    return AuthSpringButton(
      label: TextContents.register.text,
      buttonColor: kSecondBaseColor,
      onTap: () async {
        await context.push(RouterEnums.login.paths,
            extra: LoginsData(isLogin: false));
      },
      height: 50,
      width: 300,
    );
  }

  /// パスワード再設定ボタンの生成
  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: ColorChangingTextButton(
        mainAxisAlignment: MainAxisAlignment.center,
        normalColor: kTextSecondBaseColor,
        pressedColor: kTextSecondBaseColor.withAlpha(150),
        labelText: TextContents.forgotPassword.text,
        onTap: () async {
          await context.push(RouterEnums.repassword.paths,
              extra: RepasswordsData(
                cationText: TextContents.passwordResetEmailDescription.text +
                    TextContents.enterEmail.text,
                appBarColor: kTextBaseColor,
                containerColor: kLightGray5,
                backgroundColor: kTextBaseColor,
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: _buildBackButton(),
        backgroundColor: kTextBaseColor,
      ),
      backgroundColor: kTextBaseColor,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 175,
                    child: Image.asset(assetsMap['urHabitsTitle']!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      TextContents.appName.text,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(child: _buildLoginButton()),
            const SizedBox(height: 10),
            Center(child: _buildSignUpButton()),
            _buildForgotPasswordButton(),
          ],
        ),
      ),
    );
  }
}
