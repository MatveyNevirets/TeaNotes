// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeSuccessSignInState extends WelcomeState {
  String? message;
  WelcomeSuccessSignInState({this.message});
}

class WelcomeErrorState extends WelcomeState {
  String message;
  WelcomeErrorState({required this.message});
}
