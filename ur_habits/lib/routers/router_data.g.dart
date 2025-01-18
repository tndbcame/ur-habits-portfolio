// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabsData _$TabsDataFromJson(Map<String, dynamic> json) => TabsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
    );

Map<String, dynamic> _$TabsDataToJson(TabsData instance) => <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
    };

LoginsData _$LoginsDataFromJson(Map<String, dynamic> json) => LoginsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      isLogin: json['isLogin'] as bool,
    );

Map<String, dynamic> _$LoginsDataToJson(LoginsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'isLogin': instance.isLogin,
    };

RenamesData _$RenamesDataFromJson(Map<String, dynamic> json) => RenamesData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RenamesDataToJson(RenamesData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'name': instance.name,
    };

RepasswordsData _$RepasswordsDataFromJson(Map<String, dynamic> json) =>
    RepasswordsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      title: json['title'] as String?,
      cationText: json['cationText'] as String?,
      appBarColor: const ColorConverter()
          .fromJson((json['appBarColor'] as num?)?.toInt()),
      containerColor: const ColorConverter()
          .fromJson((json['containerColor'] as num?)?.toInt()),
      backgroundColor: const ColorConverter()
          .fromJson((json['backgroundColor'] as num?)?.toInt()),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$RepasswordsDataToJson(RepasswordsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'title': instance.title,
      'cationText': instance.cationText,
      'appBarColor': const ColorConverter().toJson(instance.appBarColor),
      'containerColor': const ColorConverter().toJson(instance.containerColor),
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'email': instance.email,
    };

TitlesData _$TitlesDataFromJson(Map<String, dynamic> json) => TitlesData(
      key: const KeyConverter().fromJson(json['key'] as String?),
    );

Map<String, dynamic> _$TitlesDataToJson(TitlesData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
    };

UnregistersData _$UnregistersDataFromJson(Map<String, dynamic> json) =>
    UnregistersData(
      key: const KeyConverter().fromJson(json['key'] as String?),
    );

Map<String, dynamic> _$UnregistersDataToJson(UnregistersData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
    };

HabitDetailsData _$HabitDetailsDataFromJson(Map<String, dynamic> json) =>
    HabitDetailsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      isUpdate: json['isUpdate'] as bool,
      habit: json['habit'] == null
          ? null
          : HabitView.fromJson(json['habit'] as Map<String, dynamic>),
      publicHabitsSize: (json['publicHabitsSize'] as num).toInt(),
    );

Map<String, dynamic> _$HabitDetailsDataToJson(HabitDetailsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'isUpdate': instance.isUpdate,
      'habit': instance.habit,
      'publicHabitsSize': instance.publicHabitsSize,
    };

DeadlinesData _$DeadlinesDataFromJson(Map<String, dynamic> json) =>
    DeadlinesData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
    );

Map<String, dynamic> _$DeadlinesDataToJson(DeadlinesData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'selectedDate': instance.selectedDate?.toIso8601String(),
    };

GoalDetailsData _$GoalDetailsDataFromJson(Map<String, dynamic> json) =>
    GoalDetailsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      selectedDataType:
          DataType.fromJson(json['selectedDataType'] as Map<String, dynamic>),
      accumulationType: (json['accumulationType'] as num).toInt(),
      isUpdate: json['isUpdate'] as bool,
      habitGoal: json['habitGoal'] == null
          ? null
          : HabitGoalView.fromJson(json['habitGoal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoalDetailsDataToJson(GoalDetailsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'selectedDataType': instance.selectedDataType,
      'accumulationType': instance.accumulationType,
      'isUpdate': instance.isUpdate,
      'habitGoal': instance.habitGoal,
    };

IconsData _$IconsDataFromJson(Map<String, dynamic> json) => IconsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      iconId: (json['iconId'] as num).toInt(),
    );

Map<String, dynamic> _$IconsDataToJson(IconsData instance) => <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'iconId': instance.iconId,
    };

HabitRecordsData _$HabitRecordsDataFromJson(Map<String, dynamic> json) =>
    HabitRecordsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
      habit: HabitView.fromJson(json['habit'] as Map<String, dynamic>),
      ishome: json['ishome'] as bool,
      readOnly: json['readOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$HabitRecordsDataToJson(HabitRecordsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
      'habit': instance.habit,
      'ishome': instance.ishome,
      'readOnly': instance.readOnly,
    };

SettingsData _$SettingsDataFromJson(Map<String, dynamic> json) => SettingsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
    );

Map<String, dynamic> _$SettingsDataToJson(SettingsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
    };

UrHabitsTutorialsData _$UrHabitsTutorialsDataFromJson(
        Map<String, dynamic> json) =>
    UrHabitsTutorialsData(
      key: const KeyConverter().fromJson(json['key'] as String?),
    );

Map<String, dynamic> _$UrHabitsTutorialsDataToJson(
        UrHabitsTutorialsData instance) =>
    <String, dynamic>{
      'key': const KeyConverter().toJson(instance.key),
    };
