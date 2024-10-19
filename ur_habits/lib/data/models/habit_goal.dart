import 'package:isar/isar.dart';

part 'habit_goal.g.dart';

@Collection()
class HabitGoal {
  @Index()
  Id id = Isar.autoIncrement;
  String? title;
  int? incDecTyep;
  String? currentStrVal;
  String? targetStrVal;
  DateTime? inputedDate;
  int? currentDurVal;
  int? targetDurVal;
  DateTime? deadline;
  String? memo;
}
