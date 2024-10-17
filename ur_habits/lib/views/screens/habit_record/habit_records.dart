import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/helper/dialog_helper.dart';
import 'package:ur_habits/view_models/providers/firebase_habits_provider.dart';
import 'package:ur_habits/utils/helper/ads/ad_manager.dart';
import 'package:ur_habits/views/components/button/color_changing_text_button.dart';
import 'package:ur_habits/views/components/button/help_button.dart';
import 'package:ur_habits/views/components/calender/calender_page_view.dart';
import 'package:ur_habits/views/components/dialog/caution_dialog/overlay/overlay_manager.dart';
import 'package:ur_habits/views/components/text/discription_text.dart';
import 'package:ur_habits/views/components/text/discription_title.dart';
import 'package:ur_habits/views/screens/habit_record/components/panel/habit_record_memo_panel.dart';
import 'package:ur_habits/views/screens/habit_record/components/section/habit_record_goal_section.dart';
import 'package:ur_habits/views/screens/habit_record/components/section/habit_record_section.dart';
import 'package:ur_habits/views/screens/habit_record/components/tile/habit_record_list_tile.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/checkbox_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/counter_dialog.dart';
import 'package:ur_habits/views/components/dialog/input_dialog/number_field_dialog.dart';
import 'package:ur_habits/utils/habit_converter.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/routers/route_manager.dart';
import 'package:ur_habits/views/screens/habit_record/components/toggle/record_toggle.dart';
import 'package:ur_habits/resources/colors.dart';
import 'package:ur_habits/views/screens/habit_record/components/graph/achievement_rate_calculator.dart';
import 'package:ur_habits/view_models/providers/isar_habits_provider.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/views/screens/habit_record/helper/habit_record_helper.dart';

class HabitRecordScreen extends ConsumerStatefulWidget {
  const HabitRecordScreen({
    super.key,
    required this.habit,
    required this.popLabel,
    this.readOnly = false,
  });
  final HabitView habit;
  final IconData popLabel;
  final bool readOnly;

  @override
  ConsumerState<HabitRecordScreen> createState() {
    return _HabitRecordScreen();
  }
}

