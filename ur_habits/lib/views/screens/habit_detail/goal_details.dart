import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/utils/ui/validators/habit_validator.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/screens/habit_detail/components/form/habit_detail_text_form.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/goal_detail/deadline_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/goal_detail/inc_dec_type_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/goal_detail/input_value_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/goal_detail/memo_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/title_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/deadlines.dart';
import 'package:ur_habits/resources/colors.dart';

class GoalDetailsScreen extends StatefulWidget {
  const GoalDetailsScreen({
    super.key,
    required this.routeManager,
    required this.selectedDataType,
    required this.accumulationType,
    required this.isUpdate,
    this.habitGoal,
  });

  final RouteManager routeManager;
  final DataType selectedDataType;
  final int accumulationType;
  final bool isUpdate;
  final HabitGoalView? habitGoal;

  @override
  State<StatefulWidget> createState() => _GoalDetailsScreen();
}

class _GoalDetailsScreen extends State<GoalDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _selectedIncDecVal;
  DateTime? _selectedDeadline;
  String _enteredTitle = '';
  String? _enteredMemo;
  late TextEditingController _currentController;
  late TextEditingController _targetController;
  late final HabitValues _enteredCurrentVal;
  late final HabitValues _enteredTargetVal;

  @override
  void initState() {
    super.initState();
    _initializeFormValues();
  }

  @override
  void dispose() {
    _currentController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  /// 初期化処理をまとめた
  void _initializeFormValues() {
    if (widget.habitGoal == null) {
      _initializeNewHabitValues();
    } else {
      _initializeExistingHabitValues();
    }
  }

  /// 新規作成時の初期化処理
  void _initializeNewHabitValues() {
    _currentController = TextEditingController();
    _targetController = TextEditingController();
    _enteredCurrentVal = HabitValues(str: '');
    _enteredTargetVal = HabitValues(str: '');
    _selectedIncDecVal =
        widget.accumulationType == 3 ? 1 : widget.accumulationType;
  }

  /// 既存データがある場合の初期化処理
  void _initializeExistingHabitValues() {
    _enteredTitle = widget.habitGoal!.title;
    _enteredCurrentVal = widget.isUpdate
        ? HabitValues(str: '')
        : widget.habitGoal!.currentValues;
    _enteredTargetVal = widget.habitGoal!.targetValues;
    _selectedIncDecVal =
        widget.accumulationType == 3 ? 1 : widget.accumulationType;
    _selectedDeadline = widget.habitGoal!.deadline;
    _enteredMemo = widget.habitGoal!.memo;
    _currentController = TextEditingController(text: _enteredCurrentVal.str);
    _targetController = TextEditingController(text: _enteredTargetVal.str);
  }

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, widget.routeManager, [
      DiscriptionTitle(title: TextContents.title.text),
      DiscriptionText(text: TextContents.enterGoalTitle.text),
      DiscriptionTitle(title: TextContents.goalValue.text),
      DiscriptionText(text: TextContents.enterGoalValue.text),
      DiscriptionTitle(title: TextContents.goalProgress.text),
      DiscriptionText(text: TextContents.enterGoalDegree.text),
      DiscriptionTitle(title: TextContents.currentValue.text),
      DiscriptionText(text: TextContents.enterCurrentValue.text),
      DiscriptionTitle(title: TextContents.goalDeadline.text),
      DiscriptionText(text: TextContents.enterDeadline.text),
      DiscriptionTitle(title: TextContents.note.text),
      DiscriptionText(text: TextContents.enterMemo.text),
      const SizedBox(height: 20),
      DiscriptionText(text: TextContents.requiredFieldsNote.text),
    ]);
  }

  /// 保存ボタンの処理
  void _onSave(String? val, bool isTarget) {
    if (val == null) return;
    if (isTarget) {
      _enteredTargetVal.str = val;
    } else {
      _enteredCurrentVal.str = val;
    }
  }

  /// 締め切り設定の処理
  Future<void> _setDeadline() async {
    final newDeadline = await widget.routeManager.push<DateTime>(
      context,
      DeadlineScreen(
        routeManager: widget.routeManager,
        selectedDate: _selectedDeadline,
      ),
    );
    if (newDeadline == null) return;

    setState(() {
      _selectedDeadline = newDeadline;
    });
  }

  void _onComplete() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      DateTime now = DateTime.now();
      DateTime nowDate = DateTime(now.year, now.month, now.day);
      widget.routeManager.pop<HabitGoalView>(
          context,
          HabitGoalView(
            title: _enteredTitle,
            incDecTyep: _selectedIncDecVal,
            currentValues: _enteredCurrentVal,
            targetValues: _enteredTargetVal,
            inputedDate: nowDate,
            deadline: _selectedDeadline,
            memo: _enteredMemo,
          ));
    }
  }

  /// 数値入力フィールドに該当するか判定する
  bool _isNumberInput(int dataTypeId, bool isTarget, int accumulationType) {
    return dataTypeId == 1 ||
        dataTypeId == 2 ||
        dataTypeId == 8 ||
        (dataTypeId == 6 && isTarget) ||
        (dataTypeId == 7 && accumulationType != 3);
  }

  /// 星ピッカーの結果を更新する
  void _updateStarPickerValues((String, DateTime?) result, bool isTarget) {
    if (isTarget) {
      _enteredTargetVal.str = result.$1;
      _targetController.value = TextEditingValue(text: result.$1);
    } else {
      _enteredCurrentVal.str = result.$1;
      _currentController.value = TextEditingValue(text: result.$1);
    }
  }

  /// 時間ピッカーの結果を更新する
  void _updateTimePickerValues(
      (Duration, String, DateTime?) result, bool isTarget) {
    if (isTarget) {
      _enteredTargetVal.dur = result.$1;
      _enteredTargetVal.str = result.$2;
      _targetController.value = TextEditingValue(text: result.$2);
    } else {
      _enteredCurrentVal.dur = result.$1;
      _enteredCurrentVal.str = result.$2;
      _currentController.value = TextEditingValue(text: result.$2);
    }
  }

  /// AppBarの構築
  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 110,
      leading: _buildCancelButton(),
      title: Text(
        TextContents.goal.text,
        style: const TextStyle(
          color: kTextThirdBaseColor,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: kLightGray3,
      actions: <Widget>[
        HelpButton(
          onHelpTap: _showDescriptionDialog,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
        ),
        _buildCompleteButton(),
      ],
    );
  }

  /// キャンセルボタンの構築
  Widget _buildCancelButton() {
    return ColorChangingTextButton(
      leftIcon: HugeIcons.strokeRoundedArrowLeft01,
      labelText: TextContents.cancel.text,
      isBoldText: false,
      normalColor: kTextBaseColorBlack,
      pressedColor: kTextBaseColorBlack.withAlpha(150),
      onTap: () => widget.routeManager.pop(context),
    );
  }

  /// 完了ボタンの構築
  Widget _buildCompleteButton() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ColorChangingTextButton(
        labelText: TextContents.complete.text,
        isBoldText: true,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: () => _onComplete(),
      ),
    );
  }

  /// ユーザー入力フィールドのビルドを行う
  Widget _buildInputField({
    required String initialVal,
    required DataType selectedDataType,
    required bool isTarget,
  }) {
    final int dataTypeId = selectedDataType.id;
    final int accumulationType = widget.accumulationType;

    /// データタイプに基づく異なる処理
    if (_isNumberInput(dataTypeId, isTarget, accumulationType)) {
      return _buildNumberInputField(initialVal, selectedDataType, isTarget);
    } else if (dataTypeId == 6) {
      return _buildTextFieldZero();
    } else if (dataTypeId == 7) {
      return _buildStarPickerField(selectedDataType, isTarget);
    } else {
      return _buildTimePickerField(selectedDataType, isTarget);
    }
  }

  /// 数値入力フィールドのビルド
  Widget _buildNumberInputField(
      String initialVal, DataType selectedDataType, bool isTarget) {
    return HabitDetailTextForm(
      keyboardType: TextInputType.number,
      maxLength: 8,
      initialValue: initialVal,
      validator: (val) {
        return HabitValidator.validGoalTextForm(
          val,
          _enteredCurrentVal.str,
          _enteredTargetVal.str,
          selectedDataType.id,
          _selectedIncDecVal,
          isTarget,
        );
      },
      onSaved: (val) {
        _onSave(UITrimmer.formatNumericValue(val!), isTarget);
      },
    );
  }

  /// テキスト "0" を表示するフィールド
  Widget _buildTextFieldZero() {
    return Text(
      TextContents.zero.text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: kTextThirdBaseColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// 星を選択するピッカーフィールドのビルド
  Widget _buildStarPickerField(DataType selectedDataType, bool isTarget) {
    return HabitDetailTextForm(
      controller: isTarget ? _targetController : _currentController,
      hintText: TextContents.zero.text,
      readOnly: true,
      onTap: () async {
        final result = await widget.routeManager.showStarPicker(
          context,
          selectedDataType,
          initialValue:
              isTarget ? _enteredTargetVal.str : _enteredCurrentVal.str,
        );
        if (result != null) {
          _updateStarPickerValues(result, isTarget);
        }
      },
      validator: (val) {
        return HabitValidator.validGoalTextForm(
          val,
          _enteredCurrentVal.str,
          _enteredTargetVal.str,
          selectedDataType.id,
          _selectedIncDecVal,
          isTarget,
        );
      },
    );
  }

  /// 時間を選択するピッカーフィールドのビルド
  Widget _buildTimePickerField(DataType selectedDataType, bool isTarget) {
    return HabitDetailTextForm(
      controller: isTarget ? _targetController : _currentController,
      hintText: selectedDataType.id == 4
          ? TextContents.timeZero.text
          : TextContents.shortTimeZero.text,
      readOnly: true,
      onTap: () async {
        final result = await widget.routeManager.showTimePicker(
          context,
          selectedDataType,
          widget.accumulationType,
          initialValue:
              isTarget ? _enteredTargetVal.dur : _enteredCurrentVal.dur,
        );
        if (result != null) {
          _updateTimePickerValues(result, isTarget);
        }
      },
      validator: (val) {
        return HabitValidator.validGoalTimePicker(
          val,
          _enteredCurrentVal.dur,
          _enteredTargetVal.dur,
          selectedDataType.id,
          _selectedIncDecVal,
          isTarget,
        );
      },
      onSaved: (val) {
        _onSave(val, isTarget);
      },
    );
  }

  /// フォーム全体の構築
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildFormContent(),
      ),
    );
  }

  /// フォームコンテンツ全体のコンテナ
  Widget _buildFormContent() {
    return Container(
      constraints: const BoxConstraints(minHeight: 0),
      decoration: BoxDecoration(
        color: kTextBaseColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TitleTile(
              enteredTitle: _enteredTitle,
              onSaved: (val) {
                _enteredTitle = val!;
              },
              hintText: TextContents.goalExample.text,
              maxLength: 15,
            ),
            InputValueTile(
              title: TextContents.goalValue.text,
              inputField: _buildInputField(
                initialVal: _enteredTargetVal.str,
                selectedDataType: widget.selectedDataType,
                isTarget: true,
              ),
              isRequiredMark: true,
            ),
            if (!widget.isUpdate)
              IncDecTypeTile(
                accumulationType: widget.accumulationType,
                selectedIncDecVal: _selectedIncDecVal,
                onIncDecTypeChanged: (val) {
                  setState(() {
                    _selectedIncDecVal = val!;
                  });
                },
              ),
            if (!widget.isUpdate)
              InputValueTile(
                title: TextContents.currentValue.text,
                inputField: _buildInputField(
                  initialVal: _enteredCurrentVal.str,
                  selectedDataType: widget.selectedDataType,
                  isTarget: false,
                ),
              ),
            DeadlineTile(
              selectedDeadline: _selectedDeadline,
              onTap: _setDeadline,
            ),
            MemoTile(
              initialValue: _enteredMemo,
              onSaved: (val) {
                _enteredMemo = val;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: _buildAppBar(),
      body: _buildForm(),
    );
  }
}
