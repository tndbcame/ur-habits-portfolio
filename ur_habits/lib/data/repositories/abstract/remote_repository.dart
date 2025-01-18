import 'package:ur_habits/data/models/ui/habit_values.dart';
import 'package:ur_habits/data/models/ui/habit_view.dart';

abstract class RemoteRepository {
  Future<int> existsUser(String userId);
  Future<String> fetchUserName(String userId);
  Future<void> setUserInfo(String userId, String username, String email);
  Future<void> updateUsername(String myId, String username);
  Future<int> existsPartner(String userId);
  Future<List<Map<String, dynamic>>> fetchPartnerNames(String userId);
  Future<Map<String, String>> fetchPartnerInfos(String userId);
  Future<void> setPartner(String userId, String partnerId, String partnerName);
  Future<void> updatePartnername(
      String userId, String partnerId, String partnerName);
  Future<void> deletePartner(String userId, String partnerId);
  Future<bool> existsSentRequest(String userId, String destinationUserId);
  Future<bool> existsGotRequest(String userId, String receivedUserId);
  Future<void> setSentRequest(
      String userId, String destinationUserId, String username);
  Future<void> setGotRequest(
      String userId, String receivedUserId, String username);
  Future<void> deleteSentRequest(String userId, String destinationUserId);
  Future<void> deleteGotRequest(String userId, String receivedUserId);
  Future<List<Map<String, dynamic>>> fetchHabits(String userId);
  Stream<List<Map<String, dynamic>>> fetchHabitsSnapshot(String userId);
  Future<void> setHabit(HabitView habit, String userId, bool isUpdate);
  Future<void> updateHabit(HabitView habit, String userId);
  Future<void> deleteHabit(String userId, String habitId);
  Future<void> setHabitRecord(
      DateTime date, HabitValues values, String userId, String habitId,
      {int time = 3});
  Future<void> setHabitRecords(
      Map<DateTime, HabitValues> values, String userId, String habitId,
      {int time = 3});
  Future<void> deleteHabitRecord(String userId, String habitId, DateTime date);
  Future<void> updateSort(List<HabitView> habitList, String userId);
  Future<int> deleteUserData(String userId);
}