class _HabitRecordScreen extends ConsumerState<HabitRecordScreen>
    with TickerProviderStateMixin {
  final RouteManager _routeManager = RouteManager();
  final DateTime _now = DateTime.now();
  final HabitRecordHelper _habitRecordHelper = HabitRecordHelper();
  final OverlayManager _overlayManager = OverlayManager();
  final AchievementRateCalculator _achivementRateCalculator =
      AchievementRateCalculator();
  late AdManager _adManager;
  late final HabitView _habit;
  int _toggleStatus = 0;
  int _dataType = 0;
  double _achievementRate = 0;
  DateTime _activeDate = DateTime.now();
  late String _habitTitle;
  late String? _habitGoalTitle;
  List<HabitRecordListTile> _recordList = [];
  (int?, double?, Duration?) _accumVal = (null, null, null);

  @override
  void initState() {
    super.initState();
    _initializeHabitData();
  }

  @override
  void dispose() {
    super.dispose();
    _adManager.dispose();
  }

  void _showOverlayDialog() {
    String message = TextContents.partnerHabitReadOnly.text;
    _overlayManager.showOverlayDialog(context, this, message);
  }

  /// 初期データを設定
  void _initializeHabitData() {
    _habit = widget.habit;
    _habitTitle = _habit.title;
    _habitGoalTitle = _habit.goal?.title;
    _habit.records ??= <DateTime, HabitValues>{};
    _habitRecordHelper.sortByRecordDate(_habit);
    _setList();
    _calculateAchievementRate();
    _adManager = AdManager();
    _adManager
        .loadBannerAd(widget.readOnly ? AdSize.fullBanner : AdSize.banner);
  }

  Future<void> _showDescriptionDialog() async {
    await DialogHelper.showDescriptionDialog(context, _routeManager, [
      DiscriptionTitle(title: TextContents.calendar.text),
      DiscriptionText(text: TextContents.habitManagementByMonth.text),
      DiscriptionTitle(title: TextContents.goalAchieved.text),
      DiscriptionText(
          text: TextContents.habitProgressAndAccumulationManagement.text),
      const SizedBox(height: 20),
      DiscriptionText(text: TextContents.habitTutorialReference.text),
    ]);
  }

  /// アクティブな日付を設定
  void _setActiveDate(BuildContext context, DateTime date) {
    setState(() {
      _activeDate = date;
      _setList();
    });
  }

  /// 記録をセットし、達成率を再計算
  void _setRecord(Map<DateTime, HabitValues>? updatedValues) {
    setState(() {
      _habit.records = updatedValues;
      _calculateAchievementRate();
    });
    _habitRecordHelper.sortByRecordDate(_habit);
    _setList();
  }

  /// 記録リストの生成
  void _setList() {
    _recordList = _habit.records!.entries
        .where((entry) => _toggleStatus == 0
            ? _activeDate.year == entry.key.year &&
                _activeDate.month == entry.key.month
            : true)
        .map(
          (entry) => HabitRecordListTile(
            toggleStatus: _toggleStatus,
            date: entry.key,
            valStr: _habit.dataType.id == 6
                ? _habitRecordHelper.getCheckboxStatusText(entry.value.str)
                : entry.value.str,
            unit: _habit.dataType.id == 3 ||
                    _habit.dataType.id == 4 ||
                    _habit.dataType.id == 6 ||
                    _habit.dataType.id == 7
                ? ''
                : _habit.unit,
            onTap: _selectInputRecord,
            icon: _habit.dataType.id == 6
                ? entry.value.str == TextContents.one.text
                    ? HugeIcons.strokeRoundedTick01
                    : HugeIcons.strokeRoundedCheckUnread01
                : null,
          ),
        )
        .toList();
  }

  /// 記録を削除
  void _deleteRecord(BuildContext context, DateTime date) {
    Map<DateTime, HabitValues>? updatedValues;

    if (_habit.habitType == 1) {
      updatedValues = ref
          .read(isarHabitsProvider.notifier)
          .deleteHabitRecord(_habit.id, _habit.records![date]!.id!);
    } else {
      updatedValues = _habit.records;
      updatedValues!.remove(date);
      ref
          .read(firebaseHabitsProvider.notifier)
          .deleteHabitRecord(_habit.id, date);
    }

    _setRecord(updatedValues);
  }

  /// 達成率の計算
  void _calculateAchievementRate() {
    _accumVal = _achivementRateCalculator.calculateAccumulatedValue(
        _habit.dataType.id, _habit.records);
    _dataType = _achivementRateCalculator.determineDataType(_accumVal);

    if (_habit.goal != null) {
      _achievementRate = _achivementRateCalculator.calculateAchievementRate(
        _dataType,
        _habit.goal!.targetValues.str,
        _habit.goal!.targetValues.dur,
        _accumVal,
      );
    }
  }

  /// 記録の選択を行う
  void _selectInputRecord(BuildContext context, DateTime date) async {
    if (widget.readOnly) {
      _showOverlayDialog();
      return;
    }

    MapEntry<DateTime, HabitValues>? entry;

    if (_habitRecordHelper.isSimpleInputType(_habit.dataType.id)) {
      entry = await _handleNumberOrCheckboxInput(context, date);
    } else if (_habit.dataType.id == 7) {
      entry = await _handleStarPickerInput(context, date);
    } else if (_habit.dataType.id == 8) {
      entry = await _handleCounterInput(context, date);
    } else {
      entry = await _handleTimePickerInput(context, date);
    }

    if (entry == null) return;

    _saveHabitRecord(entry);
  }

  /// 数値またはチェックボックスの入力を処理
  Future<MapEntry<DateTime, HabitValues>?> _handleNumberOrCheckboxInput(
      BuildContext context, DateTime date) async {
    var result = await _routeManager.showAnimationDialog<(String, DateTime?)>(
      context,
      _habit.dataType.id == 6
          ? CheckboxDialog(
              routeManager: _routeManager,
              dialogTitle: _habit.dataType.name,
              values: _habit.records,
              onDelete: _deleteRecord,
              date: date,
            )
          : NumberFiledDialog(
              routeManager: _routeManager,
              dataType: _habit.dataType,
              values: HabitConverter.toStrMap(_habit.records!),
              onDelete: _deleteRecord,
              date: date,
            ),
      animaType: _habit.dataType.id == 6 ? 1 : 2,
    );

    if (result != null) {
      if (result.$2 != null) date = result.$2!;
      return _habitRecordHelper.createRecord(date, result.$1, null);
    }
    return null;
  }

  /// 星の評価を選択するための入力処理
  Future<MapEntry<DateTime, HabitValues>?> _handleStarPickerInput(
      BuildContext context, DateTime date) async {
    var result = await _routeManager.showStarPicker(
      context,
      _habit.dataType,
      values: HabitConverter.toStrMap(_habit.records!),
      onDelete: _deleteRecord,
      date: date,
    );

    if (result != null) {
      if (result.$2 != null) date = result.$2!;
      return _habitRecordHelper.createRecord(date, result.$1, null);
    }
    return null;
  }

  /// カウンター入力の処理
  Future<MapEntry<DateTime, HabitValues>?> _handleCounterInput(
      BuildContext context, DateTime date) async {
    var result = await _routeManager.showAnimationDialog<(String, DateTime?)>(
      context,
      CounterDialog(
        routeManager: _routeManager,
        values: HabitConverter.toStrMap(_habit.records!),
        onDelete: _deleteRecord,
        date: date,
      ),
    );

    if (result != null) {
      if (result.$2 != null) date = result.$2!;
      return _habitRecordHelper.createRecord(date, result.$1, null);
    }
    return null;
  }

  /// 時間ピッカー入力の処理
  Future<MapEntry<DateTime, HabitValues>?> _handleTimePickerInput(
      BuildContext context, DateTime date) async {
    var result = await _routeManager.showTimePicker(
      context,
      _habit.dataType,
      _habit.accumulationType,
      values: HabitConverter.toDurMap(_habit.records!),
      onDelete: _deleteRecord,
      date: date,
    );

    if (result != null) {
      if (result.$3 != null) date = result.$3!;
      return _habitRecordHelper.createRecord(date, result.$2, result.$1);
    }
    return null;
  }

  ///記録を保存
  void _saveHabitRecord(MapEntry<DateTime, HabitValues> entry) {
    Map<DateTime, HabitValues>? updatedValues;

    if (_habit.habitType == 1) {
      updatedValues = ref
          .read(isarHabitsProvider.notifier)
          .updateHabit(_habit, entry: entry);
    } else {
      updatedValues = {..._habit.records!, entry.key: entry.value};
      ref
          .read(firebaseHabitsProvider.notifier)
          .putHabitRecord(entry, _habit.id);
    }

    _setRecord(updatedValues);
  }

  Widget _buildIcon() {
    return SizedBox(
      width: 50,
      child: Icon(
        habitIcons[widget.habit.iconId],
        color: kTextBaseColor,
      ),
    );
  }

  Widget _buildGoalTitle() {
    return _habit.isGoal && _habitGoalTitle != null
        ? Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              _habitGoalTitle!,
              style: const TextStyle(
                fontSize: 18,
                color: kTextBaseColor,
              ),
            ),
          )
        : const SizedBox(height: 10);
  }

  Widget _buildAnimatedToggle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: AnimatedToggle(
        titles: [TextContents.calendar.text, TextContents.goalAchieved.text],
        onToggle: (val) {
          setState(() {
            _toggleStatus = val;
            _setList();
          });
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      elevation: 1,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        _selectInputRecord(context, DateTime(_now.year, _now.month, _now.day));
      },
      child: const Icon(
        HugeIcons.strokeRoundedAdd01,
        color: kTextBaseColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: kThirdBaseColor,
      appBar: AppBar(
        leadingWidth: 50,
        leading: ColorChangingTextButton(
          leftIcon: HugeIcons.strokeRoundedArrowLeft01,
          rightIcon: widget.popLabel,
          isBoldText: false,
          normalColor: kTextBaseColor,
          pressedColor: kTextBaseColorBlack,
          onTap: () => _routeManager.pop(context),
        ),
        title: Text(
          _habitTitle,
          style: const TextStyle(
            color: kTextBaseColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [HelpButton(onHelpTap: _showDescriptionDialog), _buildIcon()],
        backgroundColor: theme.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildGoalTitle(),
                _buildAnimatedToggle(),
                _toggleStatus == 0
                    ? CalenderPageView(
                        height: 400,
                        initialPage: 1200,
                        useInputToday: true,
                        notUseBeforeToday: false,
                        notUseAfterToday: widget.readOnly ? false : true,
                        useAsInput: false,
                        useAsDialog: false,
                        onDaySelected: _selectInputRecord,
                        onTodaySelected: _selectInputRecord,
                        onDateChanged: _setActiveDate,
                        habit: _habit,
                      )
                    : HabitRecordGoalSection(
                        screenWidth: screenWidth,
                        habit: _habit,
                        accumulatedValue:
                            _habitRecordHelper.extractAccumulatedValue(
                          _dataType,
                          _accumVal,
                          _habit.dataType.id == 4,
                        ),
                        achievementRate: _achievementRate,
                        dataType: _dataType,
                        accumVal: _accumVal,
                      ),
                HabitRecordSection(
                  screenWidth: screenWidth,
                  toggleStatus: _toggleStatus,
                  activeDate: _activeDate,
                  habit: _habit,
                  recordList: _recordList,
                ),
                HabitRecordMemoPanel(
                    screenWidth: screenWidth,
                    toggleStatus: _toggleStatus,
                    habit: _habit),
                SizedBox(
                  height: _toggleStatus == 1 && _habit.accumulationType == 3
                      ? MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.65 +
                              AppBar().preferredSize.height)
                      : 150,
                ),
              ],
            ),
          ),
          if (!widget.readOnly)
            Positioned(
              right: widget.readOnly ? null : -20,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 14, 16),
                padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                width: _adManager.bannerAdWidth,
                height: _adManager.bannerAdHeight,
                child: _adManager.getBannerAdWidget(),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation:
          widget.readOnly ? null : FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          widget.readOnly ? null : _buildFloatingActionButton(),
      bottomSheet: widget.readOnly
          ? SizedBox(
              width: _adManager.bannerAdWidth,
              height: _adManager.bannerAdHeight,
              child: _adManager.getBannerAdWidget(),
            )
          : null,
    );
  }
}
