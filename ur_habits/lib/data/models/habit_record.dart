import 'package:isar/isar.dart';

part 'habit_record.g.dart';

@Collection()
class HabitRecord {
  @Index()
  Id id = Isar.autoIncrement;
  DateTime? date;
  int? durVal;
  String? strVal;
}
