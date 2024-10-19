enum ValidationMessages {
  currentValueInvalid,
  emailInvalid,
  emailRequired,
  equalToCurrentValueNotAllowed,
  greaterThanCurrentValue,
  integerRequired,
  numericRequired,
  passwordMinLength,
  passwordMismatch,
  passwordRequired,
  smallerThanCurrentValue,
  titleValueRequired,
  targetValueRequired,
  userNameRequired,
}

extension ValidationMessagesExtension on ValidationMessages {
  static const Map<ValidationMessages, String> _texts = {
    ValidationMessages.currentValueInvalid: '現在値が不正です、変更してください',
    ValidationMessages.emailInvalid: 'メールアドレスの形式が正しくありません',
    ValidationMessages.emailRequired: 'メールアドレスを入力してください',
    ValidationMessages.equalToCurrentValueNotAllowed: '現在値と同じ値は入力できません',
    ValidationMessages.greaterThanCurrentValue: '現在値より大きな値を入力してください',
    ValidationMessages.integerRequired: '整数で入力してください',
    ValidationMessages.numericRequired: '半角数字で入力してください',
    ValidationMessages.passwordMinLength: '6文字以上で入力してください',
    ValidationMessages.passwordMismatch: 'パスワード(確認用)と異なります',
    ValidationMessages.passwordRequired: 'パスワードを入力してください',
    ValidationMessages.smallerThanCurrentValue: '現在値より小さな値を入力してください',
    ValidationMessages.targetValueRequired: '目標値を入力してください',
    ValidationMessages.titleValueRequired: 'タイトルを入力してください',
    ValidationMessages.userNameRequired: 'ユーザー名を入力してください',
  };

  String get text => _texts[this] ?? '';
}
