import 'package:json_annotation/json_annotation.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';

part 'habit_view.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitView {
  HabitView({
    required this.id,
    required this.habitType,
    required this.title,
    required this.iconId,
    required this.dataType,
    required this.accumulationType,
    required this.unit,
    required this.isGoal,
    required this.goal,
    this.records,
    this.isDeleted,
    this.sort,
  });
  final int id;
  final int habitType;
  final String title;
  final int iconId;
  final DataType dataType;
  final int accumulationType;
  final String unit;
  final bool isGoal;
  HabitGoalView? goal;
  Map<DateTime, HabitValues>? records;
  int? isDeleted;
  String? sort;

  // JSON → HabitView の変換
  factory HabitView.fromJson(Map<String, dynamic> json) =>
      _$HabitViewFromJson(json);

  // HabitView → JSON の変換
  Map<String, dynamic> toJson() => _$HabitViewToJson(this);
}
