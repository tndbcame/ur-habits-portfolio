import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ur_habits/data/repositories/abstract/remote_repository.dart';
import 'package:ur_habits/data/services/firebase_service.dart';
import 'package:ur_habits/resources/data.dart';
import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';
import 'package:ur_habits/data/repositories/firestore_repository.dart';
import 'package:ur_habits/utils/habit_values_converter.dart';
import 'package:ur_habits/view_models/mappers/habit_goal_view_mapper.dart';
import 'package:ur_habits/view_models/mappers/habit_view_mapper.dart';

class FirebaseViewModel {
  final FirebaseService firebaseServices = FirebaseService();
  final RemoteRepository repo = FirestoreRepository();

  /// ユーザーが存在するか確認する
  Future<int> checkUserExists(String userId) async {
    return await repo.existsUser(userId);
  }

  /// パートナーが存在するか確認する
  Future<int> checkPartnerExists(String userId) async {
    return await repo.existsPartner(userId);
  }

  /// ユーザー名を取得する
  Future<String> getUsername(String userId) async {
    return await repo.fetchUserName(userId);
  }

  /// ユーザー名を更新する
  Future<void> setUserInfo(String userId, String username, String email) async {
    repo.setUserInfo(userId, username, email);
  }

  /// ユーザー名を更新する
  Future<void> updateMyname(String userId, String newUsername) async {
    await repo.updateUsername(userId, newUsername);
  }

  /// パートナー名を取得する
  Future<String> getPartnername(String userId) async {
    String partnerName = '';
    final partnerNames = await repo.fetchPartnerNames(userId);
    if (partnerNames.isNotEmpty) {
      partnerName = partnerNames.first['username'];
    }
    return partnerName;
  }

  /// パートナー名を取得する
  Future<Map<String, String>> getPartnerInfo(String userId) async {
    return await repo.fetchPartnerInfos(userId);
  }

  /// パートナーの名前を更新する
  Future<void> updatePartnername(
      String userId, String partnerId, String newUsername) async {
    await repo.updatePartnername(partnerId, userId, newUsername);
  }

  /// パートナーリクエストを設定する
  Future<void> setPartnerRequests(String myId, String partnerId) async {
    final String myUsername = await getUsername(myId);
    final String partnerUsername = await getUsername(partnerId);

    if (!await repo.existsSentRequest(myId, partnerId)) {
      await repo.setSentRequest(myId, partnerId, partnerUsername);
    }
    if (!await repo.existsGotRequest(myId, partnerId)) {
      await repo.setGotRequest(myId, partnerId, myUsername);
    }
  }

  /// パートナーを設定する
  Future<void> setPartner(
      String myId, String partnerId, String myName, String partnerName) async {
    //自分側
    await repo.setPartner(myId, partnerId, partnerName);
    await _removePartnerRequests(myId, partnerId);
    //相手側
    await repo.setPartner(partnerId, myId, myName);
    await _removePartnerRequests(partnerId, myId);
  }

  /// パートナーを削除する
  Future<void> deletePartner(String myId, String partnerId) async {
    //自分側
    await repo.deletePartner(partnerId, myId);
    //相手側
    await repo.deletePartner(myId, partnerId);
  }

  /// パートナーリクエストを削除する
  Future<void> deletePartnerRequests(String myId, String partnerId) async {
    repo.deleteSentRequest(partnerId, myId);
    repo.deleteGotRequest(partnerId, myId);
  }

  /// ユーザーの習慣を取得する
  Future<List<HabitView>> getHabits(String userId) async {
    final habitsData = await repo.fetchHabits(userId);
    return habitsData.map(_createHabitView).toList();
  }

  /// パートナーの習慣を取得する
  Stream<List<HabitView>> getPartnerHabits(String userId) {
    return repo.fetchHabitsSnapshot(userId).map<List<HabitView>>((habitList) {
      return habitList.map(_createHabitView).toList();
    });
  }

  /// 習慣を追加または更新する
  Future<void> addHabit(HabitView habit, String myId, bool isUpdate) async {
    await repo.setHabit(habit, myId, isUpdate);
  }

  /// 習慣の記録を追加または更新する
  Future<void> addHabitRecord(
      DateTime date, HabitValues values, String myId, String habitId) async {
    await repo.setHabitRecord(date, values, myId, habitId);
  }

  /// 習慣を更新する
  Future<void> updateHabit(HabitView habit, String myId) async {
    await repo.updateHabit(habit, myId);
  }

