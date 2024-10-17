import 'package:ur_habits/resources/extension/text_constants_extension.dart';

/// UI表示用の文字列を整形するためのクラス
class UITrimmer {
  /// 時間（Duration）をフォーマットして文字列に変換する
  static String formatTime(Duration time, {bool includeSeconds = false}) {
    // 時間と分をフォーマット
    String formattedTime =
        '${time.inHours.toString().padLeft(2, TextContents.zero.text)}:'
        '${(time.inMinutes % 60).toString().padLeft(2, TextContents.zero.text)}';

    // 秒を含める場合
    if (includeSeconds) {
      formattedTime +=
          ':${(time.inSeconds % 60).toString().padLeft(2, TextContents.zero.text)}';
    }

    return formattedTime;
  }

  /// 数値の文字列を整形する
  static String formatNumericValue(String value) {
    if (value.isEmpty) return value;

    if (value == TextContents.zero.text) return value;

    // 不要な先頭のゼロを削除
    value = _removeLeadingZeros(value);

    // 小数点の前に数字がない場合、TextContents.zero.textを追加
    value = _ensureLeadingZero(value);

    // 小数点の後に数字がない場合、TextContents.zero.textを追加
    value = _ensureTrailingZero(value);

    // 小数点の後の不要なゼロを削除
    value = _trimTrailingZeros(value);

    return value;
  }

  /// 先頭の不要なゼロを削除する
  static String _removeLeadingZeros(String value) {
    final RegExp leadingZeroPattern = RegExp('^0+(?!\\.)');

    value = value.replaceFirst(leadingZeroPattern, '');

    // 全ての数字が削除されてしまった場合はTextContents.zero.textを返す
    if (value.isEmpty) {
      return TextContents.zero.text;
    }

    return value;
  }

  /// 小数点の前に数字がない場合、TextContents.zero.textを追加する
  static String _ensureLeadingZero(String value) {
    if (value.startsWith('.')) {
      value = '0$value';
    }
    return value;
  }

  /// 小数点の後に数字がない場合、TextContents.zero.textを追加する
  static String _ensureTrailingZero(String value) {
    if (value.endsWith('.')) {
      value = '${value}0';
    }
    return value;
  }

  /// 小数点の後の不要なゼロを削除する
  static String _trimTrailingZeros(String value) {
    if (value.contains('.')) {
      final parts = value.split('.');
      final integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';

      if (decimalPart.length > 1) {
        // 末尾のゼロを削除
        decimalPart = decimalPart.replaceFirst(RegExp(r'0+$'), '');

        // 小数点直後のゼロ以外が全て削除された場合、最初のゼロを残す
        if (decimalPart.isEmpty) {
          decimalPart = TextContents.zero.text;
        }
      }

      value = '$integerPart.$decimalPart';
    }
    return value;
  }

  /// メールアドレスの表示を短くする
  static String shortenEmail(String email) {
    if (email.length >= 30) {
      return "${email.substring(0, 26)}...";
    }
    return email;
  }
}
