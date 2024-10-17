import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/firebase_auth_error_extension.dart';
import 'package:ur_habits/data/services/firebase_service.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/utils/ui/validators/auth_validator.dart';
import 'package:ur_habits/views/components/Indicator/custom_indicator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/screens/auth/components/container/auth_form_container.dart';
import 'package:ur_habits/views/screens/auth/components/form/auth_text_form.dart';
import 'package:ur_habits/views/screens/auth/components/tile/auth_input_list_tile.dart';

class RePasswordScreen extends StatefulWidget {
  const RePasswordScreen({
    super.key,
    required this.routeManager,
    this.title,
    this.cationText,
    this.appBarColor,
    this.containerColor,
    this.backgroundColor,
    this.email,
  });

  final RouteManager routeManager;
  final String? title;
  final String? cationText;
  final Color? containerColor;
  final Color? appBarColor;
  final Color? backgroundColor;
  final String? email;

  @override
  State<RePasswordScreen> createState() => _RePasswordScreenState();
}

class _RePasswordScreenState extends State<RePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseServices = FirebaseService();
  bool _isLoading = false;
  late String _enteredEmail;

  @override
  void initState() {
    super.initState();
    _initializeEmail();
  }

  /// 初期化処理をに分離
  void _initializeEmail() {
    _enteredEmail = widget.email ?? '';
  }

  /// FirebaseAuthExceptionを処理する
  void _handleFirebaseAuthException(FirebaseAuthException e) {
    if (!mounted) return;
    final message = FirebaseAuthErrorExtension.fromCode(e.code).message;
    DialogHelper.showCautionDialog(context, widget.routeManager, message);
  }

  /// パスワードリセット完了時の処理
  Future<void> _onComplete() async {
    if (_validateAndSaveForm()) {
      _toggleLoading(true);
      try {
        await _firebaseServices.resetPassword(_enteredEmail);
      } on FirebaseAuthException catch (e) {
        _handleFirebaseAuthException(e);
        return;
      } finally {
        _toggleLoading(false);
      }
      await _showSuccessDialog();
      if (!mounted) return;
      widget.routeManager.pop(context);
    }
  }

  /// フォームのバリデーションと保存を行う
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// ローディング状態を切り替える
  void _toggleLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  /// 成功ダイアログを表示する
  Future<void> _showSuccessDialog() async {
    await DialogHelper.showCautionDialog(
      context,
      widget.routeManager,
      TextContents.passwordResetEmailSent.text,
    );
  }

  /// 戻るボタンのウィジェット生成
  Widget _buildBackButton() {
    return ColorChangingTextButton(
      leftIcon: HugeIcons.strokeRoundedArrowLeft01,
      labelText: TextContents.cancel.text,
      isBoldText: false,
      normalColor: kTextBaseColorBlack,
      pressedColor: kTextBaseColorBlack.withAlpha(150),
      onTap: () => widget.routeManager.pop(context),
    );
  }

  /// 説明文のウィジェット生成
  Widget _buildCationText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: Text(
        widget.cationText ?? '',
        style: const TextStyle(
          color: kTextBaseColorBlack,
          fontSize: 14,
        ),
      ),
    );
  }

  /// フォームウィジェットの生成
  Widget _buildAuthForm() {
    return AuthFormContainer(
      backgroundColor: widget.containerColor,
      children: [
        Form(
          key: _formKey,
          child: AuthInputListTile(
            backgroundColor: widget.containerColor,
            title: TextContents.emailAddress.text,
            textForm: AuthTextForm(
              initialValue: _enteredEmail,
              inputType: TextInputType.emailAddress,
              validator: AuthValidator.validEmail,
              onSaved: (value) => _enteredEmail = value!,
            ),
            isFinal: true,
          ),
        ),
      ],
    );
  }

  /// 送信ボタンのウィジェット生成
  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: ColorChangingTextButton(
        mainAxisAlignment: MainAxisAlignment.center,
        normalColor: kTextSecondBaseColor,
        pressedColor: kTextSecondBaseColor.withAlpha(150),
        labelText: TextContents.sendPasswordResetLink.text,
        onTap: _onComplete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.appBarColor ?? kLightGray2,
      appBar: AppBar(
        leadingWidth: 110,
        leading: _buildBackButton(),
        title: Text(
          widget.title ?? '',
          style: const TextStyle(
            color: kTextThirdBaseColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: widget.backgroundColor ?? kLightGray3,
      ),
      body: _isLoading
          ? const Center(child: CustomIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildCationText(),
                  _buildAuthForm(),
                  _buildSubmitButton(),
                ],
              ),
            ),
    );
  }
}
