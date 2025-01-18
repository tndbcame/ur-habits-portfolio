import 'package:ur_habits/data/models/habit_goal.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/utils/habit_values_converter.dart';

class HabitGoalViewMapper {
  static HabitGoalView goalToView(HabitGoal habitGoal) {
    return HabitGoalView(
      id: habitGoal.id,
      title: habitGoal.title!,
      incDecTyep: habitGoal.incDecTyep!,
      currentValues:
          _createHabitValues(habitGoal.currentStrVal, habitGoal.currentDurVal),
      targetValues:
          _createHabitValues(habitGoal.targetStrVal, habitGoal.targetDurVal),
      inputedDate: habitGoal.inputedDate!,
      deadline: habitGoal.deadline,
      memo: habitGoal.memo,
    );
  }

  static HabitGoalView mapToView(Map<String, dynamic> goalData) {
    final currentValues =
        _mapToHabitValues(goalData, 'currentStrVal', 'currentDurVal');
    final targetValues =
        _mapToHabitValues(goalData, 'targetStrVal', 'targetDurVal');

    final inputedDate = HabitValuesConverter.toDate(goalData['inputedDate']);
    final deadline = goalData['deadline'] != null
        ? HabitValuesConverter.toDate(goalData['deadline'])
        : null;

    return HabitGoalView(
      title: goalData['title'] as String,
      incDecTyep: goalData['incDecTyep'] as int,
      currentValues: currentValues,
      targetValues: targetValues,
      inputedDate: inputedDate!,
      deadline: deadline,
      memo: goalData['memo'] as String,
    );
  }

  static HabitValues _createHabitValues(String? str, int? durInSeconds) {
    return HabitValues(
      str: str!,
      dur: durInSeconds != null ? Duration(seconds: durInSeconds) : null,
    );
  }

  static HabitValues _mapToHabitValues(
      Map<String, dynamic> data, String strKey, String durKey) {
    return HabitValues(
      str: data[strKey] as String,
      dur: data[durKey] != null ? Duration(seconds: data[durKey] as int) : null,
    );
  }
}
