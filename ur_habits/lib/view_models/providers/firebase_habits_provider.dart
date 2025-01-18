import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/view_models/firestore_view_model.dart';

class FirebaseHabitsNotifier extends StateNotifier<List<HabitView>> {
  FirebaseHabitsNotifier() : super([]);

  final FirebaseViewModel _firebaseViewModel = FirebaseViewModel();

  /// Firebaseから習慣データを取得し、stateに反映
  Future<bool> fetchHabits() async {
    final habits =
        await _firebaseViewModel.getHabits(_firebaseViewModel.getUid());
    state = [...habits];
    _sortHabits();
    return true;
  }

  /// 習慣を追加
  Future<void> addHabit(HabitView habit, bool isUpdate) async {
    await _firebaseViewModel.addHabit(
      habit,
      _firebaseViewModel.getUid(),
      isUpdate,
    );
  }

  /// 習慣を更新し、stateを同期
  Future<bool> updateHabit(HabitView habit) async {
    await _firebaseViewModel.updateHabit(
      habit,
      _firebaseViewModel.getUid(),
    );
    _updateHabitState(habit);
    return false;
  }

  /// 記録を追加または更新
  void putHabitRecord(
    MapEntry<DateTime, HabitValues> entry,
    int habitId,
  ) {
    _updateHabitRecordState(entry, habitId);
    _firebaseViewModel.addHabitRecord(
      entry.key,
      entry.value,
      _firebaseViewModel.getUid(),
      habitId.toString(),
    );
  }

  /// 習慣を削除
  Future<void> deleteHabit(int habitId) async {
    state.removeWhere((item) => item.id == habitId);
    await _firebaseViewModel.deleteHabit(
      _firebaseViewModel.getUid(),
      habitId.toString(),
    );
  }

  /// 記録を削除
  void deleteHabitRecord(int habitId, DateTime date) {
    state[state.indexWhere((item) => item.id == habitId)].records?.remove(date);
    _firebaseViewModel.deleteHabitRecord(
      _firebaseViewModel.getUid(),
      habitId.toString(),
      date,
    );
  }

  /// 習慣の並び替え
  Future<void> sortHabits(List<HabitView> habits) async {
    _applySortingToHabits(habits);
    await _firebaseViewModel.updateSortOrder(
      habits,
      _firebaseViewModel.getUid(),
    );
  }

  /// 習慣の総数をカウント
  int countHabits() {
    return state.length;
  }

  /// 習慣を並び替える
  void _sortHabits() {
    state.sort((a, b) {
      if (a.sort!.compareTo(b.sort!) == 0) {
        return 1;
      }
      return a.sort!.compareTo(b.sort!);
    });
  }

  /// state内の習慣を更新
  void _updateHabitState(HabitView habit) {
    final index = state.indexWhere((item) => item.id == habit.id);
    final existingValues = state[index].records;
    state[index] = habit;
    state[index].records = existingValues;
  }

  /// 記録をstateに反映
  void _updateHabitRecordState(
    MapEntry<DateTime, HabitValues> entry,
    int habitId,
  ) {
    final index = state.indexWhere((item) => item.id == habitId);
    var values = state[index].records ?? {};
    values[entry.key] = entry.value;
    state[index].records = values;
  }

  /// 並び替えを習慣に適用
  void _applySortingToHabits(List<HabitView> habits) {
    habits.asMap().forEach((index, habit) {
      habit.sort = index.toString();
    });
  }
}

final firebaseHabitsProvider =
    StateNotifierProvider<FirebaseHabitsNotifier, List<HabitView>>(
        (ref) => FirebaseHabitsNotifier());
