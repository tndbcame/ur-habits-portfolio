import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_manager.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/caution_dialog.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/selecting_caution_dialog.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/accumulation_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/data_type_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/goal_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/habit_type_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/icon_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/title_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/components/tile/habit_detail/unit_tile.dart';
import 'package:ur_habits/views/screens/habit_detail/goal_details.dart';
import 'package:ur_habits/views/screens/habit_detail/icons.dart';
import 'package:ur_habits/resources/colors.dart';

class HabitDetailsScreen extends StatefulWidget {
  const HabitDetailsScreen({
    super.key,
    required this.isUpdate,
    this.habit,
    required this.publicHabitsSize,
  });

  final bool isUpdate;
  final HabitView? habit;
  final int publicHabitsSize;

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RouteManager _routeManager = RouteManager();
  final OverlayManager _overlayManager = OverlayManager();
//  final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();
  int _habitType = 1;
  int _selectedIconIndex = 1;
  int _accumulationType = 1;
  bool _isNotInputUnit = false;
  bool _isGoal = true;
  String _enteredTitle = '';
  String _unit = dataTypes[0].unit;
  Map<DateTime, HabitValues>? _records;
  DataType _selectedDataType = dataTypes[0];
  HabitGoalView? _habitGoal;

  @override
  void initState() {
    super.initState();
    _initializeHabit();
  }

