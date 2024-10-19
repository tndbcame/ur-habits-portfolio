import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/repositories/isar_repository.dart';
import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/init.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/utils/habit_converter.dart';
import 'package:ur_habits/view_models/mappers/habit_goal_mapper.dart';
import 'package:ur_habits/view_models/mappers/habit_goal_view_mapper.dart';
import 'package:ur_habits/view_models/mappers/habit_mapper.dart';
import 'package:ur_habits/view_models/mappers/habit_record_mapper.dart';
import 'package:ur_habits/view_models/mappers/habit_view_mapper.dart';

class IsarViewModel {
  IsarViewModel({required this.isarRepository});
  final IsarRepository isarRepository;

  /// 初期データを確認し、未初期化ならば初期化処理を実行する
  bool initializeData() {
    Init? initData = isarRepository.getInitData();
    if (initData != null && initData.initFlg!) {
      return false;
    }
    Init init = Init()..initFlg = true;
    isarRepository.insertInitData(init);
    return true;
  }

  /// 全てのHabitを取得し、View用に変換して返す
  Future<List<HabitView>> getAllHabits() async {
    List<Habit> habits = await isarRepository.getAllHabits();
    return habits.map((habit) => _convertToHabitView(habit, false)).toList();
  }

  /// Habitの追加・更新を同期的に行い、結果を返す
  HabitView? saveHabitSync(
    HabitView habitView,
    bool isUpdate, {
    MapEntry<DateTime, HabitValues>? entry,
  }) {
    final habitData = _prepareHabitData(habitView, isUpdate, entry: entry);
    final habit = isarRepository.saveHabitSync(
        habitData.habit, habitData.goal, habitData.records);
    return habit != null ? _convertToHabitView(habit, true) : null;
  }

  /// Habitの追加・更新を非同期的に行い、結果を返す
  Future<HabitView?> saveHabit(
    HabitView habitView,
    bool isUpdate, {
    MapEntry<DateTime, HabitValues>? entry,
  }) async {
    final habitData = _prepareHabitData(habitView, isUpdate, entry: entry);
    final habit = await isarRepository.saveHabit(
        habitData.habit, habitData.goal, habitData.records);
    return habit != null ? _convertToHabitView(habit, true) : null;
  }

  /// 複数のHabitを非同期的に保存する
  Future<void> saveAllHabits(List<HabitView> habitViews) async {
    final now = DateTime.now();
    for (HabitView habitView in habitViews) {
      final habit = HabitMapper.toHabit(habitView, null, [], now, true);
      await isarRepository.saveHabit(habit, null, []);
    }
  }

  /// Habitの削除を非同期で行い、削除後のHabit一覧を返す
  Future<List<HabitView>> deleteHabit(HabitView habitView) async {
    final habitData = _prepareHabitData(habitView, true);
    final deletedHabits = await isarRepository.deleteHabit(
        habitData.habit, habitData.goal, habitData.records);
    return deletedHabits
        .map((deletedHabit) => _convertToHabitView(deletedHabit, false))
        .toList();
  }

  /// Habitの削除を同期で行い、削除後のHabit一覧を返す
  List<HabitView> deleteHabitSync(HabitView habitView) {
    final now = DateTime.now();
    final goal = HabitGoalMapper.toHabitGoal(habitView);
    final records = _convertValuesToRecords(habitView.records);
    final habit = HabitMapper.toHabit(habitView, goal, records, now, true);
    final deletedHabits = isarRepository.deleteHabitSync(habit, goal, records);
    return deletedHabits
        .map((deletedHabit) => _convertToHabitView(deletedHabit, false))
        .toList();
  }

  /// Habitのレコード削除を同期で行い、更新されたHabitの値を返す
  Map<DateTime, HabitValues> deleteHabitRecordSync(int habitId, int recordId) {
    Habit? habit = isarRepository.deleteHabitRecordSync(habitId, recordId);
    Map<DateTime, HabitValues> values = {};
    for (var record in habit!.records) {
      if (record.date == null || record.strVal == null) continue;
      values.addAll(HabitConverter.recordToRecordMap(record));
    }
    return values;
  }

  /// Habit, Goal, Recordsのセットを準備する
  _HabitData _prepareHabitData(
    HabitView habitView,
    bool isUpdate, {
    MapEntry<DateTime, HabitValues>? entry,
  }) {
    final now = DateTime.now();
    final goal = HabitGoalMapper.toHabitGoal(habitView);
    final records = entry != null
        ? [HabitRecordMapper.toHabitRecord(entry.key, entry.value)!]
        : _convertValuesToRecords(habitView.records);
    final habit = HabitMapper.toHabit(habitView, goal, records, now, isUpdate);
    return _HabitData(habit, goal, records);
  }

  /// HabitViewからHabitViewを生成する
  HabitView _convertToHabitView(Habit habit, bool isAdded) {
    final HabitGoalView? goalView = habit.goal.value != null
        ? HabitGoalViewMapper.goalToView(habit.goal.value!)
        : null;
    final values = _convertHabitRecordsToValues(habit, isAdded);
    return HabitViewMapper.habitToView(habit, goalView, values, isAdded);
  }

  /// HabitのレコードをHabitValues形式に変換する
  Map<DateTime, HabitValues> _convertHabitRecordsToValues(
      Habit habit, bool isAdded) {
    Map<DateTime, HabitValues> values = {};
    if (isAdded &&
        habit.isGoal &&
        habit.goal.value?.currentStrVal?.isNotEmpty == true) {
      values.addAll(HabitConverter.toRecordMap(
        habit.goal.value!.inputedDate!,
        habit.goal.value!.currentStrVal!,
        habit.goal.value!.currentDurVal != null
            ? Duration(seconds: habit.goal.value!.currentDurVal!)
            : null,
      ));
    }
    for (var record in habit.records) {
      if (record.date != null && record.strVal?.isNotEmpty == true) {
        values.addAll(HabitConverter.recordToRecordMap(record));
      }
    }
    return values;
  }

  /// HabitViewの値をレコード形式に変換する
  List<HabitRecord> _convertValuesToRecords(
      Map<DateTime, HabitValues>? values) {
    return values?.entries
            .map((e) => HabitRecordMapper.toHabitRecord(e.key, e.value)!)
            .toList() ??
        [];
  }
}

/// 習慣の内部クラス(ここでは複雑なため管理しやすいよう作成)
class _HabitData {
  final Habit habit;
  final HabitGoal? goal;
  final List<HabitRecord> records;

  _HabitData(this.habit, this.goal, this.records);
}
