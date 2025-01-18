// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_goal_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitGoalView _$HabitGoalViewFromJson(Map<String, dynamic> json) =>
    HabitGoalView(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      incDecTyep: (json['incDecTyep'] as num).toInt(),
      currentValues:
          HabitValues.fromJson(json['currentValues'] as Map<String, dynamic>),
      targetValues:
          HabitValues.fromJson(json['targetValues'] as Map<String, dynamic>),
      inputedDate: DateTime.parse(json['inputedDate'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$HabitGoalViewToJson(HabitGoalView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'incDecTyep': instance.incDecTyep,
      'currentValues': instance.currentValues.toJson(),
      'targetValues': instance.targetValues.toJson(),
      'inputedDate': instance.inputedDate.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'memo': instance.memo,
    };
