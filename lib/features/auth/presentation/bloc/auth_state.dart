// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class UnauthenticateState extends AuthState {
  String? message;
  UnauthenticateState({this.message});
}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  String? message;
  AuthenticatedState({this.message});
}

class AuthErrorState extends AuthState {
  String message;
  AuthErrorState({required this.message});
}

class AuthLetterSendedState extends AuthState {
  String message;
  AuthLetterSendedState({required this.message});
}