  /// 習慣の並び順を更新する
  Future<void> updateSortOrder(List<HabitView> habits, String myId) async {
    await repo.updateSort(habits, myId);
  }

  /// 習慣を削除する
  Future<void> deleteHabit(String myId, String habitId) async {
    await repo.deleteHabit(myId, habitId);
  }

  /// 習慣の記録を削除する
  Future<void> deleteHabitRecord(
      String myId, String habitId, DateTime date) async {
    await repo.deleteHabitRecord(myId, habitId, date);
  }

  /// ユーザーのすべて情報を削除する
  /// @return : 0 (オフライン), 1 (成功), 99 (エラー)
  Future<int> deleteUserData() async {
    return await repo.deleteUserData(getUid());
  }

  /// パートナー依頼の拒否・承認アクションを処理
  Future<void> handleRequestAction(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    bool isDeny,
    String uid, {
    String? name,
  }) async {
    if (isDeny) {
      await _handlePartnerRequest(doc, uid, isApproval: false);
    } else if (name != null) {
      await _handlePartnerRequest(doc, uid, name: name, isApproval: true);
    }
  }

  // ---------------- プライベートメソッド ----------------

  /// パートナーのリクエストを削除する
  Future<void> _removePartnerRequests(String myId, String partnerId) async {
    //自分側
    if (await repo.existsSentRequest(myId, partnerId)) {
      repo.deleteSentRequest(myId, partnerId);
    }
    //相手側
    if (await repo.existsGotRequest(myId, partnerId)) {
      repo.deleteGotRequest(myId, partnerId);
    }
  }

  /// HabitViewオブジェクトを作成する
  HabitView _createHabitView(Map<String, dynamic> habitData) {
    final goal = habitData['goal'] != null
        ? HabitGoalViewMapper.mapToView(habitData['goal'])
        : null;

    final records = (habitData['records'] as List<dynamic>?)
        ?.map((record) {
          final date = HabitValuesConverter.toDate(record['date']);
          if (date == null) return null;
          return HabitValuesConverter.toRecordMap(
            date,
            record['str'] as String,
            record['dur'] != null
                ? Duration(seconds: record['dur'] as int)
                : null,
          );
        })
        .where((r) => r != null)
        .fold<Map<DateTime, HabitValues>>({}, (map, r) => map..addAll(r!));

    final dataType = dataTypes.firstWhere(
      (data) => data.id == habitData['dataTypeId'] as int,
    );

    return HabitViewMapper.mapToView(habitData, dataType, goal, records ?? {});
  }

  /// パートナー依頼を処理する
  Future<void> _handlePartnerRequest(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    String uid, {
    String? name,
    required bool isApproval,
  }) async {
    if (isApproval) {
      setPartner(uid, doc.id, name!, doc['username']);
    } else {
      deletePartnerRequests(uid, doc.id);
    }
  }

  // ---------------- Firebaseサービス関連のメソッド ----------------

  /// ログアウト
  Future<void> logout() async {
    await firebaseServices.logout();
  }

  /// パートナーのスナップショットを取得
  Stream<QuerySnapshot<Map<String, dynamic>>> getPartnerSnapshot() {
    final userId = firebaseServices.currentUserId!;
    return firebaseServices.getSubCollectionSnapshot(userId, 'partner');
  }

  /// リクエストのスナップショットを取得
  Stream<QuerySnapshot<Map<String, dynamic>>> getRequestsSnapshot() {
    final userId = firebaseServices.currentUserId!;
    return firebaseServices.getSubCollectionSnapshot(userId, 'gotRequests');
  }

  /// 全ユーザーのスナップショットを取得
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersSnapshot() {
    return firebaseServices.getCollectionSnapshot('users');
  }

  /// 習慣のスナップショットを取得
  Stream<QuerySnapshot<Map<String, dynamic>>> getHabitsSnapshot(String userId) {
    return firebaseServices.getSubCollectionSnapshot(userId, 'habits');
  }

  /// 現在のユーザーIDを取得
  String getUid() {
    final userId = firebaseServices.currentUserId;
    if (userId == null) return '';
    return userId;
  }

  /// 現在のユーザーのEmailを取得
  String getEmail() {
    final email = firebaseServices.currentUserEmail;
    if (email == null) return '';
    return email;
  }

  /// Firebase Authのユーザーの状態変化を監視
  Stream<User?> getSteamUser() {
    return firebaseServices.authStateChanges();
  }
}
