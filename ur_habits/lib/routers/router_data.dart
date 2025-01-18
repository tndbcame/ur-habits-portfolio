import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/data/models/ui/habit_goal_view.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/utils/color_converter.dart';
import 'package:ur_habits/utils/key_converter.dart';

part 'router_data.g.dart';

@JsonSerializable()
class TabsData {
  @KeyConverter()
  final Key? key;

  TabsData({this.key});

  factory TabsData.fromJson(Map<String, dynamic> json) =>
      _$TabsDataFromJson(json);

  Map<String, dynamic> toJson() => _$TabsDataToJson(this);
}

@JsonSerializable()
class LoginsData {
  @KeyConverter()
  final Key? key;
  final bool isLogin;

  LoginsData({this.key, required this.isLogin});

  factory LoginsData.fromJson(Map<String, dynamic> json) =>
      _$LoginsDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginsDataToJson(this);
}

@JsonSerializable()
class RenamesData {
  @KeyConverter()
  final Key? key;
  final String name;

  RenamesData({this.key, required this.name});

  factory RenamesData.fromJson(Map<String, dynamic> json) =>
      _$RenamesDataFromJson(json);

  Map<String, dynamic> toJson() => _$RenamesDataToJson(this);
}

@JsonSerializable()
class RepasswordsData {
  @KeyConverter()
  final Key? key;
  final String? title;
  final String? cationText;
  @ColorConverter()
  final Color? appBarColor;
  @ColorConverter()
  final Color? containerColor;
  @ColorConverter()
  final Color? backgroundColor;
  final String? email;

  RepasswordsData({
    this.key,
    this.title,
    this.cationText,
    this.appBarColor,
    this.containerColor,
    this.backgroundColor,
    this.email,
  });

  factory RepasswordsData.fromJson(Map<String, dynamic> json) =>
      _$RepasswordsDataFromJson(json);

  Map<String, dynamic> toJson() => _$RepasswordsDataToJson(this);
}

@JsonSerializable()
class TitlesData {
  @KeyConverter()
  final Key? key;

  TitlesData({this.key});

  factory TitlesData.fromJson(Map<String, dynamic> json) =>
      _$TitlesDataFromJson(json);

  Map<String, dynamic> toJson() => _$TitlesDataToJson(this);
}

@JsonSerializable()
class UnregistersData {
  @KeyConverter()
  final Key? key;

  UnregistersData({this.key});

  factory UnregistersData.fromJson(Map<String, dynamic> json) =>
      _$UnregistersDataFromJson(json);

  Map<String, dynamic> toJson() => _$UnregistersDataToJson(this);
}

@JsonSerializable()
class HabitDetailsData {
  @KeyConverter()
  final Key? key;
  final bool isUpdate;
  final HabitView? habit;
  final int publicHabitsSize;

  HabitDetailsData({
    this.key,
    required this.isUpdate,
    this.habit,
    required this.publicHabitsSize,
  });

  factory HabitDetailsData.fromJson(Map<String, dynamic> json) =>
      _$HabitDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$HabitDetailsDataToJson(this);
}

@JsonSerializable()
class DeadlinesData {
  @KeyConverter()
  final Key? key;
  final DateTime? selectedDate;

  DeadlinesData({this.key, this.selectedDate});

  factory DeadlinesData.fromJson(Map<String, dynamic> json) =>
      _$DeadlinesDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeadlinesDataToJson(this);
}

@JsonSerializable()
class GoalDetailsData {
  @KeyConverter()
  final Key? key;
  final DataType selectedDataType;
  final int accumulationType;
  final bool isUpdate;
  final HabitGoalView? habitGoal;

  GoalDetailsData({
    this.key,
    required this.selectedDataType,
    required this.accumulationType,
    required this.isUpdate,
    this.habitGoal,
  });

  factory GoalDetailsData.fromJson(Map<String, dynamic> json) =>
      _$GoalDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoalDetailsDataToJson(this);
}

@JsonSerializable()
class IconsData {
  @KeyConverter()
  final Key? key;
  final int iconId;

  IconsData({this.key, required this.iconId});

  factory IconsData.fromJson(Map<String, dynamic> json) =>
      _$IconsDataFromJson(json);

  Map<String, dynamic> toJson() => _$IconsDataToJson(this);
}

@JsonSerializable()
class HabitRecordsData {
  @KeyConverter()
  final Key? key;
  final HabitView habit;
  final bool ishome;
  final bool readOnly;

  HabitRecordsData({
    this.key,
    required this.habit,
    required this.ishome,
    this.readOnly = false,
  });

  factory HabitRecordsData.fromJson(Map<String, dynamic> json) =>
      _$HabitRecordsDataFromJson(json);

  Map<String, dynamic> toJson() => _$HabitRecordsDataToJson(this);
}

@JsonSerializable()
class SettingsData {
  @KeyConverter()
  final Key? key;

  SettingsData({this.key});

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);
}

@JsonSerializable()
class UrHabitsTutorialsData {
  @KeyConverter()
  final Key? key;

  UrHabitsTutorialsData({this.key});

  factory UrHabitsTutorialsData.fromJson(Map<String, dynamic> json) =>
      _$UrHabitsTutorialsDataFromJson(json);

  Map<String, dynamic> toJson() => _$UrHabitsTutorialsDataToJson(this);
}
