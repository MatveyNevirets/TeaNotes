// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class TryLoginEvent extends LoginEvent {
  String email;
  String password;
  TryLoginEvent({required this.email, required this.password});
}
