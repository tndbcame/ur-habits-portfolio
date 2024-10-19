import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/init.dart';

/// ローカルDB(isar)とのやり取りを行うリポジトリクラス
class IsarRepository {
  IsarRepository({required this.isar});
  final Isar isar;

  /// 初期データをクリアする
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
  Init? getInitData() {
    try {
      return isar.inits.where().findFirstSync();
    } catch (e) {
      // エラー処理
      log('初期データの取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 初期データを挿入する
  void insertInitData(Init initData) {
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
  List<Habit> getAllHabitsSync() {
    try {
      return isar.habits.where().findAllSync();
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return [];
    }
  }

  /// すべての習慣を非同期で取得する
  Future<List<Habit>> getAllHabits() async {
    try {
      return await isar.habits.where().findAll();
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return [];
    }
  }

  /// IDから習慣を同期的に取得する
  Habit? getHabitByIdSync(int id) {
    try {
      return isar.habits.getSync(id);
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// IDから習慣を非同期で取得する
  Future<Habit?> getHabitById(int id) async {
    try {
      return await isar.habits.get(id);
    } catch (e) {
      // エラー処理
      log('習慣の取得中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣を同期的に保存する
  Habit? saveHabitSync(
      Habit habit, HabitGoal? goal, List<HabitRecord> records) {
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
  Future<Habit?> saveHabit(
      Habit habit, HabitGoal? goal, List<HabitRecord> records) async {
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
  Habit? deleteHabitRecordSync(int habitId, int recordId) {
    try {
      isar.writeTxnSync(() {
        isar.habitRecords.deleteSync(recordId);
      });
      return getHabitByIdSync(habitId);
    } catch (e) {
      // エラー処理
      log('習慣レコードの削除中にエラーが発生しました: $e');
      return null;
    }
  }

  /// 習慣を同期的に削除する
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
      return getAllHabitsSync();
    } catch (e) {
      // エラー処理
      log('習慣の削除中にエラーが発生しました: $e');
      return [];
    }
  }

  /// 習慣を非同期で削除する
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
      return await getAllHabits();
    } catch (e) {
      // エラー処理
      log('習慣の削除中にエラーが発生しました: $e');
      return [];
    }
  }
}
