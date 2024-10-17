import 'package:ur_habits/resources/extension/validation_messages.dart';
import 'package:ur_habits/utils/ui/validators/input_validator.dart';

/// 認証用のバリデーションクラス
class AuthValidator {
  /// ユーザー名を検証する
  static String? validUsername(String? username) {
    if (!InputValidator.isNotEmpty(username)) {
      return ValidationMessages.userNameRequired.text;
    }
    return null;
  }

  /// メールアドレスを検証する
  static String? validEmail(String? email) {
    if (!InputValidator.isNotEmpty(email)) {
      return ValidationMessages.emailRequired.text;
    }
    if (!InputValidator.isValidEmailFormat(email!)) {
      return ValidationMessages.emailInvalid.text;
    }
    return null;
  }

  /// パスワードを検証する
  static String? validPassword(String? password,
      {String? confirmationPassword}) {
    if (!InputValidator.isNotEmpty(password)) {
      return ValidationMessages.passwordRequired.text;
    }
    if (!InputValidator.hasMinLength(password!, 6)) {
      return ValidationMessages.passwordMinLength.text;
    }
    if (confirmationPassword != null &&
        password.compareTo(confirmationPassword) != 0) {
      return ValidationMessages.passwordMismatch.text;
    }
    return null;
  }
}
