import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_habits/data/repositories/isar_repository.dart';
import 'package:ur_habits/data/services/isar_accesser.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/view_models/isar_view_model.dart';

class IsarHabitsNotifier extends StateNotifier<List<HabitView>> {
  IsarHabitsNotifier() : super([]) {
    _initialize();
  }

  final _isarViewModel =
      IsarViewModel(repo: IsarRepository(isar: IsarAccessor().isar));

  /// 初期化処理
  void _initialize() {
    bool isInitialized = _isarViewModel.initializeData();
    if (isInitialized) {
      _addDefaultHabits();
    }
    fetchAllHabits();
  }

  /// デフォルトの習慣を追加
  void _addDefaultHabits() {
    for (HabitView defaultItem in defaultHabits) {
      addHabit(defaultItem, isInit: true);
    }
  }

  /// すべての習慣を取得し、stateに格納
  Future<void> fetchAllHabits() async {
    final result = await _isarViewModel.getAllHabits();
    state = [...result];
    _sortHabits();
  }

  /// 新しい習慣を追加
  void addHabit(HabitView habit, {bool? isInit}) {
    final result = _isarViewModel.saveHabitSync(habit, false);
    if (isInit != null && isInit) return;
    if (result != null) {
      state = [result, ...state];
    }
    sortHabits(state);
  }

  /// 新しい習慣を追加（非同期）
  Future<void> addHabitAsync(HabitView habit, {bool? isInit}) async {
    final result = await _isarViewModel.saveHabit(habit, false);
    if (isInit != null && isInit) return;
    if (result != null) {
      state = [result, ...state];
    }
    sortHabits(state);
  }

  /// 習慣を更新し、レコードを追加
  Map<DateTime, HabitValues>? updateHabit(HabitView habit,
      {MapEntry<DateTime, HabitValues>? entry}) {
    final result = _isarViewModel.saveHabitSync(habit, true, entry: entry);
    if (result != null) {
      _updateStateWithHabit(result);
    }
    return _extractRecordsById(habit.id);
  }

  /// 習慣を削除
  Future<void> deleteHabit(HabitView habit) async {
    List<HabitView> habits = _isarViewModel.deleteHabitSync(habit);
    state = [...habits];
    sortHabits(state);
  }

  /// 習慣を削除（非同期）
  Future<void> deleteHabitAsync(HabitView habit) async {
    List<HabitView> habits = await _isarViewModel.deleteHabit(habit);
    state = [...habits];
    sortHabits(state);
  }

  /// 習慣の記録を削除
  Map<DateTime, HabitValues>? deleteHabitRecord(int habitId, int recordId) {
    final result = _isarViewModel.deleteHabitRecordSync(habitId, recordId);
    _updateRecordsInState(habitId, result);
    return _extractRecordsById(habitId);
  }

  /// 習慣を並び替え、stateに反映
  void _sortHabits() {
    state.sort((a, b) => a.sort!.compareTo(b.sort!));
  }

  /// 並び替えた習慣を保存
  void sortHabits(List<HabitView> habits) {
    habits.asMap().forEach((index, item) {
      item.sort = index.toString();
    });
    state = habits;
    _isarViewModel.saveAllHabits(state);
  }

  /// state内の特定の習慣を更新
  void _updateStateWithHabit(HabitView habit) {
    final index = state.indexWhere((item) => item.id == habit.id);
    if (index != -1) {
      state[index] = habit;
    }
  }

  /// 記録をstateに反映
  void _updateRecordsInState(int habitId, Map<DateTime, HabitValues>? records) {
    final index = state.indexWhere((item) => item.id == habitId);
    if (index != -1 && records != null) {
      state[index].records = records;
    }
  }

  /// 習慣のIDから記録を抽出
  Map<DateTime, HabitValues>? _extractRecordsById(int id) {
    return state.firstWhere((item) => item.id == id).records;
  }
}

final isarHabitsProvider =
    StateNotifierProvider<IsarHabitsNotifier, List<HabitView>>(
        (ref) => IsarHabitsNotifier());
