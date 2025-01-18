import 'package:json_annotation/json_annotation.dart';

part 'data_type.g.dart';

@JsonSerializable(explicitToJson: true)
class DataType {
  const DataType(
    this.id,
    this.name,
    this.unit,
  );
  final int id;
  final String name;
  final String unit;

  factory DataType.fromJson(Map<String, dynamic> json) =>
      _$DataTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DataTypeToJson(this);
}
