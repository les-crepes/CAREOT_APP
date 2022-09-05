enum LoginExceptionType {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknown,
}

class LoginException implements Exception {
  LoginExceptionType exceptionType;
  LoginException(this.exceptionType);

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