  /// 初期化処理
  void _initializeHabit() {
    if (widget.habit == null) return;
    _habitType = widget.habit!.habitType;
    _enteredTitle = widget.habit!.title;
    _selectedIconIndex = widget.habit!.iconId;
    _selectedDataType = widget.habit!.dataType;
    _accumulationType = widget.habit!.accumulationType;
    _unit = widget.habit!.unit;
    _isGoal = widget.habit!.isGoal;
    _records = widget.habit!.records;
    _habitGoal = widget.habit!.goal;
    _setIsInput(_selectedDataType.id);
  }

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, _routeManager, [
      DiscriptionTitle(title: TextContents.habitType.text),
      DiscriptionText(text: TextContents.selectHabitVisibility.text),
      DiscriptionTitle(title: TextContents.title.text),
      DiscriptionText(text: TextContents.enterHabitTitle.text),
      DiscriptionTitle(title: TextContents.icon.text),
      DiscriptionText(text: TextContents.setHabitIcon.text),
      DiscriptionTitle(title: TextContents.dataType.text),
      DiscriptionText(text: TextContents.setDataType.text),
      DiscriptionTitle(title: TextContents.unit.text),
      DiscriptionText(text: TextContents.enterUnit.text),
      DiscriptionTitle(title: TextContents.cumulative.text),
      DiscriptionText(text: TextContents.setCumulative.text),
      DiscriptionTitle(title: TextContents.goalExistence.text),
      DiscriptionText(text: TextContents.setGoal.text),
      DiscriptionTitle(title: TextContents.goal.text),
      DiscriptionText(text: TextContents.setGoalValue.text),
      const SizedBox(height: 20),
      DiscriptionText(text: TextContents.requiredFieldsNote.text),
      DiscriptionText(text: TextContents.deleteHabitInfo.text),
    ]);
  }

  /// 目標の有無を切り替える処理
  void _toggleIsGoal() {
    setState(() {
      _isGoal = !_isGoal;
    });
  }

  /// 習慣タイプを変更する処理
  void _toggleHabitType() {
    if (widget.publicHabitsSize >= 3) {
      _showOverlayDialog(context, TextContents.habitLimitReached.text);
    } else {
      setState(() {
        _habitType = (_habitType == 1) ? 2 : 1;
      });
    }
  }

  /// データタイプのIDによって入力可能かどうかを設定
  void _setIsInput(int id) {
    _isNotInputUnit = !(id == 1 || id == 2 || id == 8);
  }

  /// アイコン選択画面に遷移し、結果を反映
  void _setIcons(int selectedIcons) async {
    final newSelectedIcons = await _routeManager.push<int>(
      context,
      IconsScreen(routeManager: _routeManager, iconId: selectedIcons),
    );

    if (newSelectedIcons != null) {
      setState(() {
        _selectedIconIndex = newSelectedIcons;
      });
    }
  }

  /// 目標設定画面に遷移し、結果を反映
  void _setGoalItem() async {
    final newHabitGoal = await _routeManager.push<HabitGoalView>(
      context,
      GoalDetailsScreen(
        routeManager: _routeManager,
        selectedDataType: _selectedDataType,
        accumulationType: _accumulationType,
        isUpdate: widget.isUpdate,
        habitGoal: _habitGoal,
      ),
    );

    if (newHabitGoal != null) {
      setState(() {
        _habitGoal = newHabitGoal;
      });
    }
  }

  /// データタイプ選択時の警告表示
  void _goalResetWarning() async {
    if (_habitGoal != null) {
      await _routeManager.showAnimationDialog(
        context,
        CautionDialog(
          message: TextContents.goalResetWarning.text,
          messageFontSize: 16,
          confirmButtonColor: Theme.of(context).primaryColor,
          onConfirm: () {
            _routeManager.pop(context);
          },
        ),
        animaType: 1,
      );
    }
  }

  /// データタイプ変更処理
  void _onChangedDataType(DataType? val) {
    if (val == null) return;
    setState(() {
      if (_selectedDataType.id != val.id) {
        _habitGoal = null;
      }
      _selectedDataType = val;
      _unit = _selectedDataType.unit;
      _setIsInput(_selectedDataType.id);
      if (_selectedDataType.id == 6) {
        _accumulationType = 1;
      }
    });
  }

  /// 習慣の削除確認と削除処理
  void _onDelete() async {
    final isDelete = await _routeManager.showAnimationDialog<bool>(
      context,
      SelectingCautionDialog(
        routeManager: _routeManager,
        message: TextContents.confirmHabitDelete.text,
        confirmButtonText: TextContents.delete.text,
        messageFontSize: 16,
        confirmButtonColor: kSecondBaseColor,
      ),
      animaType: 1,
    );

    if (isDelete == true && mounted) {
      _routeManager.pop<HabitView>(
        context,
        HabitView(
          id: widget.habit!.id,
          habitType: widget.habit!.habitType,
          title: _enteredTitle,
          iconId: _selectedIconIndex,
          dataType: _selectedDataType,
          accumulationType: _accumulationType,
          unit: _unit,
          isGoal: _isGoal,
          goal: _habitGoal,
          isDeleted: 1,
        ),
      );
    }
  }

  /// 習慣の完了処理
  void _onComplete() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final id = widget.habit?.id ?? -1;
      _routeManager.pop<HabitView>(
        context,
        HabitView(
          id: id,
          habitType: _habitType,
          title: _enteredTitle,
          iconId: _selectedIconIndex,
          dataType: _selectedDataType,
          accumulationType: _accumulationType,
          unit: _unit,
          isGoal: _isGoal,
          goal: _habitGoal,
          records: _records ?? _getInitialRecords(),
          sort: widget.habit?.sort,
        ),
      );
    }
  }

  /// 習慣記録の初期値を設定
  Map<DateTime, HabitValues>? _getInitialRecords() {
    if (!_isGoal &&
        _habitGoal != null &&
        _habitGoal!.currentValues.str.isNotEmpty) {
      return {
        _habitGoal!.inputedDate: HabitValues(
          str: _selectedDataType.id == 6
              ? TextContents.checked.text
              : _habitGoal!.currentValues.str,
          dur: _habitGoal!.currentValues.dur,
        ),
      };
    }
    return null;
  }

  /// オーバーレイダイアログを表示
  void _showOverlayDialog(BuildContext context, String message) {
    _overlayManager.showOverlayDialog(context, this, message);
  }

  /// アップバー
  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 110,
      leading: ColorChangingTextButton(
        leftIcon: HugeIcons.strokeRoundedArrowLeft01,
        labelText: TextContents.cancel.text,
        isBoldText: false,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: () => _routeManager.pop(context),
      ),
      title: Text(
        widget.isUpdate
            ? TextContents.editHabit.text
            : TextContents.addHabit.text,
        style: const TextStyle(
          fontSize: 20,
          color: kTextThirdBaseColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: kLightGray3,
      actions: [
        HelpButton(
          onHelpTap: _showDescriptionDialog,
          normalColor: kTextBaseColorBlack,
          pressedColor: kTextBaseColorBlack.withAlpha(150),
        ),
        _buildCompleteButton(),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ColorChangingTextButton(
        labelText: TextContents.complete.text,
        isBoldText: true,
        normalColor: kTextBaseColorBlack,
        pressedColor: kTextBaseColorBlack.withAlpha(150),
        onTap: _onComplete,
      ),
    );
  }

  /// フォーム内容
  Widget _buildFormContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HabitTypeTile(
            //  userStream: _firebaseViewModel.getSteamUser(),
            habitType: _habitType,
            onTapHabitType: _toggleHabitType,
            showOverlayDialog: _showOverlayDialog,
          ),
          TitleTile(
            enteredTitle: _enteredTitle,
            onSaved: (val) => _enteredTitle = val!,
            hintText: TextContents.habitExample.text,
          ),
          IconTile(
            selectedIconIndex: _selectedIconIndex,
            habitIcons: habitIcons,
            onTapIcon: () => _setIcons(_selectedIconIndex),
          ),
          DataTypeTile(
            isUpdate: widget.isUpdate,
            selectedDataType: _selectedDataType,
            dataTypes: dataTypes,
            onChangedDataType: _onChangedDataType,
            onTap: _goalResetWarning,
            showOverlayDialog: () => _showOverlayDialog(
              context,
              TextContents.cannotInputDuringUpdate.text,
            ),
          ),
          UnitTile(
            isNotInputUnit: _isNotInputUnit,
            unit: _unit,
            onSaved: (val) => _unit = val!,
            showOverlayDialog: () => _showOverlayDialog(
              context,
              TextContents.noUnitForDataType.text,
            ),
          ),
          AccumulationTile(
            isUpdate: widget.isUpdate,
            selectedAccumulationType: _accumulationType,
            accumulationTypes: accumulationTypes,
            onChangedAccumulationType: (val) => setState(() {
              if (_accumulationType != val) {
                _habitGoal = null;
              }
              _accumulationType = val!;
            }),
            onTap: _goalResetWarning,
            showOverlayDialog: () => _showOverlayDialog(
              context,
              TextContents.cannotInputDuringUpdate.text,
            ),
            selectedDataTypeId: _selectedDataType.id,
          ),
          GoalTile(
            isGoal: _isGoal,
            habitGoalTitle: _habitGoal?.title,
            onTapIsGoal: _toggleIsGoal,
            onTapGoalItem: _setGoalItem,
          ),
        ],
      ),
    );
  }

  /// FloatingActionButtonのロジック
  Widget? _buildFloatingActionButton(BuildContext context) {
    if (widget.isUpdate) {
      return FloatingActionButton(
        elevation: 2,
        backgroundColor: kTextBaseColor,
        onPressed: _onDelete,
        child: Icon(
          HugeIcons.strokeRoundedDelete02,
          color: Theme.of(context).primaryColor,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGray2,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 0),
                  decoration: BoxDecoration(
                    color: kTextBaseColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _buildFormContent(context),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}
