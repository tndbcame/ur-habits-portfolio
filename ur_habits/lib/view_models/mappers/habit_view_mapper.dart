import 'package:ur_habits/data/models/habit.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/data.dart';

class HabitViewMapper {
  static HabitView habitToView(
    Habit habit,
    HabitGoalView? goal,
    Map<DateTime, HabitValues> values,
    bool isAdded,
  ) {
    final dataType = dataTypes.firstWhere(
      (data) => data.id == habit.dataTypeId,
    );

    return HabitView(
      id: habit.id,
      habitType: 1,
      title: habit.title,
      iconId: habit.iconId,
      dataType: dataType,
      accumulationType: habit.accumulationType,
      unit: habit.unit,
      isGoal: habit.isGoal,
      goal: goal,
      records: values,
      sort: habit.sort,
    );
  }

  static mapToView(
    Map<String, dynamic> habitData,
    DataType dataType,
    HabitGoalView? goal,
    Map<DateTime, HabitValues>? values,
  ) {
    return HabitView(
      id: habitData['id'] as int,
      habitType: 2,
      title: habitData['title'] as String,
      iconId: habitData['iconId'] as int,
      dataType: dataType,
      accumulationType: habitData['accumulationType'] as int,
      unit: habitData['unit'] as String,
      isGoal: habitData['isGoal'] as bool,
      goal: goal,
      records: values,
      sort: habitData['sort'] as String?,
    );
  }
}
