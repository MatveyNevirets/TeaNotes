// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

class AreYouSureDeleteDetailsState extends DetailsState {}

class ISureDeleteDetailsState extends DetailsState {}

class SuccessfulDeleteState extends DetailsState {
  String message;
  SuccessfulDeleteState({required this.message});
}

class ErrorDeleteState extends DetailsState {
  String message;
  ErrorDeleteState({required this.message});
}
