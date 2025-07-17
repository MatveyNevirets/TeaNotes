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