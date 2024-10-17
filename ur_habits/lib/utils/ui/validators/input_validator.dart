/// 共通のバリデーションクラス
class InputValidator {
  /// 値がnullまたは空でないことを確認する
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// 値が整数であることを確認する
  static bool isInteger(String value) {
    return int.tryParse(value) != null;
  }

  /// 値が数値であることを確認する
  static bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  /// 値が指定された最小長以上であることを確認する
  static bool hasMinLength(String value, int minLength) {
    return value.trim().length >= minLength;
  }

  /// 値がメールアドレスの形式であることを確認する
  static bool isValidEmailFormat(String email) {
    // メールアドレスの形式チェック
    const pattern =
        r'^[a-zA-Z0-9_.+-]+@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
