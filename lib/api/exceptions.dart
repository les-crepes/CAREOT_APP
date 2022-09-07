enum AuthExceptionType {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  weakPassword,
  operationNotAllowed,
  emailAlreadyInUse,
  unknown,
}

/// Generic exception related to Authentication. Check the error message for more details.
class AuthenticationException implements Exception {
  AuthExceptionType exceptionType;
  AuthenticationException(this.exceptionType);

  @override
  String toString() {
    switch (exceptionType) {
      case AuthExceptionType.invalidEmail:
        return "Invalid email";
      case AuthExceptionType.userDisabled:        return "User disabled";
      case AuthExceptionType.userNotFound:
        return "User not found";
      case AuthExceptionType.wrongPassword:
        return "Wrong password";
      case AuthExceptionType.weakPassword:
        return "Weak password";
      case AuthExceptionType.operationNotAllowed:
        return "Operation not allowed";
      case AuthExceptionType.emailAlreadyInUse:
        return "Email already in use";
      default:
        return "Unknown error";
    }
  }
}

enum StorageExceptionType {
  unknown,
  notFound,
  permissionDenied,
  aborted,
  alreadyExists,
  canceled,
  deadlineExceeded,
  unavailable,
}

/// Generic exception related to Storage. Check the error message for more details.
class StorageException implements Exception {
  StorageExceptionType exceptionType;
  StorageException(this.exceptionType);

  @override
  String toString() {
    switch (exceptionType) {
      case StorageExceptionType.notFound:
        return "Not found";
      case StorageExceptionType.permissionDenied:
        return "Permission denied";
      case StorageExceptionType.aborted:
        return "Aborted";
      case StorageExceptionType.alreadyExists:
        return "Already exists";
      case StorageExceptionType.canceled:
        return "Canceled";
      case StorageExceptionType.deadlineExceeded:
        return "Deadline exceeded";
      case StorageExceptionType.unavailable:
        return "Unavailable";
      default:
        return "Unknown error";
    }
  }
}