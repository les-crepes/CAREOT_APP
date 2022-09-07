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

enum DatabaseExceptionType {
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
class DatabaseException implements Exception {
  DatabaseExceptionType exceptionType;
  DatabaseException(this.exceptionType);

  @override
  String toString() {
    switch (exceptionType) {
      case DatabaseExceptionType.notFound:
        return "Not found";
      case DatabaseExceptionType.permissionDenied:
        return "Permission denied";
      case DatabaseExceptionType.aborted:
        return "Aborted";
      case DatabaseExceptionType.alreadyExists:
        return "Already exists";
      case DatabaseExceptionType.canceled:
        return "Canceled";
      case DatabaseExceptionType.deadlineExceeded:
        return "Deadline exceeded";
      case DatabaseExceptionType.unavailable:
        return "Unavailable";
      default:
        return "Unknown error";
    }
  }
}

enum FileStorageExceptionType {
  unknown,
  objectNotFound,
  bucketNotFound,
  projectNotFound,
  quotaExceeded,
  unauthenticated,
  unauthorized,
  retryLimitExceeded,
  invalidChecksum,
  canceled,
  invalidEventName,
  invalidUrl,
  invalidArgument,
  noDefaultBucket,
  cannotSliceBlob,
  serverFileWrongSize,
}

/// Generic exception related to Storage. Check the error message for more details.
class FileStorageException implements Exception {
  FileStorageExceptionType exceptionType;
  FileStorageException(this.exceptionType);

  @override
  String toString() {
    switch (exceptionType) {
      case FileStorageExceptionType.objectNotFound:
        return "Object not found";
      case FileStorageExceptionType.bucketNotFound:
        return "Bucket not found";
      case FileStorageExceptionType.projectNotFound:
        return "Project not found";
      case FileStorageExceptionType.quotaExceeded:
        return "Quota exceeded";
      case FileStorageExceptionType.unauthenticated:
        return "Unauthenticated";
      case FileStorageExceptionType.unauthorized:
        return "Unauthorized";
      case FileStorageExceptionType.retryLimitExceeded:
        return "Retry limit exceeded";
      case FileStorageExceptionType.invalidChecksum:
        return "Invalid checksum";
      case FileStorageExceptionType.canceled:
        return "Canceled";
      case FileStorageExceptionType.invalidEventName:
        return "Invalid event name";
      case FileStorageExceptionType.invalidUrl:
        return "Invalid URL";
      case FileStorageExceptionType.invalidArgument:
        return "Invalid argument";
      case FileStorageExceptionType.noDefaultBucket:
        return "No default bucket";
      case FileStorageExceptionType.cannotSliceBlob:
        return "Cannot slice blob";
      case FileStorageExceptionType.serverFileWrongSize:
        return "Server file wrong size";
      default:
        return "Unknown error";
    }
  }
}