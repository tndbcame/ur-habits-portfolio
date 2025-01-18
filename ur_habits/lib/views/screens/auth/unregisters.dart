import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/data/services/firebase_service.dart';
import 'package:ur_habits/resources/extension/firebase_auth_error_extension.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/helpers/dialog_helper.dart';
import 'package:ur_habits/utils/ui/validators/auth_validator.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_view.dart';
import 'package:ur_habits/views/screens/auth/components/form/auth_text_form.dart';
import 'package:ur_habits/views/screens/auth/components/tile/auth_input_list_tile.dart';

class UnregisterScreen extends StatefulWidget {
  const UnregisterScreen({
    super.key,
  });

  @override
  State<UnregisterScreen> createState() => _UnregisterScreenState();
}

class _UnregisterScreenState extends State<UnregisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseServices = FirebaseService();
  final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();
  bool _isLoading = false;
  String _enteredEmail = '';
  String _enteredPassword = '';

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  /// 初期化処理を
  void _initializeFields() {
    _enteredEmail = '';
    _enteredPassword = '';
  }

  /// FirebaseAuthExceptionの処理
  void _handleFirebaseAuthException(FirebaseAuthException e) {
    if (!mounted) return;
    final message = FirebaseAuthErrorExtension.fromCode(e.code).message;
    DialogHelper.showCautionDialog(context, message);
  }

  /// 退会処理の完了時の処理
  Future<void> _onComplete() async {
    if (_validateAndSaveForm()) {
      final result = await _confirmUnregister();
      if (result == true) {
        _executeUnregister();
      }
    }
  }

  /// 確認ダイアログを表示
  Future<bool?> _confirmUnregister() {
    return DialogHelper.showSelectDialog(
      context,
      TextContents.confirmWithdrawal.text,
      TextContents.withdraw.text,
      Theme.of(context).primaryColor,
    );
  }

  /// 退会処理の実行
  Future<void> _executeUnregister() async {
    setState(() => _isLoading = true);
    int resultStatus = 1;
    try {
      await _firebaseServices.reauthenticateUser(
          _enteredEmail, _enteredPassword);
      resultStatus = await _firebaseViewModel.deleteUserData();
      await _handleResultStatus(resultStatus);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthException(e);
    } finally {
      setState(() => _isLoading = false);
    }
    if (mounted && resultStatus == 1) {
      context.pop();
    }
  }

  /// 結果に基づく処理を行う
  Future<void> _handleResultStatus(int resultStatus) async {
    if (resultStatus == 1) {
      await _firebaseServices.deleteUser();
      await _showCompletionDialog(TextContents.withdrawalComplete.text);
    } else if (resultStatus == 0) {
      await _showCompletionDialog(TextContents.noInternet.text);
    } else {
      await _showCompletionDialog(TextContents.unexpectedError.text);
    }
  }

  /// 完了ダイアログを表示する
  Future<void> _showCompletionDialog(String message) async {
    if (mounted) {
      await DialogHelper.showCautionDialog(context, message);
    }
  }

  /// フォームのバリデーションと保存
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// フォームのメインコンテンツを構築する
  Widget _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Form(
        key: _formKey,
        child: !_isLoading
            ? UrHabitsScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Text(
                        TextContents.reauthRequiredForWithdrawal.text,
                        style: const TextStyle(color: kTextBaseColorBlack),
                      ),
                    ),
                    _buildInputFields(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Text(
                        TextContents.deleteAccountWarning.text,
                        style: const TextStyle(color: kTextBaseColorBlack),
                      ),
                    ),
                    ColorChangingTextButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      normalColor: kRed,
                      pressedColor: kRed.withAlpha(150),
                      labelText: TextContents.confirmWithdrawalAction.text,
                      textSize: 16,
                      onTap: _onComplete,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CustomIndicator(
                  color: kTextBaseColor,
                ),
              ),
      ),
    );
  }

  /// 入力フィールド群を構築する
  Widget _buildInputFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: kTextBaseColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEmailField(),
              _buildPasswordField(),
            ],
          ),
        ),
      ),
    );
  }

  /// メールアドレスフィールドを構築する
  Widget _buildEmailField() {
    return AuthInputListTile(
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
      title: TextContents.password.text,
      textForm: AuthTextForm(
        initialValue: _enteredPassword,
        inputType: TextInputType.text,
        validator: (value) => AuthValidator.validPassword(value),
        onSaved: (value) => _enteredPassword = value!,
        obscureText: true,
        formatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@_.-]'))
        ],
        isConfirmPass: false,
      ),
      isFinal: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: AppBar(
        leadingWidth: 110, // leadingWidthを設定する
        leading: ColorChangingTextButton(
          leftIcon: HugeIcons.strokeRoundedArrowLeft01,
          labelText: TextContents.cancel.text,
          isBoldText: false,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
          onTap: () => context.pop(),
        ),
        title: Text(
          TextContents.confirmWithdrawalAction.text,
          style: const TextStyle(
            color: kTextThirdBaseColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: kLightGray3,
      ),
      body: _buildFormContent(),
    );
  }
}
