/// Manager for the connection to the server.
abstract class Connection {
  /// Returns if the connection is established.
  bool get isConnected;

  /// Returns if the user connected is verified
  bool get isVerified;

  /// Get the uid of the connected user.
  String get uid;

  /// Connect to the server.
  Future<bool> connect({required String email, required String password});

  /// Register a new user.
  Future<bool> register({required String email, required String password});

  /// Disconnect from the server.
  Future<void> disconnect();

  /// Verify the user connected.
  Future<void> verify();

}