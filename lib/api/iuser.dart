import 'package:pdg_app/model/user.dart';

abstract class IUser {
  Future<void> createUser(User user);
  Future<User> readUser(String userid);
  Future<void> updateUser(User user);
  Future<void> addClient(String userId, String dietitianId);
  void deleteUser(String userid);
  Future<List<User>> getDietitianClient(String dietitianId);
  Future<User?> readDietitianOfClient(String clientId);
}
