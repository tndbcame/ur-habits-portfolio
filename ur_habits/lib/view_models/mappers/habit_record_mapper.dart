import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';

class HabitRecordMapper {
  static HabitRecord? toHabitRecord(DateTime? date, HabitValues? value) {
    if (date == null || value == null || value.str.isEmpty) return null;

    final record = HabitRecord();
    if (value.id != null) {
      record.id = value.id!;
    }
    record
      ..date = date
      ..strVal = value.str
      ..durVal = value.dur?.inSeconds;
    return record;
  }
}
