import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/init.dart';

abstract class LocalRepository {
  void clearData({bool isClear = false});
  Init? fetchInitData();
  void setInitData(Init initData);
  List<Habit> fetchAllHabitsSync();
  Future<List<Habit>> fetchAllHabits();
  Habit? fetchHabitByIdSync(int id);
  Future<Habit?> fetchHabitById(int id);
  Habit? setHabitSync(Habit habit, HabitGoal? goal, List<HabitRecord> records);
  Future<Habit?> setHabit(
      Habit habit, HabitGoal? goal, List<HabitRecord> records);
  Habit? deleteHabitRecordSync(int habitId, int recordId);
  List<Habit> deleteHabitSync(
      Habit habit, HabitGoal? goal, List<HabitRecord?> records);
  Future<List<Habit>> deleteHabit(
      Habit habit, HabitGoal? goal, List<HabitRecord?> records);
}
