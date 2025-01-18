// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitValues _$HabitValuesFromJson(Map<String, dynamic> json) => HabitValues(
      id: (json['id'] as num?)?.toInt(),
      str: json['str'] as String,
      dur: json['dur'] == null
          ? null
          : Duration(microseconds: (json['dur'] as num).toInt()),
    );

Map<String, dynamic> _$HabitValuesToJson(HabitValues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'str': instance.str,
      'dur': instance.dur?.inMicroseconds,
    };
