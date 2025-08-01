class Failure implements Exception {
  Object? error;
  StackTrace? stack;
  Failure(this.error, this.stack);
}

class ServerException extends Failure {
  ServerException(super.error, super.stack);
}

class DatabaseInsertException extends Failure {
  DatabaseInsertException(super.error, super.stack);
}

class DatabaseQueryException extends Failure {
  DatabaseQueryException(super.error, super.stack);
}

class EmailRegistrationException extends Failure {
  EmailRegistrationException(super.error, super.stack);
}

class EmailLoginNotVerifedException extends Failure {
  EmailLoginNotVerifedException(super.error, super.stack);
}

class EmailLoginException extends Failure {
  EmailLoginException(super.error, super.stack);
}

class GoogleSignInException extends Failure {
  GoogleSignInException(super.error, super.stack);
}

class UserIsNullException extends Failure {
  UserIsNullException(super.error, super.stack);
}

class FetchTeaPostsException extends Failure {
  FetchTeaPostsException(super.error, super.stack);
}
