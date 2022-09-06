enum LoginExceptionType {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknown,
}

/// Generic exception related to Authentication. Check the error message for more details.
class AuthenticationException implements Exception {
  LoginExceptionType exceptionType;
  AuthenticationException(this.exceptionType);

  @override
  String toString() {
    switch (exceptionType) {
      case LoginExceptionType.invalidEmail:
        return "Invalid email";
      case LoginExceptionType.userDisabled:
        return "User disabled";
      case LoginExceptionType.userNotFound:
        return "User not found";
      case LoginExceptionType.wrongPassword:
        return "Wrong password";
      default:
        return "Unknown error";
    }
  }
}
