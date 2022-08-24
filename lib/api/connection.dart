/// Manager for the connection to the server.
abstract class Connection {
  /// Returns if the connection is established.
  bool get isConnected;

  /// Connect to the server.
  Future<bool> connect({required String email, required String password});

  /// Register a new user.
  Future<bool> register({required String email, required String password});
}