import 'package:json_annotation/json_annotation.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';

part 'habit_goal_view.g.dart';

enum DefalutGoals {
  weight,
  absExercise,
}

@JsonSerializable(explicitToJson: true)
class HabitGoalView {
  const HabitGoalView({
    this.id,
    required this.title,
    required this.incDecTyep,
    required this.currentValues,
    required this.targetValues,
    required this.inputedDate,
    required this.deadline,
    required this.memo,
  });
  final int? id;
  final String title;
  final int incDecTyep;
  final HabitValues currentValues;
  final HabitValues targetValues;
  final DateTime inputedDate;
  final DateTime? deadline;
  final String? memo;

  factory HabitGoalView.fromJson(Map<String, dynamic> json) =>
      _$HabitGoalViewFromJson(json);

  Map<String, dynamic> toJson() => _$HabitGoalViewToJson(this);
}
