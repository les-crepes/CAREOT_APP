/// Manager for the connection to the server.
abstract class Auth {
  /// Returns if the connection is established.
  bool get isConnected;

  /// Returns if the user connected is verified
  bool get isVerified;

  /// Get the uid of the connected user.
  String get uid;

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// A [AuthenticationException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///  - Thrown if the email address is not valid.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given email has been disabled.
  /// - **user-not-found**:
  ///  - Thrown if there is no user corresponding to the given email.
  /// - **wrong-password**:
  ///  - Thrown if the password is invalid for the given email, or the account
  ///    corresponding to the email does not have a password set.
  Future<void> signIn({required String email, required String password});

  /// Register a new user.
  Future<bool> register({required String email, required String password});

  /// Disconnect from the server.
  Future<void> signOut();

  /// Send a verification to the user connected.
  Future<void> sendVerification();

  /// Get the email of the user connected.
  String getUserEmail();

  /// Returns if the user connected is a dietitian.
  Future<bool> isDietitian();

  /// Returns if the email [emailAddress] is already used by a user.
  Future<bool> checkIfEmailInUse(String emailAddress);
}
