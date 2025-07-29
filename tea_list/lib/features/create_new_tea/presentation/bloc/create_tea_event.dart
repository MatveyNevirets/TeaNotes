// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_tea_bloc.dart';

sealed class CreateTeaEvent {}

class AddTeaEvent extends CreateTeaEvent {
  final TeaModel tea;

  AddTeaEvent({required this.tea});
}
