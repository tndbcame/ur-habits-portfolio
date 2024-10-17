import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ur_habits/data/models/habit_record.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';

/// HabitValuesの変換を行うクラス
class HabitConverter {
  /// dynamic型の日付をDateTimeに変換する
  static DateTime? toDate(dynamic date) {
    if (date is Timestamp) {
      return date.toDate();
    } else if (date is DateTime) {
      return date;
    }
    return null;
  }

  /// HabitValuesのMapをStringのMapに変換する
  static Map<DateTime, String> toStrMap(
      Map<DateTime, HabitValues> habitValuesMap) {
    return habitValuesMap
        .map((dateTime, habitValues) => MapEntry(dateTime, habitValues.str));
  }

  /// HabitValuesのMapをDurationのMapに変換する
  static Map<DateTime, Duration> toDurMap(
      Map<DateTime, HabitValues> habitValuesMap) {
    // durがnullのエントリを削除
    habitValuesMap
        .removeWhere((dateTime, habitValues) => habitValues.dur == null);
    return habitValuesMap
        .map((dateTime, habitValues) => MapEntry(dateTime, habitValues.dur!));
  }

  /// 指定されたパラメータからHabitValuesのMapを作成する
  static Map<DateTime, HabitValues> toRecordMap(
      DateTime dateTime, String strValue, Duration? durationValue,
      {int? id}) {
    return {
      dateTime: HabitValues(
        id: id,
        str: strValue,
        dur: durationValue,
      ),
    };
  }

  /// HabitRecordをHabitValuesのMapに変換する
  static Map<DateTime, HabitValues> recordToRecordMap(HabitRecord record) {
    return {
      record.date!: HabitValues(
        id: record.id,
        str: record.strVal!,
        dur: record.durVal != null ? Duration(seconds: record.durVal!) : null,
      ),
    };
  }
}
