import 'package:json_annotation/json_annotation.dart';

part 'habit_values.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitValues {
  HabitValues({
    this.id,
    required this.str,
    this.dur,
  });
  int? id;
  String str;
  Duration? dur;

  factory HabitValues.fromJson(Map<String, dynamic> json) =>
      _$HabitValuesFromJson(json);

  Map<String, dynamic> toJson() => _$HabitValuesToJson(this);
}
