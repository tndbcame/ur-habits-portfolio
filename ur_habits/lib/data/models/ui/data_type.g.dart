// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataType _$DataTypeFromJson(Map<String, dynamic> json) => DataType(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['unit'] as String,
    );

Map<String, dynamic> _$DataTypeToJson(DataType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
    };
