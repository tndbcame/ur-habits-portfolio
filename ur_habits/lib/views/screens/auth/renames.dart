import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/validators/auth_validator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/components/scroll/ur_habits_scroll_view.dart';
import 'package:ur_habits/views/screens/auth/components/container/auth_form_container.dart';
import 'package:ur_habits/views/screens/auth/components/form/auth_text_form.dart';
import 'package:ur_habits/views/screens/auth/components/tile/auth_input_list_tile.dart';

class RenameScreen extends StatefulWidget {
  const RenameScreen({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<RenameScreen> createState() => _RenameScreenState();
}

class _RenameScreenState extends State<RenameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _enteredName;

  @override
  void initState() {
    super.initState();
    _initializeEnteredName();
  }

  // 初期化処理
  void _initializeEnteredName() {
    _enteredName = widget.name;
  }

  /// 完了ボタン押下時の処理
  void _onComplete() {
    if (_validateAndSaveForm()) {
      context.pop<String>(_enteredName);
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

  /// 戻るボタンのウィジェット生成
  Widget _buildBackButton() {
    return ColorChangingTextButton(
      leftIcon: HugeIcons.strokeRoundedArrowLeft01,
      labelText: TextContents.cancel.text,
      isBoldText: false,
      normalColor: kTextBaseColorBlack,
      pressedColor: kTextBaseColorBlack.withAlpha(150),
      onTap: () => context.pop(),
    );
  }

  /// 完了ボタンのウィジェット生成
  Widget _buildCompleteButton() {
    return ColorChangingTextButton(
      labelText: TextContents.complete.text,
      isBoldText: true,
      normalColor: kTextBaseColorBlack,
      pressedColor: kTextBaseColorBlack.withAlpha(150),
      onTap: _onComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: AppBar(
        leadingWidth: 110,
        leading: _buildBackButton(),
        title: Text(
          TextContents.changeUsername.text,
          style: const TextStyle(
            color: kTextThirdBaseColor,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          _buildCompleteButton(),
          const SizedBox(width: 12.0),
        ],
        centerTitle: true,
        backgroundColor: kLightGray3,
      ),
      body: UrHabitsScrollView(
        child: Column(
          children: [
            AuthFormContainer(
              children: [
                Form(
                  key: _formKey,
                  child: AuthInputListTile(
                    title: TextContents.username.text,
                    textForm: AuthTextForm(
                      inputType: TextInputType.name,
                      initialValue: widget.name,
                      validator: AuthValidator.validUsername,
                      onSaved: (val) => _enteredName = val!,
                      maxLength: 10,
                    ),
                    isFinal: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
