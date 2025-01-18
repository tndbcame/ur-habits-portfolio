import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/init.dart';
import 'package:ur_habits/data/repositories/abstract/local_repository.dart';

/// ローカルDB(isar)とのやり取りを行うリポジトリクラス
class IsarRepository extends LocalRepository {
  IsarRepository({required this.isar});
  final Isar isar;

  /// 初期データをクリアする
  @override
  void clearData({bool isClear = false}) {
    if (isClear) {
      try {
        isar.writeTxnSync(() {
          isar.clearSync();
        });
      } catch (e) {
        // エラー処理
        log('データのクリア中にエラーが発生しました: $e');
      }
    }
  }

  /// 初期データを取得する
  @override
  Init? fetchInitData() {
    try {
      return isar.inits.where().findFirstSync();
    } catch (e) {
      // エラー処理
      log('初期データの取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 初期データを挿入する
  @override
  void setInitData(Init initData) {
    try {
      isar.writeTxnSync(() {
        isar.inits.putSync(initData);
      });
    } catch (e) {
      // エラー処理
      log('初期データの挿入中にエラーが発生しました: $e');
    }
  }

  /// すべての習慣を同期的に取得する
  @override
  List<Habit> fetchAllHabitsSync() {
    try {
      return isar.habits.where().findAllSync();
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return [];
    }
  }

  /// すべての習慣を非同期で取得する
  @override
  Future<List<Habit>> fetchAllHabits() async {
    try {
      return await isar.habits.where().findAll();
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return [];
    }
  }

  /// IDから習慣を同期的に取得する
  @override
  Habit? fetchHabitByIdSync(int id) {
    try {
      return isar.habits.getSync(id);
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// IDから習慣を非同期で取得する
  @override
  Future<Habit?> fetchHabitById(int id) async {
    try {
      return await isar.habits.get(id);
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣を同期的に保存する
  @override
  Habit? setHabitSync(
    Habit habit,
    HabitGoal? goal,
    List<HabitRecord> records,
  ) {
    try {
      isar.writeTxnSync(() {
        isar.habits.putSync(habit);
        if (goal != null) {
          isar.habitGoals.putSync(goal);
        }
        if (records.isNotEmpty) {
          isar.habitRecords.putAllSync(records);
        }
      });
      return isar.habits.getSync(habit.id);
    } catch (e) {
      // エラー処理
      log('習慣の保存中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣を非同期で保存する
  @override
  Future<Habit?> setHabit(
    Habit habit,
    HabitGoal? goal,
    List<HabitRecord> records,
  ) async {
    try {
      await isar.writeTxn(() async {
        await isar.habits.put(habit);
        if (goal != null) {
          await isar.habitGoals.put(goal);
          await habit.goal.save();
        }
        if (records.isNotEmpty) {
          await isar.habitRecords.putAll(records);
          await habit.records.save();
        }
      });
      return await isar.habits.get(habit.id);
    } catch (e) {
      // エラー処理
      log('習慣の保存中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣のレコードを同期的に削除する
  @override
  Habit? deleteHabitRecordSync(int habitId, int recordId) {
    try {
      isar.writeTxnSync(() {
        isar.habitRecords.deleteSync(recordId);
      });
      return fetchHabitByIdSync(habitId);
    } catch (e) {
      // エラー処理
      log('習慣レコードの削除中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣を同期的に削除する
  @override
  List<Habit> deleteHabitSync(
      Habit habit, HabitGoal? goal, List<HabitRecord?> records) {
    try {
      isar.writeTxnSync(() {
        isar.habits.deleteSync(habit.id);
        if (goal != null) {
          isar.habitGoals.deleteSync(goal.id);
        }
        if (records.isNotEmpty) {
          for (HabitRecord? record in records) {
            if (record != null) {
              isar.habitRecords.deleteSync(record.id);
            }
          }
        }
      });
      return fetchAllHabitsSync();
    } catch (e) {
      // エラー処理
      log('習慣の削除中にエラーが発生しました: $e');
      return [];
    }
  }

  /// 習慣を非同期で削除する
  @override
  Future<List<Habit>> deleteHabit(
      Habit habit, HabitGoal? goal, List<HabitRecord?> records) async {
    try {
      await isar.writeTxn(() async {
        await isar.habits.delete(habit.id);
        if (goal != null) {
          await isar.habitGoals.delete(goal.id);
        }
        if (records.isNotEmpty) {
          for (HabitRecord? record in records) {
            if (record != null) {
              await isar.habitRecords.delete(record.id);
            }
          }
        }
      });
      return await fetchAllHabits();
    } catch (e) {
      // エラー処理
      log('習慣の削除中にエラーが発生しました: $e');
      return [];
    }
  }
}
