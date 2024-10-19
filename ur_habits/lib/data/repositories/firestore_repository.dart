// import 'dart:async';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:ur_habits/data/services/firebase_service.dart';
// import 'package:ur_habits/data/models/ui/habit_values.dart';
// import 'package:ur_habits/data/models/ui/habit_view.dart';

// /// Firestoreとのやり取りを行うリポジトリクラス
// class FirestoreRepository {
//   /// シングルトンで実装
//   static final FirestoreRepository _instance = FirestoreRepository._internal();
//   factory FirestoreRepository() => _instance;
//   FirestoreRepository._internal();

//   final FirebaseService _firebaseService = FirebaseService();

//   // ---------------- ユーザー関連のメソッド ----------------

//   /// ユーザーの存在を確認する
//   /// @return : 0 - 存在する, 1 - 存在しない, 99 - エラー
//   Future<int> checkUserExists(String userId) async {
//     int status = 1;
//     try {
//       DocumentSnapshot docSnapshot = await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .get();

//       if (docSnapshot.exists) {
//         status = 0;
//       } else {
//         status = 1;
//       }
//     } on FirebaseException catch (e) {
//       if (e.code == 'unavailable') {
//         status = 1;
//       } else {
//         status = 99;
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//       status = 99;
//     }
//     return status;
//   }

//   /// ユーザー名を取得する
//   Future<String> getUserName(String userId) async {
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     String username = '';
//     try {
//       DocumentSnapshot<Map<String, dynamic>> docSnapshot =
//           await _firebaseService.firestore
//               .collection('users')
//               .doc(userId)
//               .get(cacheOptions);

//       username = docSnapshot.data()?['username'] ?? '';
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return username;
//   }

//   /// ユーザー情報を設定する
//   Future<void> setUserInfo(
//     String userId,
//     String username,
//     String email,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore.collection('users').doc(userId).set({
//         'username': username,
//         'email': email,
//       }).timeout(
//           Duration(
//             seconds: isOffline ? 1 : 3,
//           ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// ユーザー名を更新する
//   Future<void> updateUsername(
//     String myId,
//     String username,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore.collection('users').doc(myId).update({
//         'username': username,
//       }).timeout(
//           Duration(
//             seconds: isOffline ? 1 : 3,
//           ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   // ---------------- パートナー関連のメソッド ----------------

//   /// パートナーの存在を確認する
//   /// @return : 2 - 存在する, 0 - 存在しない, 99 - エラー
//   Future<int> checkPartnerExists(String userId) async {
//     int status = 0;
//     try {
//       QuerySnapshot docSnapshot = await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .get();
//       for (var docSnapshot in docSnapshot.docs) {
//         if (docSnapshot.exists) {
//           status = 2;
//           break;
//         } else {
//           status = 0;
//           break;
//         }
//       }
//     } on FirebaseException catch (e) {
//       if (e.code == 'unavailable') {
//         status = 0;
//       } else {
//         status = 99;
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//       status = 99;
//     }
//     return status;
//   }

//   /// パートナーの名前を取得する
//   Future<List<Map<String, dynamic>>> getPartnerNames(String userId) async {
//     List<Map<String, dynamic>> partnerNames = [];
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseService
//           .firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .get();

//       for (var doc in querySnapshot.docs) {
//         partnerNames.add(doc.data());
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return partnerNames;
//   }

//   /// パートナー情報を取得する
//   Future<Map<String, String>> getPartnerInfos(String userId) async {
//     Map<String, String> partnerInfo = {};
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseService
//           .firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .get();

//       for (var doc in querySnapshot.docs) {
//         partnerInfo.addAll({doc.id: doc.data().toString()});
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return partnerInfo;
//   }

