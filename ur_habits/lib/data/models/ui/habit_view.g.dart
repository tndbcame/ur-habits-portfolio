// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitView _$HabitViewFromJson(Map<String, dynamic> json) => HabitView(
      id: (json['id'] as num).toInt(),
      habitType: (json['habitType'] as num).toInt(),
      title: json['title'] as String,
      iconId: (json['iconId'] as num).toInt(),
      dataType: DataType.fromJson(json['dataType'] as Map<String, dynamic>),
      accumulationType: (json['accumulationType'] as num).toInt(),
      unit: json['unit'] as String,
      isGoal: json['isGoal'] as bool,
      goal: json['goal'] == null
          ? null
          : HabitGoalView.fromJson(json['goal'] as Map<String, dynamic>),
      records: (json['records'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            DateTime.parse(k), HabitValues.fromJson(e as Map<String, dynamic>)),
      ),
      isDeleted: (json['isDeleted'] as num?)?.toInt(),
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$HabitViewToJson(HabitView instance) => <String, dynamic>{
      'id': instance.id,
      'habitType': instance.habitType,
      'title': instance.title,
      'iconId': instance.iconId,
      'dataType': instance.dataType.toJson(),
      'accumulationType': instance.accumulationType,
      'unit': instance.unit,
      'isGoal': instance.isGoal,
      'goal': instance.goal?.toJson(),
      'records': instance.records
          ?.map((k, e) => MapEntry(k.toIso8601String(), e.toJson())),
      'isDeleted': instance.isDeleted,
      'sort': instance.sort,
    };
