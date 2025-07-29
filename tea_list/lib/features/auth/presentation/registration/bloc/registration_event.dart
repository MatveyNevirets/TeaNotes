// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class TryRegisterEvent extends RegistrationEvent {
  String name;
  String email;
  String password;
  TryRegisterEvent({required this.name, required this.email, required this.password});
}
