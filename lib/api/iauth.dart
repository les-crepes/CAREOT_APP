/// Manager for the connection to the server.
abstract class Auth {
  /// Returns if the connection is established.
  bool get isConnected;

  /// Returns if the user connected is verified
  bool get isVerified;

  /// Get the uid of the connected user.
  String get uid;

  /// Connect to the server.
  Future<void> signIn({required String email, required String password});

  /// Register a new user.
  Future<bool> register({required String email, required String password});

  /// Disconnect from the server.
  Future<void> signOut();

  /// Send a verification to the user connected.
  Future<void> sendVerification();

  String getUserEmail();

  Future<bool> isDietitian();

  Future<bool> checkIfEmailInUse(String emailAddress);
}
