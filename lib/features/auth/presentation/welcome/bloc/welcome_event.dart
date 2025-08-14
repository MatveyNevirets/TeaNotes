part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeEvent {}

class TryGoogleSignInEvent extends WelcomeEvent {}

class CheckUserLoginEvent extends WelcomeEvent {}