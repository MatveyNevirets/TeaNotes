// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  String email;
  String password;
  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  String email;
  String password;
  String name;
  RegisterEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class CheckUserLoginEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
