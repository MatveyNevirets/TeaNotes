// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {
  String? message;
  RegistrationInitial({this.message});
}

class LoadingRegistration extends RegistrationState {}

class ErrorRegistration extends RegistrationState {
  Object? error;
  StackTrace? stack;
  ErrorRegistration({required this.error, required this.stack});
}

class LetterHasBeenSended extends RegistrationState {
  String message;
  LetterHasBeenSended({required this.message});
}

class SuccessRegistration extends RegistrationState {
  String message;
  SuccessRegistration({required this.message});
}
