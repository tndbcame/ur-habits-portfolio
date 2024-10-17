import 'package:ur_habits/data/models/ui/habit_values.dart';

class AchievementRateCalculator {
  /// 累積値を計算する
  (int?, double?, Duration?) calculateAccumulatedValue(
    int dataType,
    Map<DateTime, HabitValues>? values,
  ) {
    if (values == null) return (null, null, null);

    try {
      switch (dataType) {
        case 1:
        case 6:
        case 8:
          return _calculateIntegerAccumulation(values);
        case 2:
        case 7:
          return _calculateDoubleAccumulation(values);
        default:
          return _calculateDurationAccumulation(values);
      }
    } catch (e) {
      return (null, null, null);
    }
  }

  /// データタイプを判定する
  int determineDataType((int?, double?, Duration?)? accumulatedValue) {
    if (accumulatedValue == null) return 0;
    if (accumulatedValue.$1 != null) return 1;
    if (accumulatedValue.$2 != null) return 2;
    if (accumulatedValue.$3 != null) return 3;
    return 0;
  }

  /// 達成率を計算する
  double calculateAchievementRate(
    int dataType,
    String targetValue,
    Duration? targetDuration,
    (int?, double?, Duration?)? accumulatedValue,
  ) {
    if (accumulatedValue == null) return 0;

    switch (dataType) {
      case 1:
        return _calculateIntegerAchievementRate(targetValue, accumulatedValue);
      case 2:
        return _calculateDoubleAchievementRate(targetValue, accumulatedValue);
      case 3:
        return _calculateDurationAchievementRate(
            targetDuration, accumulatedValue);
      default:
        return 0;
    }
  }

  /// int型の累積値を計算する
  (int?, double?, Duration?) _calculateIntegerAccumulation(
      Map<DateTime, HabitValues> values) {
    int total = 0;
    values.forEach((key, val) {
      total += int.parse(val.str);
    });
    return (total, null, null);
  }

  /// double型の累積値を計算する
  (int?, double?, Duration?) _calculateDoubleAccumulation(
      Map<DateTime, HabitValues> values) {
    double total = 0;
    values.forEach((key, val) {
      total += double.parse(val.str);
    });
    return (null, total, null);
  }

  /// Duration型の累積値を計算する
  (int?, double?, Duration?) _calculateDurationAccumulation(
      Map<DateTime, HabitValues> values) {
    Duration total = Duration.zero;
    values.forEach((key, val) {
      if (val.dur != null) {
        total += val.dur!;
      }
    });
    return (null, null, total);
  }

  /// int型の達成率を計算する
  double _calculateIntegerAchievementRate(
      String targetValue, (int?, double?, Duration?) accumulatedValue) {
    if (int.tryParse(targetValue) == null || accumulatedValue.$1 == 0) return 0;
    return ((accumulatedValue.$1! / int.parse(targetValue)) * 10000).round() /
        100;
  }

  /// double型の達成率を計算する
  double _calculateDoubleAchievementRate(
      String targetValue, (int?, double?, Duration?) accumulatedValue) {
    if (double.tryParse(targetValue) == null || accumulatedValue.$2 == 0) {
      return 0;
    }
    return ((accumulatedValue.$2! / double.parse(targetValue)) * 10000)
            .round() /
        100;
  }

  /// Duration型の達成率を計算する
  double _calculateDurationAchievementRate(
      Duration? targetDuration, (int?, double?, Duration?) accumulatedValue) {
    if (targetDuration == null || accumulatedValue.$3!.inSeconds == 0) return 0;
    return ((accumulatedValue.$3!.inSeconds / targetDuration.inSeconds) * 10000)
            .round() /
        100;
  }
}
