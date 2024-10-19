import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';

class HabitMapper {
  static Habit toHabit(
    HabitView habitItem,
    HabitGoal? habitGoal,
    List<HabitRecord> records,
    DateTime now,
    bool isUpdate,
  ) {
    final habit = Habit();
    habit.records.addAll(records);

    if (isUpdate) {
      habit.id = habitItem.id;
    }

    return habit
      ..title = habitItem.title
      ..iconId = habitItem.iconId
      ..dataTypeId = habitItem.dataType.id
      ..accumulationType = habitItem.accumulationType
      ..unit = habitItem.unit
      ..isGoal = habitItem.isGoal
      ..goal.value = habitGoal
      ..createdAt = now
      ..updatedAt = now
      ..sort = habitItem.sort;
  }
}
