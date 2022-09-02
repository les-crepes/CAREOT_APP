import 'package:pdg_app/model/user.dart';

abstract class IUser {
  Future<void> createUser(User user);
  Future<User> readUser(String userid);
  void updateUser(User user);
  void deleteUser(String userid);
  Future<List<User>> getDietitianClient(String dietitianId);
}
