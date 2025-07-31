// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginErrorState extends LoginState {
  String message;
  LoginErrorState({required this.message});
}

class LoginLoadingState extends LoginState {}

class SuccessLoginState extends LoginState {
  String message;
  SuccessLoginState({required this.message});
}
