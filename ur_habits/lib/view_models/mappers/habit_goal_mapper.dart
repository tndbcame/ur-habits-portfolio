import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';

class HabitGoalMapper {
  static HabitGoal? toHabitGoal(HabitView habitItem) {
    if (habitItem.goal == null) return null;
    final goal = habitItem.goal!;
    final habitGoal = HabitGoal();
    if (habitItem.goal!.id != null) {
      habitGoal.id = goal.id!;
    }
    return habitGoal
      ..title = goal.title
      ..incDecTyep = goal.incDecTyep
      ..currentStrVal = goal.currentValues.str
      ..targetStrVal = goal.targetValues.str
      ..inputedDate = goal.inputedDate
      ..currentDurVal = goal.currentValues.dur?.inSeconds
      ..targetDurVal = goal.targetValues.dur?.inSeconds
      ..deadline = goal.deadline
      ..memo = goal.memo;
  }
}
