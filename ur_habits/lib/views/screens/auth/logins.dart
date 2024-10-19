//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/utils/ui/ui_helper.dart';
import 'package:ur_habits/utils/ui/validators/auth_validator.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/resources/extension/firebase_auth_error_extension.dart';
import 'package:ur_habits/data/services/firebase_service.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/screens/auth/components/button/auth_spring_button.dart';
import 'package:ur_habits/views/screens/auth/components/container/auth_form_container.dart';
import 'package:ur_habits/views/screens/auth/components/form/auth_text_form.dart';
import 'package:ur_habits/views/screens/auth/components/tile/auth_input_list_tile.dart';
import 'package:ur_habits/views/screens/tabs/tabs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.isLogin,
    required this.routeManager,
  });

  final bool isLogin;
  final RouteManager routeManager;
  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();
  // final FirebaseService _firebaseServices = FirebaseService();
  final bool _isSendMail = false;
  final bool _isLoading = false;
  String _enteredUsername = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  String? _enteredConfirmationPassword;

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, widget.routeManager, [
      DiscriptionTitle(title: TextContents.emailAddress.text),
      DiscriptionText(text: TextContents.emailAddressFormatError.text),
      DiscriptionTitle(title: TextContents.password.text),
      DiscriptionText(text: TextContents.passwordConfirmationEntry.text),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DiscriptionText(
          text: TextContents.newAccountOnlyMessage.text,
          size: 16,
        ),
      ),
      DiscriptionTitle(title: TextContents.username.text),
      DiscriptionText(text: TextContents.accountUsernameEntry.text),
      DiscriptionTitle(title: TextContents.confirmPassword.text),
      DiscriptionText(text: TextContents.passwordEntryInstructions.text),
      const SizedBox(height: 20),
      DiscriptionText(text: TextContents.emailConfirmationInstructions.text),
    ]);
  }

  // /// FirebaseAuthExceptionの処理
  // void _handleFirebaseAuthException(FirebaseAuthException e) {
  //   if (!mounted) return;
  //   String message = FirebaseAuthErrorExtension.fromCode(e.code).message;
  //   DialogHelper.showCautionDialog(context, widget.routeManager, message);
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  /// キャンセル処理
  void _handleOnCansel() async {
    if (UIHelper.isKeyboardVisible(context)) {
      await UIHelper.closeKeyboard(context);
      await Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        widget.routeManager.pop(context);
      });
    } else {
      widget.routeManager.pop(context);
    }
  }

  // /// Firebaseでの認証処理を行う
  // Future<UserCredential?> _authenticate(
  //     Future<UserCredential> Function(String, String) authMethod) async {
  //   try {
  //     return await authMethod(_enteredEmail, _enteredPassword);
  //   } on FirebaseAuthException catch (e) {
  //     _handleFirebaseAuthException(e);
  //   }
  //   return null;
  // }

  // /// フォーム送信処理を行う
  // void _submitForm() async {
  //   _formKey.currentState!.save();
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     final UserCredential? userCredential = await _authenticate(
  //       widget.isLogin
  //           ? _firebaseServices.signInUser
  //           : _firebaseServices.registerUser,
  //     );
  //     if (userCredential != null && userCredential.user != null) {
  //       if (!widget.isLogin) {
  //         await userCredential.user!.sendEmailVerification();
  //         _firebaseViewModel.setUserInfo(
  //             _firebaseViewModel.getUid(), _enteredUsername, _enteredEmail);
  //         setState(() {
  //           _isSendMail = true;
  //         });
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         if (!mounted) return;
  //         await DialogHelper.showCautionDialog(
  //             context, widget.routeManager, TextContents.emailSentSuccess.text);
  //       } else {
  //         if (!mounted) return;
  //         await widget.routeManager.push(context, const TabsScreen());
  //       }
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // /// メール確認処理を行う
  // void _completeEmailVerification() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final userCredential = await _authenticate(_firebaseServices.signInUser);
  //   if (userCredential == null || userCredential.user == null) return;
  //   final User user = userCredential.user!;
  //   if (!mounted) return;
  //   if (user.emailVerified) {
  //     await DialogHelper.showCautionDialog(context, widget.routeManager,
  //         TextContents.emailConfirmationComplete.text);
  //     if (!mounted) return;
  //     await widget.routeManager.push(
  //       context,
  //       const TabsScreen(),
  //     );
  //   } else {
  //     await DialogHelper.showCautionDialog(
  //         context, widget.routeManager, TextContents.checkEmail.text);
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  /// 共通のSpringButtonを生成する
  Widget _buildSpringButton({
    required String label,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AuthSpringButton(
            label: label,
            buttonColor: buttonColor,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  /// AppBarを構築する
  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 110,
      leading: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedArrowLeft01,
        labelText: TextContents.cancel.text,
        isBoldText: false,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: _handleOnCansel,
      ),
      backgroundColor: kTextBaseColor,
      actions: [
        HelpButton(
          onHelpTap: _showDescriptionDialog,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
          padding: 12,
        ),
      ],
    );
  }

  /// フォームのメインコンテンツを構築する
  Widget _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Form(
        key: _formKey,
        child: !_isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    AuthFormContainer(
                      backgroundColor: kLightGray5,
                      children: [
                        if (!widget.isLogin) _buildUsernameField(),
                        _buildEmailField(),
                        _buildPasswordField(),
                        if (!widget.isLogin) _buildConfirmationPasswordField(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildActionButton(),
                        if (_isSendMail) _buildVerificationButton(),
                      ],
                    ),
                  ],
                ),
              )
            : const Center(
                child: CustomIndicator(),
              ),
      ),
    );
  }

  /// ユーザー名フィールドを構築する
  Widget _buildUsernameField() {
    return AuthInputListTile(
      backgroundColor: kLightGray5,
      title: TextContents.username.text,
      textForm: AuthTextForm(
        initialValue: _enteredUsername,
        inputType: TextInputType.name,
        validator: AuthValidator.validUsername,
        onSaved: (value) => _enteredUsername = value!,
        maxLength: 10,
      ),
    );
  }

  /// メールアドレスフィールドを構築する
  Widget _buildEmailField() {
    return AuthInputListTile(
      backgroundColor: kLightGray5,
      title: TextContents.emailAddress.text,
      textForm: AuthTextForm(
        initialValue: _enteredEmail,
        inputType: TextInputType.emailAddress,
        validator: AuthValidator.validEmail,
        onSaved: (value) => _enteredEmail = value!,
      ),
    );
  }

  /// パスワードフィールドを構築する
  Widget _buildPasswordField() {
    return AuthInputListTile(
      backgroundColor: kLightGray5,
      title: TextContents.password.text,
      textForm: AuthTextForm(
          initialValue: _enteredPassword,
          inputType: TextInputType.text,
          validator: (value) => AuthValidator.validPassword(
                value,
                confirmationPassword: _enteredConfirmationPassword,
              ),
          onSaved: (value) => _enteredPassword = value!,
          obscureText: true,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@_.-]'))
          ],
          isConfirmPass: false),
      isFinal: widget.isLogin,
    );
  }

  /// 確認用パスワードフィールドを構築する
  Widget _buildConfirmationPasswordField() {
    return AuthInputListTile(
      backgroundColor: kLightGray5,
      title: TextContents.confirmPassword.text,
      textForm: AuthTextForm(
        initialValue: _enteredConfirmationPassword,
        inputType: TextInputType.text,
        validator: (value) => AuthValidator.validPassword(
          value,
        ),
        onSaved: (value) => _enteredConfirmationPassword = value,
        obscureText: true,
        formatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@_.-]'))
        ],
        isConfirmPass: true,
      ),
      isFinal: true,
    );
  }

  /// 送信ボタンを構築する
  Widget _buildActionButton() {
    return _buildSpringButton(
        label: widget.isLogin
            ? TextContents.login.text
            : _isSendMail
                ? TextContents.resendConfirmationEmail.text
                : TextContents.sendConfirmationEmail.text,
        buttonColor:
            widget.isLogin ? Theme.of(context).primaryColor : kSecondBaseColor,
        // onTap: _submitForm,
        onTap: () {} //仮の処理
        );
  }

  /// メール確認完了ボタンを構築する
  Widget _buildVerificationButton() {
    return _buildSpringButton(
        label: TextContents.emailConfirmed.text,
        buttonColor: kSecondBaseColor,
        // onTap: _completeEmailVerification,
        onTap: () {} //仮の処理
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: kTextBaseColor,
      body: _buildFormContent(),
    );
  }
}
