// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// /// Firebaseサービスを管理するクラス
// class FirebaseService {
//   /// シングルトンで実装
//   static final FirebaseService _instance = FirebaseService._internal();
//   factory FirebaseService() => _instance;
//   FirebaseService._internal();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   /// FirebaseAuthのゲッター
//   FirebaseAuth get auth => _auth;

//   /// FirebaseFirestoreのゲッター
//   FirebaseFirestore get firestore => _firestore;

//   /// 現在のユーザーUIDを取得
//   String? get currentUserId => _auth.currentUser?.uid;

//   /// 現在のユーザーEmailを取得
//   String? get currentUserEmail => _auth.currentUser?.email;

//   /// Firebase Authの状態変化を監視
//   Stream<User?> authStateChanges() => _auth.authStateChanges();

//   /// ログアウト
//   Future<void> logout() async {
//     await _auth.signOut();
//   }

//   /// 新規ユーザーを登録する
//   Future<UserCredential> registerUser(String email, String password) async {
//     try {
//       return await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       log('ユーザー登録中にエラーが発生しました: $e');
//       rethrow;
//     }
//   }

//   /// ユーザーにサインインする
//   Future<UserCredential> signInUser(String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       log('サインイン中にエラーが発生しました: $e');
//       rethrow;
//     }
//   }

//   Future<UserCredential> reauthenticateUser(
//       String email, String password) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw FirebaseAuthException;
//     } else {
//       AuthCredential credential =
//           EmailAuthProvider.credential(email: email, password: password);
//       try {
//         // 再認証の実行
//         return await user.reauthenticateWithCredential(credential);
//       } catch (e) {
//         log('再認証中にエラーが発生しました: $e');
//         rethrow;
//       }
//     }
//   }

//   /// パスワードの再設定
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       log('パスワードをリセット中にエラーが起きました: $e');
//       rethrow;
//     }
//   }

//   /// ユーザーの退会処理
//   Future<void> deleteUser() async {
//     try {
//       await _auth.currentUser?.delete();
//     } catch (e) {
//       log('退会中にエラーが発生しました: $e');
//       rethrow;
//     }
//   }

//   /// Firestore内の指定したコレクションのスナップショットを取得
//   Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionSnapshot(
//       String collectionPath) {
//     return _firestore.collection(collectionPath).snapshots();
//   }

//   /// Firestore内の指定したサブコレクションのスナップショットを取得
//   Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionSnapshot(
//       String userId, String subCollectionPath) {
//     return _firestore
//         .collection('users')
//         .doc(userId)
//         .collection(subCollectionPath)
//         .snapshots();
//   }
// }
