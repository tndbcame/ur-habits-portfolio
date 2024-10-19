import 'package:isar/isar.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';

part 'habit.g.dart';

@Collection()
class Habit {
  @Index()
  Id id = Isar.autoIncrement;
  late String title;
  late int iconId;
  late int dataTypeId;
  late int accumulationType;
  late String unit;
  late bool isGoal;
  final goal = IsarLink<HabitGoal>();
  final records = IsarLinks<HabitRecord>();
  String? sort;
  late DateTime createdAt;
  late DateTime updatedAt;
}