//   /// パートナーを設定する
//   Future<void> setPartner(
//     String userId,
//     String partnerId,
//     String partnerName,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .doc(partnerId)
//           .set({'username': partnerName}).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// パートナー名を更新する
//   Future<void> updatePartnername(
//     String userId,
//     String partnerId,
//     String partnerName,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .doc(partnerId)
//           .update({'username': partnerName}).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// パートナーを削除する
//   Future<void> deletePartner(
//     String userId,
//     String partnerId,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('partner')
//           .doc(partnerId)
//           .delete()
//           .timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   // ---------------- リクエスト関連のメソッド ----------------

//   /// 送信リクエストが存在するか確認する
//   Future<bool> sentRequestExist(
//     String userId,
//     String destinationUserId,
//   ) async {
//     bool requestExists = false;
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     try {
//       DocumentSnapshot docSnapshot = await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('sentRequests')
//           .doc(destinationUserId)
//           .get(cacheOptions);

//       requestExists = docSnapshot.exists;
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return requestExists;
//   }

//   /// 受信リクエストが存在するか確認する
//   Future<bool> gotRequestExist(
//     String userId,
//     String receivedUserId,
//   ) async {
//     bool requestExists = false;
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     try {
//       DocumentSnapshot docSnapshot = await _firebaseService.firestore
//           .collection('users')
//           .doc(receivedUserId)
//           .collection('gotRequests')
//           .doc(userId)
//           .get(cacheOptions);

//       requestExists = docSnapshot.exists;
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return requestExists;
//   }

//   /// 送信リクエストを設定する
//   Future<void> setSentRequest(
//     String userId,
//     String destinationUserId,
//     String username,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('sentRequests')
//           .doc(destinationUserId)
//           .set({'username': username}).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 受信リクエストを設定する
//   Future<void> setGotRequest(
//     String userId,
//     String receivedUserId,
//     String username,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(receivedUserId)
//           .collection('gotRequests')
//           .doc(userId)
//           .set({'username': username}).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 送信リクエストを削除する
//   Future<void> deleteSentRequest(
//     String userId,
//     String destinationUserId,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('sentRequests')
//           .doc(destinationUserId)
//           .delete()
//           .timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 受信リクエストを削除する
//   Future<void> deleteGotRequest(
//     String userId,
//     String receivedUserId,
//   ) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(receivedUserId)
//           .collection('gotRequests')
//           .doc(userId)
//           .delete()
//           .timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   // ---------------- 習慣関連のメソッド ----------------

//   /// 習慣を取得する
//   Future<List<Map<String, dynamic>>> getHabits(String userId) async {
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     List<Map<String, dynamic>> habitsData = [];
//     try {
//       QuerySnapshot<Map<String, dynamic>> habitsSnapshot =
//           await _firebaseService.firestore
//               .collection('users')
//               .doc(userId)
//               .collection('habits')
//               .get(cacheOptions);

//       for (var doc in habitsSnapshot.docs) {
//         Map<String, dynamic> habitData = doc.data();
//         List<Map<String, dynamic>> recordsData =
//             await getHabitRecords(doc.reference);
//         habitData['records'] = recordsData;
//         habitsData.add(habitData);
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return habitsData;
//   }

//   /// 習慣の記録を取得する
//   Future<List<Map<String, dynamic>>> getHabitRecords(
//     DocumentReference habitDocRef,
//   ) async {
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     List<Map<String, dynamic>> recordsData = [];
//     try {
//       QuerySnapshot<Map<String, dynamic>> recordsSnapshot =
//           await habitDocRef.collection('habitRecords').get(cacheOptions);

//       for (var doc in recordsSnapshot.docs) {
//         recordsData.add({
//           'date': doc.data()['date'],
//           'str': doc.data()['str'],
//           'dur': doc.data()['dur'],
//         });
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     return recordsData;
//   }

//   /// 習慣を設定する
//   Future<void> setHabit(
//     HabitView habit,
//     String userId,
//     bool isUpdate,
//   ) async {
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     int habitId = await _getNextHabitId(userId, cacheOptions);
//     bool isOffline = await _isOffline();
//     bool existRecords = habit.records != null;

//     if (existRecords) {
//       await setHabitRecords(
//         habit.records!,
//         userId,
//         habitId.toString(),
//         time: isOffline ? 1 : 3,
//       );
//     } else if (habit.goal != null &&
//         habit.goal!.currentValues.str.isNotEmpty &&
//         !isUpdate) {
//       await setHabitRecord(
//         habit.goal!.inputedDate,
//         habit.goal!.currentValues,
//         userId,
//         habitId.toString(),
//         time: isOffline ? 1 : 3,
//       );
//     }

//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .doc(habitId.toString())
//           .set({
//         'id': habitId,
//         'title': habit.title,
//         'iconId': habit.iconId,
//         'dataTypeId': habit.dataType.id,
//         'accumulationType': habit.accumulationType,
//         'unit': habit.unit,
//         'isGoal': habit.isGoal,
//         'sort': '-1',
//         'goal': habit.goal == null
//             ? null
//             : {
//                 'title': habit.goal?.title,
//                 'incDecTyep': habit.goal?.incDecTyep,
//                 'currentStrVal': habit.goal?.currentValues.str,
//                 'targetStrVal': habit.goal?.targetValues.str,
//                 'inputedDate': habit.goal?.inputedDate,
//                 'currentDurVal': habit.goal?.currentValues.dur?.inSeconds,
//                 'targetDurVal': habit.goal?.targetValues.dur?.inSeconds,
//                 'deadline': habit.goal?.deadline,
//                 'memo': habit.goal?.memo,
//               },
//       }).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣を更新する
//   Future<void> updateHabit(HabitView habit, String userId) async {
//     bool isOffline = await _isOffline();
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .doc(habit.id.toString())
//           .update({
//         'title': habit.title,
//         'iconId': habit.iconId,
//         'isGoal': habit.isGoal,
//         if (habit.goal != null)
//           'goal': {
//             'title': habit.goal?.title,
//             'incDecTyep': habit.goal?.incDecTyep,
//             'currentStrVal': habit.goal?.currentValues.str,
//             'targetStrVal': habit.goal?.targetValues.str,
//             'inputedDate': habit.goal?.inputedDate,
//             'currentDurVal': habit.goal?.currentValues.dur?.inSeconds,
//             'targetDurVal': habit.goal?.targetValues.dur?.inSeconds,
//             'deadline': habit.goal?.deadline,
//             'memo': habit.goal?.memo,
//           },
//       }).timeout(
//               Duration(
//                 seconds: isOffline ? 1 : 3,
//               ), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣を削除する
//   Future<void> deleteHabit(String userId, String habitId) async {
//     bool isOffline = await _isOffline();

//     await _deleteHabitRecords(userId, habitId, isOffline ? 1 : 3);

//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .doc(habitId)
//           .delete()
//           .timeout(Duration(seconds: isOffline ? 1 : 3), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣の記録を設定する
//   Future<void> setHabitRecord(
//     DateTime date,
//     HabitValues values,
//     String userId,
//     String habitId, {
//     int time = 3,
//   }) async {
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .doc(habitId)
//           .collection('habitRecords')
//           .doc(date.toString())
//           .set({
//         'date': date,
//         'str': values.str,
//         'dur': values.dur?.inSeconds,
//       }).timeout(Duration(seconds: time), onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣の記録を設定する（複数）
//   Future<void> setHabitRecords(
//     Map<DateTime, HabitValues> values,
//     String userId,
//     String habitId, {
//     int time = 3,
//   }) async {
//     if (values.isEmpty) return;

//     try {
//       const int batchSize = 500;
//       List<MapEntry<DateTime, HabitValues>> records = values.entries.toList();
//       int totalRecords = records.length;
//       int index = 0;

//       // レコードを500個ごとにバッチ処理
//       while (index < totalRecords) {
//         WriteBatch batch = _firebaseService.firestore.batch();

//         // バッチに追加するエントリの範囲を決定
//         int endIndex = index + batchSize;
//         if (endIndex > totalRecords) endIndex = totalRecords;

//         // バッチ内の各記録を追加
//         for (int i = index; i < endIndex; i++) {
//           var record = records[i];
//           DocumentReference docRef = _firebaseService.firestore
//               .collection('users')
//               .doc(userId)
//               .collection('habits')
//               .doc(habitId)
//               .collection('habitRecords')
//               .doc(record.key.toString());

//           batch.set(docRef, {
//             'date': record.key,
//             'str': record.value.str,
//             'dur': record.value.dur?.inSeconds,
//           });
//         }

//         // バッチをコミット
//         await batch.commit().timeout(Duration(seconds: time), onTimeout: () {
//           log('バッチコミットがタイムアウトになりました');
//           return;
//         });

//         // 次のバッチへ進むためにインデックスを更新
//         index = endIndex;
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣の記録を削除する
//   Future<void> deleteHabitRecord(
//       String userId, String habitId, DateTime date) async {
//     try {
//       await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .doc(habitId)
//           .collection('habitRecords')
//           .doc(date.toString())
//           .delete();
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// 習慣のソート順を更新する
//   Future<void> updateSort(List<HabitView> habitList, String userId) async {
//     bool isOffline = await _isOffline();
//     var cacheOptions = await _fetchCacheOptionsIfOffline();
//     try {
//       QuerySnapshot habitsSnapshot = await _firebaseService.firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .get(cacheOptions);

//       WriteBatch batch = _firebaseService.firestore.batch();

//       for (var habitDoc in habitsSnapshot.docs) {
//         HabitView habit = habitList.firstWhere(
//           (item) => item.id.toString() == habitDoc.id,
//         );

//         batch.update(habitDoc.reference, {
//           'sort': habit.sort,
//         });
//       }

//       await batch.commit().timeout(Duration(seconds: isOffline ? 1 : 3),
//           onTimeout: () {
//         log('タイムアウトになりました');
//         return;
//       });
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//   }

//   /// ユーザーのデータをすべて削除するメソッド。
//   /// @return : 0 (オフライン), 1 (成功), 99 (エラー)
//   Future<int> deleteUserData(String userId) async {
//     bool isOffline = await _isOffline();
//     if (isOffline) return 0;

//     WriteBatch batch = _firebaseService.firestore.batch();
//     int batchCount = 0;

//     Future<void> commitBatch() async {
//       if (batchCount > 0) {
//         await batch.commit();
//         batch = _firebaseService.firestore.batch(); // 新しいバッチを作成
//         batchCount = 0; // カウンターをリセット
//       }
//     }

//     DocumentReference userDoc =
//         _firebaseService.firestore.collection('users').doc(userId);

//     try {
//       // サブコレクションの削除メソッド
//       Future<void> deleteSubCollection(
//           String collectionName, DocumentReference docRef) async {
//         QuerySnapshot snapshot = await docRef.collection(collectionName).get();
//         for (DocumentSnapshot doc in snapshot.docs) {
//           batch.delete(doc.reference);
//           batchCount++;
//           if (batchCount >= 500) await commitBatch();
//         }
//       }

//       // partnerコレクションの削除
//       QuerySnapshot partnerSnapshot = await userDoc.collection('partner').get();
//       for (DocumentSnapshot partnerDoc in partnerSnapshot.docs) {
//         DocumentReference partnerRef = _firebaseService.firestore
//             .collection('users')
//             .doc(partnerDoc.id)
//             .collection('partner')
//             .doc(userId);
//         batch.delete(partnerRef);
//         batch.delete(partnerDoc.reference);
//         batchCount += 2; // 2つのドキュメントを削除するため、カウンターを2増やす
//         if (batchCount >= 500) await commitBatch();
//       }

//       // gotRequestsコレクションの削除
//       await deleteSubCollection('gotRequests', userDoc);

//       // sentRequestsコレクションと相手側のgotRequestsの削除
//       QuerySnapshot sentRequestsSnapshot =
//           await userDoc.collection('sentRequests').get();
//       for (DocumentSnapshot sentRequestDoc in sentRequestsSnapshot.docs) {
//         String partnerId = sentRequestDoc.id;

//         // 自分側の送信リクエストを削除
//         batch.delete(sentRequestDoc.reference);
//         batchCount++;
//         if (batchCount >= 500) await commitBatch();

//         // 相手側の受信リクエストを削除
//         DocumentReference partnerGotRequestDoc = _firebaseService.firestore
//             .collection('users')
//             .doc(partnerId)
//             .collection('gotRequests')
//             .doc(userId);

//         if ((await partnerGotRequestDoc.get()).exists) {
//           batch.delete(partnerGotRequestDoc);
//           batchCount++;
//           if (batchCount >= 500) await commitBatch();
//         }
//       }

//       // habitsとそのサブコレクションhabitRecordsの削除
//       QuerySnapshot habitsSnapshot = await userDoc.collection('habits').get();
//       for (DocumentSnapshot habitDoc in habitsSnapshot.docs) {
//         await deleteSubCollection('habitRecords', habitDoc.reference);
//         batch.delete(habitDoc.reference);
//         batchCount++;
//         if (batchCount >= 500) await commitBatch();
//       }

//       // 最後にuserIdのドキュメント自体を削除
//       batch.delete(userDoc);
//       batchCount++;
//       if (batchCount >= 500) await commitBatch();

//       // 最終的なバッチのコミット
//       await commitBatch();
//       return 1;
//     } catch (e) {
//       return 99;
//     }
//   }

//   // ---------------- ヘルパーメソッド ----------------

//   /// 次の習慣IDを取得する
//   Future<int> _getNextHabitId(String userId, GetOptions? options) async {
//     List<int> docIdList = [];
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await _firebaseService
//           .firestore
//           .collection('users')
//           .doc(userId)
//           .collection('habits')
//           .get(options);

//       for (var doc in snapshot.docs) {
//         docIdList.add(int.parse(doc.id));
//       }
//     } catch (e) {
//       log('エラーが発生しました: $e');
//     }
//     int id = 1;
//     if (docIdList.isNotEmpty) {
//       int maxValue = docIdList.reduce((a, b) => a > b ? a : b);
//       id = maxValue + 1;
//     }
//     return id;
//   }

//   /// 習慣の記録を全て削除する
//   Future<void> _deleteHabitRecords(
//     String userId,
//     String habitId,
//     int time,
//   ) async {
//     final collectionRef = _firebaseService.firestore
//         .collection('users')
//         .doc(userId)
//         .collection('habits')
//         .doc(habitId)
//         .collection('habitRecords');

//     const int batchSize = 500;
//     bool batchCompleted = false;
//     var cacheOptions = await _fetchCacheOptionsIfOffline();

//     while (!batchCompleted) {
//       try {
//         final snapshot = await collectionRef.limit(batchSize).get(cacheOptions);

//         if (snapshot.docs.isEmpty) {
//           batchCompleted = true;
//           log('全てのドキュメントが削除されました');
//           break;
//         }

//         WriteBatch batch = _firebaseService.firestore.batch();

//         for (var doc in snapshot.docs) {
//           batch.delete(doc.reference);
//         }

//         await batch.commit().timeout(Duration(seconds: time), onTimeout: () {
//           log('バッチコミットがタイムアウトになりました');
//           return;
//         });
//         log('${snapshot.docs.length} 件のドキュメントが削除されました');
//       } catch (e) {
//         log('エラーが発生しました: $e');
//         break;
//       }
//     }
//   }

//   /// オフラインの場合にキャッシュからデータを取得するオプションを返す
//   Future<GetOptions?> _fetchCacheOptionsIfOffline() async {
//     return await _isOffline() ? const GetOptions(source: Source.cache) : null;
//   }

//   /// ネットワーク接続がオフラインかどうかを判定する
//   Future<bool> _isOffline() async {
//     try {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       return connectivityResult.first == ConnectivityResult.none;
//     } catch (e) {
//       log('エラーが発生しました: $e');
//       return true;
//     }
//   }
// }
