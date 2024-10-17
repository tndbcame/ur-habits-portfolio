import 'dart:collection';

import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/utils/ui/ui_trimmer.dart';

class HabitRecordHelper {
  /// チェックボックス用の表示文字列を取得
  getCheckboxStatusText(String selectVal) {
    return selectVal == TextContents.one.text
        ? TextContents.taskDone.text
        : TextContents.taskNotDone.text;
  }

  /// 記録日で並び替え
  void sortByRecordDate(HabitView habit) {
    habit.records = SplayTreeMap.from(habit.records!, (a, b) => a.compareTo(b));
  }

  /// 記録を生成
  MapEntry<DateTime, HabitValues> createRecord(
      DateTime date, String strVal, Duration? durVal) {
    return MapEntry(
      date,
      HabitValues(
        str: strVal,
        dur: durVal,
      ),
    );
  }

  /// 累積値を抽出
  String extractAccumulatedValue(
      int dataType, (int?, double?, Duration?) accumVal, bool? includeSeconds) {
    switch (dataType) {
      case 1:
        return accumVal.$1.toString();
      case 2:
        var value = accumVal.$2!.toString();
        if (value.length > 14) {
          value = accumVal.$2!.toStringAsFixed(4);
        }
        return UITrimmer.formatNumericValue(value);
      case 3:
        return UITrimmer.formatTime(accumVal.$3!,
            includeSeconds: includeSeconds ?? false);
      default:
        return TextContents.zero.text;
    }
  }

  /// 単純な数値やチェックボックスの入力が必要なデータタイプか確認
  bool isSimpleInputType(int dataTypeId) {
    return dataTypeId == 1 || dataTypeId == 2 || dataTypeId == 6;
  }
}
