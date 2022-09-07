import 'package:pdg_app/model/user.dart';

/// Interface for the user API
abstract class IUser {
  /// Add [user] to the database
  Future<void> createUser(User user);

  /// Returns the user in the database with [userId]
  Future<User> readUser(String userid);

  /// Update the [user] in the database
  Future<void> updateUser(User user);

  /// Delete the user with [userid] from the database
  void deleteUser(String userid);

  /// Add the client [clientId] to the list of clients of the dietitian [dietitianId]
  Future<void> addClient(String userId, String dietitianId);

  /// Get the clients of the dietitian [dietitianId]
  Future<List<User>> getDietitianClient(String dietitianId);

  /// Get the dietitian of the client [clientId]
  Future<User?> readDietitianOfClient(String clientId);

  /// Subscribe to the dietitian [dietitianId] client list
  Stream<List<User>> followDietitianClientList(String dietitianId);
}
