/// Firebase認証エラーを表す列挙型
enum FirebaseAuthError {
  /// ユーザーが見つからない
  userNotFound,

  /// ユーザーが無効化されている
  userDisabled,

  /// 最近のログインが必要
  requiresRecentLogin,

  /// メールアドレスが既に使用されている
  emailAlreadyInUse,

  /// 無効なメールアドレス
  invalidEmail,

  /// 間違ったパスワード
  wrongPassword,

  /// リクエストが多すぎる
  tooManyRequests,

  /// アクションコードが期限切れ
  expiredActionCode,

  /// 不明なエラー
  unknown,
}

/// FirebaseAuthErrorの拡張機能
extension FirebaseAuthErrorExtension on FirebaseAuthError {
  /// エラーメッセージを取得する
  String get message {
    return _messages[this] ?? '予期しないエラーが発生しました';
  }

  /// エラーコードからFirebaseAuthErrorに変換する
  static FirebaseAuthError fromCode(String code) {
    return _errorCodeMap[code] ?? FirebaseAuthError.unknown;
  }

  /// エラーメッセージのマップ
  static const Map<FirebaseAuthError, String> _messages = {
    FirebaseAuthError.userNotFound: '指定されたユーザーは登録されていません',
    FirebaseAuthError.userDisabled: '指定されたユーザーは無効化されています',
    FirebaseAuthError.requiresRecentLogin:
        'アカウント削除などのセキュアな操作を行うにはログインによる再認証が必要です',
    FirebaseAuthError.emailAlreadyInUse: '既に利用されているメールアドレスです',
    FirebaseAuthError.invalidEmail: '不正なメールアドレスです',
    FirebaseAuthError.wrongPassword: 'メールアドレス、またはパスワードが間違っています',
    FirebaseAuthError.tooManyRequests: 'アクセスが集中しています。少し時間を置いてから再度お試しください',
    FirebaseAuthError.expiredActionCode:
        'メールアドレスリンクの期限が切れています。再度認証メールを送信してください',
    FirebaseAuthError.unknown: '予期しないエラーが発生しました',
  };

  /// エラーコードとFirebaseAuthErrorのマッピング
  static const Map<String, FirebaseAuthError> _errorCodeMap = {
    'user-not-found': FirebaseAuthError.userNotFound,
    'user-disabled': FirebaseAuthError.userDisabled,
    'requires-recent-login': FirebaseAuthError.requiresRecentLogin,
    'email-already-in-use': FirebaseAuthError.emailAlreadyInUse,
    'invalid-email': FirebaseAuthError.invalidEmail,
    'wrong-password': FirebaseAuthError.wrongPassword,
    'too-many-requests': FirebaseAuthError.tooManyRequests,
    'expired-action-code': FirebaseAuthError.expiredActionCode,
  };
}
