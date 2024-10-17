import 'package:ur_habits/data/models/ui/data_type.dart';
import 'package:ur_habits/resources/extension/text_constants_extension.dart';
import 'package:ur_habits/resources/extension/validation_messages.dart';
import 'package:ur_habits/utils/ui/validators/input_validator.dart';

/// 習慣に関するバリデーションクラス
class HabitValidator {
  /// タイトルを検証する
  static String? validTitle(String? title) {
    if (!InputValidator.isNotEmpty(title)) {
      return ValidationMessages.titleValueRequired.text;
    }
    return null;
  }

  /// 目標値（テキストフォーム）を検証する
  static String? validGoalTextForm(
    String? inputValue,
    String currentValue,
    String targetValue,
    int dataTypeId,
    int incrementDecrementType,
    bool isTarget,
  ) {
    if (InputValidator.isNotEmpty(inputValue)) {
      if (!InputValidator.isNumeric(inputValue!)) {
        return ValidationMessages.numericRequired.text;
      }
      // データタイプが特定の場合、整数であることを確認
      if (dataTypeId == 1 || dataTypeId == 6 || dataTypeId == 8) {
        if (!InputValidator.isInteger(inputValue)) {
          return ValidationMessages.integerRequired.text;
        }
      }
    }
    if (isTarget) {
      try {
        if (!InputValidator.isNotEmpty(inputValue)) {
          return ValidationMessages.targetValueRequired.text;
        }
        if (!InputValidator.isNotEmpty(currentValue)) {
          return null;
        }
        double currentVal = double.parse(currentValue);
        double targetVal = double.parse(targetValue);
        if (incrementDecrementType == 2 && currentVal < targetVal) {
          return ValidationMessages.smallerThanCurrentValue.text;
        } else if (incrementDecrementType == 1 && currentVal > targetVal) {
          return ValidationMessages.greaterThanCurrentValue.text;
        } else if (currentVal == targetVal) {
          return ValidationMessages.equalToCurrentValueNotAllowed.text;
        }
      } catch (e) {
        return ValidationMessages.currentValueInvalid.text;
      }
    }
    return null;
  }

  /// 目標値（時間ピッカー）を検証する
  static String? validGoalTimePicker(
    String? inputValue,
    Duration? currentValue,
    Duration? targetValue,
    int dataTypeId,
    int incrementDecrementType,
    bool isTarget,
  ) {
    if (isTarget) {
      try {
        if (!InputValidator.isNotEmpty(inputValue)) {
          return ValidationMessages.targetValueRequired.text;
        }
        if (currentValue == null) {
          return null;
        }
        if (incrementDecrementType == 2 &&
            currentValue.inSeconds < targetValue!.inSeconds) {
          return ValidationMessages.smallerThanCurrentValue.text;
        } else if (incrementDecrementType == 1 &&
            currentValue.inSeconds > targetValue!.inSeconds) {
          return ValidationMessages.greaterThanCurrentValue.text;
        } else if (currentValue.inSeconds == targetValue!.inSeconds) {
          return ValidationMessages.equalToCurrentValueNotAllowed.text;
        }
      } catch (e) {
        return TextContents.errorOccurred.text;
      }
    }
    return null;
  }

  /// 記録用の入力値を検証する
  static String? validRecordTextForm(String? inputValue, DataType dataType) {
    if (!InputValidator.isNotEmpty(inputValue)) {
      return TextContents.enterValue.text;
    }
    if (!InputValidator.isNumeric(inputValue!)) {
      return ValidationMessages.numericRequired.text;
    }
    if (dataType.id != 2 && !InputValidator.isInteger(inputValue)) {
      return ValidationMessages.integerRequired.text;
    }
    return null;
  }
}
